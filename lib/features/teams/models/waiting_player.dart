class WaitingPlayer {
  const WaitingPlayer({
    required this.playerId,
    required this.playerName,
    required this.waitingSince,
    required this.priorityOrder,
  });

  final String playerId;
  final String playerName;
  final DateTime waitingSince;
  final int priorityOrder;

  Map<String, dynamic> toJson() {
    return {
      'playerId': playerId,
      'playerName': playerName,
      'waitingSince': waitingSince.toIso8601String(),
      'priorityOrder': priorityOrder,
    };
  }

  factory WaitingPlayer.fromJson(Map<String, dynamic> json) {
    return WaitingPlayer(
      playerId: json['playerId'] as String? ?? '',
      playerName: json['playerName'] as String? ?? '',
      waitingSince: DateTime.tryParse(json['waitingSince'] as String? ?? '') ?? DateTime.now(),
      priorityOrder: json['priorityOrder'] as int? ?? 0,
    );
  }
}
