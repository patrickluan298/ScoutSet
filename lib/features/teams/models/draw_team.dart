import 'team_draw_player.dart';

class DrawTeam {
  const DrawTeam({
    required this.id,
    required this.name,
    required this.players,
  });

  final String id;
  final String name;
  final List<TeamDrawPlayer> players;

  int get totalLevelWeight => players.fold<int>(0, (sum, player) => sum + player.level.weight);

  DrawTeam copyWith({
    String? id,
    String? name,
    List<TeamDrawPlayer>? players,
  }) {
    return DrawTeam(
      id: id ?? this.id,
      name: name ?? this.name,
      players: players ?? this.players,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'players': players.map((player) => player.toJson()).toList(),
    };
  }

  factory DrawTeam.fromJson(Map<String, dynamic> json) {
    return DrawTeam(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      players: (json['players'] as List<dynamic>? ?? const [])
          .map((item) => TeamDrawPlayer.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList(),
    );
  }
}
