import 'set_score.dart';

enum MatchStatus {
  notStarted('not_started'),
  inProgress('in_progress'),
  finished('finished');

  const MatchStatus(this.value);

  final String value;

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
    required this.createdAt,
    this.winnerTeam,
    this.finishedAt,
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
  final String? winnerTeam;
  final DateTime createdAt;
  final DateTime? finishedAt;

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
      'winnerTeam': winnerTeam,
      'createdAt': createdAt.toIso8601String(),
      'finishedAt': finishedAt?.toIso8601String(),
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
      winnerTeam: json['winnerTeam'] as String?,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
      finishedAt: DateTime.tryParse(json['finishedAt'] as String? ?? ''),
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
    Object? winnerTeam = _sentinel,
    DateTime? createdAt,
    Object? finishedAt = _sentinel,
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
      winnerTeam: winnerTeam == _sentinel ? this.winnerTeam : winnerTeam as String?,
      createdAt: createdAt ?? this.createdAt,
      finishedAt: finishedAt == _sentinel ? this.finishedAt : finishedAt as DateTime?,
    );
  }
}

const Object _sentinel = Object();
