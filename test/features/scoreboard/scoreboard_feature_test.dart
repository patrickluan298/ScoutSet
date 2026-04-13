import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/core/theme/app_theme.dart';
import 'package:scoutset/data/local/database/app_services.dart';
import 'package:scoutset/features/scoreboard/models/match_score.dart';
import 'package:scoutset/features/scoreboard/models/set_score.dart';
import 'package:scoutset/features/scoreboard/screens/match_detail_screen.dart';
import 'package:scoutset/features/scoreboard/screens/scoreboard_screen.dart';
import 'package:scoutset/features/scoreboard/services/scoreboard_service.dart';
import 'package:scoutset/features/scoreboard/widgets/set_score_table.dart';
import 'package:scoutset/features/teams/models/team_draw_player.dart';

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

  Future<void> addPoints(ScoreboardService service, {required int teamA, required int teamB}) async {
    final sharedPoints = teamA < teamB ? teamA : teamB;

    for (var i = 0; i < sharedPoints; i++) {
      await service.addPointToTeamA();
      await service.addPointToTeamB();
    }

    for (var i = sharedPoints; i < teamA; i++) {
      await service.addPointToTeamA();
    }

    for (var i = sharedPoints; i < teamB; i++) {
      await service.addPointToTeamB();
    }
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

  testWidgets('opens point origin sheet and player picker for roster matches', (tester) async {
    const player = TeamDrawPlayer(
      id: 'p1',
      name: 'Joao',
      position: 'Ponteiro',
      level: PlayerLevel.avancado,
    );
    service.startMatch(
      teamAName: 'A',
      teamBName: 'B',
      teamAPlayers: const [player],
    );

    await pumpScoreboard(tester);
    await tester.tap(find.widgetWithText(ElevatedButton, '+1 A').first);
    await tester.pumpAndSettle();

    expect(find.text('Ataque'), findsOneWidget);
    expect(find.text('Erro adversário'), findsOneWidget);

    await tester.tap(find.byKey(const Key('point-origin-team_a-attack')));
    await tester.pumpAndSettle();

    expect(find.text('Quem marcou por A?'), findsOneWidget);
    await tester.tap(find.byKey(const Key('point-player-p1')));
    await tester.pumpAndSettle();

    expect(service.getState().currentTeamAScore, 1);
  });

  testWidgets('manual match scores directly without opening point category sheet', (tester) async {
    service.startMatch(teamAName: 'A', teamBName: 'B');

    await pumpScoreboard(tester);
    await tester.tap(find.widgetWithText(ElevatedButton, '+1 A').first);
    await tester.pumpAndSettle();

    expect(find.text('Registrar ponto para A'), findsNothing);
    expect(find.text('Erro adversário'), findsNothing);
    expect(service.getState().currentTeamAScore, 1);
  });

  testWidgets('finished match keeps next set summary at zero', (tester) async {
    await tester.pumpWidget(
      buildTestable(
        const SetScoreTable(
          finishedSets: [
            SetScore(
              setNumber: 1,
              teamAScore: 25,
              teamBScore: 20,
              winnerTeamId: 'team_a',
              targetPoints: 25,
            ),
          ],
          currentSet: 2,
          currentTeamAScore: 25,
          currentTeamBScore: 20,
          currentTargetPoints: 25,
          isMatchFinished: true,
        ),
      ),
    );

    expect(find.text('0'), findsNWidgets(2));
    expect(find.text('Set 2'), findsOneWidget);
  });

  testWidgets('renders five sets in the summary table with a 15-point fifth set', (tester) async {
    await tester.pumpWidget(
      buildTestable(
        const SetScoreTable(
          finishedSets: [],
          currentSet: 1,
          currentTeamAScore: 0,
          currentTeamBScore: 0,
          currentTargetPoints: 25,
        ),
      ),
    );

    expect(find.text('Set 5'), findsOneWidget);
    expect(find.text('15 pts'), findsOneWidget);
  });

  testWidgets('match details show 15-point target in the fifth set', (tester) async {
    final match = MatchScore(
      id: 'match-detail-1',
      teamAName: 'A',
      teamBName: 'B',
      currentSet: 5,
      sets: [
        SetScore(
          setNumber: 1,
          teamAScore: 25,
          teamBScore: 20,
          winnerTeamId: TeamSide.teamA.value,
          targetPoints: 25,
        ),
        SetScore(
          setNumber: 2,
          teamAScore: 18,
          teamBScore: 25,
          winnerTeamId: TeamSide.teamB.value,
          targetPoints: 25,
        ),
        SetScore(
          setNumber: 3,
          teamAScore: 25,
          teamBScore: 21,
          winnerTeamId: TeamSide.teamA.value,
          targetPoints: 25,
        ),
        SetScore(
          setNumber: 4,
          teamAScore: 20,
          teamBScore: 25,
          winnerTeamId: TeamSide.teamB.value,
          targetPoints: 25,
        ),
      ],
      teamASetsWon: 2,
      teamBSetsWon: 2,
      servingTeam: TeamSide.teamA,
      matchStatus: MatchStatus.inProgress,
      sourceType: MatchSourceType.manual,
      createdAt: DateTime(2026, 4, 9, 10),
    );

    await tester.pumpWidget(buildTestable(MatchDetailScreen(match: match)));
    await tester.pumpAndSettle();

    expect(find.text('Set 5'), findsOneWidget);
    expect(find.text('15 pts'), findsOneWidget);
  });

  testWidgets('shows red match point alert when next point can end the match', (tester) async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await addPoints(service, teamA: 25, teamB: 10);
    await addPoints(service, teamA: 25, teamB: 20);
    await addPoints(service, teamA: 24, teamB: 20);

    await pumpScoreboard(tester);

    expect(find.text('MATCH POINT PARA A'), findsOneWidget);
    expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
  });

  testWidgets('shows red match point alert in the deciding set', (tester) async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await addPoints(service, teamA: 25, teamB: 10);
    await addPoints(service, teamA: 20, teamB: 25);
    await addPoints(service, teamA: 25, teamB: 18);
    await addPoints(service, teamA: 18, teamB: 25);
    await addPoints(service, teamA: 14, teamB: 12);

    await pumpScoreboard(tester);

    expect(find.text('MATCH POINT PARA A'), findsOneWidget);
  });

  testWidgets('shows yellow set point alert in the first set', (tester) async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await addPoints(service, teamA: 24, teamB: 20);

    await pumpScoreboard(tester);

    expect(find.text('SET POINT PARA A'), findsOneWidget);
    expect(find.byIcon(Icons.notification_important_outlined), findsOneWidget);
    expect(find.text('MATCH POINT PARA A'), findsNothing);
  });

  testWidgets('keeps match point only for the fifth set after the game reaches 2x2', (tester) async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await addPoints(service, teamA: 25, teamB: 10);
    await addPoints(service, teamA: 20, teamB: 25);
    await addPoints(service, teamA: 25, teamB: 10);
    await addPoints(service, teamA: 20, teamB: 24);

    await pumpScoreboard(tester);

    expect(find.text('MATCH POINT PARA B'), findsNothing);
    expect(find.text('SET POINT PARA B'), findsOneWidget);

    await service.addPointToTeamB();
    await addPoints(service, teamA: 14, teamB: 12);
    await tester.pumpWidget(buildTestable(const ScoreboardScreen()));
    await tester.pumpAndSettle();

    expect(find.text('MATCH POINT PARA A'), findsOneWidget);
  });
}
