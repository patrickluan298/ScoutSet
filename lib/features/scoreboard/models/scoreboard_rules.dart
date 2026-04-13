const int scoreboardMaxSets = 5;
const int scoreboardSetsToWin = 3;
const int scoreboardRegularSetTargetPoints = 25;
const int scoreboardTieBreakSetTargetPoints = 15;

int scoreboardTargetPointsForSet(int setNumber) {
  return setNumber == scoreboardMaxSets
      ? scoreboardTieBreakSetTargetPoints
      : scoreboardRegularSetTargetPoints;
}
