import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_theme.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/section_title.dart';
import '../../teams/screens/saved_teams_screen.dart';
import '../models/match_score.dart';
import '../models/scoreboard_state.dart';
import '../services/scoreboard_service.dart';
import '../widgets/match_status_banner.dart';
import '../widgets/score_controls.dart';
import '../widgets/scoreboard_header.dart';
import '../widgets/set_score_table.dart';
import '../widgets/team_score_card.dart';
import 'match_history_screen.dart';

class ScoreboardScreen extends StatefulWidget {
  const ScoreboardScreen({
    super.key,
    this.showScaffold = true,
  });

  final bool showScaffold;

  @override
  State<ScoreboardScreen> createState() => _ScoreboardScreenState();
}

class _ScoreboardScreenState extends State<ScoreboardScreen> {
  static const int _maxTeamNameLength = 10;
  static final RegExp _allowedTeamNameCharacters = RegExp(r'[A-Za-z0-9À-ÖØ-öø-ÿ ]');
  static final RegExp _allowedTeamNamePattern = RegExp(r'^[A-Za-z0-9À-ÖØ-öø-ÿ ]+$');
  final _formKey = GlobalKey<FormState>();
  final _teamAController = TextEditingController();
  final _teamBController = TextEditingController();
  final ScoreboardService _service = ScoreboardService.instance;
  bool _isSavingPoint = false;

  @override
  void dispose() {
    _teamAController.dispose();
    _teamBController.dispose();
    super.dispose();
  }

