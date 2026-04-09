import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../models/rules_models.dart';

class RulesSectionPanel extends StatefulWidget {
  const RulesSectionPanel({
    required this.title,
    required this.content,
    required this.expanded,
    required this.onChanged,
    super.key,
    this.label,
    this.subtitle,
    this.media,
  });

  final String? label;
  final String title;
  final String? subtitle;
  final String content;
  final bool expanded;
  final ValueChanged<bool> onChanged;
  final RulesSectionMedia? media;

  @override
  State<RulesSectionPanel> createState() => _RulesSectionPanelState();
}

class _RulesSectionPanelState extends State<RulesSectionPanel> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppTheme.colorsOf(context);
    final blocks = _contentBlocks(widget.content);
    final accent = colors.accent;
    final surfaceColor =
        widget.expanded ? colors.surfaceContainerLow : colors.surfaceContainer;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.01 : 1,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.expanded
                  ? accent.withValues(alpha: 0.4)
                  : colors.subtleBorder,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: theme.brightness == Brightness.dark ? 0.16 : 0.05,
                ),
                blurRadius: _isHovered ? 30 : 20,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedContainer(
                      key: Key(
                        'rules-panel-accent-${widget.label ?? widget.title}',
                      ),
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      width: 4,
                      color: widget.expanded ? accent : Colors.transparent,
                    ),
                  ),
                ),
                Theme(
                  data: theme.copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    key: PageStorageKey<String>(
                      'rules-panel-${widget.label ?? widget.title}',
                    ),
                    initiallyExpanded: widget.expanded,
                    onExpansionChanged: widget.onChanged,
                    tilePadding: const EdgeInsets.fromLTRB(22, 14, 18, 14),
                    childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    iconColor: accent,
                    collapsedIconColor: colors.onSurfaceVariant,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.label != null &&
                            widget.label!.trim().isNotEmpty) ...[
                          Text(
                            'REGRA ${widget.label!}',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: widget.expanded
                                  ? accent
                                  : colors.onSurfaceVariant,
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],
                        Text(
                          widget.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: colors.onSurface,
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                            height: 1.08,
                          ),
                        ),
                        if (widget.subtitle != null &&
                            widget.subtitle!.trim().isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            widget.subtitle!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color:
                                  colors.primaryDetail.withValues(alpha: 0.86),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ],
                    ),
                    children: [
                      if (widget.media != null) ...[
                        _RuleMediaCard(media: widget.media!),
                        const SizedBox(height: 18),
                      ],
                      for (var index = 0; index < blocks.length; index++) ...[
                        _RuleContentBlock(
                          block: blocks[index],
                          index: index,
                        ),
                        if (index != blocks.length - 1)
                          const SizedBox(height: 12),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> _contentBlocks(String content) {
    return content
        .trim()
        .split(RegExp(r'\n\s*\n'))
        .map((block) => block.trim())
        .where((block) => block.isNotEmpty)
        .toList(growable: false);
  }
}

class _RuleMediaCard extends StatelessWidget {
  const _RuleMediaCard({
    required this.media,
  });

  final RulesSectionMedia media;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colorsOf(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _RuleMediaImage(imageAsset: media.imageAsset),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.68),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 14,
              right: 14,
              bottom: 12,
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: colors.accent,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      media.caption ?? 'Figura técnica',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: colors.onSurface,
                            letterSpacing: 0.9,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RuleMediaImage extends StatelessWidget {
  const _RuleMediaImage({
    required this.imageAsset,
  });

  final String? imageAsset;

  @override
  Widget build(BuildContext context) {
    if (imageAsset == null || imageAsset!.trim().isEmpty) {
      return _RuleMediaPlaceholder();
    }

    return Image.asset(
      imageAsset!,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const _RuleMediaPlaceholder();
      },
    );
  }
}

class _RuleMediaPlaceholder extends StatelessWidget {
  const _RuleMediaPlaceholder();

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colorsOf(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.surfaceContainer,
            colors.primaryDetail.withValues(alpha: 0.45),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 44,
          color: colors.onSurface.withValues(alpha: 0.76),
        ),
      ),
    );
  }
}

class _RuleContentBlock extends StatelessWidget {
  const _RuleContentBlock({
    required this.block,
    required this.index,
  });

  final String block;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppTheme.colorsOf(context);
    final numberMatch = RegExp(r'^(\d+[.,]\d+(?:[.,]\d+)*)').firstMatch(block);
    final leadingNumber = numberMatch?.group(1)?.replaceAll(',', '.');
    final displayText = leadingNumber == null
        ? block
        : block.replaceFirst(RegExp(r'^\d+[.,]\d+(?:[.,]\d+)*\s*'), '');
    final isQuoted = displayText.startsWith('"') && displayText.endsWith('"');
    final backgroundColor =
        index.isEven ? colors.surface : colors.surfaceContainer;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.subtleBorder.withValues(alpha: 0.9),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (leadingNumber != null) ...[
            Text(
              leadingNumber,
              style: theme.textTheme.labelMedium?.copyWith(
                color: colors.accent,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
          ],
          Text(
            displayText.trim(),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: isQuoted
                  ? colors.primaryDetail.withValues(alpha: 0.95)
                  : colors.onSurface.withValues(alpha: 0.96),
              fontStyle: isQuoted ? FontStyle.italic : FontStyle.normal,
              fontWeight:
                  leadingNumber == null ? FontWeight.w500 : FontWeight.w400,
              height: 1.58,
            ),
          ),
        ],
      ),
    );
  }
}
