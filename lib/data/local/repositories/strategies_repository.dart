import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../../../features/strategies/models/movement.dart';
import '../../../features/strategies/models/player_position.dart';
import '../../../features/strategies/models/strategy.dart' as strategy_model;
import '../../../features/strategies/models/substitution.dart';
import '../database/app_database.dart';

class StrategiesRepository {
  StrategiesRepository(this._database);

  final AppDatabase _database;

  Future<List<strategy_model.Strategy>> listStrategies() async {
    final strategyRows = await (_database.select(_database.strategies)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
    return Future.wait(strategyRows.map(_mapStrategyRow));
  }

  Future<strategy_model.Strategy?> getStrategyById(String id) async {
    final row = await (_database.select(_database.strategies)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _mapStrategyRow(row);
  }

  Future<strategy_model.Strategy> upsertStrategy(strategy_model.Strategy strategy) async {
    await _database.transaction(() async {
      await _database.into(_database.strategies).insertOnConflictUpdate(
            StrategiesCompanion.insert(
              id: strategy.id,
              name: strategy.name,
              description: strategy.description,
              gameMode: strategy.gameMode.name,
              createdAt: strategy.createdAt.toIso8601String(),
            ),
          );

      await (_database.delete(_database.strategyPlayers)
            ..where((tbl) => tbl.strategyId.equals(strategy.id)))
          .go();
      await (_database.delete(_database.strategyMovements)
            ..where((tbl) => tbl.strategyId.equals(strategy.id)))
          .go();
      await (_database.delete(_database.strategySubstitutions)
            ..where((tbl) => tbl.strategyId.equals(strategy.id)))
          .go();

      await _database.batch((batch) {
        for (var index = 0; index < strategy.playersPositions.length; index++) {
          final player = strategy.playersPositions[index];
          batch.insert(
            _database.strategyPlayers,
            StrategyPlayersCompanion.insert(
              id: '${strategy.id}-${player.playerId}-court',
              strategyId: strategy.id,
              sortOrder: Value(index),
              playerId: player.playerId,
              label: player.label,
              x: player.position.dx,
              y: player.position.dy,
              defaultX: Value(player.defaultPosition?.dx),
              defaultY: Value(player.defaultPosition?.dy),
              isStarter: player.isStarter,
              isLibero: player.isLibero,
              isBench: false,
            ),
          );
        }

        for (var index = 0; index < strategy.benchPlayers.length; index++) {
          final player = strategy.benchPlayers[index];
          batch.insert(
            _database.strategyPlayers,
            StrategyPlayersCompanion.insert(
              id: '${strategy.id}-${player.playerId}-bench',
              strategyId: strategy.id,
              sortOrder: Value(index),
              playerId: player.playerId,
              label: player.label,
              x: player.position.dx,
              y: player.position.dy,
              defaultX: Value(player.defaultPosition?.dx),
              defaultY: Value(player.defaultPosition?.dy),
              isStarter: player.isStarter,
              isLibero: player.isLibero,
              isBench: true,
            ),
          );
        }

        for (var index = 0; index < strategy.movements.length; index++) {
          final movement = strategy.movements[index];
          batch.insert(
            _database.strategyMovements,
            StrategyMovementsCompanion.insert(
              id: movement.id,
              strategyId: strategy.id,
              sortOrder: Value(index),
              playerId: movement.playerId,
              fromX: movement.startPosition.dx,
              fromY: movement.startPosition.dy,
              toX: movement.endPosition.dx,
              toY: movement.endPosition.dy,
              movementType: movement.movementType.name,
            ),
          );
        }

        for (final substitution in strategy.substitutions) {
          batch.insert(
            _database.strategySubstitutions,
            StrategySubstitutionsCompanion.insert(
              id: substitution.id,
              strategyId: strategy.id,
              playerOutId: substitution.playerOutId,
              playerInId: substitution.playerInId,
              createdAt: substitution.createdAt.toIso8601String(),
              countsTowardLimit: substitution.countsTowardLimit,
              isLiberoExchange: substitution.isLiberoExchange,
            ),
          );
        }
      });
    });

    return (await getStrategyById(strategy.id))!;
  }

  Future<void> deleteStrategy(String id) async {
    await _database.transaction(() async {
      await (_database.delete(_database.strategyPlayers)..where((tbl) => tbl.strategyId.equals(id))).go();
      await (_database.delete(_database.strategyMovements)..where((tbl) => tbl.strategyId.equals(id))).go();
      await (_database.delete(_database.strategySubstitutions)..where((tbl) => tbl.strategyId.equals(id))).go();
      await (_database.delete(_database.strategies)..where((tbl) => tbl.id.equals(id))).go();
    });
  }

  Future<void> clearAll() async {
    await _database.transaction(() async {
      await _database.delete(_database.strategyPlayers).go();
      await _database.delete(_database.strategyMovements).go();
      await _database.delete(_database.strategySubstitutions).go();
      await _database.delete(_database.strategies).go();
    });
  }

  Future<strategy_model.Strategy> _mapStrategyRow(Strategy row) async {
    final playerRows = await (_database.select(_database.strategyPlayers)
          ..where((tbl) => tbl.strategyId.equals(row.id))
          ..orderBy([(t) => OrderingTerm(expression: t.isBench), (t) => OrderingTerm(expression: t.sortOrder)]))
        .get();
    final movementRows = await (_database.select(_database.strategyMovements)
          ..where((tbl) => tbl.strategyId.equals(row.id))
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .get();
    final substitutionRows = await (_database.select(_database.strategySubstitutions)
          ..where((tbl) => tbl.strategyId.equals(row.id))
          ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]))
        .get();

    final courtPlayers = playerRows.where((item) => !item.isBench).map(_mapStrategyPlayer).toList();
    final benchPlayers = playerRows.where((item) => item.isBench).map(_mapStrategyPlayer).toList();

    return strategy_model.Strategy(
      id: row.id,
      name: row.name,
      description: row.description,
      playersPositions: courtPlayers,
      benchPlayers: benchPlayers,
      movements: movementRows.map(_mapMovement).toList(),
      substitutions: substitutionRows.map(_mapSubstitution).toList(),
      createdAt: DateTime.parse(row.createdAt),
      gameMode: StrategyGameMode.values.byName(row.gameMode),
    );
  }

  PlayerPosition _mapStrategyPlayer(StrategyPlayer row) {
    return PlayerPosition(
      playerId: row.playerId,
      label: row.label,
      position: Offset(row.x, row.y),
      defaultPosition:
          row.defaultX == null || row.defaultY == null ? null : Offset(row.defaultX!, row.defaultY!),
      isStarter: row.isStarter,
      isLibero: row.isLibero,
    );
  }

  Movement _mapMovement(StrategyMovement row) {
    return Movement(
      id: row.id,
      playerId: row.playerId,
      startPosition: Offset(row.fromX, row.fromY),
      endPosition: Offset(row.toX, row.toY),
      movementType: MovementType.values.byName(row.movementType),
    );
  }

  Substitution _mapSubstitution(StrategySubstitution row) {
    return Substitution(
      id: row.id,
      playerOutId: row.playerOutId,
      playerInId: row.playerInId,
      createdAt: DateTime.parse(row.createdAt),
      countsTowardLimit: row.countsTowardLimit,
      isLiberoExchange: row.isLiberoExchange,
    );
  }
}
