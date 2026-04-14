import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/data/local/database/app_services.dart';
import 'package:scoutset/features/scoreboard/models/match_score.dart';
import 'package:scoutset/features/scoreboard/models/set_point_event.dart';
import 'package:scoutset/features/scoreboard/models/set_score.dart';
import 'package:scoutset/features/scoreboard/services/scoreboard_service.dart';
import 'package:scoutset/features/teams/models/team_draw_player.dart';
import 'package:scoutset/features/teams/services/team_draw_service.dart';
import 'package:scoutset/models/sport_mode.dart';
import 'package:scoutset/services/sport_mode_service.dart';

void main() {
  late ScoreboardService service;

  List<TeamDrawPlayer> beachDuo(String prefix) {
    return List.generate(
      2,
      (index) => TeamDrawPlayer(
        id: '$prefix$index',
        name: '${prefix.toUpperCase()} $index',
        position: 'Posicao $index',
        level: PlayerLevel.intermediario,
      ),
    );
  }

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
    final match =
        service.startMatch(teamAName: 'ScoutSet', teamBName: 'Rivais');

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

  test('does not finish match when the same team wins the first two sets',
      () async {
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

  test('finishes match 3x0 when the same team wins the first three sets',
      () async {
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

  test('opens fifth set with a 15-point target when match is tied 2x2',
      () async {
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

  test('beach mode finishes in two sets and limits match to three sets',
      () async {
    SportModeService.instance.selectMode(SportMode.beach);
    service.startMatch(
      teamAName: 'A',
      teamBName: 'B',
      teamAPlayers: beachDuo('a'),
      teamBPlayers: beachDuo('b'),
    );
    await addPoints(teamA: 21, teamB: 15);
    expect(service.getState().activeMatch?.currentSet, 2);

    await addPoints(teamA: 21, teamB: 19);

    final match = service.getState().activeMatch;
    expect(match?.sportMode, SportMode.beach);
    expect(match?.matchStatus, MatchStatus.finished);
    expect(match?.teamASetsWon, 2);
    expect(match?.currentSet, 2);
  });

  test('beach mode rejects teams that are not doubles', () {
    SportModeService.instance.selectMode(SportMode.beach);
    final trio = List.generate(
      3,
      (index) => TeamDrawPlayer(
        id: 'a$index',
        name: 'A $index',
        position: 'Posicao $index',
        level: PlayerLevel.intermediario,
      ),
    );
    final duo = List.generate(
      2,
      (index) => TeamDrawPlayer(
        id: 'b$index',
        name: 'B $index',
        position: 'Posicao $index',
        level: PlayerLevel.intermediario,
      ),
    );

    expect(
      () => service.startMatch(
        teamAName: 'A',
        teamBName: 'B',
        teamAPlayers: trio,
        teamBPlayers: duo,
      ),
      throwsA(
        isA<ArgumentError>().having(
          (error) => error.message,
          'message',
          'No volei de praia, o placar aceita apenas partidas com duplas completas de 2 atletas por equipe.',
        ),
      ),
    );
  });

  test('persists beach sport mode in saved match history', () async {
    SportModeService.instance.selectMode(SportMode.beach);
    service.startMatch(
      teamAName: 'A',
      teamBName: 'B',
      teamAPlayers: beachDuo('a'),
      teamBPlayers: beachDuo('b'),
    );
    await addPoints(teamA: 21, teamB: 15);
    await addPoints(teamA: 21, teamB: 19);

    final finished = service.listHistory().single;
    expect(finished.sportMode, SportMode.beach);

    service.clearCachedStateForTesting();
    await service.initialize();

    final reloaded = service.listHistory().single;
    expect(reloaded.sportMode, SportMode.beach);
  });

  test('cleans match history entries older than one week on refresh', () async {
    final expiredMatch = MatchScore(
      id: 'expired-match',
      teamAName: 'A',
      teamBName: 'B',
      currentSet: 2,
      sets: [
        SetScore(
          setNumber: 1,
          teamAScore: 25,
          teamBScore: 20,
          winnerTeamId: TeamSide.teamA.value,
          targetPoints: 25,
        ),
      ],
      teamASetsWon: 1,
      teamBSetsWon: 0,
      servingTeam: TeamSide.teamA,
      matchStatus: MatchStatus.finished,
      sourceType: MatchSourceType.manual,
      createdAt: DateTime(2026, 4, 1),
      finishedAt: DateTime(2026, 4, 1, 1),
      sportMode: SportMode.court,
      winnerTeam: TeamSide.teamA.value,
    );

    await AppServices.matchesRepository.saveFinishedMatch(expiredMatch);

    await service.refreshHistory();

    expect(service.listHistory(), isEmpty);
    final stored = await AppServices.matchesRepository.listHistory();
    expect(stored, isEmpty);
  });

  test('keeps matches finished within the last week even if created earlier',
      () async {
    final recentFinishedMatch = MatchScore(
      id: 'recent-finished-match',
      teamAName: 'A',
      teamBName: 'B',
      currentSet: 3,
      sets: [
        SetScore(
          setNumber: 1,
          teamAScore: 25,
          teamBScore: 18,
          winnerTeamId: TeamSide.teamA.value,
          targetPoints: 25,
        ),
        SetScore(
          setNumber: 2,
          teamAScore: 25,
          teamBScore: 21,
          winnerTeamId: TeamSide.teamA.value,
          targetPoints: 25,
        ),
      ],
      teamASetsWon: 2,
      teamBSetsWon: 0,
      servingTeam: TeamSide.teamA,
      matchStatus: MatchStatus.finished,
      sourceType: MatchSourceType.manual,
      createdAt: DateTime(2026, 4, 1),
      finishedAt: DateTime(2026, 4, 12),
      sportMode: SportMode.court,
      winnerTeam: TeamSide.teamA.value,
    );

    await AppServices.matchesRepository.saveFinishedMatch(recentFinishedMatch);

    await service.refreshHistory();

    expect(service.listHistory(), hasLength(1));
    expect(service.listHistory().single.id, 'recent-finished-match');
  });

  test('beach mode uses 21 points in regular sets', () async {
    SportModeService.instance.selectMode(SportMode.beach);
    service.startMatch(
      teamAName: 'A',
      teamBName: 'B',
      teamAPlayers: beachDuo('a'),
      teamBPlayers: beachDuo('b'),
    );

    await addPoints(teamA: 21, teamB: 19);

    final state = service.getState();
    expect(state.activeMatch?.sets, hasLength(1));
    expect(state.activeMatch?.sets.single.targetPoints, 21);
    expect(state.activeMatch?.currentSet, 2);
  });

  test('beach mode announces mandatory side change every 7 points', () async {
    SportModeService.instance.selectMode(SportMode.beach);
    service.startMatch(
      teamAName: 'A',
      teamBName: 'B',
      teamAPlayers: beachDuo('a'),
      teamBPlayers: beachDuo('b'),
    );

    await addPoints(teamA: 4, teamB: 3);

    expect(
      service.getState().statusMessage,
      '1° set em andamento\nTroca de lado obrigatoria.',
    );
  });

  test('beach deciding set announces mandatory side change every 5 points',
      () async {
    SportModeService.instance.selectMode(SportMode.beach);
    service.startMatch(
      teamAName: 'A',
      teamBName: 'B',
      teamAPlayers: beachDuo('a'),
      teamBPlayers: beachDuo('b'),
    );
    await addPoints(teamA: 21, teamB: 19);
    await addPoints(teamA: 18, teamB: 21);

    await addPoints(teamA: 3, teamB: 2);

    expect(
      service.getState().statusMessage,
      '3° set em andamento\nTroca de lado obrigatoria.',
    );
  });

  test('undo never makes score negative and only affects current set',
      () async {
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

  test('reset preserves the configured initial rotation order', () async {
    final players = List.generate(
      6,
      (index) => TeamDrawPlayer(
        id: 'p$index',
        name: 'Jogador $index',
        position: 'Posicao $index',
        level: PlayerLevel.intermediario,
      ),
    );

    service.startMatch(
      teamAName: 'A',
      teamBName: 'B',
      teamAPlayers: players,
      teamAStartingPlayers: [
        players[4],
        players[2],
        players[0],
        players[5],
        players[1],
        players[3],
      ],
    );
    await service.addPointToTeamB();

    service.resetCurrentMatch();

    final match = service.getState().activeMatch;
    expect(
      match?.teamAOnCourtPlayers.map((player) => player.id),
      ['p4', 'p2', 'p0', 'p5', 'p1', 'p3'],
    );
    expect(match?.servingTeam, TeamSide.teamA);
  });

  test('rejects manual finish before the match ends by rule', () async {
    service.startMatch(teamAName: 'A', teamBName: 'B');
    await addPoints(teamA: 12, teamB: 9);

    await expectLater(
      service.finishCurrentMatch(),
      throwsA(isA<ArgumentError>()),
    );
    expect(service.listHistory(), isEmpty);
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
    await addPoints(teamA: 24, teamB: 0);

    final set = service.getState().activeMatch?.sets.single;
    expect(set?.pointEvents, hasLength(25));
    expect(set?.pointEvents.first.playerName, 'Joao');
    expect(set?.playerPointStats.single.points, 1);
    expect(set?.pointsByOrigin[PointOrigin.attack], 1);
  });

  test('registers opponent error without linking a player', () async {
    service.startMatch(teamAName: 'A', teamBName: 'B');

    await service.addPoint(
      team: TeamSide.teamA,
      pointOrigin: PointOrigin.opponentError,
    );
    await addPoints(teamA: 24, teamB: 0);

    final set = service.getState().activeMatch?.sets.single;
    expect(set?.pointEvents.first.pointOrigin, PointOrigin.opponentError);
    expect(set?.pointEvents.first.playerId, isNull);
    expect(set?.pointsByOrigin[PointOrigin.opponentError], 1);
  });

  test('serve point uses the current indoor server automatically', () async {
    final teamAPlayers = List.generate(
      6,
      (index) => TeamDrawPlayer(
        id: 'a$index',
        name: 'A $index',
        position: 'Posicao $index',
        level: PlayerLevel.intermediario,
      ),
    );

    service.startMatch(
      teamAName: 'A',
      teamBName: 'B',
      teamAPlayers: teamAPlayers,
      teamBPlayers: const [
        TeamDrawPlayer(
          id: 'b1',
          name: 'B1',
          position: 'Defensor',
          level: PlayerLevel.intermediario,
        ),
        TeamDrawPlayer(
          id: 'b2',
          name: 'B2',
          position: 'Bloqueador',
          level: PlayerLevel.intermediario,
        ),
      ],
    );

    await service.addPoint(
      team: TeamSide.teamA,
      pointOrigin: PointOrigin.serve,
    );

    final event = service.getState().currentSetPointEvents.single;
    expect(event.playerId, 'a0');
    expect(event.playerName, 'A 0');
    expect(event.serverPlayerId, 'a0');
  });

  test('serve point uses the current beach server automatically', () async {
    SportModeService.instance.selectMode(SportMode.beach);
    const teamAPlayers = [
      TeamDrawPlayer(
        id: 'a1',
        name: 'A1',
        position: 'Defensor',
        level: PlayerLevel.intermediario,
      ),
      TeamDrawPlayer(
        id: 'a2',
        name: 'A2',
        position: 'Bloqueador',
        level: PlayerLevel.intermediario,
      ),
    ];

    service.startMatch(
      teamAName: 'A',
      teamBName: 'B',
      teamAPlayers: teamAPlayers,
      teamBPlayers: const [
        TeamDrawPlayer(
          id: 'b1',
          name: 'B1',
          position: 'Defensor',
          level: PlayerLevel.intermediario,
        ),
        TeamDrawPlayer(
          id: 'b2',
          name: 'B2',
          position: 'Bloqueador',
          level: PlayerLevel.intermediario,
        ),
      ],
    );

    await service.addPoint(
      team: TeamSide.teamA,
      pointOrigin: PointOrigin.serve,
    );

    final event = service.getState().currentSetPointEvents.single;
    expect(event.playerId, 'a1');
    expect(event.playerName, 'A1');
    expect(event.serverPlayerId, 'a1');
  });

  test('starts court match with configured initial rotation order', () {
    final players = List.generate(
      8,
      (index) => TeamDrawPlayer(
        id: 'p$index',
        name: 'Jogador $index',
        position: 'Posicao $index',
        level: PlayerLevel.intermediario,
      ),
    );

    final match = service.startMatch(
      teamAName: 'A',
      teamBName: 'B',
      teamAPlayers: players,
      teamAStartingPlayers: [
        players[3],
        players[1],
        players[5],
        players[0],
        players[4],
        players[2],
      ],
    );

    expect(
      match.teamAOnCourtPlayers.map((player) => player.id),
      ['p3', 'p1', 'p5', 'p0', 'p4', 'p2'],
    );
    expect(match.teamAPlayers.first.id, 'p3');
    expect(match.teamAPlayers[5].id, 'p2');
    expect(match.teamAPlayers[6].id, 'p6');
  });

  test('starts beach match with configured serving order', () {
    SportModeService.instance.selectMode(SportMode.beach);
    const players = [
      TeamDrawPlayer(
        id: 'a1',
        name: 'A1',
        position: 'Defensor',
        level: PlayerLevel.intermediario,
      ),
      TeamDrawPlayer(
        id: 'a2',
        name: 'A2',
        position: 'Bloqueador',
        level: PlayerLevel.intermediario,
      ),
    ];

    final match = service.startMatch(
      teamAName: 'A',
      teamBName: 'B',
      teamAPlayers: players,
      teamAStartingPlayers: [players[1], players[0]],
      teamBPlayers: const [
        TeamDrawPlayer(
          id: 'b1',
          name: 'B1',
          position: 'Defensor',
          level: PlayerLevel.intermediario,
        ),
        TeamDrawPlayer(
          id: 'b2',
          name: 'B2',
          position: 'Bloqueador',
          level: PlayerLevel.intermediario,
        ),
      ],
    );

    expect(
      match.teamAOnCourtPlayers.map((player) => player.id),
      ['a2', 'a1'],
    );
    expect(match.teamAPlayers.map((player) => player.id), ['a2', 'a1']);
  });

  test('receiving team rotates when it wins the rally and takes the serve',
      () async {
    final players = List.generate(
      6,
      (index) => TeamDrawPlayer(
        id: 'p$index',
        name: 'Jogador $index',
        position: 'Posicao $index',
        level: PlayerLevel.intermediario,
      ),
    );

    service.startMatch(
      teamAName: 'A',
      teamBName: 'B',
      teamAPlayers: players,
    );

    await service.addPointToTeamB();

    final match = service.getState().activeMatch;
    expect(match?.servingTeam, TeamSide.teamB);
    expect(match?.teamAOnCourtPlayers.map((player) => player.id),
        ['p0', 'p1', 'p2', 'p3', 'p4', 'p5']);
    expect(match?.teamBOnCourtPlayers, isEmpty);
  });

  test(
      'service order rotates inside the scoring team when it wins while receiving',
      () async {
    final teamBPlayers = List.generate(
      6,
      (index) => TeamDrawPlayer(
        id: 'b$index',
        name: 'B $index',
        position: 'Posicao $index',
        level: PlayerLevel.intermediario,
      ),
    );

    service.startMatch(
      teamAName: 'A',
      teamBName: 'B',
      teamBPlayers: teamBPlayers,
    );

    await service.addPointToTeamB();

    final match = service.getState().activeMatch;
    expect(match?.servingTeam, TeamSide.teamB);
    expect(
      match?.teamBOnCourtPlayers.map((player) => player.id),
      ['b1', 'b2', 'b3', 'b4', 'b5', 'b0'],
    );
  });

  test('serving team keeps the same service order when it wins the rally',
      () async {
    final teamAPlayers = List.generate(
      6,
      (index) => TeamDrawPlayer(
        id: 'a$index',
        name: 'A $index',
        position: 'Posicao $index',
        level: PlayerLevel.intermediario,
      ),
    );

    service.startMatch(
      teamAName: 'A',
      teamBName: 'B',
      teamAPlayers: teamAPlayers,
    );

    await service.addPointToTeamA();

    final match = service.getState().activeMatch;
    expect(match?.servingTeam, TeamSide.teamA);
    expect(
      match?.teamAOnCourtPlayers.map((player) => player.id),
      ['a0', 'a1', 'a2', 'a3', 'a4', 'a5'],
    );
  });

  test(
      'detects indoor rotational fault and awards point plus serve to opponent',
      () async {
    final teamAPlayers = List.generate(
      6,
      (index) => TeamDrawPlayer(
        id: 'a$index',
        name: 'A $index',
        position: 'Posicao $index',
        level: PlayerLevel.intermediario,
      ),
    );
    final teamBPlayers = List.generate(
      6,
      (index) => TeamDrawPlayer(
        id: 'b$index',
        name: 'B $index',
        position: 'Posicao $index',
        level: PlayerLevel.intermediario,
      ),
    );

    service.startMatch(
      teamAName: 'A',
      teamBName: 'B',
      teamAPlayers: teamAPlayers,
      teamBPlayers: teamBPlayers,
    );

    await service.addPoint(
      team: TeamSide.teamA,
      pointOrigin: PointOrigin.serve,
      player: teamAPlayers[1],
      serverPlayer: teamAPlayers[1],
    );

    final state = service.getState();
    final match = state.activeMatch;
    expect(state.currentTeamAScore, 0);
    expect(state.currentTeamBScore, 1);
    expect(match?.servingTeam, TeamSide.teamB);
    expect(
      state.currentSetPointEvents.single.pointOrigin,
      PointOrigin.rotationalFault,
    );
    expect(state.currentSetPointEvents.single.serverPlayerId, 'a1');
    expect(
      match?.teamBOnCourtPlayers.map((player) => player.id),
      ['b1', 'b2', 'b3', 'b4', 'b5', 'b0'],
    );
  });

  test('detects beach rotational fault and alternates the new server correctly',
      () async {
    SportModeService.instance.selectMode(SportMode.beach);
    const teamAPlayers = [
      TeamDrawPlayer(
        id: 'a1',
        name: 'A1',
        position: 'Defensor',
        level: PlayerLevel.intermediario,
      ),
      TeamDrawPlayer(
        id: 'a2',
        name: 'A2',
        position: 'Bloqueador',
        level: PlayerLevel.intermediario,
      ),
    ];
    const teamBPlayers = [
      TeamDrawPlayer(
        id: 'b1',
        name: 'B1',
        position: 'Defensor',
        level: PlayerLevel.intermediario,
      ),
      TeamDrawPlayer(
        id: 'b2',
        name: 'B2',
        position: 'Bloqueador',
        level: PlayerLevel.intermediario,
      ),
    ];

    service.startMatch(
      teamAName: 'A',
      teamBName: 'B',
      teamAPlayers: teamAPlayers,
      teamBPlayers: teamBPlayers,
    );

    await service.addPoint(
      team: TeamSide.teamA,
      pointOrigin: PointOrigin.attack,
      player: teamAPlayers[0],
      serverPlayer: teamAPlayers[1],
    );

    final state = service.getState();
    final match = state.activeMatch;
    expect(state.currentTeamAScore, 0);
    expect(state.currentTeamBScore, 1);
    expect(match?.servingTeam, TeamSide.teamB);
    expect(
      state.currentSetPointEvents.single.pointOrigin,
      PointOrigin.rotationalFault,
    );
    expect(
      match?.teamBOnCourtPlayers.map((player) => player.id),
      ['b2', 'b1'],
    );
  });

  test(
      'starts roster matches with first six players on court and no preset bench',
      () {
    final players = List.generate(
      8,
      (index) => TeamDrawPlayer(
        id: 'p$index',
        name: 'Jogador $index',
        position: 'Posicao $index',
        level: PlayerLevel.intermediario,
      ),
    );

    final match = service.startMatch(
      teamAName: 'A',
      teamBName: 'B',
      teamAPlayers: players,
    );

    expect(match.teamAOnCourtPlayers, hasLength(6));
    expect(match.teamABenchPlayers, isEmpty);
    expect(match.teamASetStarterIds, ['p0', 'p1', 'p2', 'p3', 'p4', 'p5']);
  });

  test(
      'applies a legal regulation substitution and allows only the starter to return',
      () async {
    final starters = List.generate(
      6,
      (index) => TeamDrawPlayer(
        id: 'p$index',
        name: 'Jogador $index',
        position: 'Posicao $index',
        level: PlayerLevel.intermediario,
      ),
    );
    await TeamDrawService.instance.savePlayer(
      id: 'p6',
      name: 'Reserva 6',
      position: 'Posicao 6',
      level: PlayerLevel.intermediario,
    );

    service.startMatch(
      teamAName: 'A',
      teamBName: 'B',
      teamAPlayers: starters,
    );

    await service.applySubstitution(
      team: TeamSide.teamA,
      playerOutId: 'p0',
      playerInId: 'p6',
    );

    final stateAfterEntry = service.getState();
    expect(
        stateAfterEntry.activeMatch?.teamAOnCourtPlayers
            .map((player) => player.id),
        contains('p6'));
    expect(stateAfterEntry.activeMatch?.teamASetSubstitutions, hasLength(1));

    await expectLater(
      service.applySubstitution(
        team: TeamSide.teamA,
        playerOutId: 'p6',
        playerInId: 'p5',
      ),
      throwsA(isA<ArgumentError>()),
    );

    await service.applySubstitution(
      team: TeamSide.teamA,
      playerOutId: 'p6',
      playerInId: 'p0',
    );

    final stateAfterReturn = service.getState();
    expect(
        stateAfterReturn.activeMatch?.teamAOnCourtPlayers
            .map((player) => player.id),
        contains('p0'));
    expect(
      stateAfterReturn.activeMatch?.teamASetSubstitutions
          .where((item) => item.countsTowardLimit),
      hasLength(2),
    );
  });

  test('resets substitution count and current starters when a new set starts',
      () async {
    final starters = List.generate(
      6,
      (index) => TeamDrawPlayer(
        id: 'p$index',
        name: 'Jogador $index',
        position: 'Posicao $index',
        level: PlayerLevel.intermediario,
      ),
    );
    await TeamDrawService.instance.savePlayer(
      id: 'p6',
      name: 'Reserva 6',
      position: 'Posicao 6',
      level: PlayerLevel.intermediario,
    );

    service.startMatch(
      teamAName: 'A',
      teamBName: 'B',
      teamAPlayers: starters,
    );
    await service.applySubstitution(
      team: TeamSide.teamA,
      playerOutId: 'p0',
      playerInId: 'p6',
    );

    await addPoints(teamA: 25, teamB: 0);

    final match = service.getState().activeMatch;
    expect(match?.currentSet, 2);
    expect(match?.teamASetSubstitutions, isEmpty);
    expect(match?.teamASetStarterIds, contains('p6'));
    expect(match?.teamASetStarterIds, isNot(contains('p0')));
  });

  test('requires player when origin is attributable and roster exists',
      () async {
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
