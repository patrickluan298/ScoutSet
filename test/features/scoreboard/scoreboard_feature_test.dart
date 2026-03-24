import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/core/theme/app_theme.dart';
import 'package:scoutset/features/scoreboard/screens/scoreboard_screen.dart';
import 'package:scoutset/features/scoreboard/services/scoreboard_service.dart';

void main() {
  late ScoreboardService service;

  setUp(() {
    service = ScoreboardService.instance;
    service.clearAll();
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

    expect(find.text('Nova partida'), findsOneWidget);
    expect(find.byKey(const Key('scoreboard-team-a-field')), findsOneWidget);
    expect(find.byKey(const Key('scoreboard-team-b-field')), findsOneWidget);
  });

  testWidgets('transitions from setup form to live scoreboard', (tester) async {
    await pumpScoreboard(tester);

    await tester.enterText(find.byKey(const Key('scoreboard-team-a-field')), 'Time Azul');
    await tester.enterText(find.byKey(const Key('scoreboard-team-b-field')), 'Time Ouro');
    await tester.tap(find.byKey(const Key('scoreboard-start-button')));
    await tester.pumpAndSettle();

    expect(find.text('Time Azul x Time Ouro'), findsOneWidget);
    expect(find.text('Controles do placar'), findsOneWidget);
    expect(find.text('Set 1 em andamento'), findsWidgets);
  });

  testWidgets('renders banner and scores during the match', (tester) async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    service.addPointToTeamA();
    service.addPointToTeamB();
    service.toggleServingTeam();

    await pumpScoreboard(tester);

    expect(find.text('A'), findsWidgets);
    expect(find.text('B'), findsWidgets);
    expect(find.text('1'), findsWidgets);
    expect(find.text('Alternar saque'), findsOneWidget);
  });

  testWidgets('blocks scoring controls after the match ends', (tester) async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    for (var i = 0; i < 25; i++) {
      service.addPointToTeamA();
    }
    for (var i = 0; i < 25; i++) {
      service.addPointToTeamA();
    }

    await pumpScoreboard(tester);

    final pointButton = tester.widget<ElevatedButton>(find.widgetWithText(ElevatedButton, '+1 A').first);
    expect(pointButton.onPressed, isNull);
    expect(find.text('Nova partida'), findsOneWidget);
    expect(find.textContaining('venceu a partida'), findsOneWidget);
  });

  testWidgets('navigates to history and detail screens', (tester) async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    for (var i = 0; i < 12; i++) {
      service.addPointToTeamA();
    }
    service.finishCurrentMatch();

    await pumpScoreboard(tester);
    await tester.tap(find.byIcon(Icons.history).first);
    await tester.pumpAndSettle();

    expect(find.text('Historico de partidas'), findsOneWidget);
    expect(find.text('A x B'), findsOneWidget);

    await tester.tap(find.text('A x B').first);
    await tester.pumpAndSettle();

    expect(find.text('Detalhes da partida'), findsOneWidget);
    expect(find.textContaining('Vencedor:'), findsWidgets);
  });
}
