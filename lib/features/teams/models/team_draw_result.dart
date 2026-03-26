import 'draw_team.dart';
import 'waiting_player.dart';

enum DrawMode {
  random('random', 'Aleatório'),
  balanced('balanced', 'Balanceado'),
  manual('manual', 'Manual');

  const DrawMode(this.value, this.label);

  final String value;
  final String label;

  static DrawMode fromValue(String? value) {
    return DrawMode.values.firstWhere(
      (mode) => mode.value == value,
      orElse: () => DrawMode.random,
    );
  }
}

enum OddPlayerHandling {
  extraPlayerOnTeam('extra_player_on_team'),
  waitingQueue('waiting_queue');

  const OddPlayerHandling(this.value);

  final String value;

  static OddPlayerHandling fromValue(String? value) {
    return OddPlayerHandling.values.firstWhere(
      (handling) => handling.value == value,
      orElse: () => OddPlayerHandling.extraPlayerOnTeam,
    );
  }
}

class TeamDrawResult {
  const TeamDrawResult({
    required this.id,
    required this.contextKey,
    required this.createdAt,
    required this.totalPlayers,
    required this.numberOfTeams,
    required this.teams,
    required this.waitingPlayers,
    required this.drawMode,
    required this.oddPlayerHandling,
  });

  final String id;
  final String contextKey;
  final DateTime createdAt;
  final int totalPlayers;
  final int numberOfTeams;
  final List<DrawTeam> teams;
  final List<WaitingPlayer> waitingPlayers;
  final DrawMode drawMode;
  final OddPlayerHandling oddPlayerHandling;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contextKey': contextKey,
      'createdAt': createdAt.toIso8601String(),
      'totalPlayers': totalPlayers,
      'numberOfTeams': numberOfTeams,
      'teams': teams.map((team) => team.toJson()).toList(),
      'waitingPlayers': waitingPlayers.map((player) => player.toJson()).toList(),
      'drawMode': drawMode.value,
      'oddPlayerHandling': oddPlayerHandling.value,
    };
  }

  factory TeamDrawResult.fromJson(Map<String, dynamic> json) {
    return TeamDrawResult(
      id: json['id'] as String? ?? '',
      contextKey: json['contextKey'] as String? ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
      totalPlayers: json['totalPlayers'] as int? ?? 0,
      numberOfTeams: json['numberOfTeams'] as int? ?? 2,
      teams: (json['teams'] as List<dynamic>? ?? const [])
          .map((item) => DrawTeam.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList(),
      waitingPlayers: (json['waitingPlayers'] as List<dynamic>? ?? const [])
          .map((item) => WaitingPlayer.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList(),
      drawMode: DrawMode.fromValue(json['drawMode'] as String?),
      oddPlayerHandling: OddPlayerHandling.fromValue(json['oddPlayerHandling'] as String?),
    );
  }
}
