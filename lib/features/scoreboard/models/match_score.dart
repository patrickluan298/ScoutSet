import '../../../models/sport_mode.dart';
import '../../teams/models/team_draw_player.dart';
import '../../teams/models/waiting_player.dart';
import 'set_score.dart';

enum MatchStatus {
  notStarted('not_started'),
  inProgress('in_progress'),
  finished('finished');

  const MatchStatus(this.value);

  final String value;

  String get label {
    switch (this) {
      case MatchStatus.notStarted:
        return 'Não iniciada';
      case MatchStatus.inProgress:
        return 'Em andamento';
      case MatchStatus.finished:
        return 'Finalizada';
    }
  }

  static MatchStatus fromValue(String? value) {
    return MatchStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => MatchStatus.notStarted,
    );
  }
}

enum TeamSide {
  teamA('team_a'),
  teamB('team_b');

  const TeamSide(this.value);

  final String value;

  static TeamSide fromValue(String? value) {
    return TeamSide.values.firstWhere(
      (team) => team.value == value,
      orElse: () => TeamSide.teamA,
    );
  }
}

enum MatchSourceType {
  manual('manual'),
  savedTeamGroup('saved_team_group');

  const MatchSourceType(this.value);

  final String value;

  static MatchSourceType fromValue(String? value) {
    return MatchSourceType.values.firstWhere(
      (sourceType) => sourceType.value == value,
      orElse: () => MatchSourceType.manual,
    );
  }
}

class MatchScore {
  const MatchScore({
    required this.id,
    required this.teamAName,
    required this.teamBName,
    required this.currentSet,
    required this.sets,
    required this.teamASetsWon,
    required this.teamBSetsWon,
    required this.servingTeam,
    required this.matchStatus,
    required this.sourceType,
    required this.createdAt,
    this.winnerTeam,
    this.finishedAt,
    this.sportMode = SportMode.court,
    this.savedTeamGroupId,
    this.savedTeamGroupTitle,
    this.teamAPlayers = const [],
    this.teamBPlayers = const [],
    this.teamAOriginTeamId,
    this.teamBOriginTeamId,
    this.waitingPlayersSnapshot = const [],
  });

  final String id;
  final String teamAName;
  final String teamBName;
  final int currentSet;
  final List<SetScore> sets;
  final int teamASetsWon;
  final int teamBSetsWon;
  final TeamSide servingTeam;
  final MatchStatus matchStatus;
  final MatchSourceType sourceType;
  final String? winnerTeam;
  final DateTime createdAt;
  final DateTime? finishedAt;
  final SportMode sportMode;
  final String? savedTeamGroupId;
  final String? savedTeamGroupTitle;
  final List<TeamDrawPlayer> teamAPlayers;
  final List<TeamDrawPlayer> teamBPlayers;
  final String? teamAOriginTeamId;
  final String? teamBOriginTeamId;
  final List<WaitingPlayer> waitingPlayersSnapshot;

  bool get isFinished => matchStatus == MatchStatus.finished;

