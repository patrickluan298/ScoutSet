import 'package:drift/drift.dart';

import '../../../features/drills/models/drill.dart' as drill_model;
import '../database/app_database.dart';

class DrillsRepository {
  DrillsRepository(this._database);

  final AppDatabase _database;

  Future<List<drill_model.Drill>> listDrills() async {
    final rows = await (_database.select(_database.drills)
          ..orderBy([(t) => OrderingTerm(expression: t.name)]))
        .get();
    return Future.wait(rows.map(_mapDrillRow));
  }

  Future<drill_model.Drill?> getDrillById(String id) async {
    final row = await (_database.select(_database.drills)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _mapDrillRow(row);
  }

  Future<void> setFavorite({
    required String drillId,
    required bool isFavorite,
  }) async {
    await (_database.update(_database.drills)..where((tbl) => tbl.id.equals(drillId))).write(
      DrillsCompanion(
        isFavorite: Value(isFavorite),
      ),
    );
  }

  Future<void> clearAll() async {
    await _database.transaction(() async {
      await _database.delete(_database.drillFrameZones).go();
      await _database.delete(_database.drillFrameMovements).go();
      await _database.delete(_database.drillFramePlayers).go();
      await _database.delete(_database.drillAnimationFrames).go();
      await _database.delete(_database.drillVariations).go();
      await _database.delete(_database.drillErrors).go();
      await _database.delete(_database.drillTips).go();
      await _database.delete(_database.drillSteps).go();
      await _database.delete(_database.drillPlayers).go();
      await _database.delete(_database.drills).go();
    });
  }

  Future<drill_model.Drill> _mapDrillRow(Drill row) async {
    final players = await (_database.select(_database.drillPlayers)
          ..where((tbl) => tbl.drillId.equals(row.id))
          ..orderBy([(t) => OrderingTerm(expression: t.id)]))
        .get();
    final steps = await _orderedSteps(row.id);
    final tips = await _orderedTips(row.id);
    final errors = await _orderedErrors(row.id);
    final variations = await _orderedVariations(row.id);
    final frameRows = await (_database.select(_database.drillAnimationFrames)
          ..where((tbl) => tbl.drillId.equals(row.id))
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .get();

    final frames = <drill_model.AnimationFrame>[];
    for (final frameRow in frameRows) {
      final framePlayers = await (_database.select(_database.drillFramePlayers)
            ..where((tbl) => tbl.frameId.equals(frameRow.id))
            ..orderBy([(t) => OrderingTerm(expression: t.id)]))
          .get();
      final frameMovements = await (_database.select(_database.drillFrameMovements)
            ..where((tbl) => tbl.frameId.equals(frameRow.id))
            ..orderBy([(t) => OrderingTerm(expression: t.id)]))
          .get();
      final frameZones = await (_database.select(_database.drillFrameZones)
            ..where((tbl) => tbl.frameId.equals(frameRow.id))
            ..orderBy([(t) => OrderingTerm(expression: t.id)]))
          .get();

      frames.add(
        drill_model.AnimationFrame(
          timestamp: frameRow.timestamp,
          playersPositions: framePlayers
              .map(
                (player) => drill_model.PlayerPosition(
                  playerId: player.playerId,
                  x: player.x,
                  y: player.y,
                ),
              )
              .toList(),
          movements: frameMovements
              .map(
                (movement) => drill_model.MovementPath(
                  playerId: movement.playerId,
                  fromX: movement.fromX,
                  fromY: movement.fromY,
                  toX: movement.toX,
                  toY: movement.toY,
                  label: movement.label,
                ),
              )
              .toList(),
          stepIndex: frameRow.stepIndex,
          highlightPlayerId: frameRow.highlightPlayerId,
          instructionText: frameRow.instructionText,
          ballPosition: frameRow.ballX == null || frameRow.ballY == null
              ? null
              : drill_model.BallPosition(x: frameRow.ballX!, y: frameRow.ballY!),
          highlightedZones: frameZones
              .map(
                (zone) => drill_model.CourtZoneHighlight(
                  x: zone.x,
                  y: zone.y,
                  width: zone.width,
                  height: zone.height,
                  label: zone.label,
                ),
              )
              .toList(),
        ),
      );
    }

    return drill_model.Drill(
      id: row.id,
      name: row.name,
      category: row.category,
      objective: row.objective,
      difficulty: row.difficulty,
      duration: row.duration,
      players: players
          .map(
            (player) => drill_model.DrillPlayer(
              id: player.playerId,
              label: player.label,
              role: player.role,
              colorHex: player.colorHex,
            ),
          )
          .toList(),
      steps: steps,
      tips: tips,
      commonErrors: errors,
      variations: variations,
      animationFrames: frames,
      isFavorite: row.isFavorite,
    );
  }

  Future<List<String>> _orderedSteps(String drillId) async {
    final rows = await (_database.select(_database.drillSteps)
          ..where((tbl) => tbl.drillId.equals(drillId))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.sortOrder)]))
        .get();
    return rows.map((item) => item.textValue).toList();
  }

  Future<List<String>> _orderedTips(String drillId) async {
    final rows = await (_database.select(_database.drillTips)
          ..where((tbl) => tbl.drillId.equals(drillId))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.sortOrder)]))
        .get();
    return rows.map((item) => item.textValue).toList();
  }

  Future<List<String>> _orderedErrors(String drillId) async {
    final rows = await (_database.select(_database.drillErrors)
          ..where((tbl) => tbl.drillId.equals(drillId))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.sortOrder)]))
        .get();
    return rows.map((item) => item.textValue).toList();
  }

  Future<List<String>> _orderedVariations(String drillId) async {
    final rows = await (_database.select(_database.drillVariations)
          ..where((tbl) => tbl.drillId.equals(drillId))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.sortOrder)]))
        .get();
    return rows.map((item) => item.textValue).toList();
  }
}
