import 'match_score.dart';
import 'scoreboard_rules.dart';
import 'set_point_event.dart';

class ScoreboardSnapshot {
  const ScoreboardSnapshot({
    required this.teamAScore,
    required this.teamBScore,
    required this.servingTeam,
    required this.statusMessage,
    required this.currentSetStartedAt,
    required this.currentSetPointEvents,
  });

  final int teamAScore;
  final int teamBScore;
  final TeamSide servingTeam;
  final String statusMessage;
  final DateTime currentSetStartedAt;
  final List<SetPointEvent> currentSetPointEvents;
}

class ScoreboardState {
  const ScoreboardState({
    required this.history,
    required this.statusMessage,
    required this.canUndo,
    required this.currentTeamAScore,
    required this.currentTeamBScore,
    required this.currentSetStartedAt,
    required this.currentSetPointEvents,
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
        currentSetStartedAt = null,
        currentSetPointEvents = const [],
        lastSnapshot = null;

  final MatchScore? activeMatch;
  final List<MatchScore> history;
  final String statusMessage;
  final bool canUndo;
  final int currentTeamAScore;
  final int currentTeamBScore;
  final DateTime? currentSetStartedAt;
  final List<SetPointEvent> currentSetPointEvents;
  final ScoreboardSnapshot? lastSnapshot;

  bool get hasActiveMatch => activeMatch != null;

  bool get isMatchFinished => activeMatch?.matchStatus == MatchStatus.finished;

  int get currentSetTargetPoints {
    final match = activeMatch;
    if (match == null) {
      return scoreboardRegularSetTargetPoints;
    }

    return scoreboardTargetPointsForSet(match.currentSet);
  }

  ScoreboardState copyWith({
    Object? activeMatch = _sentinel,
    List<MatchScore>? history,
    String? statusMessage,
    bool? canUndo,
    int? currentTeamAScore,
    int? currentTeamBScore,
    Object? currentSetStartedAt = _sentinel,
    List<SetPointEvent>? currentSetPointEvents,
    Object? lastSnapshot = _sentinel,
  }) {
    return ScoreboardState(
      activeMatch: activeMatch == _sentinel ? this.activeMatch : activeMatch as MatchScore?,
      history: history ?? this.history,
      statusMessage: statusMessage ?? this.statusMessage,
      canUndo: canUndo ?? this.canUndo,
      currentTeamAScore: currentTeamAScore ?? this.currentTeamAScore,
      currentTeamBScore: currentTeamBScore ?? this.currentTeamBScore,
      currentSetStartedAt: currentSetStartedAt == _sentinel
          ? this.currentSetStartedAt
          : currentSetStartedAt as DateTime?,
      currentSetPointEvents: currentSetPointEvents ?? this.currentSetPointEvents,
      lastSnapshot:
          lastSnapshot == _sentinel ? this.lastSnapshot : lastSnapshot as ScoreboardSnapshot?,
    );
  }
}

const Object _sentinel = Object();
