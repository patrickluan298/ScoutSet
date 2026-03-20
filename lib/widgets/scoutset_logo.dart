import 'package:flutter/material.dart';

class ScoutSetLogo extends StatelessWidget {
  const ScoutSetLogo({
    super.key,
    this.compact = false,
    this.showTagline = false,
    this.center = false,
  });

  static const _assetPath = 'assets/images/logo_scoutset.png';

  final bool compact;
  final bool showTagline;
  final bool center;

  @override
  Widget build(BuildContext context) {
    final imageHeight = compact ? 36.0 : 126.0;
    final taglineStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: Colors.white.withValues(alpha: 0.82),
      fontWeight: FontWeight.w500,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Image.asset(
          _assetPath,
          height: imageHeight,
          fit: BoxFit.contain,
        ),
        if (showTagline) ...[
          const SizedBox(height: 10),
          Text(
            'Volei, estrategia e leitura de jogo',
            textAlign: center ? TextAlign.center : TextAlign.start,
            style: taglineStyle,
          ),
        ],
      ],
    );
  }
}
