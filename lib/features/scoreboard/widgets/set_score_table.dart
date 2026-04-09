import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../widgets/app_card.dart';
import '../models/scoreboard_rules.dart';
import '../models/set_score.dart';

class SetScoreTable extends StatelessWidget {
  const SetScoreTable({
    required this.finishedSets,
    required this.currentSet,
    required this.currentTeamAScore,
    required this.currentTeamBScore,
    required this.currentTargetPoints,
    this.isMatchFinished = false,
    super.key,
  });

  final List<SetScore> finishedSets;
  final int currentSet;
  final int currentTeamAScore;
  final int currentTeamBScore;
  final int currentTargetPoints;
  final bool isMatchFinished;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Resumo dos Sets',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 16),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1.2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1.2),
            },
            children: [
              const TableRow(
                children: [
                  _HeaderCell(label: 'Set'),
                  _HeaderCell(label: 'Time A'),
                  _HeaderCell(label: 'Time B'),
                  _HeaderCell(label: 'Meta'),
                  _HeaderCell(label: 'Duração'),
                ],
              ),
              for (var setNumber = 1; setNumber <= scoreboardMaxSets; setNumber++)
                _buildSetRow(setNumber),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _buildSetRow(int setNumber) {
    final finishedSet = _findSet(setNumber);
    final isCurrent = setNumber == currentSet && finishedSet == null;
    final inProgressTeamAScore = isMatchFinished ? 0 : currentTeamAScore;
    final inProgressTeamBScore = isMatchFinished ? 0 : currentTeamBScore;
    final teamAScore = finishedSet?.teamAScore ?? (isCurrent ? inProgressTeamAScore : null);
    final teamBScore = finishedSet?.teamBScore ?? (isCurrent ? inProgressTeamBScore : null);
    final targetPoints = finishedSet?.targetPoints ??
        (setNumber == currentSet ? currentTargetPoints : scoreboardTargetPointsForSet(setNumber));
    final rowColor = finishedSet != null
        ? AppTheme.accentColor.withValues(alpha: 0.12)
        : isCurrent
            ? AppTheme.secondaryBlueColor.withValues(alpha: 0.08)
            : Colors.transparent;

    return TableRow(
      decoration: BoxDecoration(
        color: rowColor,
        borderRadius: BorderRadius.circular(12),
      ),
      children: [
        _ValueCell(label: 'Set $setNumber', isHighlighted: isCurrent || finishedSet != null),
        _ValueCell(label: teamAScore?.toString() ?? '-', isHighlighted: isCurrent),
        _ValueCell(label: teamBScore?.toString() ?? '-', isHighlighted: isCurrent),
        _ValueCell(label: '$targetPoints pts', isHighlighted: false),
        _ValueCell(
          label: finishedSet == null ? '-' : _formatDuration(finishedSet.durationSeconds),
          isHighlighted: false,
        ),
      ],
    );
  }

  SetScore? _findSet(int setNumber) {
    for (final set in finishedSets) {
      if (set.setNumber == setNumber) {
        return set;
      }
    }
    return null;
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

class _HeaderCell extends StatelessWidget {
  const _HeaderCell({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseStyle = Theme.of(context).textTheme.bodyMedium;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: baseStyle?.copyWith(
              fontWeight: FontWeight.w700,
              color: isDark
                  ? AppTheme.whiteColor.withValues(alpha: 0.72)
                  : AppTheme.mediumGrayColor,
            ),
      ),
    );
  }
}

class _ValueCell extends StatelessWidget {
  const _ValueCell({
    required this.label,
    required this.isHighlighted,
  });

  final String label;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseStyle = Theme.of(context).textTheme.bodyLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: baseStyle?.copyWith(
              fontWeight: isHighlighted ? FontWeight.w800 : FontWeight.w600,
              color: isDark
                  ? (isHighlighted
                      ? AppTheme.whiteColor
                      : AppTheme.whiteColor.withValues(alpha: 0.72))
                  : AppTheme.textColor,
            ),
      ),
    );
  }
}
