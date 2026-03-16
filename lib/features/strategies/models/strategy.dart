import 'player_position.dart';
import 'movement.dart';
import 'substitution.dart';

class Strategy {
  const Strategy({
    required this.id,
    required this.name,
    required this.description,
    required this.playersPositions,
    required this.benchPlayers,
    required this.movements,
    required this.substitutions,
    required this.createdAt,
    required this.gameMode,
  });

  final String id;
  final String name;
  final String description;
  final List<PlayerPosition> playersPositions;
  final List<PlayerPosition> benchPlayers;
  final List<Movement> movements;
  final List<Substitution> substitutions;
  final DateTime createdAt;
  final StrategyGameMode gameMode;

  int get playersCount => playersPositions.length;
  int get regulationSubstitutionsCount =>
      substitutions.where((item) => item.countsTowardLimit).length;
  int get liberoExchangesCount =>
      substitutions.where((item) => item.isLiberoExchange).length;

  Strategy copyWith({
    String? id,
    String? name,
    String? description,
    List<PlayerPosition>? playersPositions,
    List<PlayerPosition>? benchPlayers,
    List<Movement>? movements,
    List<Substitution>? substitutions,
    DateTime? createdAt,
    StrategyGameMode? gameMode,
  }) {
    return Strategy(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      playersPositions: playersPositions ?? this.playersPositions,
      benchPlayers: benchPlayers ?? this.benchPlayers,
      movements: movements ?? this.movements,
      substitutions: substitutions ?? this.substitutions,
      createdAt: createdAt ?? this.createdAt,
      gameMode: gameMode ?? this.gameMode,
    );
  }

  factory Strategy.fromJson(Map<String, dynamic> json) {
    return Strategy(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      playersPositions: (json['playersPositions'] as List<dynamic>)
          .map((item) => PlayerPosition.fromJson(item as Map<String, dynamic>))
          .toList(),
      benchPlayers: (json['benchPlayers'] as List<dynamic>? ?? const [])
          .map((item) => PlayerPosition.fromJson(item as Map<String, dynamic>))
          .toList(),
      movements: (json['movements'] as List<dynamic>)
          .map((item) => Movement.fromJson(item as Map<String, dynamic>))
          .toList(),
      substitutions: (json['substitutions'] as List<dynamic>? ?? const [])
          .map((item) => Substitution.fromJson(item as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      gameMode: StrategyGameMode.values.byName(json['gameMode'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'playersPositions': playersPositions.map((item) => item.toJson()).toList(),
      'benchPlayers': benchPlayers.map((item) => item.toJson()).toList(),
      'movements': movements.map((item) => item.toJson()).toList(),
      'substitutions': substitutions.map((item) => item.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'gameMode': gameMode.name,
    };
  }
}
