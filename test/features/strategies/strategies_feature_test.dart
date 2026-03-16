import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/core/theme/app_theme.dart';
import 'package:scoutset/features/strategies/models/player_position.dart';
import 'package:scoutset/features/strategies/models/strategy.dart';
import 'package:scoutset/features/strategies/screens/strategies_screen.dart';
import 'package:scoutset/features/strategies/screens/strategy_detail_screen.dart';
import 'package:scoutset/features/strategies/services/strategy_service.dart';
import 'package:scoutset/features/strategies/widgets/player_marker.dart';
import 'package:scoutset/features/strategies/models/substitution.dart';

void main() {
  late StrategyService service;

  setUp(() {
    service = StrategyService.instance;
    service.clearAll();
  });

  Widget buildTestable(Widget child) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: child,
    );
  }

  testWidgets('strategies screen shows empty state and saves a new strategy', (tester) async {
    await tester.pumpWidget(
      buildTestable(const StrategiesScreen()),
    );

    expect(find.text('Criar primeira estrategia'), findsOneWidget);

    await tester.tap(find.text('Criar primeira estrategia'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('strategy-name-field')), 'Recepcao 3x1');
    await tester.tap(find.text('Salvar estrategia'));
    await tester.pumpAndSettle();

    expect(find.text('Recepcao 3x1'), findsOneWidget);
    expect(find.text('6 jogadores'), findsOneWidget);
  });

  testWidgets('editor switches between indoor and beach player counts', (tester) async {
    await tester.pumpWidget(
      buildTestable(const StrategiesScreen()),
    );

    await tester.tap(find.text('Criar primeira estrategia'));
    await tester.pumpAndSettle();

    expect(find.byType(PlayerMarker), findsNWidgets(6));

    await tester.tap(find.text('Praia'));
    await tester.pumpAndSettle();

    expect(find.byType(PlayerMarker), findsNWidgets(2));
  });

  testWidgets('beach mode shows substitutions are not allowed', (tester) async {
    await tester.pumpWidget(
      buildTestable(const StrategiesScreen()),
    );

    await tester.tap(find.text('Criar primeira estrategia'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Praia'));
    await tester.pumpAndSettle();

    expect(
      find.text('No volei de praia nao sao permitidas substituicoes durante o set.'),
      findsOneWidget,
    );
  });

  testWidgets('indoor mode applies a regulation substitution', (tester) async {
    await tester.pumpWidget(
      buildTestable(const StrategiesScreen()),
    );

    await tester.tap(find.text('Criar primeira estrategia'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('sub-out-dropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('1 - P1').last);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('sub-in-dropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('7 - B7').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Aplicar substituicao'));
    await tester.pumpAndSettle();

    expect(find.text('P1 -> B7'), findsOneWidget);
    expect(find.text('1/6'), findsOneWidget);
  });

  testWidgets('detail screen renders strategy in read only mode', (tester) async {
    final strategy = service.createStrategy(
      Strategy(
        id: '',
        name: 'Bloqueio duplo',
        description: 'Ajuste de bloqueio com cobertura curta.',
        playersPositions: service.defaultPlayersForMode(StrategyGameMode.indoor),
        benchPlayers: service.defaultBenchPlayersForMode(StrategyGameMode.indoor),
        movements: const [],
        substitutions: [
          Substitution(
            id: service.nextSubstitutionId(),
            playerOutId: 'P1',
            playerInId: 'B7',
            createdAt: DateTime(2026, 3, 16),
          ),
        ],
        createdAt: DateTime(2026, 3, 16),
        gameMode: StrategyGameMode.indoor,
      ),
    );

    await tester.pumpWidget(
      buildTestable(StrategyDetailScreen(strategyId: strategy.id)),
    );

    expect(find.text('Bloqueio duplo'), findsWidgets);
    expect(find.text('Visualizacao'), findsOneWidget);
    expect(find.byType(PlayerMarker), findsNWidgets(6));
    expect(find.text('Substituicoes regulamentares: 1/6'), findsOneWidget);
  });
}
