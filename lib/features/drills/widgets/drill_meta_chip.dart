import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class DrillMetaChip extends StatelessWidget {
  const DrillMetaChip({
    required this.primaryText,
    super.key,
    this.secondaryText,
    this.compact = false,
  });

  final String primaryText;
  final String? secondaryText;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 10 : 12,
        vertical: compact ? 8 : 10,
      ),
      decoration: BoxDecoration(
        color: AppTheme.lightGrayColor,
        borderRadius: BorderRadius.circular(compact ? 12 : 14),
      ),
      child: secondaryText == null
          ? Text(
              primaryText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  primaryText,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  secondaryText!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
    );
  }
}
