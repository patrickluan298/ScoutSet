class Substitution {
  const Substitution({
    required this.id,
    required this.playerOutId,
    required this.playerInId,
    required this.createdAt,
    this.isLiberoExchange = false,
    this.countsTowardLimit = true,
  });

  final String id;
  final String playerOutId;
  final String playerInId;
  final DateTime createdAt;
  final bool isLiberoExchange;
  final bool countsTowardLimit;

  Substitution copyWith({
    String? id,
    String? playerOutId,
    String? playerInId,
    DateTime? createdAt,
    bool? isLiberoExchange,
    bool? countsTowardLimit,
  }) {
    return Substitution(
      id: id ?? this.id,
      playerOutId: playerOutId ?? this.playerOutId,
      playerInId: playerInId ?? this.playerInId,
      createdAt: createdAt ?? this.createdAt,
      isLiberoExchange: isLiberoExchange ?? this.isLiberoExchange,
      countsTowardLimit: countsTowardLimit ?? this.countsTowardLimit,
    );
  }

  factory Substitution.fromJson(Map<String, dynamic> json) {
    return Substitution(
      id: json['id'] as String,
      playerOutId: json['playerOutId'] as String,
      playerInId: json['playerInId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isLiberoExchange: json['isLiberoExchange'] as bool? ?? false,
      countsTowardLimit: json['countsTowardLimit'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'playerOutId': playerOutId,
      'playerInId': playerInId,
      'createdAt': createdAt.toIso8601String(),
      'isLiberoExchange': isLiberoExchange,
      'countsTowardLimit': countsTowardLimit,
    };
  }
}
