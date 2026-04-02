import 'package:flutter/material.dart';

import '../../../../config/app_routes.dart';
import '../../../../utils/app_spacing.dart';
import '../../../../utils/ui_feedback.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_card.dart';
import '../../scoreboard/models/match_score.dart';
import '../../scoreboard/services/scoreboard_service.dart';
import '../team_dialogs.dart';
import '../models/draw_team.dart';
import '../models/team_draw_result.dart';
import '../services/team_draw_service.dart';
import '../widgets/draw_summary_card.dart';
import '../widgets/team_draw_card.dart';
import '../widgets/waiting_queue_banner.dart';

class TeamDrawResultScreen extends StatefulWidget {
  const TeamDrawResultScreen({
    required this.result,
    super.key,
  });
  final TeamDrawResult result;

  @override
  State<TeamDrawResultScreen> createState() => _TeamDrawResultScreenState();
}

class _TeamDrawResultScreenState extends State<TeamDrawResultScreen> {
  late TeamDrawResult _currentResult;

  @override
  void initState() {
    super.initState();
    _currentResult = widget.result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado do Sorteio')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          DrawSummaryCard(result: _currentResult),
          if (_currentResult.waitingPlayers.isNotEmpty) ...[
            AppSpacing.gapMedium,
            WaitingQueueBanner(
              waitingPlayers: _currentResult.waitingPlayers,
              title: 'Jogador aguardando a próxima partida',
            ),
          ],
          AppSpacing.gapMedium,
          ...List.generate(
            _currentResult.teams.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TeamDrawCard(
                team: _currentResult.teams[index],
                color: _teamColor(index),
              ),
            ),
          ),
          AppSpacing.gapMedium,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              AppButton(
                label: 'Salvar Equipes',
                icon: Icons.save_outlined,
                onPressed: () => _save(context),
              ),
              AppButton(
                label: 'Iniciar Partida com Estes Times',
                icon: Icons.sports_score_outlined,
                onPressed: () => _startMatch(context),
              ),
              AppButton(
                label: 'Novo Sorteio',
                icon: Icons.refresh,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          AppSpacing.gapSmall,
          AppCard(
            child: Text(
              'Use este resultado como base para salvar formações, repetir confronto ou iniciar o placar com equipes reais.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _save(BuildContext context) async {
    final draft = await showSaveTeamsDialog(
      context,
      initialTeamNames: _currentResult.teams.map((team) => team.name).toList(),
    );

    if (draft == null || !context.mounted) {
      return;
    }

    final renamedTeams = List<DrawTeam>.generate(
      _currentResult.teams.length,
      (index) => _currentResult.teams[index].copyWith(
        name: draft.teamNames[index],
      ),
    );
    final renamedResult = TeamDrawResult(
      id: _currentResult.id,
      contextKey: _currentResult.contextKey,
      createdAt: _currentResult.createdAt,
      totalPlayers: _currentResult.totalPlayers,
      numberOfTeams: _currentResult.numberOfTeams,
      teams: renamedTeams,
      waitingPlayers: _currentResult.waitingPlayers,
      drawMode: _currentResult.drawMode,
      oddPlayerHandling: _currentResult.oddPlayerHandling,
    );

    await TeamDrawService.instance.saveResultAsGroup(
      result: renamedResult,
      title: draft.title,
    );

    if (!context.mounted) {
      return;
    }
    setState(() {
      _currentResult = renamedResult;
    });
    showAppSnackBar(context, 'Formação salva com sucesso.');
  }

  Future<void> _startMatch(BuildContext context) async {
    final selection = await showTeamsMatchupDialog(
      context,
      teams: _currentResult.teams,
      title: 'Escolha o Confronto',
      confirmLabel: 'Usar times',
    );
    if (selection == null || !context.mounted) {
      return;
    }

    final scoreboardService = ScoreboardService.instance;
    scoreboardService.prepareForNewMatch();
    scoreboardService.startMatch(
      teamAName: selection.teamA.name,
      teamBName: selection.teamB.name,
      sourceType: MatchSourceType.savedTeamGroup,
      savedTeamGroupTitle: 'Rodada ${_currentResult.createdAt.day}/${_currentResult.createdAt.month}',
      teamAPlayers: selection.teamA.players,
      teamBPlayers: selection.teamB.players,
      teamAOriginTeamId: selection.teamA.id,
      teamBOriginTeamId: selection.teamB.id,
      waitingPlayersSnapshot: _currentResult.waitingPlayers,
    );

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.scoreboard,
      (route) => route.isFirst,
    );
  }

  Color _teamColor(int index) {
    const colors = [
      Color(0xFF0F58B5),
      Color(0xFFD86C1F),
      Color(0xFF21845B),
    ];
    return colors[index % colors.length];
  }
}
