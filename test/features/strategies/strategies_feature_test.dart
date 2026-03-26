import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/core/theme/app_theme.dart';
import 'package:scoutset/data/local/database/app_services.dart';
import 'package:scoutset/features/strategies/models/player_position.dart';
import 'package:scoutset/features/strategies/models/strategy.dart';
import 'package:scoutset/features/strategies/models/substitution.dart';
import 'package:scoutset/features/strategies/screens/strategies_screen.dart';
import 'package:scoutset/features/strategies/screens/strategy_detail_screen.dart';
import 'package:scoutset/features/strategies/services/strategy_service.dart';
import 'package:scoutset/features/strategies/widgets/player_marker.dart';

void main() {
  late StrategyService service;

  setUp(() async {
    await AppServices.useInMemoryDatabaseForTesting();
    service = StrategyService.instance;
    await service.clearAll();
  });

  Widget buildTestable(Widget child) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: child,
    );
  }

  Future<void> tapVisible(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  testWidgets('strategies screen shows empty state and saves a new strategy', (tester) async {
    await tester.pumpWidget(
      buildTestable(const StrategiesScreen()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Criar primeira estratégia'), findsOneWidget);

    await tapVisible(tester, find.text('Criar primeira estratégia'));

    await tester.enterText(find.byKey(const Key('strategy-name-field')), 'Recepção 3x1');
    await tapVisible(tester, find.text('Salvar Estratégia'));

    expect(find.text('Recepção 3x1'), findsOneWidget);
    expect(find.text('6 jogadores'), findsOneWidget);
  });

  testWidgets('editor switches between indoor and beach player counts', (tester) async {
    await tester.pumpWidget(
      buildTestable(const StrategiesScreen()),
    );
    await tester.pumpAndSettle();

    await tapVisible(tester, find.text('Criar primeira estratégia'));

    expect(find.byType(PlayerMarker), findsNWidgets(6));

    await tapVisible(tester, find.text('Praia'));

    expect(find.byType(PlayerMarker), findsNWidgets(2));
  });

  testWidgets('beach mode shows substitutions are not allowed', (tester) async {
    await tester.pumpWidget(
      buildTestable(const StrategiesScreen()),
    );
    await tester.pumpAndSettle();

    await tapVisible(tester, find.text('Criar primeira estratégia'));
    await tapVisible(tester, find.text('Praia'));

    expect(
      find.text('No vôlei de praia não são permitidas substituições durante o set.'),
      findsOneWidget,
    );
  });

  testWidgets('indoor mode applies a regulation substitution', (tester) async {
    await tester.pumpWidget(
      buildTestable(const StrategiesScreen()),
    );
    await tester.pumpAndSettle();

    await tapVisible(tester, find.text('Criar primeira estratégia'));

    await tapVisible(tester, find.byKey(const Key('sub-out-dropdown')));
    await tapVisible(tester, find.text('1 - P1').last);

    await tapVisible(tester, find.byKey(const Key('sub-in-dropdown')));
    await tapVisible(tester, find.text('7 - B7').last);

    await tapVisible(tester, find.text('Aplicar substituição'));

    expect(find.text('P1 -> B7'), findsOneWidget);
    expect(find.text('1/6'), findsOneWidget);
  });

  testWidgets('detail screen renders strategy in read only mode', (tester) async {
    final strategy = await service.createStrategy(
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
    await tester.pumpAndSettle();

    expect(find.text('Bloqueio duplo'), findsWidgets);
    expect(find.text('Visualização'), findsOneWidget);
    expect(find.byType(PlayerMarker), findsNWidgets(6));
    expect(find.text('Substituições regulamentares: 1/6'), findsOneWidget);
  });
}