  Future<void> _openHistory() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const MatchHistoryScreen(),
      ),
    );
  }

  Future<void> _openSavedTeams() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const SavedTeamsScreen(),
      ),
    );
  }

  Future<void> _handlePointTeamA() async {
    if (_isSavingPoint) {
      return;
    }
    setState(() => _isSavingPoint = true);
    try {
      await _service.addPointToTeamA();
    } finally {
      if (mounted) {
        setState(() => _isSavingPoint = false);
      }
    }
  }

  Future<void> _handlePointTeamB() async {
    if (_isSavingPoint) {
      return;
    }
    setState(() => _isSavingPoint = true);
    try {
      await _service.addPointToTeamB();
    } finally {
      if (mounted) {
        setState(() => _isSavingPoint = false);
      }
    }
  }

  bool _hasDuplicatedTeamNames() {
    final teamAName = _teamAController.text.trim().toLowerCase();
    final teamBName = _teamBController.text.trim().toLowerCase();
    return teamAName.isNotEmpty && teamBName.isNotEmpty && teamAName == teamBName;
  }

  String? _validateTeamName(
    String? value,
    String fieldLabel, {
    bool validateDuplicate = false,
  }) {
    final normalizedValue = (value ?? '').trim();
    if (normalizedValue.isEmpty) {
      return 'Informe o nome do $fieldLabel.';
    }
    if (!_allowedTeamNamePattern.hasMatch(normalizedValue)) {
      return 'Use apenas letras, numeros e espacos.';
    }
    if (validateDuplicate && _hasDuplicatedTeamNames()) {
      return 'Os times precisam ter nomes diferentes.';
    }
    return null;
  }

  void _startMatch() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    try {
      _service.startMatch(
        teamAName: _teamAController.text,
        teamBName: _teamBController.text,
      );
      FocusScope.of(context).unfocus();
    } on ArgumentError catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message?.toString() ?? 'Não foi possível iniciar a partida.'),
        ),
      );
    }
  }

  void _prepareNewMatch() {
    _service.prepareForNewMatch();
    _formKey.currentState?.reset();
    _teamAController.clear();
    _teamBController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final content = ValueListenableBuilder<ScoreboardState>(
      valueListenable: _service.stateNotifier,
      builder: (context, state, _) {
        return ListView(
          padding: AppSpacing.screen,
          children: [
            if (!state.hasActiveMatch) _buildSetupView(state) else _buildLiveScoreboard(state),
          ],
        );
      },
    );

    if (!widget.showScaffold) {
      return SafeArea(child: content);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Placar')),
      body: content,
    );
  }

  Widget _buildSetupView(ScoreboardState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScoreboardHeader(
          title: 'Placar Eletrônico de Vôlei',
          subtitle: 'Monte a partida, acompanhe os sets e salve o histórico em tempo real.',
          statusLabel: state.statusMessage,
        ),
        AppSpacing.gapMedium,
        AppCard(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Nova Partida',
                  subtitle: 'Informe os nomes dos times manualmente ou use equipes salvas. Máximo de 10 caracteres.',
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const Key('scoreboard-team-a-field'),
                  controller: _teamAController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(_allowedTeamNameCharacters),
                    LengthLimitingTextInputFormatter(_maxTeamNameLength),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Nome do time A',
                    prefixIcon: Icon(Icons.groups_2_outlined),
                  ),
                  validator: (value) => _validateTeamName(value, 'time A'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  key: const Key('scoreboard-team-b-field'),
                  controller: _teamBController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(_allowedTeamNameCharacters),
                    LengthLimitingTextInputFormatter(_maxTeamNameLength),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Nome do time B',
                    prefixIcon: Icon(Icons.groups_outlined),
                  ),
                  validator: (value) => _validateTeamName(
                    value,
                    'time B',
                    validateDuplicate: true,
                  ),
                ),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: _openSavedTeams,
                  icon: const Icon(Icons.folder_shared_outlined),
                  label: const Text('Selecionar equipes salvas'),
                ),
                const SizedBox(height: 20),
                AppButton(
                  key: const Key('scoreboard-start-button'),
                  label: 'Iniciar Partida',
                  icon: Icons.play_arrow,
                  onPressed: _startMatch,
                ),
              ],
            ),
          ),
        ),
        if (state.history.isNotEmpty) ...[
          AppSpacing.gapMedium,
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Histórico Recente', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  'Você já tem ${state.history.length} partida(s) registrada(s) nesta sessão.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: _openHistory,
                  icon: const Icon(Icons.history),
                  label: const Text('Abrir Histórico'),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLiveScoreboard(ScoreboardState state) {
    final match = state.activeMatch!;
    final isFinished = state.isMatchFinished;
    final winnerTeam = match.winnerTeam;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScoreboardHeader(
          title: '${match.teamAName} x ${match.teamBName}',
          subtitle: isFinished ? 'Resultado final em sets: ${match.teamASetsWon} x ${match.teamBSetsWon}' : '',
          statusLabel: isFinished ? 'Partida encerrada' : '',
        ),
        if (match.sourceType == MatchSourceType.savedTeamGroup) ...[
          const SizedBox(height: 12),
          AppCard(
            child: Text(
              match.savedTeamGroupTitle == null
                  ? 'Partida iniciada a partir de equipes salvas.'
                  : 'Partida iniciada a partir da formação "${match.savedTeamGroupTitle}".',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
        if (state.history.isNotEmpty) ...[
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton.icon(
              onPressed: _openHistory,
              icon: const Icon(Icons.history),
              label: const Text('Histórico de Partidas'),
            ),
          ),
        ],
        AppSpacing.gapMedium,
        MatchStatusBanner(
          message: state.statusMessage,
          isFinished: isFinished,
        ),
        AppSpacing.gapMedium,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TeamScoreCard(
                teamName: match.teamAName,
                score: state.currentTeamAScore,
                setsWon: match.teamASetsWon,
                isServing: match.servingTeam == TeamSide.teamA,
                isWinner: winnerTeam == TeamSide.teamA.value,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TeamScoreCard(
                teamName: match.teamBName,
                score: state.currentTeamBScore,
                setsWon: match.teamBSetsWon,
                isServing: match.servingTeam == TeamSide.teamB,
                isWinner: winnerTeam == TeamSide.teamB.value,
              ),
            ),
          ],
        ),
        AppSpacing.gapMedium,
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Controles do Placar',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 16),
              ScoreControls(
                teamAName: match.teamAName,
                teamBName: match.teamBName,
                onPointTeamA: () {
                  _handlePointTeamA();
                },
                onPointTeamB: () {
                  _handlePointTeamB();
                },
                onUndo: _service.undoLastPoint,
                onReset: _service.resetCurrentMatch,
                onFinish: () => _service.finishCurrentMatch(),
                onNewMatch: _prepareNewMatch,
                canScore: !isFinished && !_isSavingPoint,
                canUndo: state.canUndo,
                canReset: !isFinished,
              ),
            ],
          ),
        ),
        AppSpacing.gapMedium,
        SetScoreTable(
          finishedSets: match.sets,
          currentSet: match.currentSet,
          currentTeamAScore: state.currentTeamAScore,
          currentTeamBScore: state.currentTeamBScore,
          currentTargetPoints: state.currentSetTargetPoints,
        ),
        if (isFinished) ...[
          AppSpacing.gapMedium,
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.emoji_events, color: AppTheme.accentColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${_winnerLabel(match)} venceu a partida.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.whiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  String _winnerLabel(MatchScore match) {
    if (match.winnerTeam == TeamSide.teamA.value) {
      return match.teamAName;
    }
    if (match.winnerTeam == TeamSide.teamB.value) {
      return match.teamBName;
    }
    return 'Nenhum time';
  }
}
