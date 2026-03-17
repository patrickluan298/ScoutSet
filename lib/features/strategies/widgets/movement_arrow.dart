import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../models/movement.dart';

class MovementArrow extends StatelessWidget {
  const MovementArrow({
    required this.start,
    required this.end,
    required this.type,
    super.key,
    this.isHighlighted = false,
  });

  final Offset start;
  final Offset end;
  final MovementType type;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        size: Size.infinite,
        painter: _MovementArrowPainter(
          start: start,
          end: end,
          type: type,
          isHighlighted: isHighlighted,
        ),
      ),
    );
  }
}

class _MovementArrowPainter extends CustomPainter {
  const _MovementArrowPainter({
    required this.start,
    required this.end,
    required this.type,
    required this.isHighlighted,
  });

  final Offset start;
  final Offset end;
  final MovementType type;
  final bool isHighlighted;

  @override
  void paint(Canvas canvas, Size size) {
    final color = _colorForType(type);
    final paint = Paint()
      ..color = color
      ..strokeWidth = isHighlighted ? 4 : 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()..moveTo(start.dx, start.dy);
    if (type == MovementType.coverage) {
      final midpoint = Offset((start.dx + end.dx) / 2, (start.dy + end.dy) / 2);
      path.quadraticBezierTo(midpoint.dx + 18, midpoint.dy - 24, end.dx, end.dy);
    } else {
      path.lineTo(end.dx, end.dy);
    }
    canvas.drawPath(path, paint);

    final angle = math.atan2(end.dy - start.dy, end.dx - start.dx);
    final arrowSize = isHighlighted ? 12.0 : 10.0;
    final arrowPath = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(
        end.dx - arrowSize * math.cos(angle - math.pi / 6),
        end.dy - arrowSize * math.sin(angle - math.pi / 6),
      )
      ..moveTo(end.dx, end.dy)
      ..lineTo(
        end.dx - arrowSize * math.cos(angle + math.pi / 6),
        end.dy - arrowSize * math.sin(angle + math.pi / 6),
      );
    canvas.drawPath(arrowPath, paint);
  }

  @override
  bool shouldRepaint(covariant _MovementArrowPainter oldDelegate) {
    return oldDelegate.start != start ||
        oldDelegate.end != end ||
        oldDelegate.type != type ||
        oldDelegate.isHighlighted != isHighlighted;
  }

  Color _colorForType(MovementType type) {
    switch (type) {
      case MovementType.attack:
        return AppTheme.accentColor;
      case MovementType.move:
        return const Color(0xFF2A9D8F);
      case MovementType.block:
        return const Color(0xFFE63946);
      case MovementType.defense:
        return const Color(0xFF457B9D);
      case MovementType.coverage:
        return const Color(0xFF6D597A);
    }
  }
}
