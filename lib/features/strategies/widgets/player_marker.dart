import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../models/player_position.dart';

class PlayerMarker extends StatelessWidget {
  const PlayerMarker({
    required this.player,
    required this.onTap,
    required this.onPanUpdate,
    required this.onResetPosition,
    super.key,
    this.isSelected = false,
    this.isInteractive = true,
    this.size = 44,
  });

  final PlayerPosition player;
  final VoidCallback onTap;
  final ValueChanged<Offset> onPanUpdate;
  final VoidCallback onResetPosition;
  final bool isSelected;
  final bool isInteractive;
  final double size;

  @override
  Widget build(BuildContext context) {
    final marker = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppTheme.accentColor : AppTheme.primaryColor,
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: Text(
          player.label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );

    if (!isInteractive) {
      return marker;
    }

    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onResetPosition,
      onPanUpdate: (details) => onPanUpdate(details.delta),
      child: marker,
    );
  }
}
