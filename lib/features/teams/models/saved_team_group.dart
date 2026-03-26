import 'draw_team.dart';
import 'saved_team.dart';
import 'team_draw_result.dart';
import 'team_draw_player.dart';
import 'waiting_player.dart';

class SavedTeamGroup {
  const SavedTeamGroup({
    required this.id,
    required this.title,
    required this.teams,
    required this.waitingPlayers,
    required this.createdAt,
    required this.sourceType,
    this.contextKey,
    this.notes,
  });

  final String id;
  final String title;
  final List<DrawTeam> teams;
  final List<WaitingPlayer> waitingPlayers;
  final DateTime createdAt;
  final SavedGroupSourceType sourceType;
  final String? contextKey;
  final String? notes;

  int get totalPlayers =>
      teams.fold<int>(0, (sum, team) => sum + team.players.length) + waitingPlayers.length;

  SavedTeamGroup copyWith({
    String? id,
    String? title,
    List<DrawTeam>? teams,
    List<WaitingPlayer>? waitingPlayers,
    DateTime? createdAt,
    SavedGroupSourceType? sourceType,
    Object? contextKey = _sentinel,
    Object? notes = _sentinel,
  }) {
    return SavedTeamGroup(
      id: id ?? this.id,
      title: title ?? this.title,
      teams: teams ?? this.teams,
      waitingPlayers: waitingPlayers ?? this.waitingPlayers,
      createdAt: createdAt ?? this.createdAt,
      sourceType: sourceType ?? this.sourceType,
      contextKey: contextKey == _sentinel ? this.contextKey : contextKey as String?,
      notes: notes == _sentinel ? this.notes : notes as String?,
    );
  }

  factory SavedTeamGroup.fromDrawResult({
    required String id,
    required String title,
    required TeamDrawResult result,
    String? notes,
  }) {
    return SavedTeamGroup(
      id: id,
      title: title,
      teams: result.teams,
      waitingPlayers: result.waitingPlayers,
      createdAt: result.createdAt,
      sourceType: switch (result.drawMode) {
        DrawMode.random => SavedGroupSourceType.random,
        DrawMode.balanced => SavedGroupSourceType.balanced,
        DrawMode.manual => SavedGroupSourceType.manual,
      },
      contextKey: result.contextKey,
      notes: notes,
    );
  }

  List<TeamDrawPlayer> get allPlayers => [
        for (final team in teams) ...team.players,
      ];
}

const Object _sentinel = Object();
