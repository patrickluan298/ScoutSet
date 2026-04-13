import '../../../models/sport_mode.dart';

class ScoreboardRules {
  const ScoreboardRules({
    required this.maxSets,
    required this.setsToWin,
    required this.regularSetTargetPoints,
    required this.finalSetTargetPoints,
  });

  final int maxSets;
  final int setsToWin;
  final int regularSetTargetPoints;
  final int finalSetTargetPoints;

  int targetPointsForSet(int setNumber) {
    return setNumber == maxSets ? finalSetTargetPoints : regularSetTargetPoints;
  }

  static const ScoreboardRules court = ScoreboardRules(
    maxSets: 5,
    setsToWin: 3,
    regularSetTargetPoints: 25,
    finalSetTargetPoints: 15,
  );

  static const ScoreboardRules beach = ScoreboardRules(
    maxSets: 3,
    setsToWin: 2,
    regularSetTargetPoints: 25,
    finalSetTargetPoints: 15,
  );

  static ScoreboardRules forMode(SportMode mode) {
    return mode == SportMode.beach ? beach : court;
  }
}
