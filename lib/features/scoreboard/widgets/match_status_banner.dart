import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class MatchStatusBanner extends StatelessWidget {
  const MatchStatusBanner({
    required this.message,
    required this.isFinished,
    super.key,
  });

  final String message;
  final bool isFinished;

  @override
  Widget build(BuildContext context) {
    final background = isFinished
        ? AppTheme.accentColor.withValues(alpha: 0.18)
        : AppTheme.secondaryBlueColor.withValues(alpha: 0.12);
    final foreground = isFinished ? AppTheme.primaryColor : AppTheme.secondaryBlueColor;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: foreground.withValues(alpha: 0.28)),
      ),
      child: Row(
        children: [
          Icon(
            isFinished ? Icons.emoji_events : Icons.campaign,
            color: foreground,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: foreground,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
