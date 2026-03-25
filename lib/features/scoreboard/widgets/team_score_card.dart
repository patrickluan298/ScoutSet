import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class TeamScoreCard extends StatelessWidget {
  const TeamScoreCard({
    required this.teamName,
    required this.score,
    required this.setsWon,
    required this.isServing,
    super.key,
    this.isWinner = false,
  });

  final String teamName;
  final int score;
  final int setsWon;
  final bool isServing;
  final bool isWinner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = isWinner ? AppTheme.accentColor : AppTheme.whiteColor;
    final foregroundColor = isWinner ? AppTheme.primaryColor : AppTheme.textColor;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isServing ? AppTheme.secondaryBlueColor : const Color(0xFFD9E2EC),
          width: isServing ? 2.2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  teamName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              if (isServing)
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryBlueColor,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Tooltip(
                    message: 'Sacando',
                    child: Icon(
                      Icons.sports_volleyball,
                      color: AppTheme.whiteColor,
                      size: 18,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            score.toString(),
            style: theme.textTheme.headlineMedium?.copyWith(
              fontSize: 56,
              fontWeight: FontWeight.w900,
              color: foregroundColor,
              height: 1,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Sets vencidos: $setsWon',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
