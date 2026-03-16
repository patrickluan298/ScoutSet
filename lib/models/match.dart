class Match {
  const Match({
    required this.id,
    required this.teamA,
    required this.teamB,
    required this.sets,
    required this.date,
  });

  final String id;
  final String teamA;
  final String teamB;
  final List<int> sets;
  final DateTime date;
}

