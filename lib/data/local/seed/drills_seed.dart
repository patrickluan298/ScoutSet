import 'package:drift/drift.dart';

import '../database/app_database.dart';
import 'drills_seed_data.dart';

class DrillsSeed {
  const DrillsSeed._();

  static Future<void> seed(AppDatabase database) async {
    final existing = await database.select(database.drills).get();
    if (existing.isNotEmpty) {
      return;
    }

    final drills = kInitialDrills;

    await database.batch((batch) {
      for (final drill in drills) {
        batch.insert(
          database.drills,
          DrillsCompanion.insert(
            id: drill.id,
            name: drill.name,
            category: drill.category,
            objective: drill.objective,
            difficulty: drill.difficulty,
            duration: drill.duration,
            isFavorite: drill.isFavorite,
          ),
        );

        for (var i = 0; i < drill.players.length; i++) {
          final player = drill.players[i];
          batch.insert(
            database.drillPlayers,
            DrillPlayersCompanion.insert(
              id: '${drill.id}-player-$i',
              drillId: drill.id,
              playerId: player.id,
              label: player.label,
              role: player.role,
              colorHex: player.colorHex,
            ),
          );
        }

        for (var i = 0; i < drill.steps.length; i++) {
          batch.insert(
            database.drillSteps,
            DrillStepsCompanion.insert(
              id: '${drill.id}-step-$i',
              drillId: drill.id,
              sortOrder: i,
              textValue: drill.steps[i],
            ),
          );
        }

        for (var i = 0; i < drill.tips.length; i++) {
          batch.insert(
            database.drillTips,
            DrillTipsCompanion.insert(
              id: '${drill.id}-tip-$i',
              drillId: drill.id,
              sortOrder: i,
              textValue: drill.tips[i],
            ),
          );
        }

        for (var i = 0; i < drill.commonErrors.length; i++) {
          batch.insert(
            database.drillErrors,
            DrillErrorsCompanion.insert(
              id: '${drill.id}-error-$i',
              drillId: drill.id,
              sortOrder: i,
              textValue: drill.commonErrors[i],
            ),
          );
        }

        for (var i = 0; i < drill.variations.length; i++) {
          batch.insert(
            database.drillVariations,
            DrillVariationsCompanion.insert(
              id: '${drill.id}-variation-$i',
              drillId: drill.id,
              sortOrder: i,
              textValue: drill.variations[i],
            ),
          );
        }

        for (var i = 0; i < drill.animationFrames.length; i++) {
          final frame = drill.animationFrames[i];
          final frameId = '${drill.id}-frame-$i';
          batch.insert(
            database.drillAnimationFrames,
            DrillAnimationFramesCompanion.insert(
              id: frameId,
              drillId: drill.id,
              sortOrder: i,
              timestamp: frame.timestamp,
              stepIndex: frame.stepIndex,
              highlightPlayerId: Value(frame.highlightPlayerId),
              instructionText: Value(frame.instructionText),
              ballX: Value(frame.ballPosition?.x),
              ballY: Value(frame.ballPosition?.y),
            ),
          );

          for (var playerIndex = 0; playerIndex < frame.playersPositions.length; playerIndex++) {
            final player = frame.playersPositions[playerIndex];
            batch.insert(
              database.drillFramePlayers,
              DrillFramePlayersCompanion.insert(
                id: '$frameId-player-$playerIndex',
                frameId: frameId,
                playerId: player.playerId,
                x: player.x,
                y: player.y,
              ),
            );
          }

          for (var movementIndex = 0; movementIndex < frame.movements.length; movementIndex++) {
            final movement = frame.movements[movementIndex];
            batch.insert(
              database.drillFrameMovements,
              DrillFrameMovementsCompanion.insert(
                id: '$frameId-movement-$movementIndex',
                frameId: frameId,
                playerId: movement.playerId,
                fromX: movement.fromX,
                fromY: movement.fromY,
                toX: movement.toX,
                toY: movement.toY,
                label: movement.label,
              ),
            );
          }

          for (var zoneIndex = 0; zoneIndex < frame.highlightedZones.length; zoneIndex++) {
            final zone = frame.highlightedZones[zoneIndex];
            batch.insert(
              database.drillFrameZones,
              DrillFrameZonesCompanion.insert(
                id: '$frameId-zone-$zoneIndex',
                frameId: frameId,
                x: zone.x,
                y: zone.y,
                width: zone.width,
                height: zone.height,
                label: zone.label,
              ),
            );
          }
        }
      }
    });
  }
}
