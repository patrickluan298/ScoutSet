import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/features/strategies/models/movement.dart';
import 'package:scoutset/features/strategies/models/player_position.dart';
import 'package:scoutset/features/strategies/models/strategy.dart';
import 'package:scoutset/features/strategies/services/strategy_service.dart';
import 'package:scoutset/features/strategies/models/substitution.dart';

void main() {
  late StrategyService service;

  setUp(() {
    service = StrategyService.instance;
    service.clearAll();
  });

  test('create, list, update and delete strategies in memory', () {
    final createdAt = DateTime(2026, 3, 16);
    final strategy = Strategy(
      id: '',
      name: 'Saida rapida',
      description: 'Ataque pela ponta com cobertura.',
      playersPositions: service.defaultPlayersForMode(StrategyGameMode.indoor),
      benchPlayers: service.defaultBenchPlayersForMode(StrategyGameMode.indoor),
      movements: [
        const Movement(
          id: 'movement-a',
          playerId: 'P1',
          startPosition: Offset(0.24, 0.82),
          endPosition: Offset(0.4, 0.6),
          movementType: MovementType.attack,
        ),
      ],
      substitutions: const [],
      createdAt: createdAt,
      gameMode: StrategyGameMode.indoor,
    );

    final created = service.createStrategy(strategy);
    expect(created.id, isNotEmpty);
    expect(service.listStrategies(), hasLength(1));

    final updated = service.updateStrategy(
      created.copyWith(
        name: 'Saida rapida ajustada',
        description: 'Ataque pela ponta com ajuste no bloqueio.',
        movements: [
          const Movement(
            id: 'movement-b',
            playerId: 'P2',
            startPosition: Offset(0.5, 0.82),
            endPosition: Offset(0.55, 0.45),
            movementType: MovementType.block,
          ),
        ],
        substitutions: [
          Substitution(
            id: service.nextSubstitutionId(),
            playerOutId: 'P1',
            playerInId: 'B7',
            createdAt: createdAt,
          ),
        ],
      ),
    );

    expect(updated.createdAt, createdAt);
    expect(updated.name, 'Saida rapida ajustada');
    expect(updated.movements.single.movementType, MovementType.block);
    expect(updated.regulationSubstitutionsCount, 1);

    service.deleteStrategy(updated.id);
    expect(service.listStrategies(), isEmpty);
  });

  test('returns default player templates for indoor and beach', () {
    final indoorPlayers = service.resetPlayersForMode(StrategyGameMode.indoor);
    final beachPlayers = service.resetPlayersForMode(StrategyGameMode.beach);
    final indoorBench = service.defaultBenchPlayersForMode(StrategyGameMode.indoor);
    final beachBench = service.defaultBenchPlayersForMode(StrategyGameMode.beach);

    expect(indoorPlayers, hasLength(6));
    expect(beachPlayers, hasLength(2));
    expect(indoorBench, isNotEmpty);
    expect(indoorBench.any((player) => player.isLibero), isTrue);
    expect(beachBench, isEmpty);
  });
}
