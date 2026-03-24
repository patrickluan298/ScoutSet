import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/section_title.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _teamAController = TextEditingController();
  final _teamBController = TextEditingController();
  final ScoreboardService _service = ScoreboardService.instance;

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

  void _prepareNewMatch(ScoreboardState state) {
    final activeMatch = state.activeMatch;
    _teamAController.text = activeMatch?.teamAName ?? '';
    _teamBController.text = activeMatch?.teamBName ?? '';
    _service.prepareForNewMatch();
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
          onHistoryTap: state.history.isEmpty ? null : _openHistory,
        ),
        AppSpacing.gapMedium,
        AppCard(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Nova partida',
                  subtitle: 'Informe os nomes dos dois times para iniciar o placar.',
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const Key('scoreboard-team-a-field'),
                  controller: _teamAController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do time A',
                    prefixIcon: Icon(Icons.groups_2_outlined),
                  ),
                  validator: (value) {
                    if ((value ?? '').trim().isEmpty) {
                      return 'Informe o nome do time A.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  key: const Key('scoreboard-team-b-field'),
                  controller: _teamBController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do time B',
                    prefixIcon: Icon(Icons.groups_outlined),
                  ),
                  validator: (value) {
                    if ((value ?? '').trim().isEmpty) {
                      return 'Informe o nome do time B.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                AppButton(
                  key: const Key('scoreboard-start-button'),
                  label: 'Iniciar partida',
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
                Text('Histórico recente', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  'Você já tem ${state.history.length} partida(s) registrada(s) nesta sessão.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: _openHistory,
                  icon: const Icon(Icons.history),
                  label: const Text('Abrir histórico'),
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
          subtitle: isFinished
              ? 'Resultado final em sets: ${match.teamASetsWon} x ${match.teamBSetsWon}'
              : 'Set ${match.currentSet} em disputa',
          statusLabel: isFinished ? 'Partida encerrada' : 'Set atual: ${match.currentSet}',
          onHistoryTap: _openHistory,
        ),
        AppSpacing.gapMedium,
        MatchStatusBanner(
          message: state.statusMessage,
          isFinished: isFinished,
        ),
        AppSpacing.gapMedium,
        LayoutBuilder(
          builder: (context, constraints) {
            final useRow = constraints.maxWidth >= 720;
            final firstCard = TeamScoreCard(
              teamName: match.teamAName,
              score: state.currentTeamAScore,
              setsWon: match.teamASetsWon,
              isServing: match.servingTeam == TeamSide.teamA,
              isWinner: winnerTeam == TeamSide.teamA.value,
            );
            final secondCard = TeamScoreCard(
              teamName: match.teamBName,
              score: state.currentTeamBScore,
              setsWon: match.teamBSetsWon,
              isServing: match.servingTeam == TeamSide.teamB,
              isWinner: winnerTeam == TeamSide.teamB.value,
            );

            if (useRow) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: firstCard),
                  const SizedBox(width: 16),
                  Expanded(child: secondCard),
                ],
              );
            }

            return Column(
              children: [
                firstCard,
                const SizedBox(height: 16),
                secondCard,
              ],
            );
          },
        ),
        AppSpacing.gapMedium,
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Controles do placar', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 16),
              ScoreControls(
                teamAName: match.teamAName,
                teamBName: match.teamBName,
                onPointTeamA: _service.addPointToTeamA,
                onPointTeamB: _service.addPointToTeamB,
                onUndo: _service.undoLastPoint,
                onReset: _service.resetCurrentMatch,
                onFinish: _service.finishCurrentMatch,
                onNewMatch: () => _prepareNewMatch(state),
                canScore: !isFinished,
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
