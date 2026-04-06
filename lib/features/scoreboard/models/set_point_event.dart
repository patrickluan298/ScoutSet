import 'match_score.dart';

enum PointOrigin {
  attack('attack', 'Ataque', true),
  block('block', 'Bloqueio', true),
  serve('serve', 'Saque', true),
  opponentError('opponent_error', 'Erro adversário', false),
  other('other', 'Outro', false);

  const PointOrigin(this.value, this.label, this.requiresPlayer);

  final String value;
  final String label;
  final bool requiresPlayer;

  static PointOrigin fromValue(String? value) {
    return PointOrigin.values.firstWhere(
      (origin) => origin.value == value,
      orElse: () => PointOrigin.other,
    );
  }
}

class SetPointEvent {
  const SetPointEvent({
    required this.sequence,
    required this.scoringTeam,
    required this.pointOrigin,
    required this.recordedAt,
    this.playerId,
    this.playerName,
  });

  final int sequence;
  final TeamSide scoringTeam;
  final PointOrigin pointOrigin;
  final String? playerId;
  final String? playerName;
  final DateTime recordedAt;

  Map<String, dynamic> toJson() {
    return {
      'sequence': sequence,
      'scoringTeam': scoringTeam.value,
      'pointOrigin': pointOrigin.value,
      'playerId': playerId,
      'playerName': playerName,
      'recordedAt': recordedAt.toIso8601String(),
    };
  }

  factory SetPointEvent.fromJson(Map<String, dynamic> json) {
    return SetPointEvent(
      sequence: json['sequence'] as int? ?? 0,
      scoringTeam: TeamSide.fromValue(json['scoringTeam'] as String?),
      pointOrigin: PointOrigin.fromValue(json['pointOrigin'] as String?),
      playerId: json['playerId'] as String?,
      playerName: json['playerName'] as String?,
      recordedAt: DateTime.tryParse(json['recordedAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }
}

class PlayerPointStat {
  const PlayerPointStat({
    required this.playerId,
    required this.playerName,
    required this.teamSide,
    required this.points,
  });

  final String playerId;
  final String playerName;
  final TeamSide teamSide;
  final int points;
}
