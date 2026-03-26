import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/core/theme/app_theme.dart';
import 'package:scoutset/data/local/database/app_services.dart';
import 'package:scoutset/features/scoreboard/screens/scoreboard_screen.dart';
import 'package:scoutset/features/scoreboard/services/scoreboard_service.dart';

void main() {
  late ScoreboardService service;

  setUp(() async {
    await AppServices.useInMemoryDatabaseForTesting();
    service = ScoreboardService.instance;
    await service.clearAll();
  });

  Widget buildTestable(Widget child) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: child,
    );
  }

  Future<void> pumpScoreboard(WidgetTester tester) async {
    await tester.pumpWidget(buildTestable(const ScoreboardScreen()));
    await tester.pumpAndSettle();
  }

  testWidgets('shows setup card before a match starts', (tester) async {
    await pumpScoreboard(tester);

    expect(find.text('Nova Partida'), findsOneWidget);
    expect(find.byKey(const Key('scoreboard-team-a-field')), findsOneWidget);
    expect(find.byKey(const Key('scoreboard-team-b-field')), findsOneWidget);
  });

  testWidgets('transitions from setup form to live scoreboard', (tester) async {
    await pumpScoreboard(tester);

    await tester.enterText(find.byKey(const Key('scoreboard-team-a-field')), 'Time Azul');
    await tester.enterText(find.byKey(const Key('scoreboard-team-b-field')), 'Time Ouro');
    await tester.tap(find.byKey(const Key('scoreboard-start-button')));
    await tester.pumpAndSettle();

    expect(find.text('TIME AZUL x TIME OURO'), findsOneWidget);
    expect(find.text('Controles do Placar'), findsOneWidget);
    expect(find.text('1° set em andamento'), findsWidgets);
  });

  testWidgets('prevents starting a match with duplicated team names', (tester) async {
    await pumpScoreboard(tester);

    await tester.enterText(find.byKey(const Key('scoreboard-team-a-field')), 'Time Azul');
    await tester.enterText(find.byKey(const Key('scoreboard-team-b-field')), 'time azul');
    await tester.tap(find.byKey(const Key('scoreboard-start-button')));
    await tester.pumpAndSettle();

    expect(find.text('Os times precisam ter nomes diferentes.'), findsOneWidget);
    expect(find.text('Controles do Placar'), findsNothing);
  });

  testWidgets('clears team fields when preparing a new match', (tester) async {
    service.startMatch(teamAName: 'Azul', teamBName: 'Ouro');
    await service.finishCurrentMatch();

    await pumpScoreboard(tester);
    final newMatchButton = find.widgetWithText(ElevatedButton, 'Nova Partida');
    final button = tester.widget<ElevatedButton>(newMatchButton);
    button.onPressed?.call();
    await tester.pumpAndSettle();

    final teamAField = tester.widget<TextFormField>(
      find.byKey(const Key('scoreboard-team-a-field')),
    );
    final teamBField = tester.widget<TextFormField>(
      find.byKey(const Key('scoreboard-team-b-field')),
    );

    expect(teamAField.controller?.text, isEmpty);
    expect(teamBField.controller?.text, isEmpty);
  });

  testWidgets('limits team names to 10 characters', (tester) async {
    await pumpScoreboard(tester);

    await tester.enterText(find.byKey(const Key('scoreboard-team-a-field')), '12345678901');
    await tester.pump();

    final teamAField = tester.widget<TextFormField>(
      find.byKey(const Key('scoreboard-team-a-field')),
    );

    expect(teamAField.controller?.text, '1234567890');
  });

  testWidgets('blocks special characters in team names', (tester) async {
    await pumpScoreboard(tester);

    await tester.enterText(find.byKey(const Key('scoreboard-team-a-field')), 'Time@A!');
    await tester.pump();

    final teamAField = tester.widget<TextFormField>(
      find.byKey(const Key('scoreboard-team-a-field')),
    );

    expect(teamAField.controller?.text, 'TimeA');
  });

  testWidgets('renders banner and scores during the match', (tester) async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await service.addPointToTeamA();
    await service.addPointToTeamB();

    await pumpScoreboard(tester);

    expect(find.text('A'), findsWidgets);
    expect(find.text('B'), findsWidgets);
    expect(find.text('1'), findsWidgets);
  });

  testWidgets('blocks scoring controls after the match ends', (tester) async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    for (var i = 0; i < 25; i++) {
      await service.addPointToTeamA();
    }
    for (var i = 0; i < 25; i++) {
      await service.addPointToTeamA();
    }

    await pumpScoreboard(tester);

    final pointButton = tester.widget<ElevatedButton>(find.widgetWithText(ElevatedButton, '+1 A').first);
    expect(pointButton.onPressed, isNull);
    expect(find.text('Nova Partida'), findsOneWidget);
    expect(find.textContaining('venceu a partida'), findsOneWidget);
  });

  testWidgets('navigates to history and detail screens', (tester) async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    for (var i = 0; i < 12; i++) {
      await service.addPointToTeamA();
    }
    await service.finishCurrentMatch();

    await pumpScoreboard(tester);
    await tester.tap(find.widgetWithText(OutlinedButton, 'Histórico de Partidas'));
    await tester.pumpAndSettle();

    expect(find.text('Histórico de Partidas'), findsOneWidget);
    expect(find.text('A x B'), findsOneWidget);

    await tester.tap(find.text('A x B').first);
    await tester.pumpAndSettle();

    expect(find.text('Detalhes da Partida'), findsOneWidget);
    expect(find.textContaining('Vencedor:'), findsWidgets);
  });
}
