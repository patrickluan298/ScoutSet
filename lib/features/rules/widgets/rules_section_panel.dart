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
    final colors = AppTheme.colorsOf(context);
    final blocks = content
        .trim()
        .split(RegExp(r'\n\s*\n'))
        .where((block) => block.trim().isNotEmpty)
        .toList(growable: false);

    final accentColor =
        expanded ? colors.accent : colors.primaryDetail.withValues(alpha: 0.28);
    final surfaceColor =
        expanded ? colors.surfaceContainer : colors.panelBackground;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: expanded ? colors.accent : colors.subtleBorder,
          width: expanded ? 1.3 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.surface.withValues(
                alpha: theme.brightness == Brightness.dark ? 0.18 : 0.03),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              width: 4,
              height: expanded ? null : 90,
              color: accentColor,
            ),
            Expanded(
              child: Theme(
                data: theme.copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  key: PageStorageKey<String>('rules-panel-${label ?? title}'),
                  initiallyExpanded: expanded,
                  onExpansionChanged: onChanged,
                  tilePadding: const EdgeInsets.fromLTRB(18, 14, 18, 12),
                  childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  iconColor: colors.accent,
                  collapsedIconColor: colors.onSurfaceVariant,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (label != null) ...[
                        Container(
                          constraints: const BoxConstraints(minWidth: 54),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                            color: expanded
                                ? colors.accent
                                : colors.chipBackground,
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: expanded
                                  ? colors.accent
                                  : colors.subtleBorder,
                            ),
                          ),
                          child: Text(
                            label!,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: expanded
                                  ? colors.surface
                                  : colors.chipForeground,
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              height: 1.1,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (subtitle != null &&
                                subtitle!.trim().isNotEmpty) ...[
                              Text(
                                subtitle!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colors.onSurfaceVariant,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.2,
                                  fontSize: 12,
                                  height: 1.1,
                                ),
                              ),
                              const SizedBox(height: 4),
                            ],
                            Text(
                              title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: colors.onSurface,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                height: 1.15,
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
                      margin: const EdgeInsets.only(bottom: 12),
                      color: colors.divider,
                    ),
                    for (var index = 0; index < blocks.length; index++) ...[
                      _buildContentBlock(
                        context,
                        blocks[index],
                        index: index,
                      ),
                      const SizedBox(height: 10),
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

  Widget _buildContentBlock(
    BuildContext context,
    String block, {
    required int index,
  }) {
    final theme = Theme.of(context);
    final colors = AppTheme.colorsOf(context);
    final numberMatch = RegExp(r'^(\d+[.,]\d+(?:[.,]\d+)*)').firstMatch(block);
    final leadingNumber = numberMatch?.group(1);
    final isBullet = block.startsWith('–') || block.startsWith('-');
    final displayText = leadingNumber == null
        ? block
        : block.replaceFirst(RegExp(r'^\d+[.,]\d+(?:[.,]\d+)*\s*'), '');
    final backgroundColor =
        index.isEven ? colors.panelAlternate : colors.panelBackground;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.subtleBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (leadingNumber != null || isBullet)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (leadingNumber != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: colors.primaryDetail,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        leadingNumber,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.surface,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          height: 1,
                        ),
                      ),
                    ),
                  if (isBullet)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: colors.accent,
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                ],
              ),
            ),
          Text(
            displayText.trimRight(),
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.58,
              color: colors.onSurface.withValues(alpha: 0.96),
              fontWeight:
                  leadingNumber != null ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
