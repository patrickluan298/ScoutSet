import 'package:flutter/material.dart';

import '../../../config/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/sport_mode.dart';
import '../../../services/sport_mode_service.dart';
import '../../../widgets/app_page_scaffold.dart';

class ModeSelectionScreen extends StatelessWidget {
  const ModeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppTheme.colorsOf(context);

    return AppPageScaffold(
      showScaffold: true,
      backgroundColor: colors.pageBackground,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colors.pageBackground,
              colors.surface,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -120,
              right: -120,
              child: _AmbientGlow(
                size: 360,
                color: AppTheme.accentColor.withValues(alpha: 0.12),
              ),
            ),
            Positioned(
              bottom: -170,
              left: -140,
              child: _AmbientGlow(
                size: 460,
                color: colors.primaryDetail.withValues(alpha: 0.18),
              ),
            ),
            Positioned.fill(
              child: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final compact = constraints.maxWidth < 760;

                    return SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        compact ? 24 : 40,
                        compact ? 28 : 40,
                        compact ? 24 : 40,
                        compact ? 32 : 40,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1080),
                          child: Column(
                            children: [
                              SizedBox(height: compact ? 12 : 28),
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 680),
                                child: Text(
                                  'Escolha a Modalidade',
                                  textAlign: TextAlign.center,
                                  style:
                                      theme.textTheme.headlineMedium?.copyWith(
                                    fontSize: compact ? 32 : 40,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -1.1,
                                    color: colors.onSurface
                                        .withValues(alpha: 0.96),
                                  ),
                                ),
                              ),
                              SizedBox(height: compact ? 28 : 56),
                              GridView.count(
                                crossAxisCount: compact ? 1 : 2,
                                crossAxisSpacing: 24,
                                mainAxisSpacing: 24,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                childAspectRatio: 16 / 10,
                                children: SportMode.values
                                    .map(
                                      (mode) => _ModeCard(
                                        mode: mode,
                                        onTap: () {
                                          SportModeService.instance
                                              .selectMode(mode);
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            AppRoutes.dashboard,
                                            (route) => false,
                                          );
                                        },
                                      ),
                                    )
                                    .toList(growable: false),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeCard extends StatefulWidget {
  const _ModeCard({
    required this.mode,
    required this.onTap,
  });

  final SportMode mode;
  final VoidCallback onTap;

  @override
  State<_ModeCard> createState() => _ModeCardState();
}

class _ModeCardState extends State<_ModeCard> {
  static const _courtAsset = 'assets/images/mode_selection/volei_quadra.png';
  static const _beachAsset = 'assets/images/mode_selection/volei_praia.png';

  bool _isHovered = false;
  bool _isPressed = false;

  void _setHovered(bool value) {
    if (_isHovered == value) {
      return;
    }
    setState(() => _isHovered = value);
  }

  void _setPressed(bool value) {
    if (_isPressed == value) {
      return;
    }
    setState(() => _isPressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colorsOf(context);
    final theme = Theme.of(context);
    final palette = _paletteFor(widget.mode, colors);
    final imageAsset =
        widget.mode == SportMode.court ? _courtAsset : _beachAsset;
    final scale = _isPressed ? 0.985 : (_isHovered ? 1.01 : 1.0);
    final shadowColor =
        palette.glow.withValues(alpha: _isHovered ? 0.26 : 0.18);

    return Semantics(
      button: true,
      label: widget.mode.label,
      child: MouseRegion(
        onEnter: (_) => _setHovered(true),
        onExit: (_) => _setHovered(false),
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              key: Key('sport-mode-${widget.mode.value}'),
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(28),
              onHighlightChanged: _setPressed,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutCubic,
                decoration: BoxDecoration(
                  color: colors.surfaceContainer,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: colors.subtleBorder
                        .withValues(alpha: _isHovered ? 0.82 : 0.58),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: _isHovered ? 34 : 24,
                      offset: const Offset(0, 18),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AnimatedScale(
                        scale: _isHovered ? 1.05 : 1,
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeOutQuart,
                        child: Image.asset(
                          imageAsset,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.04),
                              Colors.black.withValues(alpha: 0.14),
                              Colors.black.withValues(alpha: 0.36),
                              colors.pageBackground.withValues(alpha: 0.94),
                            ],
                            stops: const [0, 0.4, 0.68, 1],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 22,
                        right: 22,
                        child: AnimatedOpacity(
                          opacity: _isHovered ? 1 : 0.72,
                          duration: const Duration(milliseconds: 220),
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: palette.dot,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: palette.dot.withValues(alpha: 0.72),
                                  blurRadius: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 28,
                        right: 28,
                        bottom: 28,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.mode.label,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.4,
                                  shadows: const [
                                    Shadow(
                                      color: Color(0x59000000),
                                      blurRadius: 14,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            AnimatedSlide(
                              duration: const Duration(milliseconds: 260),
                              curve: Curves.easeOutCubic,
                              offset: Offset(_isHovered ? 0.22 : 0, 0),
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _ModePalette _paletteFor(SportMode mode, ScoutSetThemeColors colors) {
    if (mode == SportMode.court) {
      return _ModePalette(
        dot: colors.onSurface.withValues(alpha: 0.92),
        glow: colors.primaryDetail,
      );
    }

    return _ModePalette(
      dot: AppTheme.accentColor.withValues(alpha: 0.95),
      glow: AppTheme.accentColor,
    );
  }
}

class _AmbientGlow extends StatelessWidget {
  const _AmbientGlow({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: size * 0.32,
              spreadRadius: size * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}

class _ModePalette {
  const _ModePalette({
    required this.dot,
    required this.glow,
  });

  final Color dot;
  final Color glow;
}
