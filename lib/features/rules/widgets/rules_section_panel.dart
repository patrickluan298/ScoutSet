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
        .map(_normalizeBlock)
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
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: expanded ? accentColor : const Color(0xFFD9E2EC),
          width: expanded ? 1.3 : 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              width: 3,
              height: expanded ? null : 82,
              color: accentColor,
            ),
            Expanded(
              child: Theme(
                data: theme.copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  key: PageStorageKey<String>('rules-panel-${label ?? title}'),
                  initiallyExpanded: expanded,
                  onExpansionChanged: onChanged,
                  tilePadding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  iconColor: AppTheme.accentColor,
                  collapsedIconColor: AppTheme.mediumGrayColor,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (label != null) ...[
                        Container(
                          constraints: const BoxConstraints(minWidth: 54),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                            if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
                              Text(
                                subtitle!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: AppTheme.mediumGrayColor,
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
                      color: AppTheme.primaryColor.withValues(alpha: 0.08),
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

  String _normalizeBlock(String block) {
    final cleanedLines = block
        .split('\n')
        .map((line) => _removeTrailingReferenceColumn(line).trim())
        .where((line) => line.isNotEmpty)
        .where((line) => !_isReferenceOnlyLine(line))
        .where((line) => !_isStructuralHeaderLine(line))
        .toList(growable: false);

    return cleanedLines.join(' ').replaceAll(RegExp(r'\s{2,}'), ' ').trim();
  }

  String _removeTrailingReferenceColumn(String line) {
    return line.replaceFirst(
      RegExp(
        r'\s{3,}(?:(?:\d+[.,]\d+(?:[.,]\d+)?[a-z]?|D\d+(?:\s*\(\d+\))?|[a-z]|e|,|\(|\)|\.)\s*)+$',
        caseSensitive: false,
      ),
      '',
    );
  }

  bool _isReferenceOnlyLine(String line) {
    final normalized = line.trim();
    return RegExp(
      r'^(?:(?:\d+[.,]\d+(?:[.,]\d+)?[a-z]?|D\d+(?:\s*\(\d+\))?|[a-z]|e|,|\(|\)|\.)\s*)+$',
      caseSensitive: false,
    ).hasMatch(normalized);
  }

  bool _isStructuralHeaderLine(String line) {
    final normalized = line.trim();
    return RegExp(
      r'^(PARTE\s+\d+\s*-\s*SEÇÃO\s+\d+\s*:\s*.+|CAPÍTULO\s+\d+.*|REGRAS OFICIAIS DE VÔLEI.*)$',
      caseSensitive: false,
    ).hasMatch(normalized);
  }

  Widget _buildContentBlock(
    BuildContext context,
    String block, {
    required int index,
  }) {
    final theme = Theme.of(context);
    final numberMatch = RegExp(r'^(\d+[.,]\d+(?:[.,]\d+)*)').firstMatch(block);
    final leadingNumber = numberMatch?.group(1);
    final isBullet = block.startsWith('–') || block.startsWith('-');
    final displayText = leadingNumber == null ? block : block.replaceFirst(RegExp(r'^\d+[.,]\d+(?:[.,]\d+)*\s*'), '');
    final backgroundColor = index.isEven
        ? AppTheme.lightGrayColor.withValues(alpha: 0.74)
        : Colors.white;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppTheme.primaryColor.withValues(alpha: 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.03),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        leadingNumber,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.whiteColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          height: 1,
                        ),
                        ),
                      ),
                ],
              ),
            ),
          Text(
            displayText.trimRight(),
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.58,
              color: AppTheme.textColor.withValues(alpha: 0.95),
              fontWeight: leadingNumber != null ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
