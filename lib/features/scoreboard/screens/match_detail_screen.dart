import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/app_card.dart';
import '../models/match_score.dart';
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
    final winner = match.winnerTeam == TeamSide.teamA.value ? match.teamAName : match.teamBName;
    final lastSet = match.sets.isEmpty ? null : match.sets.last;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da partida')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          ScoreboardHeader(
            title: '${match.teamAName} x ${match.teamBName}',
            subtitle: 'Resultado final em sets: ${match.teamASetsWon} x ${match.teamBSetsWon}',
            statusLabel: 'Status: ${match.matchStatus.value}',
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
                  title: 'Placar final',
                  value: '${match.teamASetsWon} x ${match.teamBSetsWon}',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _InfoCard(
                  title: 'Ultimo set',
                  value: lastSet == null ? '-' : '${lastSet.teamAScore} x ${lastSet.teamBScore}',
                ),
              ),
            ],
          ),
          AppSpacing.gapMedium,
          SetScoreTable(
            finishedSets: match.sets,
            currentSet: match.currentSet,
            currentTeamAScore: lastSet?.teamAScore ?? 0,
            currentTeamBScore: lastSet?.teamBScore ?? 0,
            currentTargetPoints: lastSet?.targetPoints ?? 25,
          ),
          AppSpacing.gapMedium,
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Resumo da partida', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                _DetailRow(label: 'Vencedor', value: winner),
                _DetailRow(label: 'Data de inicio', value: _formatDate(match.createdAt)),
                _DetailRow(
                  label: 'Data de encerramento',
                  value: match.finishedAt == null ? '-' : _formatDate(match.finishedAt!),
                ),
                _DetailRow(label: 'Status', value: match.matchStatus.value),
              ],
            ),
          ),
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
