import 'package:flutter/material.dart';

enum MovementType {
  attack,
  move,
  block,
  defense,
  coverage,
}

class Movement {
  const Movement({
    required this.id,
    required this.playerId,
    required this.startPosition,
    required this.endPosition,
    required this.movementType,
  });

  final String id;
  final String playerId;
  final Offset startPosition;
  final Offset endPosition;
  final MovementType movementType;

  Movement copyWith({
    String? id,
    String? playerId,
    Offset? startPosition,
    Offset? endPosition,
    MovementType? movementType,
  }) {
    return Movement(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      startPosition: startPosition ?? this.startPosition,
      endPosition: endPosition ?? this.endPosition,
      movementType: movementType ?? this.movementType,
    );
  }

  factory Movement.fromJson(Map<String, dynamic> json) {
    return Movement(
      id: json['id'] as String,
      playerId: json['playerId'] as String,
      startPosition: Offset(
        (json['startDx'] as num).toDouble(),
        (json['startDy'] as num).toDouble(),
      ),
      endPosition: Offset(
        (json['endDx'] as num).toDouble(),
        (json['endDy'] as num).toDouble(),
      ),
      movementType: MovementType.values.byName(json['movementType'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'playerId': playerId,
      'startDx': startPosition.dx,
      'startDy': startPosition.dy,
      'endDx': endPosition.dx,
      'endDy': endPosition.dy,
      'movementType': movementType.name,
    };
  }
}
