import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/app_card.dart';
import '../models/match_score.dart';
import '../models/set_point_event.dart';
import '../models/set_score.dart';
import '../widgets/match_status_banner.dart';
import '../widgets/scoreboard_header.dart';
import '../widgets/set_score_table.dart';

class MatchDetailScreen extends StatelessWidget {
  const MatchDetailScreen({
    required this.match,
    super.key,
  });

  final MatchScore match;

  @override
  Widget build(BuildContext context) {
    final winner = match.winnerTeam == TeamSide.teamA.value
        ? match.teamAName
        : match.winnerTeam == TeamSide.teamB.value
            ? match.teamBName
            : 'Empate';
    final lastSet = match.sets.isEmpty ? null : match.sets.last;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Detalhes da Partida'),
      ),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          ScoreboardHeader(
            title: '${match.teamAName} x ${match.teamBName}',
            subtitle: 'Resultado final: ${match.teamASetsWon} x ${match.teamBSetsWon}',
            statusLabel: 'Status: ${match.matchStatus.label}',
          ),
          AppSpacing.gapMedium,
          MatchStatusBanner(
            message: 'Vencedor: $winner',
            isFinished: match.isFinished,
          ),
          AppSpacing.gapMedium,
          Row(
            children: [
              Expanded(
                child: _InfoCard(
                  title: 'Placar Final',
                  value: '${match.teamASetsWon} x ${match.teamBSetsWon}',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _InfoCard(
                  title: 'Último set',
                  value: lastSet == null ? '-' : '${lastSet.teamAScore} x ${lastSet.teamBScore}',
                ),
              ),
            ],
          ),
          AppSpacing.gapMedium,
          SetScoreTable(
            finishedSets: match.sets,
            currentSet: match.currentSet,
            currentTeamAScore: 0,
            currentTeamBScore: 0,
            currentTargetPoints: match.currentSet == 3 ? 15 : 25,
            isMatchFinished: match.isFinished,
          ),
          if (match.sets.isNotEmpty) ...[
            AppSpacing.gapMedium,
            ...match.sets.map(
              (set) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _SetBreakdownCard(
                  match: match,
                  set: set,
                  formatDuration: _formatDuration,
                ),
              ),
            ),
          ],
          AppSpacing.gapMedium,
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Resumo da Partida',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 12),
                _DetailRow(label: 'Vencedor', value: winner),
                _DetailRow(label: 'Data de inicio', value: _formatDate(match.createdAt)),
                _DetailRow(
                  label: 'Data de encerramento',
                  value: match.finishedAt == null ? '-' : _formatDate(match.finishedAt!),
                ),
                _DetailRow(label: 'Status', value: match.matchStatus.label),
                _DetailRow(
                  label: 'Origem',
                  value: match.sourceType == MatchSourceType.manual ? 'Times digitados manualmente' : 'Equipes salvas',
                ),
                if (match.savedTeamGroupTitle != null)
                  _DetailRow(label: 'Formação', value: match.savedTeamGroupTitle!),
              ],
            ),
          ),
          if (match.teamAPlayers.isNotEmpty || match.teamBPlayers.isNotEmpty) ...[
            AppSpacing.gapMedium,
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Escalação dos Jogadores',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _PlayersSection(title: match.teamAName, players: match.teamAPlayers.map((player) => player.name).toList()),
                  const SizedBox(height: 12),
                  _PlayersSection(title: match.teamBName, players: match.teamBPlayers.map((player) => player.name).toList()),
                  if (match.waitingPlayersSnapshot.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _PlayersSection(
                      title: 'Jogadores aguardando',
                      players: match.waitingPlayersSnapshot.map((player) => player.playerName).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
          AppSpacing.gapMedium,
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppTheme.accentColor.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$winner venceu por ${match.teamASetsWon}x${match.teamBSetsWon}.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primaryColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime value) {
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$day/$month/${value.year} $hour:$minute';
  }

  String _formatDuration(int durationSeconds) {
    if (durationSeconds <= 0) {
      return '-';
    }

    final duration = Duration(seconds: durationSeconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:$minutes:$seconds';
    }
    return '${duration.inMinutes.toString().padLeft(2, '0')}:$seconds';
  }
}

class _SetBreakdownCard extends StatelessWidget {
  const _SetBreakdownCard({
    required this.match,
    required this.set,
    required this.formatDuration,
  });

  final MatchScore match;
  final SetScore set;
  final String Function(int durationSeconds) formatDuration;

  @override
  Widget build(BuildContext context) {
    final originTotals = set.pointsByOrigin;
    final teamAStats = set.playerPointStats.where((stat) => stat.teamSide == TeamSide.teamA).toList();
    final teamBStats = set.playerPointStats.where((stat) => stat.teamSide == TeamSide.teamB).toList();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Set ${set.setNumber}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          _DetailRow(label: 'Placar', value: '${set.teamAScore} x ${set.teamBScore}'),
          _DetailRow(label: 'Duração', value: formatDuration(set.durationSeconds)),
          _DetailRow(
            label: 'Origens',
            value: originTotals.isEmpty
                ? 'Sem eventos registrados'
                : PointOrigin.values
                    .where((origin) => originTotals.containsKey(origin))
                    .map((origin) => '${origin.label} ${originTotals[origin]}')
                    .join(' • '),
          ),
          const SizedBox(height: 12),
          Text(
            'Pontuação individual',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          if (teamAStats.isEmpty && teamBStats.isEmpty)
            Text(
              'Sem pontuação individual registrada neste set.',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          else ...[
            _PlayerStatsBlock(teamName: match.teamAName, stats: teamAStats),
            const SizedBox(height: 12),
            _PlayerStatsBlock(teamName: match.teamBName, stats: teamBStats),
          ],
          if ((originTotals[PointOrigin.opponentError] ?? 0) > 0) ...[
            const SizedBox(height: 12),
            Text(
              'Pontos por erro adversário: ${originTotals[PointOrigin.opponentError]}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PlayerStatsBlock extends StatelessWidget {
  const _PlayerStatsBlock({
    required this.teamName,
    required this.stats,
  });

  final String teamName;
  final List<PlayerPointStat> stats;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          teamName,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          stats.isEmpty
              ? 'Sem pontuação individual registrada.'
              : stats.map((stat) => '${stat.playerName} ${stat.points}').join(' • '),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _PlayersSection extends StatelessWidget {
  const _PlayersSection({
    required this.title,
    required this.players,
  });

  final String title;
  final List<String> players;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 6),
        Text(players.join(', ')),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 10),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.primaryColor,
                ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.mediumGrayColor,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
