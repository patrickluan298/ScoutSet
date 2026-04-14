import '../../../models/sport_mode.dart';

class ScoreboardRules {
  const ScoreboardRules({
    required this.maxSets,
    required this.setsToWin,
    required this.regularSetTargetPoints,
    required this.finalSetTargetPoints,
    this.regularSetSideChangePoints,
    this.finalSetSideChangePoints,
  });

  final int maxSets;
  final int setsToWin;
  final int regularSetTargetPoints;
  final int finalSetTargetPoints;
  final int? regularSetSideChangePoints;
  final int? finalSetSideChangePoints;

  int targetPointsForSet(int setNumber) {
    return setNumber == maxSets ? finalSetTargetPoints : regularSetTargetPoints;
  }

  int? sideChangePointsForSet(int setNumber) {
    return setNumber == maxSets
        ? finalSetSideChangePoints
        : regularSetSideChangePoints;
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
    regularSetTargetPoints: 21,
    finalSetTargetPoints: 15,
    regularSetSideChangePoints: 7,
    finalSetSideChangePoints: 5,
  );

  static ScoreboardRules forMode(SportMode mode) {
    return mode == SportMode.beach ? beach : court;
  }
}
