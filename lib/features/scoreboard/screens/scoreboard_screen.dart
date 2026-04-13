import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/navigation_helpers.dart';
import '../../../utils/team_name_validator.dart';
import '../../../utils/ui_feedback.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_page_scaffold.dart';
import '../../../widgets/section_title.dart';
import '../../teams/models/team_draw_player.dart';
import '../../teams/screens/saved_teams_screen.dart';
import '../models/match_score.dart';
import '../models/scoreboard_rules.dart';
import '../models/scoreboard_state.dart';
import '../models/set_point_event.dart';
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
    await pushPage(context, const MatchHistoryScreen());
  }

  Future<void> _openSavedTeams() async {
    await pushPage(context, const SavedTeamsScreen());
  }

  Future<void> _handlePointForTeam(TeamSide team) async {
    if (_isSavingPoint) {
      return;
    }
    final state = _service.getState();
    final match = state.activeMatch;
    if (match == null) {
      return;
    }

    final players = team == TeamSide.teamA ? match.teamAPlayers : match.teamBPlayers;

    setState(() => _isSavingPoint = true);
    try {
      if (players.isEmpty) {
        if (team == TeamSide.teamA) {
          await _service.addPointToTeamA();
        } else {
          await _service.addPointToTeamB();
        }
        return;
      }

      final selection = await _selectPointForTeam(team: team, match: match);
      if (selection == null) {
        return;
      }

      await _service.addPoint(
        team: team,
        pointOrigin: selection.pointOrigin,
        player: selection.player,
      );
    } finally {
      if (mounted) {
        setState(() => _isSavingPoint = false);
      }
    }
  }

  bool _hasDuplicatedTeamNames() {
    return hasDuplicatedTeamNames([
      _teamAController.text,
      _teamBController.text,
    ]);
  }

  String? _validateTeamName(
    String? value,
    String fieldLabel, {
    bool validateDuplicate = false,
  }) {
    final validation = validateTeamNameValue(value, fieldLabel);
    if (validation != null) {
      return validation;
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
      showAppSnackBar(
        context,
        error.message?.toString() ?? 'Não foi possível iniciar a partida.',
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

  Future<_PointSelection?> _selectPointForTeam({
    required TeamSide team,
    required MatchScore match,
  }) {
    final players = team == TeamSide.teamA ? match.teamAPlayers : match.teamBPlayers;
    final canAssignPlayers = players.isNotEmpty;
    final availableOrigins = canAssignPlayers
        ? const [
            PointOrigin.attack,
            PointOrigin.block,
            PointOrigin.serve,
            PointOrigin.opponentError,
          ]
        : const [PointOrigin.opponentError];

    return showModalBottomSheet<_PointSelection>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Registrar ponto para ${team == TeamSide.teamA ? match.teamAName : match.teamBName}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  canAssignPlayers
                      ? 'Escolha a origem do ponto e, quando necessário, o jogador responsável.'
                      : 'Esta partida não tem elenco vinculado. Você pode registrar ponto por erro adversário.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                for (final origin in availableOrigins) ...[
                  _PointOriginTile(
                    key: Key('point-origin-${team.value}-${origin.value}'),
                    title: origin.label,
                    subtitle: origin.requiresPlayer
                        ? 'Selecionar atleta do time'
                        : 'Registrar ponto sem vincular jogador',
                    onTap: () async {
                      TeamDrawPlayer? selectedPlayer;
                      if (origin.requiresPlayer) {
                        selectedPlayer = await showModalBottomSheet<TeamDrawPlayer>(
                          context: context,
                          showDragHandle: true,
                          builder: (context) => _PlayerPickerSheet(
                            teamName: team == TeamSide.teamA ? match.teamAName : match.teamBName,
                            players: players,
                          ),
                        );
                        if (selectedPlayer == null || !context.mounted) {
                          return;
                        }
                      }

                      if (!context.mounted) {
                        return;
                      }
                      Navigator.of(context).pop(
                        _PointSelection(pointOrigin: origin, player: selectedPlayer),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          ),
        );
      },
    );
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

    return AppPageScaffold(
      showScaffold: widget.showScaffold,
      child: content,
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
                  inputFormatters: teamNameInputFormatters(),
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
                  inputFormatters: teamNameInputFormatters(),
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
                  label: const Text('Selecionar Equipes Salvas'),
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
    final matchPointMessage = _buildMatchPointMessage(state);
    final setPointMessage = matchPointMessage == null ? _buildSetPointMessage(state) : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScoreboardHeader(
          title: '${match.teamAName} x ${match.teamBName}',
          subtitle: isFinished ? 'Resultado final: ${match.teamASetsWon} x ${match.teamBSetsWon}' : '',
          statusLabel: isFinished ? 'Partida encerrada' : '',
        ),
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
        if (isFinished)
          _FinishedMatchBanner(
            message: match.winnerTeam == null
                ? 'A partida terminou empatada.'
                : '${_winnerLabel(match)} venceu a partida.',
          )
        else
          MatchStatusBanner(
            message: state.statusMessage,
            isFinished: false,
          ),
        if (matchPointMessage != null) ...[
          const SizedBox(height: 12),
          _MatchPointAlert(message: matchPointMessage),
        ] else if (setPointMessage != null) ...[
          const SizedBox(height: 12),
          _SetPointAlert(message: setPointMessage),
        ],
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
                  _handlePointForTeam(TeamSide.teamA);
                },
                onPointTeamB: () {
                  _handlePointForTeam(TeamSide.teamB);
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
          isMatchFinished: isFinished,
        ),
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
    return 'Empate';
  }

  String? _buildMatchPointMessage(ScoreboardState state) {
    final match = state.activeMatch;
    if (match == null || match.isFinished) {
      return null;
    }

    if (_isMatchPointFor(
      match,
      team: TeamSide.teamA,
      teamScore: state.currentTeamAScore,
      opponentScore: state.currentTeamBScore,
      targetPoints: state.currentSetTargetPoints,
    )) {
      return 'MATCH POINT PARA ${match.teamAName}';
    }

    if (_isMatchPointFor(
      match,
      team: TeamSide.teamB,
      teamScore: state.currentTeamBScore,
      opponentScore: state.currentTeamAScore,
      targetPoints: state.currentSetTargetPoints,
    )) {
      return 'MATCH POINT PARA ${match.teamBName}';
    }

    return null;
  }

  String? _buildSetPointMessage(ScoreboardState state) {
    final match = state.activeMatch;
    if (match == null || match.isFinished) {
      return null;
    }

    if (_isSetPointFor(
      teamScore: state.currentTeamAScore,
      opponentScore: state.currentTeamBScore,
      targetPoints: state.currentSetTargetPoints,
    )) {
      return 'SET POINT PARA ${match.teamAName}';
    }

    if (_isSetPointFor(
      teamScore: state.currentTeamBScore,
      opponentScore: state.currentTeamAScore,
      targetPoints: state.currentSetTargetPoints,
    )) {
      return 'SET POINT PARA ${match.teamBName}';
    }

    return null;
  }

  bool _isMatchPointFor(
    MatchScore match, {
    required TeamSide team,
    required int teamScore,
    required int opponentScore,
    required int targetPoints,
  }) {
    final setsWon = team == TeamSide.teamA ? match.teamASetsWon : match.teamBSetsWon;
    if (setsWon < (scoreboardSetsToWin - 1)) {
      return false;
    }

    return _isSetPointFor(
      teamScore: teamScore,
      opponentScore: opponentScore,
      targetPoints: targetPoints,
    );
  }

  bool _isSetPointFor({
    required int teamScore,
    required int opponentScore,
    required int targetPoints,
  }) {
    final isAtSetPoint = teamScore >= (targetPoints - 1);
    final hasAdvantage = teamScore > opponentScore;
    return isAtSetPoint && hasAdvantage;
  }
}

class _FinishedMatchBanner extends StatelessWidget {
  const _FinishedMatchBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              message,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.whiteColor,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchPointAlert extends StatelessWidget {
  const _MatchPointAlert({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    const alertColor = Color(0xFFB42318);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: alertColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: alertColor.withValues(alpha: 0.28)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: alertColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: alertColor,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SetPointAlert extends StatelessWidget {
  const _SetPointAlert({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    const alertColor = Color(0xFFB54708);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: alertColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: alertColor.withValues(alpha: 0.28)),
      ),
      child: Row(
        children: [
          const Icon(Icons.notification_important_outlined, color: alertColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: alertColor,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PointSelection {
  const _PointSelection({
    required this.pointOrigin,
    this.player,
  });

  final PointOrigin pointOrigin;
  final TeamDrawPlayer? player;
}

class _PointOriginTile extends StatelessWidget {
  const _PointOriginTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.mediumGrayColor.withValues(alpha: 0.28)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 4),
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

class _PlayerPickerSheet extends StatelessWidget {
  const _PlayerPickerSheet({
    required this.teamName,
    required this.players,
  });

  final String teamName;
  final List<TeamDrawPlayer> players;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quem marcou por $teamName?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            for (final player in players) ...[
              ListTile(
                key: Key('point-player-${player.id}'),
                contentPadding: EdgeInsets.zero,
                title: Text(player.name),
                subtitle: Text(player.position),
                trailing: const Icon(Icons.add_circle_outline),
                onTap: () => Navigator.of(context).pop(player),
              ),
              const Divider(height: 1),
            ],
          ],
        ),
      ),
    );
  }
}
