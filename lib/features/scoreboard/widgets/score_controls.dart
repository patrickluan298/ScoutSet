import 'package:flutter/material.dart';

import '../../../widgets/app_button.dart';

class ScoreControls extends StatelessWidget {
  const ScoreControls({
    required this.teamAName,
    required this.teamBName,
    required this.onPointTeamA,
    required this.onPointTeamB,
    required this.onUndo,
    required this.onReset,
    required this.onFinish,
    required this.onNewMatch,
    required this.canScore,
    required this.canUndo,
    required this.canReset,
    super.key,
  });

  final String teamAName;
  final String teamBName;
  final VoidCallback? onPointTeamA;
  final VoidCallback? onPointTeamB;
  final VoidCallback? onUndo;
  final VoidCallback? onReset;
  final VoidCallback? onFinish;
  final VoidCallback onNewMatch;
  final bool canScore;
  final bool canUndo;
  final bool canReset;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: '+1 $teamAName',
                onPressed: canScore ? onPointTeamA : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton(
                label: '+1 $teamBName',
                onPressed: canScore ? onPointTeamB : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _ActionButton(
          label: 'Desfazer Último Ponto',
          icon: Icons.undo,
          onTap: canUndo ? onUndo : null,
        ),
        const SizedBox(height: 12),
        _ActionButton(
          label: 'Reiniciar Partida',
          icon: Icons.restart_alt,
          onTap: canReset ? onReset : null,
        ),
        if (onFinish != null) ...[
          const SizedBox(height: 12),
          _ActionButton(
            label: 'Finalizar Partida',
            icon: Icons.flag,
            onTap: canScore ? onFinish : null,
          ),
        ],
        const SizedBox(height: 12),
        _ActionButton(
          label: 'Nova Partida',
          icon: Icons.sports_score,
          onTap: onNewMatch,
          isPrimary: true,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    if (isPrimary) {
      return AppButton(
        label: label,
        onPressed: onTap,
        icon: icon,
      );
    }

    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
