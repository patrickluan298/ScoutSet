import 'package:flutter/material.dart';

import '../../../data/local/database/app_services.dart';
import '../../../data/local/repositories/strategies_repository.dart';
import '../models/movement.dart';
import '../models/player_position.dart';
import '../models/strategy.dart';
import '../models/substitution.dart';

class StrategyService {
  StrategyService._();

  static final StrategyService instance = StrategyService._();

  int _idCounter = 0;
  StrategiesRepository get _repository => AppServices.strategiesRepository;

  Future<void> initialize() async {
    await AppServices.initialize();
    final strategies = await _repository.listStrategies();
    _syncCounterFromStrategies(strategies);
  }

  Future<List<Strategy>> listStrategies() async {
    await initialize();
    final items = await _repository.listStrategies();
    items.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return items;
  }

  Future<Strategy?> getStrategyById(String id) async {
    await initialize();
    return _repository.getStrategyById(id);
  }

  Future<Strategy> createStrategy(Strategy strategy) async {
    await initialize();
    final created = strategy.copyWith(
      id: strategy.id.isEmpty ? _nextId('strategy') : strategy.id,
      playersPositions: _clonePlayers(strategy.playersPositions),
      benchPlayers: _clonePlayers(strategy.benchPlayers),
      movements: _cloneMovements(strategy.movements),
      substitutions: _cloneSubstitutions(strategy.substitutions),
    );
    return _repository.upsertStrategy(created);
  }

  Future<Strategy> updateStrategy(Strategy strategy) async {
    await initialize();
    final updated = strategy.copyWith(
      playersPositions: _clonePlayers(strategy.playersPositions),
      benchPlayers: _clonePlayers(strategy.benchPlayers),
      movements: _cloneMovements(strategy.movements),
      substitutions: _cloneSubstitutions(strategy.substitutions),
    );
    return _repository.upsertStrategy(updated);
  }

  Future<void> deleteStrategy(String id) async {
    await initialize();
    await _repository.deleteStrategy(id);
  }

  Future<void> clearAll() async {
    _idCounter = 0;
    await AppServices.initialize();
    await _repository.clearAll();
  }

  String nextMovementId() => _nextId('movement');
  String nextSubstitutionId() => _nextId('substitution');

  List<PlayerPosition> defaultPlayersForMode(StrategyGameMode mode) {
    final defaults = mode == StrategyGameMode.indoor
        ? _indoorDefaults
        : _beachDefaults;

    return defaults
        .map(
          (player) => PlayerPosition(
            playerId: player.playerId,
            label: player.label,
            position: player.position,
            defaultPosition: player.defaultPosition,
          ),
        )
        .toList();
  }

  List<PlayerPosition> defaultBenchPlayersForMode(StrategyGameMode mode) {
    if (mode == StrategyGameMode.beach) {
      return const [];
    }

    return _indoorBenchDefaults
        .map((player) => player.copyWith())
        .toList();
  }

  List<PlayerPosition> resetPlayersForMode(
    StrategyGameMode mode, {
    List<PlayerPosition>? existingPlayers,
  }) {
    final template = defaultPlayersForMode(mode);
    final currentById = {
      for (final player in existingPlayers ?? const <PlayerPosition>[])
        player.playerId: player,
    };

    return template
        .map((player) {
          final existing = currentById[player.playerId];
          return player.copyWith(
            label: existing?.label ?? player.label,
          );
        })
        .toList();
  }

  List<Movement> _cloneMovements(List<Movement> movements) {
    return movements.map((movement) => movement.copyWith()).toList();
  }

  List<Substitution> _cloneSubstitutions(List<Substitution> substitutions) {
    return substitutions.map((substitution) => substitution.copyWith()).toList();
  }

  List<PlayerPosition> _clonePlayers(List<PlayerPosition> players) {
    return players.map((player) => player.copyWith()).toList();
  }

  String _nextId(String prefix) {
    _idCounter += 1;
    return '$prefix-$_idCounter';
  }

  void _syncCounterFromStrategies(List<Strategy> strategies) {
    var highest = _idCounter;

    for (final strategy in strategies) {
      highest = _maxCounterValue(strategy.id, highest);
      for (final movement in strategy.movements) {
        highest = _maxCounterValue(movement.id, highest);
      }
      for (final substitution in strategy.substitutions) {
        highest = _maxCounterValue(substitution.id, highest);
      }
    }

    _idCounter = highest;
  }

  int _maxCounterValue(String id, int current) {
    final lastPart = id.split('-').last;
    final parsed = int.tryParse(lastPart);
    if (parsed == null || parsed <= current) {
      return current;
    }
    return parsed;
  }

  static const List<PlayerPosition> _indoorDefaults = [
    PlayerPosition(
      playerId: 'P1',
      label: '1',
      position: Offset(0.24, 0.82),
      defaultPosition: Offset(0.24, 0.82),
      isStarter: true,
    ),
    PlayerPosition(
      playerId: 'P2',
      label: '2',
      position: Offset(0.5, 0.82),
      defaultPosition: Offset(0.5, 0.82),
      isStarter: true,
    ),
    PlayerPosition(
      playerId: 'P3',
      label: '3',
      position: Offset(0.76, 0.82),
      defaultPosition: Offset(0.76, 0.82),
      isStarter: true,
    ),
    PlayerPosition(
      playerId: 'P4',
      label: '4',
      position: Offset(0.24, 0.62),
      defaultPosition: Offset(0.24, 0.62),
      isStarter: true,
    ),
    PlayerPosition(
      playerId: 'P5',
      label: '5',
      position: Offset(0.5, 0.62),
      defaultPosition: Offset(0.5, 0.62),
      isStarter: true,
    ),
    PlayerPosition(
      playerId: 'P6',
      label: '6',
      position: Offset(0.76, 0.62),
      defaultPosition: Offset(0.76, 0.62),
      isStarter: true,
    ),
  ];

  static const List<PlayerPosition> _indoorBenchDefaults = [
    PlayerPosition(
      playerId: 'B7',
      label: '7',
      position: Offset.zero,
      isStarter: false,
    ),
    PlayerPosition(
      playerId: 'B8',
      label: '8',
      position: Offset.zero,
      isStarter: false,
    ),
    PlayerPosition(
      playerId: 'B9',
      label: '9',
      position: Offset.zero,
      isStarter: false,
    ),
    PlayerPosition(
      playerId: 'B10',
      label: '10',
      position: Offset.zero,
      isStarter: false,
    ),
    PlayerPosition(
      playerId: 'B11',
      label: '11',
      position: Offset.zero,
      isStarter: false,
    ),
    PlayerPosition(
      playerId: 'B12',
      label: '12',
      position: Offset.zero,
      isStarter: false,
    ),
    PlayerPosition(
      playerId: 'L1',
      label: 'L',
      position: Offset.zero,
      isStarter: false,
      isLibero: true,
    ),
  ];

  static const List<PlayerPosition> _beachDefaults = [
    PlayerPosition(
      playerId: 'P1',
      label: '1',
      position: Offset(0.35, 0.76),
      defaultPosition: Offset(0.35, 0.76),
      isStarter: true,
    ),
    PlayerPosition(
      playerId: 'P2',
      label: '2',
      position: Offset(0.65, 0.62),
      defaultPosition: Offset(0.65, 0.62),
      isStarter: true,
    ),
  ];
}
