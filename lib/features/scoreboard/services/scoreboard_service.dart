import 'package:flutter/foundation.dart';

import '../../../data/local/database/app_services.dart';
import '../../../data/local/repositories/matches_repository.dart';
import '../../../data/local/repositories/teams_repository.dart';
import '../../../models/sport_mode.dart';
import '../../../services/sport_mode_service.dart';
import '../../strategies/models/substitution.dart';
import '../../teams/models/team_draw_player.dart';
import '../../teams/models/waiting_player.dart';
import '../models/match_score.dart';
import '../models/scoreboard_rules.dart';
import '../models/scoreboard_state.dart';
import '../models/set_point_event.dart';
import '../models/set_score.dart';

class ScoreboardService {
  static final RegExp _allowedTeamNamePattern =
      RegExp(r'^[A-Za-z0-9À-ÖØ-öø-ÿ ]+$');
  static final RegExp _liberoPattern =
      RegExp(r'libero|líbero', caseSensitive: false);

  ScoreboardService._();

  static final ScoreboardService instance = ScoreboardService._();

  final ValueNotifier<ScoreboardState> stateNotifier =
      ValueNotifier<ScoreboardState>(
    const ScoreboardState.initial(),
  );

  int _idCounter = 0;
  bool _initialized = false;

  MatchesRepository get _repository => AppServices.matchesRepository;
  TeamsRepository get _teamsRepository => AppServices.teamsRepository;

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
      throw ArgumentError(
          'Os nomes dos times devem conter apenas letras, numeros e espacos.');
    }
    if (normalizedTeamA.toLowerCase() == normalizedTeamB.toLowerCase()) {
      throw ArgumentError('Os times precisam ter nomes diferentes.');
    }

    final initialLineup = _buildInitialLineup(
      teamAPlayers: teamAPlayers,
      teamBPlayers: teamBPlayers,
    );

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
      teamAOnCourtPlayers: initialLineup.teamAOnCourt,
      teamBOnCourtPlayers: initialLineup.teamBOnCourt,
      teamABenchPlayers: const [],
      teamBBenchPlayers: const [],
      teamASetStarterIds:
          initialLineup.teamAOnCourt.map((player) => player.id).toList(),
      teamBSetStarterIds:
          initialLineup.teamBOnCourt.map((player) => player.id).toList(),
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

  Future<List<TeamDrawPlayer>> listEligibleSubstitutes(TeamSide team) async {
    final match = stateNotifier.value.activeMatch;
    if (match == null ||
        match.isFinished ||
        match.sportMode != SportMode.court) {
      return const [];
    }

    await AppServices.initialize();
    final registeredPlayers = await _teamsRepository.listPlayers();
    final activeIds = {
      ...match.teamAOnCourtPlayers.map((player) => player.id),
      ...match.teamBOnCourtPlayers.map((player) => player.id),
    };
    final candidatesById = <String, TeamDrawPlayer>{
      for (final player in registeredPlayers) player.id: player,
      for (final player in match.teamAPlayers) player.id: player,
      for (final player in match.teamBPlayers) player.id: player,
    };

    return candidatesById.values
        .where((player) => !activeIds.contains(player.id))
        .toList(growable: false);
  }

  Future<MatchScore> applySubstitution({
    required TeamSide team,
    required String playerOutId,
    required String playerInId,
    bool isLiberoExchange = false,
  }) async {
    final state = stateNotifier.value;
    final match = state.activeMatch;
    if (match == null || match.isFinished) {
      throw ArgumentError('Nao ha partida ativa para substituir.');
    }
    if (match.sportMode != SportMode.court) {
      throw ArgumentError(
          'Substituicoes so estao disponiveis no volei de quadra.');
    }

    final onCourt = List<TeamDrawPlayer>.from(
      team == TeamSide.teamA
          ? match.teamAOnCourtPlayers
          : match.teamBOnCourtPlayers,
    );
    final starterIds = List<String>.from(
      team == TeamSide.teamA
          ? match.teamASetStarterIds
          : match.teamBSetStarterIds,
    );
    final substitutions = List<Substitution>.from(
      team == TeamSide.teamA
          ? match.teamASetSubstitutions
          : match.teamBSetSubstitutions,
    );

    final outgoingIndex =
        onCourt.indexWhere((player) => player.id == playerOutId);
    if (outgoingIndex == -1) {
      throw ArgumentError('Selecione um atleta em quadra para sair.');
    }

    final eligiblePlayers = await listEligibleSubstitutes(team);
    final incoming = eligiblePlayers.cast<TeamDrawPlayer?>().firstWhere(
          (player) => player?.id == playerInId,
          orElse: () => null,
        );
    if (incoming == null) {
      throw ArgumentError(
          'O atleta selecionado nao esta elegivel para entrar.');
    }

    final outgoing = onCourt[outgoingIndex];
    final outgoingIsLibero = _isLibero(outgoing);
    final incomingIsLibero = _isLibero(incoming);

    if (isLiberoExchange) {
      if (!(outgoingIsLibero ^ incomingIsLibero)) {
        throw ArgumentError(
            'A troca de libero deve envolver exatamente um libero.');
      }
    } else {
      final regulationSubstitutions =
          substitutions.where((item) => item.countsTowardLimit).length;
      if (regulationSubstitutions >= 6) {
        throw ArgumentError(
            'Cada equipe pode fazer ate 6 substituicoes por set.');
      }
      if (incomingIsLibero) {
        throw ArgumentError('O libero deve entrar apenas em troca de libero.');
      }

      final validation = _validateRegulationSubstitution(
        outgoing: outgoing,
        incoming: incoming,
        starterIds: starterIds,
        substitutions: substitutions,
      );
      if (validation != null) {
        throw ArgumentError(validation);
      }
    }

    onCourt[outgoingIndex] = incoming;
    substitutions.add(
      Substitution(
        id: _nextSubstitutionId(),
        playerOutId: outgoing.id,
        playerInId: incoming.id,
        createdAt: DateTime.now(),
        isLiberoExchange: isLiberoExchange,
        countsTowardLimit: !isLiberoExchange,
      ),
    );

    final updatedMatch = team == TeamSide.teamA
        ? match.copyWith(
            teamAOnCourtPlayers: onCourt,
            teamASetSubstitutions: substitutions,
          )
        : match.copyWith(
            teamBOnCourtPlayers: onCourt,
            teamBSetSubstitutions: substitutions,
          );

    _setState(state.copyWith(activeMatch: updatedMatch));
    return updatedMatch;
  }

  Future<ScoreboardState> addPoint({
    required TeamSide team,
    required PointOrigin pointOrigin,
    TeamDrawPlayer? player,
    TeamDrawPlayer? serverPlayer,
  }) async {
    return _addPoint(
      team,
      pointOrigin: pointOrigin,
      player: player,
      serverPlayer: serverPlayer,
    );
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
        activeMatch: match.copyWith(
          servingTeam: snapshot.servingTeam,
          teamAOnCourtPlayers: snapshot.teamAOnCourtPlayers,
          teamBOnCourtPlayers: snapshot.teamBOnCourtPlayers,
        ),
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

    final initialLineup = _buildInitialLineup(
      teamAPlayers: match.teamAPlayers,
      teamBPlayers: match.teamBPlayers,
    );

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
          teamAOnCourtPlayers: initialLineup.teamAOnCourt,
          teamBOnCourtPlayers: initialLineup.teamBOnCourt,
          teamABenchPlayers: const [],
          teamBBenchPlayers: const [],
          teamASetStarterIds:
              initialLineup.teamAOnCourt.map((player) => player.id).toList(),
          teamBSetStarterIds:
              initialLineup.teamBOnCourt.map((player) => player.id).toList(),
          teamASetSubstitutions: const [],
          teamBSetSubstitutions: const [],
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
    if (match == null) {
      return state;
    }
    if (!match.isFinished) {
      throw ArgumentError(
        'Pelas regras da FIVB, a partida so pode ser encerrada quando um time vencer os sets regulamentares.',
      );
    }

    final finished = _finishMatch(match);
    await _publishFinishedMatch(
      finished,
      currentTeamAScore: state.currentTeamAScore,
      currentTeamBScore: state.currentTeamBScore,
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

  List<MatchScore> listHistory() =>
      List<MatchScore>.unmodifiable(stateNotifier.value.history);

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
    TeamDrawPlayer? serverPlayer,
  }) async {
    final state = stateNotifier.value;
    final match = state.activeMatch;
    if (match == null || match.isFinished) {
      return state;
    }

    final availablePlayers = team == TeamSide.teamA
        ? (match.teamAOnCourtPlayers.isNotEmpty
            ? match.teamAOnCourtPlayers
            : match.teamAPlayers)
        : (match.teamBOnCourtPlayers.isNotEmpty
            ? match.teamBOnCourtPlayers
            : match.teamBPlayers);
    final servingPlayers = match.servingTeam == TeamSide.teamA
        ? (match.teamAOnCourtPlayers.isNotEmpty
            ? match.teamAOnCourtPlayers
            : match.teamAPlayers)
        : (match.teamBOnCourtPlayers.isNotEmpty
            ? match.teamBOnCourtPlayers
            : match.teamBPlayers);
    final requiresPlayerSelection =
        availablePlayers.isNotEmpty && pointOrigin.requiresPlayer;
    if (requiresPlayerSelection && player == null) {
      throw ArgumentError('Selecione o jogador que marcou o ponto.');
    }
    if (player != null && player.id.isEmpty) {
      throw ArgumentError('Jogador inválido para registrar o ponto.');
    }
    if (serverPlayer != null && serverPlayer.id.isEmpty) {
      throw ArgumentError('Sacador inválido para registrar o rally.');
    }

    final expectedServer = _currentServerFor(match.servingTeam, match);
    final actualServer = serverPlayer ?? expectedServer;
    final hasServingOrderControl =
        servingPlayers.isNotEmpty && expectedServer != null;
    final hasRotationalFault = hasServingOrderControl &&
        actualServer != null &&
        actualServer.id != expectedServer.id;
    final effectiveScoringTeam =
        hasRotationalFault ? _opponentOf(match.servingTeam) : team;
    final effectivePointOrigin =
        hasRotationalFault ? PointOrigin.rotationalFault : pointOrigin;

    final snapshot = ScoreboardSnapshot(
      teamAScore: state.currentTeamAScore,
      teamBScore: state.currentTeamBScore,
      servingTeam: match.servingTeam,
      statusMessage: state.statusMessage,
      currentSetStartedAt: state.currentSetStartedAt ?? match.createdAt,
      currentSetPointEvents:
          List<SetPointEvent>.from(state.currentSetPointEvents),
      teamAOnCourtPlayers: List<TeamDrawPlayer>.from(match.teamAOnCourtPlayers),
      teamBOnCourtPlayers: List<TeamDrawPlayer>.from(match.teamBOnCourtPlayers),
    );

    var teamAScore = state.currentTeamAScore;
    var teamBScore = state.currentTeamBScore;
    if (effectiveScoringTeam == TeamSide.teamA) {
      teamAScore += 1;
    } else {
      teamBScore += 1;
    }

    final startedAt = state.currentSetStartedAt ?? match.createdAt;
    final pointEvent = SetPointEvent(
      sequence: state.currentSetPointEvents.length + 1,
      scoringTeam: effectiveScoringTeam,
      pointOrigin: effectivePointOrigin,
      playerId: hasRotationalFault ? null : player?.id,
      playerName: hasRotationalFault ? null : player?.name,
      serverPlayerId: actualServer?.id,
      serverPlayerName: actualServer?.name,
      recordedAt: DateTime.now(),
    );
    final nextPointEvents = [...state.currentSetPointEvents, pointEvent];

    final rallyWonByReceivingTeam = match.servingTeam != effectiveScoringTeam;
    final updatedMatch = _applyRallyResult(
      match,
      scoringTeam: effectiveScoringTeam,
      rotateScoringTeam: rallyWonByReceivingTeam,
    );
    final completedSet = _tryCloseSet(
      updatedMatch.currentSet,
      teamAScore,
      teamBScore,
      startedAt: startedAt,
      pointEvents: nextPointEvents,
    );

    if (completedSet == null) {
      final statusMessage = _buildLiveStatusMessage(
        updatedMatch,
        teamAScore: teamAScore,
        teamBScore: teamBScore,
      );
      _setState(
        state.copyWith(
          activeMatch: updatedMatch,
          statusMessage: statusMessage,
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
    final hasReachedTarget =
        teamAScore >= targetPoints || teamBScore >= targetPoints;
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
      durationSeconds:
          finishedAt.difference(startedAt).inSeconds.clamp(0, 86400),
      pointEvents: pointEvents,
    );
  }

  MatchScore _applyFinishedSet(MatchScore match, SetScore setScore) {
    final rules = _rulesFor(match.sportMode);
    final teamASetsWon = match.teamASetsWon +
        (setScore.winnerTeamId == TeamSide.teamA.value ? 1 : 0);
    final teamBSetsWon = match.teamBSetsWon +
        (setScore.winnerTeamId == TeamSide.teamB.value ? 1 : 0);
    final shouldFinish = teamASetsWon == rules.setsToWin ||
        teamBSetsWon == rules.setsToWin ||
        setScore.setNumber == rules.maxSets;
    final nextSet = shouldFinish ? setScore.setNumber : setScore.setNumber + 1;

    final nextTeamAOnCourtPlayers =
        List<TeamDrawPlayer>.from(match.teamAOnCourtPlayers);
    final nextTeamBOnCourtPlayers =
        List<TeamDrawPlayer>.from(match.teamBOnCourtPlayers);

    return match.copyWith(
      currentSet: nextSet,
      sets: [...match.sets, setScore],
      teamASetsWon: teamASetsWon,
      teamBSetsWon: teamBSetsWon,
      teamASetStarterIds:
          nextTeamAOnCourtPlayers.map((player) => player.id).toList(),
      teamBSetStarterIds:
          nextTeamBOnCourtPlayers.map((player) => player.id).toList(),
      teamASetSubstitutions: const [],
      teamBSetSubstitutions: const [],
    );
  }

  MatchScore _finishMatch(MatchScore match) {
    if (match.matchStatus == MatchStatus.finished) {
      return match;
    }
    return match.copyWith(
      matchStatus: MatchStatus.finished,
      winnerTeam: match.teamASetsWon == match.teamBSetsWon
          ? null
          : (match.teamASetsWon > match.teamBSetsWon
              ? TeamSide.teamA.value
              : TeamSide.teamB.value),
      finishedAt: DateTime.now(),
    );
  }

  Future<void> _publishFinishedMatch(
    MatchScore match, {
    required int currentTeamAScore,
    required int currentTeamBScore,
    required String statusMessage,
  }) async {
    final currentHistory = stateNotifier.value.history
        .where((item) => item.id != match.id)
        .toList();
    final updatedHistory = [match, ...currentHistory]..sort((a, b) {
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
    final mode = match?.sportMode ??
        SportModeService.instance.currentMode ??
        SportMode.court;
    return _rulesFor(mode).targetPointsForSet(setNumber);
  }

  ScoreboardRules _rulesFor(SportMode mode) => ScoreboardRules.forMode(mode);

  MatchScore _applyRallyResult(
    MatchScore match, {
    required TeamSide scoringTeam,
    required bool rotateScoringTeam,
  }) {
    if (!rotateScoringTeam) {
      return match.copyWith(servingTeam: scoringTeam);
    }

    if (scoringTeam == TeamSide.teamA) {
      return match.copyWith(
        servingTeam: TeamSide.teamA,
        teamAOnCourtPlayers: _rotateServiceOrder(match.teamAOnCourtPlayers),
      );
    }

    return match.copyWith(
      servingTeam: TeamSide.teamB,
      teamBOnCourtPlayers: _rotateServiceOrder(match.teamBOnCourtPlayers),
    );
  }

  List<TeamDrawPlayer> _rotateServiceOrder(List<TeamDrawPlayer> players) {
    if (players.length < 2) {
      return List<TeamDrawPlayer>.from(players);
    }

    return [
      ...players.skip(1),
      players.first,
    ];
  }

  TeamDrawPlayer? _currentServerFor(TeamSide team, MatchScore match) {
    final players = team == TeamSide.teamA
        ? (match.teamAOnCourtPlayers.isNotEmpty
            ? match.teamAOnCourtPlayers
            : match.teamAPlayers)
        : (match.teamBOnCourtPlayers.isNotEmpty
            ? match.teamBOnCourtPlayers
            : match.teamBPlayers);
    if (players.isEmpty) {
      return null;
    }
    return players.first;
  }

  TeamSide _opponentOf(TeamSide team) {
    return team == TeamSide.teamA ? TeamSide.teamB : TeamSide.teamA;
  }

  String _buildLiveStatusMessage(
    MatchScore match, {
    required int teamAScore,
    required int teamBScore,
  }) {
    final baseMessage = _inProgressSetLabel(match.currentSet);
    final rules = _rulesFor(match.sportMode);
    final sideChangePoints = rules.sideChangePointsForSet(match.currentSet);
    if (sideChangePoints == null) {
      return baseMessage;
    }

    final totalPoints = teamAScore + teamBScore;
    if (totalPoints > 0 && totalPoints % sideChangePoints == 0) {
      return '$baseMessage\nTroca de lado obrigatoria.';
    }

    return baseMessage;
  }

  String _buildMatchFinishedMessage(MatchScore match) {
    if (match.winnerTeam == null) {
      return 'Partida encerrada em empate por ${match.teamASetsWon}x${match.teamBSetsWon}.';
    }

    final winner = match.winnerTeam == TeamSide.teamA.value
        ? match.teamAName
        : match.teamBName;
    return 'Partida encerrada.\n$winner venceu por ${match.teamASetsWon}x${match.teamBSetsWon}.';
  }

  String _nextId() {
    _idCounter += 1;
    return 'scoreboard-match-$_idCounter';
  }

  String _nextSubstitutionId() {
    _idCounter += 1;
    return 'scoreboard-sub-$_idCounter';
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

  _InitialLineup _buildInitialLineup({
    required List<TeamDrawPlayer> teamAPlayers,
    required List<TeamDrawPlayer> teamBPlayers,
  }) {
    final teamAOnCourt = teamAPlayers.take(6).toList(growable: false);
    final teamBOnCourt = teamBPlayers.take(6).toList(growable: false);

    return _InitialLineup(
      teamAOnCourt: teamAOnCourt,
      teamBOnCourt: teamBOnCourt,
    );
  }

  bool _isLibero(TeamDrawPlayer player) =>
      _liberoPattern.hasMatch(player.position);

  String? _validateRegulationSubstitution({
    required TeamDrawPlayer outgoing,
    required TeamDrawPlayer incoming,
    required List<String> starterIds,
    required List<Substitution> substitutions,
  }) {
    final regulationSubs =
        substitutions.where((item) => item.countsTowardLimit).toList();
    final outgoingIsStarter = starterIds.contains(outgoing.id);

    if (outgoingIsStarter) {
      final hasAlreadyLeft =
          regulationSubs.any((item) => item.playerOutId == outgoing.id);
      final hasAlreadyReturned =
          regulationSubs.any((item) => item.playerInId == outgoing.id);
      if (hasAlreadyLeft && hasAlreadyReturned) {
        return 'O titular ${outgoing.name} ja saiu e retornou neste set.';
      }
      if (hasAlreadyLeft && !hasAlreadyReturned) {
        return 'O titular ${outgoing.name} so pode voltar para o lugar de quem o substituiu.';
      }
      return null;
    }

    Substitution? firstEntry;
    for (final substitution in regulationSubs) {
      if (substitution.playerInId == outgoing.id) {
        firstEntry = substitution;
        break;
      }
    }
    if (firstEntry == null) {
      return 'Jogadores reservas so podem sair para o retorno do titular correspondente.';
    }

    if (incoming.id != firstEntry.playerOutId) {
      final expectedStarter = _findPlayerName(firstEntry.playerOutId);
      return 'O reserva ${outgoing.name} so pode sair para o retorno de ${expectedStarter ?? firstEntry.playerOutId}.';
    }

    final starterAlreadyReturned = regulationSubs.any(
      (item) =>
          item.playerInId == incoming.id && item.playerOutId == outgoing.id,
    );
    if (starterAlreadyReturned) {
      return 'Esse titular ja retornou ao jogo neste set.';
    }

    return null;
  }

  String? _findPlayerName(
    String playerId,
  ) {
    final activeMatch = stateNotifier.value.activeMatch;
    if (activeMatch == null) {
      return null;
    }
    final allPlayers = [
      ...activeMatch.teamAPlayers,
      ...activeMatch.teamBPlayers,
      ...activeMatch.teamAOnCourtPlayers,
      ...activeMatch.teamBOnCourtPlayers,
      ...activeMatch.teamABenchPlayers,
      ...activeMatch.teamBBenchPlayers,
    ];
    for (final player in allPlayers) {
      if (player.id == playerId) {
        return player.name;
      }
    }
    return playerId;
  }
}

class _InitialLineup {
  const _InitialLineup({
    required this.teamAOnCourt,
    required this.teamBOnCourt,
  });

  final List<TeamDrawPlayer> teamAOnCourt;
  final List<TeamDrawPlayer> teamBOnCourt;
}
