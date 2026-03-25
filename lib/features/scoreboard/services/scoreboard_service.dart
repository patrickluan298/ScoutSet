import 'package:flutter/foundation.dart';

import '../models/match_score.dart';
import '../models/scoreboard_state.dart';
import '../models/set_score.dart';

class ScoreboardService {
  ScoreboardService._();

  static final ScoreboardService instance = ScoreboardService._();

  final ValueNotifier<ScoreboardState> stateNotifier = ValueNotifier<ScoreboardState>(
    const ScoreboardState.initial(),
  );

  int _idCounter = 0;

  ScoreboardState getState() => stateNotifier.value;

  String _inProgressSetLabel(int setNumber) => '$setNumber° set em andamento';

  MatchScore startMatch({
    required String teamAName,
    required String teamBName,
    String? servingTeam,
  }) {
    final normalizedTeamA = teamAName.trim().toUpperCase();
    final normalizedTeamB = teamBName.trim().toUpperCase();
    if (normalizedTeamA.isEmpty || normalizedTeamB.isEmpty) {
      throw ArgumentError('Os nomes dos times sao obrigatorios.');
    }
    if (normalizedTeamA.toLowerCase() == normalizedTeamB.toLowerCase()) {
      throw ArgumentError('Os times precisam ter nomes diferentes.');
    }

    final match = MatchScore(
      id: _nextId(),
      teamAName: normalizedTeamA,
      teamBName: normalizedTeamB,
      currentSet: 1,
      sets: const [],
      teamASetsWon: 0,
      teamBSetsWon: 0,
      servingTeam: TeamSide.fromValue(servingTeam),
      matchStatus: MatchStatus.inProgress,
      winnerTeam: null,
      createdAt: DateTime.now(),
      finishedAt: null,
    );

    _setState(
      ScoreboardState(
        activeMatch: match,
        history: stateNotifier.value.history,
        statusMessage: _inProgressSetLabel(1),
        canUndo: false,
        currentTeamAScore: 0,
        currentTeamBScore: 0,
        lastSnapshot: null,
      ),
    );

    return match;
  }

  ScoreboardState addPointToTeamA() => _addPoint(TeamSide.teamA);

  ScoreboardState addPointToTeamB() => _addPoint(TeamSide.teamB);

  ScoreboardState undoLastPoint() {
    final state = stateNotifier.value;
    final match = state.activeMatch;
    final snapshot = state.lastSnapshot;
    if (match == null || match.isFinished || snapshot == null) {
      return state;
    }

    _setState(
      state.copyWith(
        activeMatch: match.copyWith(servingTeam: snapshot.servingTeam),
        statusMessage: snapshot.statusMessage,
        canUndo: false,
        currentTeamAScore: snapshot.teamAScore,
        currentTeamBScore: snapshot.teamBScore,
        lastSnapshot: null,
      ),
    );

    return stateNotifier.value;
  }


  ScoreboardState resetCurrentMatch() {
    final state = stateNotifier.value;
    final match = state.activeMatch;
    if (match == null || match.isFinished) {
      return state;
    }

    _setState(
      state.copyWith(
        activeMatch: match.copyWith(
          currentSet: 1,
          sets: const [],
          teamASetsWon: 0,
          teamBSetsWon: 0,
          servingTeam: TeamSide.teamA,
          matchStatus: MatchStatus.inProgress,
          winnerTeam: null,
          finishedAt: null,
        ),
        statusMessage: _inProgressSetLabel(1),
        canUndo: false,
        currentTeamAScore: 0,
        currentTeamBScore: 0,
        lastSnapshot: null,
      ),
    );

    return stateNotifier.value;
  }

  ScoreboardState finishCurrentMatch() {
    final state = stateNotifier.value;
    final match = state.activeMatch;
    if (match == null || match.isFinished) {
      return state;
    }

    var updatedMatch = match;
    var displayTeamAScore = state.currentTeamAScore;
    var displayTeamBScore = state.currentTeamBScore;

    final setHasScore = state.currentTeamAScore > 0 || state.currentTeamBScore > 0;
    if (setHasScore) {
      final winner =
          state.currentTeamAScore >= state.currentTeamBScore ? TeamSide.teamA : TeamSide.teamB;
      final finalizedSet = SetScore(
        setNumber: match.currentSet,
        teamAScore: state.currentTeamAScore,
        teamBScore: state.currentTeamBScore,
        winnerTeamId: winner.value,
        targetPoints: _targetPointsForSet(match.currentSet),
      );
      updatedMatch = _applyFinishedSet(updatedMatch, finalizedSet);
    } else if (updatedMatch.sets.isNotEmpty) {
      final lastSet = updatedMatch.sets.last;
      displayTeamAScore = lastSet.teamAScore;
      displayTeamBScore = lastSet.teamBScore;
    }

    final finished = _finishMatch(updatedMatch);
    _publishFinishedMatch(
      finished,
      currentTeamAScore: displayTeamAScore,
      currentTeamBScore: displayTeamBScore,
      statusMessage: _buildMatchFinishedMessage(finished),
    );

    return stateNotifier.value;
  }

  ScoreboardState prepareForNewMatch() {
    _setState(
      ScoreboardState(
        activeMatch: null,
        history: stateNotifier.value.history,
        statusMessage: '',
        canUndo: false,
        currentTeamAScore: 0,
        currentTeamBScore: 0,
        lastSnapshot: null,
      ),
    );
    return stateNotifier.value;
  }

  List<MatchScore> listHistory() => List<MatchScore>.unmodifiable(stateNotifier.value.history);

  MatchScore? getMatchById(String id) {
    try {
      return stateNotifier.value.history.firstWhere((match) => match.id == id);
    } catch (_) {
      return null;
    }
  }

