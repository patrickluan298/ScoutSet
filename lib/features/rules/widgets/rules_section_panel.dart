import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class RulesSectionPanel extends StatelessWidget {
  const RulesSectionPanel({
    required this.title,
    required this.content,
    required this.expanded,
    required this.onChanged,
    super.key,
    this.label,
    this.subtitle,
  });

  final String? label;
  final String title;
  final String? subtitle;
  final String content;
  final bool expanded;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final blocks = content
        .trim()
        .split(RegExp(r'\n\s*\n'))
        .where((block) => block.trim().isNotEmpty)
        .toList(growable: false);

    final accentColor = expanded
        ? AppTheme.accentColor
        : AppTheme.secondaryBlueColor.withValues(alpha: 0.18);
    final surfaceColor = expanded
        ? AppTheme.primaryColor.withValues(alpha: 0.02)
        : Colors.white;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: expanded ? accentColor : const Color(0xFFD9E2EC),
          width: expanded ? 1.3 : 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              width: 4,
              height: expanded ? null : 104,
              color: accentColor,
            ),
            Expanded(
              child: Theme(
                data: theme.copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  key: PageStorageKey<String>('rules-panel-${label ?? title}'),
                  initiallyExpanded: expanded,
                  onExpansionChanged: onChanged,
                  tilePadding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
                  childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  iconColor: AppTheme.accentColor,
                  collapsedIconColor: AppTheme.mediumGrayColor,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (label != null) ...[
                        Container(
                          constraints: const BoxConstraints(minWidth: 66),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            color: expanded
                                ? AppTheme.primaryColor
                                : AppTheme.primaryColor.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            label!,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: expanded ? AppTheme.whiteColor : AppTheme.primaryColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
                              Text(
                                subtitle!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: AppTheme.mediumGrayColor,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              const SizedBox(height: 6),
                            ],
                            Text(
                              title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Container(
                      height: 1,
                      margin: const EdgeInsets.only(bottom: 16),
                      color: AppTheme.primaryColor.withValues(alpha: 0.08),
                    ),
                    for (final block in blocks) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        decoration: BoxDecoration(
                          color: AppTheme.lightGrayColor.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          block.trimRight(),
                          style: theme.textTheme.bodyLarge?.copyWith(
                            height: 1.65,
                            color: AppTheme.textColor.withValues(alpha: 0.95),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
