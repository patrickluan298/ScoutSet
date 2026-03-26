class Drill {
  const Drill({
    required this.id,
    required this.name,
    required this.category,
    required this.objective,
    required this.difficulty,
    required this.duration,
    required this.players,
    required this.steps,
    required this.tips,
    required this.commonErrors,
    required this.variations,
    required this.animationFrames,
    this.isFavorite = false,
  });

  final String id;
  final String name;
  final String category;
  final String objective;
  final String difficulty;
  final String duration;
  final List<DrillPlayer> players;
  final List<String> steps;
  final List<String> tips;
  final List<String> commonErrors;
  final List<String> variations;
  final List<AnimationFrame> animationFrames;
  final bool isFavorite;

  int get playersCount => players.length;
}

class DrillPlayer {
  const DrillPlayer({
    required this.id,
    required this.label,
    required this.role,
    required this.colorHex,
  });

  final String id;
  final String label;
  final String role;
  final int colorHex;
}

class AnimationFrame {
  const AnimationFrame({
    required this.timestamp,
    required this.playersPositions,
    required this.movements,
    required this.stepIndex,
    this.highlightPlayerId,
    this.instructionText,
    this.ballPosition,
    this.highlightedZones = const [],
  });

  final int timestamp;
  final List<PlayerPosition> playersPositions;
  final List<MovementPath> movements;
  final int stepIndex;
  final String? highlightPlayerId;
  final String? instructionText;
  final BallPosition? ballPosition;
  final List<CourtZoneHighlight> highlightedZones;
}

class PlayerPosition {
  const PlayerPosition({
    required this.playerId,
    required this.x,
    required this.y,
  });

  final String playerId;
  final double x;
  final double y;
}

class MovementPath {
  const MovementPath({
    required this.playerId,
    required this.fromX,
    required this.fromY,
    required this.toX,
    required this.toY,
    required this.label,
  });

  final String playerId;
  final double fromX;
  final double fromY;
  final double toX;
  final double toY;
  final String label;
}

class BallPosition {
  const BallPosition({
    required this.x,
    required this.y,
  });

  final double x;
  final double y;
}

class CourtZoneHighlight {
  const CourtZoneHighlight({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.label,
  });

  final double x;
  final double y;
  final double width;
  final double height;
  final String label;
}
