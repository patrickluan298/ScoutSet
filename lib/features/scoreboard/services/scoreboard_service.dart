import 'package:flutter/foundation.dart';

import '../../../data/local/database/app_services.dart';
import '../../../data/local/repositories/matches_repository.dart';
import '../../../models/sport_mode.dart';
import '../../../services/sport_mode_service.dart';
import '../../teams/models/team_draw_player.dart';
import '../../teams/models/waiting_player.dart';
import '../models/match_score.dart';
import '../models/scoreboard_rules.dart';
import '../models/scoreboard_state.dart';
import '../models/set_point_event.dart';
import '../models/set_score.dart';

class ScoreboardService {
  static final RegExp _allowedTeamNamePattern = RegExp(r'^[A-Za-z0-9À-ÖØ-öø-ÿ ]+$');

  ScoreboardService._();

  static final ScoreboardService instance = ScoreboardService._();

  final ValueNotifier<ScoreboardState> stateNotifier = ValueNotifier<ScoreboardState>(
    const ScoreboardState.initial(),
  );

  int _idCounter = 0;
  bool _initialized = false;

  MatchesRepository get _repository => AppServices.matchesRepository;

  Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    await AppServices.initialize();
    final history = await _repository.listHistory();
    _syncCounterFromHistory(history);
    _setState(
      ScoreboardState(
        activeMatch: stateNotifier.value.activeMatch,
        history: history,
        statusMessage: stateNotifier.value.statusMessage,
        canUndo: stateNotifier.value.canUndo,
        currentTeamAScore: stateNotifier.value.currentTeamAScore,
        currentTeamBScore: stateNotifier.value.currentTeamBScore,
        currentSetStartedAt: stateNotifier.value.currentSetStartedAt,
        currentSetPointEvents: stateNotifier.value.currentSetPointEvents,
        lastSnapshot: stateNotifier.value.lastSnapshot,
      ),
    );
    _initialized = true;
  }

  ScoreboardState getState() => stateNotifier.value;

  String _inProgressSetLabel(int setNumber) => '$setNumber° set em andamento';

  MatchScore startMatch({
    required String teamAName,
    required String teamBName,
    String? servingTeam,
    MatchSourceType sourceType = MatchSourceType.manual,
    String? savedTeamGroupId,
    String? savedTeamGroupTitle,
    List<TeamDrawPlayer> teamAPlayers = const [],
    List<TeamDrawPlayer> teamBPlayers = const [],
    String? teamAOriginTeamId,
    String? teamBOriginTeamId,
    List<WaitingPlayer> waitingPlayersSnapshot = const [],
  }) {
    final startedAt = DateTime.now();
    final normalizedTeamA = teamAName.trim().toUpperCase();
    final normalizedTeamB = teamBName.trim().toUpperCase();
    if (normalizedTeamA.isEmpty || normalizedTeamB.isEmpty) {
      throw ArgumentError('Os nomes dos times sao obrigatorios.');
    }
    if (!_allowedTeamNamePattern.hasMatch(normalizedTeamA) ||
        !_allowedTeamNamePattern.hasMatch(normalizedTeamB)) {
      throw ArgumentError('Os nomes dos times devem conter apenas letras, numeros e espacos.');
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
      sourceType: sourceType,
      sportMode: SportModeService.instance.currentMode ?? SportMode.court,
      winnerTeam: null,
      createdAt: startedAt,
      finishedAt: null,
      savedTeamGroupId: savedTeamGroupId,
      savedTeamGroupTitle: savedTeamGroupTitle,
      teamAPlayers: teamAPlayers,
      teamBPlayers: teamBPlayers,
      teamAOriginTeamId: teamAOriginTeamId,
      teamBOriginTeamId: teamBOriginTeamId,
      waitingPlayersSnapshot: waitingPlayersSnapshot,
    );

    _setState(
      ScoreboardState(
        activeMatch: match,
        history: stateNotifier.value.history,
        statusMessage: _inProgressSetLabel(1),
        canUndo: false,
        currentTeamAScore: 0,
        currentTeamBScore: 0,
        currentSetStartedAt: startedAt,
        currentSetPointEvents: const [],
        lastSnapshot: null,
      ),
    );

    return match;
  }

  Future<ScoreboardState> addPointToTeamA() =>
      addPoint(team: TeamSide.teamA, pointOrigin: PointOrigin.other);

  Future<ScoreboardState> addPointToTeamB() =>
      addPoint(team: TeamSide.teamB, pointOrigin: PointOrigin.other);

  Future<ScoreboardState> addPoint({
    required TeamSide team,
    required PointOrigin pointOrigin,
    TeamDrawPlayer? player,
  }) async {
    return _addPoint(team, pointOrigin: pointOrigin, player: player);
  }

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
        currentSetStartedAt: snapshot.currentSetStartedAt,
        currentSetPointEvents: snapshot.currentSetPointEvents,
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
        currentSetStartedAt: DateTime.now(),
        currentSetPointEvents: const [],
        lastSnapshot: null,
      ),
    );

    return stateNotifier.value;
  }

  Future<ScoreboardState> finishCurrentMatch() async {
    final state = stateNotifier.value;
    final match = state.activeMatch;
    if (match == null || match.isFinished) {
      return state;
    }

    var updatedMatch = match;
    var displayTeamAScore = state.currentTeamAScore;
    var displayTeamBScore = state.currentTeamBScore;

    final setHasScore = state.currentTeamAScore > 0 ||
        state.currentTeamBScore > 0 ||
        state.currentSetPointEvents.isNotEmpty;
    if (setHasScore) {
      final finalizedSet = _buildCompletedSet(
        setNumber: match.currentSet,
        teamAScore: state.currentTeamAScore,
        teamBScore: state.currentTeamBScore,
        pointEvents: state.currentSetPointEvents,
        startedAt: state.currentSetStartedAt ?? match.createdAt,
        finishedAt: DateTime.now(),
      );
      updatedMatch = _applyFinishedSet(updatedMatch, finalizedSet);
    } else if (updatedMatch.sets.isNotEmpty) {
      final lastSet = updatedMatch.sets.last;
      displayTeamAScore = lastSet.teamAScore;
      displayTeamBScore = lastSet.teamBScore;
    }

    final finished = _finishMatch(updatedMatch);
    await _publishFinishedMatch(
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
        currentSetStartedAt: null,
        currentSetPointEvents: const [],
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
  Future<void> clearAll() async {
    _idCounter = 0;
    _initialized = false;
    await AppServices.initialize();
    await _repository.clearAll();
    _setState(const ScoreboardState.initial());
  }

  @visibleForTesting
  void clearCachedStateForTesting() {
    _initialized = false;
    _setState(const ScoreboardState.initial());
  }

  Future<ScoreboardState> _addPoint(
    TeamSide team, {
    required PointOrigin pointOrigin,
    TeamDrawPlayer? player,
  }) async {
    final state = stateNotifier.value;
    final match = state.activeMatch;
    if (match == null || match.isFinished) {
      return state;
    }

    final availablePlayers = team == TeamSide.teamA ? match.teamAPlayers : match.teamBPlayers;
    final requiresPlayerSelection = availablePlayers.isNotEmpty && pointOrigin.requiresPlayer;
    if (requiresPlayerSelection && player == null) {
      throw ArgumentError('Selecione o jogador que marcou o ponto.');
    }
    if (player != null && player.id.isEmpty) {
      throw ArgumentError('Jogador inválido para registrar o ponto.');
    }

    final snapshot = ScoreboardSnapshot(
      teamAScore: state.currentTeamAScore,
      teamBScore: state.currentTeamBScore,
      servingTeam: match.servingTeam,
      statusMessage: state.statusMessage,
      currentSetStartedAt: state.currentSetStartedAt ?? match.createdAt,
      currentSetPointEvents: List<SetPointEvent>.from(state.currentSetPointEvents),
    );

    var teamAScore = state.currentTeamAScore;
    var teamBScore = state.currentTeamBScore;
    if (team == TeamSide.teamA) {
      teamAScore += 1;
    } else {
      teamBScore += 1;
    }

    final startedAt = state.currentSetStartedAt ?? match.createdAt;
    final pointEvent = SetPointEvent(
      sequence: state.currentSetPointEvents.length + 1,
      scoringTeam: team,
      pointOrigin: pointOrigin,
      playerId: player?.id,
      playerName: player?.name,
      recordedAt: DateTime.now(),
    );
    final nextPointEvents = [...state.currentSetPointEvents, pointEvent];

    final updatedMatch = match.copyWith(servingTeam: team);
    final completedSet = _tryCloseSet(
      updatedMatch.currentSet,
      teamAScore,
      teamBScore,
      startedAt: startedAt,
      pointEvents: nextPointEvents,
    );

    if (completedSet == null) {
      _setState(
        state.copyWith(
          activeMatch: updatedMatch,
          statusMessage: _inProgressSetLabel(updatedMatch.currentSet),
          canUndo: true,
          currentTeamAScore: teamAScore,
          currentTeamBScore: teamBScore,
          currentSetStartedAt: startedAt,
          currentSetPointEvents: nextPointEvents,
          lastSnapshot: snapshot,
        ),
      );
      return stateNotifier.value;
    }

    final progressedMatch = _applyFinishedSet(updatedMatch, completedSet);
    final setWinnerName = completedSet.winnerTeamId == TeamSide.teamA.value
        ? progressedMatch.teamAName
        : progressedMatch.teamBName;

    final rules = _rulesFor(progressedMatch.sportMode);
    if (progressedMatch.teamASetsWon == rules.setsToWin ||
        progressedMatch.teamBSetsWon == rules.setsToWin) {
      final finished = _finishMatch(progressedMatch);
      await _publishFinishedMatch(
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
            '$setWinnerName venceu o ${completedSet.setNumber}º set.\n${_inProgressSetLabel(progressedMatch.currentSet)}',
        canUndo: false,
        currentTeamAScore: 0,
        currentTeamBScore: 0,
        currentSetStartedAt: DateTime.now(),
        currentSetPointEvents: const [],
        lastSnapshot: null,
      ),
    );
    return stateNotifier.value;
  }

  SetScore? _tryCloseSet(
    int setNumber,
    int teamAScore,
    int teamBScore, {
    required DateTime startedAt,
    required List<SetPointEvent> pointEvents,
  }) {
    final targetPoints = _targetPointsForSet(setNumber);
    final hasReachedTarget = teamAScore >= targetPoints || teamBScore >= targetPoints;
    final hasRequiredLead = (teamAScore - teamBScore).abs() >= 2;
    if (!hasReachedTarget || !hasRequiredLead) {
      return null;
    }

    return _buildCompletedSet(
      setNumber: setNumber,
      teamAScore: teamAScore,
      teamBScore: teamBScore,
      pointEvents: pointEvents,
      startedAt: startedAt,
      finishedAt: DateTime.now(),
    );
  }

  SetScore _buildCompletedSet({
    required int setNumber,
    required int teamAScore,
    required int teamBScore,
    required List<SetPointEvent> pointEvents,
    required DateTime startedAt,
    required DateTime finishedAt,
  }) {
    final winner = teamAScore == teamBScore
        ? null
        : (teamAScore > teamBScore ? TeamSide.teamA : TeamSide.teamB);
    return SetScore(
      setNumber: setNumber,
      teamAScore: teamAScore,
      teamBScore: teamBScore,
      winnerTeamId: winner?.value ?? '',
      targetPoints: _targetPointsForSet(setNumber),
      durationSeconds: finishedAt.difference(startedAt).inSeconds.clamp(0, 86400),
      pointEvents: pointEvents,
    );
  }

  MatchScore _applyFinishedSet(MatchScore match, SetScore setScore) {
    final rules = _rulesFor(match.sportMode);
    final teamASetsWon = match.teamASetsWon + (setScore.winnerTeamId == TeamSide.teamA.value ? 1 : 0);
    final teamBSetsWon = match.teamBSetsWon + (setScore.winnerTeamId == TeamSide.teamB.value ? 1 : 0);
    final shouldFinish = teamASetsWon == rules.setsToWin ||
        teamBSetsWon == rules.setsToWin ||
        setScore.setNumber == rules.maxSets;
    final nextSet = shouldFinish ? setScore.setNumber : setScore.setNumber + 1;

    return match.copyWith(
      currentSet: nextSet,
      sets: [...match.sets, setScore],
      teamASetsWon: teamASetsWon,
      teamBSetsWon: teamBSetsWon,
    );
  }

  MatchScore _finishMatch(MatchScore match) {
    return match.copyWith(
      matchStatus: MatchStatus.finished,
      winnerTeam: match.teamASetsWon == match.teamBSetsWon
          ? null
          : (match.teamASetsWon > match.teamBSetsWon ? TeamSide.teamA.value : TeamSide.teamB.value),
      finishedAt: DateTime.now(),
    );
  }

  Future<void> _publishFinishedMatch(
    MatchScore match, {
    required int currentTeamAScore,
    required int currentTeamBScore,
    required String statusMessage,
  }) async {
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
        currentSetStartedAt: null,
        currentSetPointEvents: const [],
        lastSnapshot: null,
      ),
    );

    await AppServices.initialize();
    await _repository.saveFinishedMatch(match);
  }

  int _targetPointsForSet(int setNumber) {
    final match = stateNotifier.value.activeMatch;
    final mode = match?.sportMode ?? SportModeService.instance.currentMode ?? SportMode.court;
    return _rulesFor(mode).targetPointsForSet(setNumber);
  }

  ScoreboardRules _rulesFor(SportMode mode) => ScoreboardRules.forMode(mode);

  String _buildMatchFinishedMessage(MatchScore match) {
    if (match.winnerTeam == null) {
      return 'Partida encerrada em empate por ${match.teamASetsWon}x${match.teamBSetsWon}.';
    }

    final winner = match.winnerTeam == TeamSide.teamA.value ? match.teamAName : match.teamBName;
    return 'Partida encerrada.\n$winner venceu por ${match.teamASetsWon}x${match.teamBSetsWon}.';
  }

  String _nextId() {
    _idCounter += 1;
    return 'scoreboard-match-$_idCounter';
  }

  void _syncCounterFromHistory(List<MatchScore> matches) {
    for (final match in matches) {
      final parsed = int.tryParse(match.id.split('-').last);
      if (parsed != null && parsed > _idCounter) {
        _idCounter = parsed;
      }
    }
  }

  void _setState(ScoreboardState state) {
    stateNotifier.value = state;
  }
}