  @visibleForTesting
  void clearAll() {
    _idCounter = 0;
    _setState(const ScoreboardState.initial());
  }

  ScoreboardState _addPoint(TeamSide team) {
    final state = stateNotifier.value;
    final match = state.activeMatch;
    if (match == null || match.isFinished) {
      return state;
    }

    final snapshot = ScoreboardSnapshot(
      teamAScore: state.currentTeamAScore,
      teamBScore: state.currentTeamBScore,
      servingTeam: match.servingTeam,
      statusMessage: state.statusMessage,
    );

    var teamAScore = state.currentTeamAScore;
    var teamBScore = state.currentTeamBScore;
    if (team == TeamSide.teamA) {
      teamAScore += 1;
    } else {
      teamBScore += 1;
    }

    final updatedMatch = match.copyWith(servingTeam: team);
    final completedSet = _tryCloseSet(updatedMatch.currentSet, teamAScore, teamBScore);

    if (completedSet == null) {
      _setState(
        state.copyWith(
          activeMatch: updatedMatch,
          statusMessage: _inProgressSetLabel(updatedMatch.currentSet),
          canUndo: true,
          currentTeamAScore: teamAScore,
          currentTeamBScore: teamBScore,
          lastSnapshot: snapshot,
        ),
      );
      return stateNotifier.value;
    }

    final progressedMatch = _applyFinishedSet(updatedMatch, completedSet);
    final setWinnerName = completedSet.winnerTeamId == TeamSide.teamA.value
        ? progressedMatch.teamAName
        : progressedMatch.teamBName;

    if (progressedMatch.teamASetsWon == 2 || progressedMatch.teamBSetsWon == 2) {
      final finished = _finishMatch(progressedMatch);
      _publishFinishedMatch(
        finished,
        currentTeamAScore: completedSet.teamAScore,
        currentTeamBScore: completedSet.teamBScore,
        statusMessage: _buildMatchFinishedMessage(finished),
      );
      return stateNotifier.value;
    }

    _setState(
      state.copyWith(
        activeMatch: progressedMatch,
        statusMessage:
            '$setWinnerName venceu o set ${completedSet.setNumber}. ${_inProgressSetLabel(progressedMatch.currentSet)}',
        canUndo: false,
        currentTeamAScore: 0,
        currentTeamBScore: 0,
        lastSnapshot: null,
      ),
    );
    return stateNotifier.value;
  }

  SetScore? _tryCloseSet(int setNumber, int teamAScore, int teamBScore) {
    final targetPoints = _targetPointsForSet(setNumber);
    final hasReachedTarget = teamAScore >= targetPoints || teamBScore >= targetPoints;
    final hasRequiredLead = (teamAScore - teamBScore).abs() >= 2;
    if (!hasReachedTarget || !hasRequiredLead) {
      return null;
    }

    final winner = teamAScore > teamBScore ? TeamSide.teamA : TeamSide.teamB;
    return SetScore(
      setNumber: setNumber,
      teamAScore: teamAScore,
      teamBScore: teamBScore,
      winnerTeamId: winner.value,
      targetPoints: targetPoints,
    );
  }

  MatchScore _applyFinishedSet(MatchScore match, SetScore setScore) {
    final winner = TeamSide.fromValue(setScore.winnerTeamId);
    final teamASetsWon = match.teamASetsWon + (winner == TeamSide.teamA ? 1 : 0);
    final teamBSetsWon = match.teamBSetsWon + (winner == TeamSide.teamB ? 1 : 0);
    final shouldFinish = teamASetsWon == 2 || teamBSetsWon == 2 || setScore.setNumber == 3;
    final nextSet = shouldFinish ? setScore.setNumber : setScore.setNumber + 1;

    return match.copyWith(
      currentSet: nextSet,
      sets: [...match.sets, setScore],
      teamASetsWon: teamASetsWon,
      teamBSetsWon: teamBSetsWon,
    );
  }

  MatchScore _finishMatch(MatchScore match) {
    final winner = match.teamASetsWon >= match.teamBSetsWon ? TeamSide.teamA : TeamSide.teamB;
    return match.copyWith(
      matchStatus: MatchStatus.finished,
      winnerTeam: winner.value,
      finishedAt: DateTime.now(),
    );
  }

  void _publishFinishedMatch(
    MatchScore match, {
    required int currentTeamAScore,
    required int currentTeamBScore,
    required String statusMessage,
  }) {
    final currentHistory = stateNotifier.value.history.where((item) => item.id != match.id).toList();
    final updatedHistory = [match, ...currentHistory]
      ..sort((a, b) {
        final aDate = a.finishedAt ?? a.createdAt;
        final bDate = b.finishedAt ?? b.createdAt;
        return bDate.compareTo(aDate);
      });

    _setState(
      stateNotifier.value.copyWith(
        activeMatch: match,
        history: updatedHistory,
        statusMessage: statusMessage,
        canUndo: false,
        currentTeamAScore: currentTeamAScore,
        currentTeamBScore: currentTeamBScore,
        lastSnapshot: null,
      ),
    );
  }

  int _targetPointsForSet(int setNumber) => setNumber == 3 ? 15 : 25;

  String _buildMatchFinishedMessage(MatchScore match) {
    final winner = match.winnerTeam == TeamSide.teamA.value ? match.teamAName : match.teamBName;
    return 'Partida encerrada. $winner venceu por ${match.teamASetsWon}x${match.teamBSetsWon}.';
  }

  String _nextId() {
    _idCounter += 1;
    return 'scoreboard-match-$_idCounter';
  }

  void _setState(ScoreboardState state) {
    stateNotifier.value = state;
  }
}
