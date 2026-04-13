import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/data/local/database/app_services.dart';
import 'package:scoutset/features/scoreboard/models/match_score.dart';
import 'package:scoutset/features/scoreboard/models/set_point_event.dart';
import 'package:scoutset/features/scoreboard/services/scoreboard_service.dart';
import 'package:scoutset/features/teams/models/team_draw_player.dart';
import 'package:scoutset/models/sport_mode.dart';
import 'package:scoutset/services/sport_mode_service.dart';

void main() {
  late ScoreboardService service;

  setUp(() async {
    await AppServices.useInMemoryDatabaseForTesting();
    SportModeService.instance.resetForTesting();
    service = ScoreboardService.instance;
    await service.clearAll();
  });

  Future<void> addPoints({required int teamA, required int teamB}) async {
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

  test('starts a match with default serving team A', () {
    final match = service.startMatch(teamAName: 'ScoutSet', teamBName: 'Rivais');

    final state = service.getState();
    expect(match.teamAName, 'SCOUTSET');
    expect(match.servingTeam, TeamSide.teamA);
    expect(state.activeMatch?.currentSet, 1);
    expect(state.currentTeamAScore, 0);
    expect(state.currentTeamBScore, 0);
    expect(match.sportMode, SportMode.court);
  });

  test('rejects team names with special characters', () {
    expect(
      () => service.startMatch(teamAName: 'Time@A', teamBName: 'Rivais'),
      throwsA(
        isA<ArgumentError>().having(
          (error) => error.message,
          'message',
          'Os nomes dos times devem conter apenas letras, numeros e espacos.',
        ),
      ),
    );
  });

  test('set closes at 25 with two-point lead', () async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await addPoints(teamA: 25, teamB: 20);

    final state = service.getState();
    expect(state.activeMatch?.sets, hasLength(1));
    expect(state.activeMatch?.teamASetsWon, 1);
    expect(state.activeMatch?.currentSet, 2);
    expect(state.currentTeamAScore, 0);
    expect(state.currentTeamBScore, 0);
  });

  test('set extends after 24x24 until two-point lead', () async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await addPoints(teamA: 24, teamB: 24);
    await service.addPointToTeamA();
    expect(service.getState().activeMatch?.sets, isEmpty);

    await service.addPointToTeamA();
    final finishedSet = service.getState().activeMatch?.sets.single;
    expect(finishedSet?.teamAScore, 26);
    expect(finishedSet?.teamBScore, 24);
  });

  test('fifth set extends after 14x14 until two-point lead', () async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await addPoints(teamA: 25, teamB: 0);
    await addPoints(teamA: 0, teamB: 25);
    await addPoints(teamA: 25, teamB: 10);
    await addPoints(teamA: 12, teamB: 25);
    await addPoints(teamA: 14, teamB: 14);
    await service.addPointToTeamB();
    expect(service.getState().activeMatch?.matchStatus, MatchStatus.inProgress);

    await service.addPointToTeamB();
    final match = service.getState().activeMatch;
    expect(match?.matchStatus, MatchStatus.finished);
    expect(match?.sets.last.teamAScore, 14);
    expect(match?.sets.last.teamBScore, 16);
  });

  test('does not finish match when the same team wins the first two sets', () async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await addPoints(teamA: 25, teamB: 10);
    await addPoints(teamA: 25, teamB: 18);

    final match = service.getState().activeMatch;
    expect(match?.matchStatus, MatchStatus.inProgress);
    expect(match?.teamASetsWon, 2);
    expect(match?.teamBSetsWon, 0);
    expect(match?.currentSet, 3);
    expect(service.listHistory(), isEmpty);
  });

  test('opens fourth set after 2x1 and fifth set after 2x2', () async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await addPoints(teamA: 25, teamB: 23);
    expect(service.getState().activeMatch?.currentSet, 2);
    await addPoints(teamA: 19, teamB: 25);
    expect(service.getState().activeMatch?.currentSet, 3);
    await addPoints(teamA: 25, teamB: 21);

    final match = service.getState().activeMatch;
    expect(match?.currentSet, 4);
    expect(match?.teamASetsWon, 2);
    expect(match?.teamBSetsWon, 1);
    expect(match?.matchStatus, MatchStatus.inProgress);

    await addPoints(teamA: 20, teamB: 25);

    final tiedMatch = service.getState().activeMatch;
    expect(tiedMatch?.currentSet, 5);
    expect(tiedMatch?.teamASetsWon, 2);
    expect(tiedMatch?.teamBSetsWon, 2);
    expect(tiedMatch?.matchStatus, MatchStatus.inProgress);
  });

  test('finishes match 3x0 when the same team wins the first three sets', () async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await addPoints(teamA: 25, teamB: 10);
    await addPoints(teamA: 25, teamB: 18);
    await addPoints(teamA: 25, teamB: 20);

    final match = service.getState().activeMatch;
    expect(match?.matchStatus, MatchStatus.finished);
    expect(match?.teamASetsWon, 3);
    expect(match?.teamBSetsWon, 0);
    expect(service.listHistory(), hasLength(1));
  });

  test('finishes match 3x2 in deciding fifth set', () async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await addPoints(teamA: 25, teamB: 10);
    await addPoints(teamA: 22, teamB: 25);
    await addPoints(teamA: 25, teamB: 18);
    await addPoints(teamA: 20, teamB: 25);
    await addPoints(teamA: 15, teamB: 12);

    final match = service.getState().activeMatch;
    expect(match?.matchStatus, MatchStatus.finished);
    expect(match?.teamASetsWon, 3);
    expect(match?.teamBSetsWon, 2);
  });

  test('blocks scoring after match has finished', () async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await addPoints(teamA: 25, teamB: 10);
    await addPoints(teamA: 25, teamB: 10);
    await addPoints(teamA: 25, teamB: 10);
    final before = service.getState();

    await service.addPointToTeamB();
    final after = service.getState();
    expect(after.currentTeamAScore, before.currentTeamAScore);
    expect(after.currentTeamBScore, before.currentTeamBScore);
  });

  test('opens fifth set with a 15-point target when match is tied 2x2', () async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await addPoints(teamA: 25, teamB: 10);
    await addPoints(teamA: 18, teamB: 25);
    await addPoints(teamA: 25, teamB: 20);
    await addPoints(teamA: 20, teamB: 25);

    final match = service.getState().activeMatch;
    expect(match?.currentSet, 5);
    expect(service.getState().currentSetTargetPoints, 15);
    expect(match?.matchStatus, MatchStatus.inProgress);
  });

  test('beach mode finishes in two sets and limits match to three sets', () async {
    SportModeService.instance.selectMode(SportMode.beach);
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await addPoints(teamA: 25, teamB: 15);
    expect(service.getState().activeMatch?.currentSet, 2);

    await addPoints(teamA: 25, teamB: 22);

    final match = service.getState().activeMatch;
    expect(match?.sportMode, SportMode.beach);
    expect(match?.matchStatus, MatchStatus.finished);
    expect(match?.teamASetsWon, 2);
    expect(match?.currentSet, 2);
  });

  test('persists beach sport mode in saved match history', () async {
    SportModeService.instance.selectMode(SportMode.beach);
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await addPoints(teamA: 25, teamB: 15);
    await addPoints(teamA: 25, teamB: 19);

    final finished = service.listHistory().single;
    expect(finished.sportMode, SportMode.beach);

    service.clearCachedStateForTesting();
    await service.initialize();

    final reloaded = service.listHistory().single;
    expect(reloaded.sportMode, SportMode.beach);
  });

  test('undo never makes score negative and only affects current set', () async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    service.undoLastPoint();
    expect(service.getState().currentTeamAScore, 0);
    expect(service.getState().currentTeamBScore, 0);

    await service.addPointToTeamA();
    service.undoLastPoint();
    expect(service.getState().currentTeamAScore, 0);
    expect(service.getState().canUndo, isFalse);
  });

  test('reset clears sets current score and status for active match', () async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await addPoints(teamA: 10, teamB: 5);
    service.resetCurrentMatch();

    final state = service.getState();
    expect(state.activeMatch?.currentSet, 1);
    expect(state.activeMatch?.sets, isEmpty);
    expect(state.currentTeamAScore, 0);
    expect(state.currentTeamBScore, 0);
    expect(state.statusMessage, '1° set em andamento');
  });


  test('manual finish archives the current match in history', () async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await addPoints(teamA: 12, teamB: 9);
    await service.finishCurrentMatch();

    final history = service.listHistory();
    expect(history, hasLength(1));
    expect(history.single.matchStatus, MatchStatus.finished);
    expect(service.getMatchById(history.single.id), isNotNull);
  });

  test('manual finish with tied scoreboard ends in draw', () async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await addPoints(teamA: 12, teamB: 12);
    await service.finishCurrentMatch();

    final match = service.getState().activeMatch;
    expect(match?.matchStatus, MatchStatus.finished);
    expect(match?.winnerTeam, isNull);
    expect(match?.teamASetsWon, 0);
    expect(match?.teamBSetsWon, 0);
    expect(match?.sets.single.teamAScore, 12);
    expect(match?.sets.single.teamBScore, 12);
    expect(match?.sets.single.winnerTeamId, isEmpty);
    expect(service.getState().statusMessage, 'Partida encerrada em empate por 0x0.');
  });

  test('registers player point event for attack', () async {
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

    await service.addPoint(
      team: TeamSide.teamA,
      pointOrigin: PointOrigin.attack,
      player: player,
    );
    await service.finishCurrentMatch();

    final set = service.getState().activeMatch?.sets.single;
    expect(set?.pointEvents, hasLength(1));
    expect(set?.pointEvents.single.playerName, 'Joao');
    expect(set?.playerPointStats.single.points, 1);
    expect(set?.pointsByOrigin[PointOrigin.attack], 1);
  });

  test('registers opponent error without linking a player', () async {
    service.startMatch(teamAName: 'A', teamBName: 'B');

    await service.addPoint(
      team: TeamSide.teamA,
      pointOrigin: PointOrigin.opponentError,
    );
    await service.finishCurrentMatch();

    final set = service.getState().activeMatch?.sets.single;
    expect(set?.pointEvents.single.pointOrigin, PointOrigin.opponentError);
    expect(set?.pointEvents.single.playerId, isNull);
    expect(set?.pointsByOrigin[PointOrigin.opponentError], 1);
  });

  test('requires player when origin is attributable and roster exists', () async {
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

    await expectLater(
      service.addPoint(
        team: TeamSide.teamA,
        pointOrigin: PointOrigin.attack,
      ),
      throwsA(isA<ArgumentError>()),
    );
  });

  test('undo removes the last point event from the current set', () async {
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

    await service.addPoint(
      team: TeamSide.teamA,
      pointOrigin: PointOrigin.attack,
      player: player,
    );
    service.undoLastPoint();

    final state = service.getState();
    expect(state.currentTeamAScore, 0);
    expect(state.currentSetPointEvents, isEmpty);
  });
}
