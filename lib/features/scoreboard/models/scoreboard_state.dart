import 'match_score.dart';

class ScoreboardSnapshot {
  const ScoreboardSnapshot({
    required this.teamAScore,
    required this.teamBScore,
    required this.servingTeam,
    required this.statusMessage,
  });

  final int teamAScore;
  final int teamBScore;
  final TeamSide servingTeam;
  final String statusMessage;
}

class ScoreboardState {
  const ScoreboardState({
    required this.history,
    required this.statusMessage,
    required this.canUndo,
    required this.currentTeamAScore,
    required this.currentTeamBScore,
    this.activeMatch,
    this.lastSnapshot,
  });

  const ScoreboardState.initial()
      : activeMatch = null,
        history = const [],
        statusMessage = '',
        canUndo = false,
        currentTeamAScore = 0,
        currentTeamBScore = 0,
        lastSnapshot = null;

  final MatchScore? activeMatch;
  final List<MatchScore> history;
  final String statusMessage;
  final bool canUndo;
  final int currentTeamAScore;
  final int currentTeamBScore;
  final ScoreboardSnapshot? lastSnapshot;

  bool get hasActiveMatch => activeMatch != null;

  bool get isMatchFinished => activeMatch?.matchStatus == MatchStatus.finished;

  int get currentSetTargetPoints {
    final match = activeMatch;
    if (match == null) {
      return 25;
    }

    return match.currentSet == 3 ? 15 : 25;
  }

  ScoreboardState copyWith({
    Object? activeMatch = _sentinel,
    List<MatchScore>? history,
    String? statusMessage,
    bool? canUndo,
    int? currentTeamAScore,
    int? currentTeamBScore,
    Object? lastSnapshot = _sentinel,
  }) {
    return ScoreboardState(
      activeMatch: activeMatch == _sentinel ? this.activeMatch : activeMatch as MatchScore?,
      history: history ?? this.history,
      statusMessage: statusMessage ?? this.statusMessage,
      canUndo: canUndo ?? this.canUndo,
      currentTeamAScore: currentTeamAScore ?? this.currentTeamAScore,
      currentTeamBScore: currentTeamBScore ?? this.currentTeamBScore,
      lastSnapshot:
          lastSnapshot == _sentinel ? this.lastSnapshot : lastSnapshot as ScoreboardSnapshot?,
    );
  }
}

const Object _sentinel = Object();