  String get setsScoreLabel => '$teamASetsWon x $teamBSetsWon';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teamAName': teamAName,
      'teamBName': teamBName,
      'currentSet': currentSet,
      'sets': sets.map((set) => set.toJson()).toList(),
      'teamASetsWon': teamASetsWon,
      'teamBSetsWon': teamBSetsWon,
      'servingTeam': servingTeam.value,
      'matchStatus': matchStatus.value,
      'sourceType': sourceType.value,
      'winnerTeam': winnerTeam,
      'createdAt': createdAt.toIso8601String(),
      'finishedAt': finishedAt?.toIso8601String(),
      'sportMode': sportMode.value,
      'savedTeamGroupId': savedTeamGroupId,
      'savedTeamGroupTitle': savedTeamGroupTitle,
      'teamAPlayers': teamAPlayers.map((player) => player.toJson()).toList(),
      'teamBPlayers': teamBPlayers.map((player) => player.toJson()).toList(),
      'teamAOriginTeamId': teamAOriginTeamId,
      'teamBOriginTeamId': teamBOriginTeamId,
      'waitingPlayersSnapshot': waitingPlayersSnapshot.map((player) => player.toJson()).toList(),
    };
  }

  factory MatchScore.fromJson(Map<String, dynamic> json) {
    return MatchScore(
      id: json['id'] as String? ?? '',
      teamAName: json['teamAName'] as String? ?? '',
      teamBName: json['teamBName'] as String? ?? '',
      currentSet: json['currentSet'] as int? ?? 1,
      sets: (json['sets'] as List<dynamic>? ?? const [])
          .map((item) => SetScore.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList(),
      teamASetsWon: json['teamASetsWon'] as int? ?? 0,
      teamBSetsWon: json['teamBSetsWon'] as int? ?? 0,
      servingTeam: TeamSide.fromValue(json['servingTeam'] as String?),
      matchStatus: MatchStatus.fromValue(json['matchStatus'] as String?),
      sourceType: MatchSourceType.fromValue(json['sourceType'] as String?),
      winnerTeam: json['winnerTeam'] as String?,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
      finishedAt: DateTime.tryParse(json['finishedAt'] as String? ?? ''),
      sportMode: SportMode.fromValue(json['sportMode'] as String?),
      savedTeamGroupId: json['savedTeamGroupId'] as String?,
      savedTeamGroupTitle: json['savedTeamGroupTitle'] as String?,
      teamAPlayers: (json['teamAPlayers'] as List<dynamic>? ?? const [])
          .map((item) => TeamDrawPlayer.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList(),
      teamBPlayers: (json['teamBPlayers'] as List<dynamic>? ?? const [])
          .map((item) => TeamDrawPlayer.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList(),
      teamAOriginTeamId: json['teamAOriginTeamId'] as String?,
      teamBOriginTeamId: json['teamBOriginTeamId'] as String?,
      waitingPlayersSnapshot: (json['waitingPlayersSnapshot'] as List<dynamic>? ?? const [])
          .map((item) => WaitingPlayer.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList(),
    );
  }

  MatchScore copyWith({
    String? id,
    String? teamAName,
    String? teamBName,
    int? currentSet,
    List<SetScore>? sets,
    int? teamASetsWon,
    int? teamBSetsWon,
    TeamSide? servingTeam,
    MatchStatus? matchStatus,
    MatchSourceType? sourceType,
    Object? winnerTeam = _sentinel,
    DateTime? createdAt,
    Object? finishedAt = _sentinel,
    SportMode? sportMode,
    Object? savedTeamGroupId = _sentinel,
    Object? savedTeamGroupTitle = _sentinel,
    List<TeamDrawPlayer>? teamAPlayers,
    List<TeamDrawPlayer>? teamBPlayers,
    Object? teamAOriginTeamId = _sentinel,
    Object? teamBOriginTeamId = _sentinel,
    List<WaitingPlayer>? waitingPlayersSnapshot,
  }) {
    return MatchScore(
      id: id ?? this.id,
      teamAName: teamAName ?? this.teamAName,
      teamBName: teamBName ?? this.teamBName,
      currentSet: currentSet ?? this.currentSet,
      sets: sets ?? this.sets,
      teamASetsWon: teamASetsWon ?? this.teamASetsWon,
      teamBSetsWon: teamBSetsWon ?? this.teamBSetsWon,
      servingTeam: servingTeam ?? this.servingTeam,
      matchStatus: matchStatus ?? this.matchStatus,
      sourceType: sourceType ?? this.sourceType,
      winnerTeam: winnerTeam == _sentinel ? this.winnerTeam : winnerTeam as String?,
      createdAt: createdAt ?? this.createdAt,
      finishedAt: finishedAt == _sentinel ? this.finishedAt : finishedAt as DateTime?,
      sportMode: sportMode ?? this.sportMode,
      savedTeamGroupId:
          savedTeamGroupId == _sentinel ? this.savedTeamGroupId : savedTeamGroupId as String?,
      savedTeamGroupTitle: savedTeamGroupTitle == _sentinel
          ? this.savedTeamGroupTitle
          : savedTeamGroupTitle as String?,
      teamAPlayers: teamAPlayers ?? this.teamAPlayers,
      teamBPlayers: teamBPlayers ?? this.teamBPlayers,
      teamAOriginTeamId:
          teamAOriginTeamId == _sentinel ? this.teamAOriginTeamId : teamAOriginTeamId as String?,
      teamBOriginTeamId:
          teamBOriginTeamId == _sentinel ? this.teamBOriginTeamId : teamBOriginTeamId as String?,
      waitingPlayersSnapshot: waitingPlayersSnapshot ?? this.waitingPlayersSnapshot,
    );
  }
}

const Object _sentinel = Object();
