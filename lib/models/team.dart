import 'athlete.dart';

class Team {
  const Team({
    required this.id,
    required this.name,
    required this.athletes,
  });

  final String id;
  final String name;
  final List<Athlete> athletes;
}

