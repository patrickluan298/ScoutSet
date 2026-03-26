enum PlayerLevel {
  iniciante('iniciante', 1, 'Iniciante'),
  intermediario('intermediario', 2, 'Intermediário'),
  avancado('avancado', 3, 'Avançado');

  const PlayerLevel(this.value, this.weight, this.label);

  final String value;
  final int weight;
  final String label;

  static PlayerLevel fromValue(String? value) {
    return PlayerLevel.values.firstWhere(
      (level) => level.value == value,
      orElse: () => PlayerLevel.intermediario,
    );
  }
}

class TeamDrawPlayer {
  const TeamDrawPlayer({
    required this.id,
    required this.name,
    required this.position,
    required this.level,
    this.isSelected = false,
    this.wasWaitingLastRound = false,
  });

  final String id;
  final String name;
  final String position;
  final PlayerLevel level;
  final bool isSelected;
  final bool wasWaitingLastRound;

  TeamDrawPlayer copyWith({
    String? id,
    String? name,
    String? position,
    PlayerLevel? level,
    bool? isSelected,
    bool? wasWaitingLastRound,
  }) {
    return TeamDrawPlayer(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      level: level ?? this.level,
      isSelected: isSelected ?? this.isSelected,
      wasWaitingLastRound: wasWaitingLastRound ?? this.wasWaitingLastRound,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'level': level.value,
      'isSelected': isSelected,
      'wasWaitingLastRound': wasWaitingLastRound,
    };
  }

  factory TeamDrawPlayer.fromJson(Map<String, dynamic> json) {
    return TeamDrawPlayer(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      position: json['position'] as String? ?? '',
      level: PlayerLevel.fromValue(json['level'] as String?),
      isSelected: json['isSelected'] as bool? ?? false,
      wasWaitingLastRound: json['wasWaitingLastRound'] as bool? ?? false,
    );
  }
}
