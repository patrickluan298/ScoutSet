import 'draw_team.dart';
import 'team_draw_player.dart';

enum SavedGroupSourceType {
  random('random', 'Sorteio Aleatório'),
  balanced('balanced', 'Sorteio Balanceado'),
  manual('manual', 'Montagem Manual');

  const SavedGroupSourceType(this.value, this.label);

  final String value;
  final String label;

  static SavedGroupSourceType fromValue(String? value) {
    return SavedGroupSourceType.values.firstWhere(
      (sourceType) => sourceType.value == value,
      orElse: () => SavedGroupSourceType.random,
    );
  }
}

class SavedTeam {
  const SavedTeam({
    required this.id,
    required this.name,
    required this.players,
    required this.createdAt,
    required this.sourceType,
  });

  final String id;
  final String name;
  final List<TeamDrawPlayer> players;
  final DateTime createdAt;
  final SavedGroupSourceType sourceType;

  factory SavedTeam.fromDrawTeam({
    required DrawTeam team,
    required DateTime createdAt,
    required SavedGroupSourceType sourceType,
  }) {
    return SavedTeam(
      id: team.id,
      name: team.name,
      players: team.players,
      createdAt: createdAt,
      sourceType: sourceType,
    );
  }
}
