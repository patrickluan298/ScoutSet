import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class ScoreboardHeader extends StatelessWidget {
  const ScoreboardHeader({
    required this.title,
    required this.subtitle,
    required this.statusLabel,
    super.key,
    this.onHistoryTap,
  });

  final String title;
  final String subtitle;
  final String statusLabel;
  final VoidCallback? onHistoryTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor,
            AppTheme.secondaryBlueColor,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: AppTheme.whiteColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppTheme.whiteColor.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
              if (onHistoryTap != null)
                IconButton(
                  onPressed: onHistoryTap,
                  icon: const Icon(Icons.history),
                  color: AppTheme.whiteColor,
                  tooltip: 'Historico',
                ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              statusLabel,
              style: theme.textTheme.bodyMedium?.copyWith(
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
