import 'package:flutter/material.dart';

enum StrategyGameMode {
  indoor,
  beach,
}

class PlayerPosition {
  const PlayerPosition({
    required this.playerId,
    required this.label,
    required this.position,
    this.defaultPosition,
    this.isStarter = true,
    this.isLibero = false,
  });

  final String playerId;
  final String label;
  final Offset position;
  final Offset? defaultPosition;
  final bool isStarter;
  final bool isLibero;

  PlayerPosition copyWith({
    String? playerId,
    String? label,
    Offset? position,
    Offset? defaultPosition,
    bool? isStarter,
    bool? isLibero,
  }) {
    return PlayerPosition(
      playerId: playerId ?? this.playerId,
      label: label ?? this.label,
      position: position ?? this.position,
      defaultPosition: defaultPosition ?? this.defaultPosition,
      isStarter: isStarter ?? this.isStarter,
      isLibero: isLibero ?? this.isLibero,
    );
  }

  factory PlayerPosition.fromJson(Map<String, dynamic> json) {
    return PlayerPosition(
      playerId: json['playerId'] as String,
      label: json['label'] as String,
      position: Offset(
        (json['positionDx'] as num).toDouble(),
        (json['positionDy'] as num).toDouble(),
      ),
      isStarter: json['isStarter'] as bool? ?? true,
      isLibero: json['isLibero'] as bool? ?? false,
      defaultPosition: json['defaultDx'] == null || json['defaultDy'] == null
          ? null
          : Offset(
              (json['defaultDx'] as num).toDouble(),
              (json['defaultDy'] as num).toDouble(),
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'playerId': playerId,
      'label': label,
      'positionDx': position.dx,
      'positionDy': position.dy,
      'isStarter': isStarter,
      'isLibero': isLibero,
      'defaultDx': defaultPosition?.dx,
      'defaultDy': defaultPosition?.dy,
    };
  }
}
