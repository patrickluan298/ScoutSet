import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../models/movement.dart';
import '../models/player_position.dart';
import 'movement_arrow.dart';
import 'player_marker.dart';
import 'strategy_toolbar.dart';

class VolleyballCourt extends StatelessWidget {
  const VolleyballCourt({
    required this.players,
    required this.movements,
    required this.selectedPlayerId,
    required this.selectedMovementId,
    required this.interactionMode,
    required this.isReadOnly,
    required this.onPlayerTap,
    required this.onPlayerDrag,
    required this.onPlayerReset,
    required this.onCourtTap,
    super.key,
  });

  final List<PlayerPosition> players;
  final List<Movement> movements;
  final String? selectedPlayerId;
  final String? selectedMovementId;
  final StrategyInteractionMode interactionMode;
  final bool isReadOnly;
  final ValueChanged<String> onPlayerTap;
  final void Function(String playerId, Offset delta, Size courtSize) onPlayerDrag;
  final ValueChanged<String> onPlayerReset;
  final ValueChanged<Offset> onCourtTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final computedHeight = width * 1.85;
        final height = math.min(computedHeight, 640.0);

        return Center(
          child: SizedBox(
            width: width,
            height: height,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: isReadOnly
                    ? null
                    : (details) {
                        final normalized = Offset(
                          (details.localPosition.dx / width).clamp(0.0, 1.0),
                          (details.localPosition.dy / height).clamp(0.0, 1.0),
                        );
                        onCourtTap(normalized);
                      },
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _VolleyballCourtPainter(),
                      ),
                    ),
                    ...movements.map((movement) {
                      return Positioned.fill(
                        child: MovementArrow(
                          start: Offset(
                            movement.startPosition.dx * width,
                            movement.startPosition.dy * height,
                          ),
                          end: Offset(
                            movement.endPosition.dx * width,
                            movement.endPosition.dy * height,
                          ),
                          type: movement.movementType,
                          isHighlighted: movement.id == selectedMovementId,
                        ),
                      );
                    }),
                    ...players.map((player) {
                      const markerSize = 44.0;
                      return Positioned(
                        left: player.position.dx * width - markerSize / 2,
                        top: player.position.dy * height - markerSize / 2,
                        child: PlayerMarker(
                          key: ValueKey(player.playerId),
                          player: player,
                          size: markerSize,
                          isSelected: player.playerId == selectedPlayerId,
                          isInteractive: !isReadOnly,
                          onTap: () => onPlayerTap(player.playerId),
                          onResetPosition: () => onPlayerReset(player.playerId),
                          onPanUpdate: (delta) => onPlayerDrag(player.playerId, delta, Size(width, height)),
                        ),
                      );
                    }),
                    Positioned(
                      left: 16,
                      top: 16,
                      child: _CourtLegend(
                        interactionMode: interactionMode,
                        isReadOnly: isReadOnly,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _VolleyballCourtPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFFBE8C5),
          Color(0xFFF5D999),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, background);

    final opponentPaint = Paint()
      ..color = const Color(0xFFF3C46A).withOpacity(0.55)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height / 2), opponentPaint);

    final teamPaint = Paint()
      ..color = AppTheme.whiteColor.withOpacity(0.08)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, size.height / 2, size.width, size.height / 2), teamPaint);

    final linePaint = Paint()
      ..color = AppTheme.whiteColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawRect(
      Rect.fromLTWH(6, 6, size.width - 12, size.height - 12),
      linePaint,
    );

    final netY = size.height / 2;
    canvas.drawLine(Offset(0, netY), Offset(size.width, netY), linePaint);

    final attackLineTop = size.height * 0.33;
    final attackLineBottom = size.height * 0.67;
    canvas.drawLine(Offset(0, attackLineTop), Offset(size.width, attackLineTop), linePaint);
    canvas.drawLine(Offset(0, attackLineBottom), Offset(size.width, attackLineBottom), linePaint);

    final third = size.width / 3;
    final zonePaint = Paint()
      ..color = AppTheme.whiteColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(third, 0), Offset(third, size.height), zonePaint);
    canvas.drawLine(Offset(third * 2, 0), Offset(third * 2, size.height), zonePaint);

    final netPaint = Paint()
      ..color = const Color(0xFF495057)
      ..strokeWidth = 5;
    canvas.drawLine(Offset(0, netY), Offset(size.width, netY), netPaint);

    final dashedPaint = Paint()
      ..color = const Color(0xFF495057).withOpacity(0.45)
      ..strokeWidth = 1;
    for (var x = 0.0; x < size.width; x += 10) {
      canvas.drawLine(Offset(x, netY - 6), Offset(x + 5, netY - 6), dashedPaint);
      canvas.drawLine(Offset(x, netY + 6), Offset(x + 5, netY + 6), dashedPaint);
    }

    _drawLabel(canvas, size, 'Lado adversario', const Offset(16, 44));
    _drawLabel(canvas, size, 'Seu time', Offset(16, size.height - 30));
  }

  void _drawLabel(Canvas canvas, Size size, String label, Offset position) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: Color(0xB3FFFFFF),
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 32);
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CourtLegend extends StatelessWidget {
  const _CourtLegend({
    required this.interactionMode,
    required this.isReadOnly,
  });

  final StrategyInteractionMode interactionMode;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.16),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          isReadOnly ? 'Visualizacao' : _labelForMode(interactionMode),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }

  String _labelForMode(StrategyInteractionMode mode) {
    switch (mode) {
      case StrategyInteractionMode.movePlayers:
        return 'Arraste os jogadores';
      case StrategyInteractionMode.drawMovement:
        return 'Selecione um jogador e toque na quadra';
      case StrategyInteractionMode.eraseMovement:
        return 'Toque proximo de uma seta para apagar';
    }
  }
}
