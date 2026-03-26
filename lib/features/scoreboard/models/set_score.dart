class SetScore {
  const SetScore({
    required this.setNumber,
    required this.teamAScore,
    required this.teamBScore,
    required this.winnerTeamId,
    required this.targetPoints,
  });

  final int setNumber;
  final int teamAScore;
  final int teamBScore;
  final String winnerTeamId;
  final int targetPoints;

  bool get isFinished => winnerTeamId.isNotEmpty;

  Map<String, dynamic> toJson() {
    return {
      'setNumber': setNumber,
      'teamAScore': teamAScore,
      'teamBScore': teamBScore,
      'winnerTeamId': winnerTeamId,
      'targetPoints': targetPoints,
    };
  }

  factory SetScore.fromJson(Map<String, dynamic> json) {
    return SetScore(
      setNumber: json['setNumber'] as int? ?? 0,
      teamAScore: json['teamAScore'] as int? ?? 0,
      teamBScore: json['teamBScore'] as int? ?? 0,
      winnerTeamId: json['winnerTeamId'] as String? ?? '',
      targetPoints: json['targetPoints'] as int? ?? 0,
    );
  }

  SetScore copyWith({
    int? setNumber,
    int? teamAScore,
    int? teamBScore,
    String? winnerTeamId,
    int? targetPoints,
  }) {
    return SetScore(
      setNumber: setNumber ?? this.setNumber,
      teamAScore: teamAScore ?? this.teamAScore,
      teamBScore: teamBScore ?? this.teamBScore,
      winnerTeamId: winnerTeamId ?? this.winnerTeamId,
      targetPoints: targetPoints ?? this.targetPoints,
    );
  }
}
