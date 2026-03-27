import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/data/local/database/app_services.dart';
import 'package:scoutset/features/teams/models/team_draw_player.dart';
import 'package:scoutset/features/teams/models/team_draw_result.dart';
import 'package:scoutset/features/teams/services/team_draw_service.dart';

void main() {
  final service = TeamDrawService.instance;

  setUp(() async {
    await AppServices.useInMemoryDatabaseForTesting();
    await service.clearAll();
    await service.savePlayer(name: 'Ana', position: 'Levantadora', level: PlayerLevel.iniciante);
    await service.savePlayer(name: 'Bruno', position: 'Central', level: PlayerLevel.intermediario);
    await service.savePlayer(name: 'Carla', position: 'Ponteira', level: PlayerLevel.avancado);
    await service.savePlayer(name: 'Diego', position: 'Líbero', level: PlayerLevel.iniciante);
    await service.savePlayer(name: 'Elaine', position: 'Oposta', level: PlayerLevel.intermediario);
    await service.savePlayer(name: 'Felipe', position: 'Central', level: PlayerLevel.avancado);
  });

  test('lista de jogadores inicia vazia em uma base nova', () async {
    await AppServices.useInMemoryDatabaseForTesting();
    await service.clearAll();

    final players = await service.listPlayers();

    expect(players, isEmpty);
  });

  test('rejeita sorteio com menos de 4 jogadores', () async {
    final players = (await service.listPlayers()).take(3).toList();

    expect(
      () => service.createDraw(
        selectedPlayers: players,
        numberOfTeams: 2,
        drawMode: DrawMode.random,
        oddPlayerHandling: OddPlayerHandling.extraPlayerOnTeam,
        testRandom: Random(1),
      ),
      throwsA(isA<ArgumentError>()),
    );
  });

  test('jogador aguardando recebe prioridade e nao repete sobra na rodada seguinte', () async {
    final players = (await service.listPlayers()).take(5).toList();

    final firstResult = await service.createDraw(
      selectedPlayers: players,
      numberOfTeams: 2,
      drawMode: DrawMode.random,
      oddPlayerHandling: OddPlayerHandling.waitingQueue,
      testRandom: Random(2),
    );

    final secondResult = await service.createDraw(
      selectedPlayers: players,
      numberOfTeams: 2,
      drawMode: DrawMode.random,
      oddPlayerHandling: OddPlayerHandling.waitingQueue,
      testRandom: Random(3),
    );

    expect(firstResult.waitingPlayers, hasLength(1));
    expect(secondResult.waitingPlayers, hasLength(1));
    expect(
      secondResult.waitingPlayers.single.playerId,
      isNot(equals(firstResult.waitingPlayers.single.playerId)),
    );
  });

  test('sorteio balanceado distribui niveis sem concentrar avancados no mesmo time', () async {
    final players = await service.listPlayers();

    final result = await service.createDraw(
      selectedPlayers: players,
      numberOfTeams: 2,
      drawMode: DrawMode.balanced,
      oddPlayerHandling: OddPlayerHandling.extraPlayerOnTeam,
      testRandom: Random(4),
    );

    expect(result.teams, hasLength(2));
    final advancedCounts = result.teams
        .map((team) => team.players.where((player) => player.level == PlayerLevel.avancado).length)
        .toList();
    expect(advancedCounts.every((count) => count >= 1), isTrue);
  });

  test('permite 2 equipes com 13 jogadores apenas quando houver fila de espera', () async {
    for (var i = 0; i < 7; i++) {
      await service.savePlayer(
        name: 'Jog$i',
        position: 'Ponteiro',
        level: PlayerLevel.intermediario,
      );
    }

    final players = await service.listPlayers();

    final result = await service.createDraw(
      selectedPlayers: players,
      numberOfTeams: 2,
      drawMode: DrawMode.random,
      oddPlayerHandling: OddPlayerHandling.waitingQueue,
      testRandom: Random(7),
    );

    expect(result.waitingPlayers, hasLength(1));
    expect(result.teams.every((team) => team.players.length <= TeamDrawService.maxPlayersPerTeam), isTrue);
  });

  test('rejeita 2 equipes com 14 jogadores por exceder 6 jogadores por time', () async {
    for (var i = 0; i < 8; i++) {
      await service.savePlayer(
        name: 'Novo$i',
        position: 'Central',
        level: PlayerLevel.intermediario,
      );
    }

    final players = await service.listPlayers();

    expect(service.allowedTeamCounts(players.length), isNot(contains(2)));
    expect(
      () => service.createDraw(
        selectedPlayers: players,
        numberOfTeams: 2,
        drawMode: DrawMode.random,
        oddPlayerHandling: OddPlayerHandling.extraPlayerOnTeam,
        testRandom: Random(8),
      ),
      throwsA(isA<ArgumentError>()),
    );
  });
}
