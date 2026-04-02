import 'set_point_event.dart';

class SetScore {
  const SetScore({
    required this.setNumber,
    required this.teamAScore,
    required this.teamBScore,
    required this.winnerTeamId,
    required this.targetPoints,
    this.durationSeconds = 0,
    this.pointEvents = const [],
  });

  final int setNumber;
  final int teamAScore;
  final int teamBScore;
  final String winnerTeamId;
  final int targetPoints;
  final int durationSeconds;
  final List<SetPointEvent> pointEvents;

  bool get isFinished => winnerTeamId.isNotEmpty;

  Duration get duration => Duration(seconds: durationSeconds);

  Map<PointOrigin, int> get pointsByOrigin {
    final totals = <PointOrigin, int>{};
    for (final event in pointEvents) {
      totals.update(event.pointOrigin, (value) => value + 1, ifAbsent: () => 1);
    }
    return totals;
  }

  List<PlayerPointStat> get playerPointStats {
    final totals = <String, PlayerPointStat>{};
    for (final event in pointEvents) {
      final playerId = event.playerId;
      final playerName = event.playerName;
      if (playerId == null ||
          playerId.isEmpty ||
          playerName == null ||
          playerName.isEmpty) {
        continue;
      }

      totals.update(
        playerId,
        (value) => PlayerPointStat(
          playerId: value.playerId,
          playerName: value.playerName,
          teamSide: value.teamSide,
          points: value.points + 1,
        ),
        ifAbsent: () => PlayerPointStat(
          playerId: playerId,
          playerName: playerName,
          teamSide: event.scoringTeam,
          points: 1,
        ),
      );
    }

    final stats = totals.values.toList()
      ..sort((a, b) {
        final byPoints = b.points.compareTo(a.points);
        if (byPoints != 0) {
          return byPoints;
        }
        return a.playerName.compareTo(b.playerName);
      });
    return stats;
  }

  Map<String, dynamic> toJson() {
    return {
      'setNumber': setNumber,
      'teamAScore': teamAScore,
      'teamBScore': teamBScore,
      'winnerTeamId': winnerTeamId,
      'targetPoints': targetPoints,
      'durationSeconds': durationSeconds,
      'pointEvents': pointEvents.map((event) => event.toJson()).toList(),
    };
  }

  factory SetScore.fromJson(Map<String, dynamic> json) {
    return SetScore(
      setNumber: json['setNumber'] as int? ?? 0,
      teamAScore: json['teamAScore'] as int? ?? 0,
      teamBScore: json['teamBScore'] as int? ?? 0,
      winnerTeamId: json['winnerTeamId'] as String? ?? '',
      targetPoints: json['targetPoints'] as int? ?? 0,
      durationSeconds: json['durationSeconds'] as int? ?? 0,
      pointEvents: (json['pointEvents'] as List<dynamic>? ?? const [])
          .map((item) =>
              SetPointEvent.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList(),
    );
  }

  SetScore copyWith({
    int? setNumber,
    int? teamAScore,
    int? teamBScore,
    String? winnerTeamId,
    int? targetPoints,
    int? durationSeconds,
    List<SetPointEvent>? pointEvents,
  }) {
    return SetScore(
      setNumber: setNumber ?? this.setNumber,
      teamAScore: teamAScore ?? this.teamAScore,
      teamBScore: teamBScore ?? this.teamBScore,
      winnerTeamId: winnerTeamId ?? this.winnerTeamId,
      targetPoints: targetPoints ?? this.targetPoints,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      pointEvents: pointEvents ?? this.pointEvents,
    );
  }
}
