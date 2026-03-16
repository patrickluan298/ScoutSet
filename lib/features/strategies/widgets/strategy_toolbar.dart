import 'package:flutter/material.dart';

import '../../../widgets/app_card.dart';
import '../models/movement.dart';

enum StrategyInteractionMode {
  movePlayers,
  drawMovement,
  eraseMovement,
}

class StrategyToolbar extends StatelessWidget {
  const StrategyToolbar({
    required this.interactionMode,
    required this.selectedMovementType,
    required this.onInteractionModeChanged,
    required this.onMovementTypeChanged,
    required this.onResetCourt,
    required this.onSave,
    super.key,
  });

  final StrategyInteractionMode interactionMode;
  final MovementType selectedMovementType;
  final ValueChanged<StrategyInteractionMode> onInteractionModeChanged;
  final ValueChanged<MovementType> onMovementTypeChanged;
  final VoidCallback onResetCourt;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ferramentas da jogada',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _ToolbarChip(
                icon: Icons.open_with,
                label: 'Mover',
                isSelected: interactionMode == StrategyInteractionMode.movePlayers,
                onTap: () => onInteractionModeChanged(StrategyInteractionMode.movePlayers),
              ),
              _ToolbarChip(
                icon: Icons.alt_route,
                label: 'Desenhar',
                isSelected: interactionMode == StrategyInteractionMode.drawMovement,
                onTap: () => onInteractionModeChanged(StrategyInteractionMode.drawMovement),
              ),
              _ToolbarChip(
                icon: Icons.auto_fix_off,
                label: 'Apagar',
                isSelected: interactionMode == StrategyInteractionMode.eraseMovement,
                onTap: () => onInteractionModeChanged(StrategyInteractionMode.eraseMovement),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: MovementType.values.map((type) {
              return ChoiceChip(
                label: Text(_movementLabel(type)),
                selected: selectedMovementType == type,
                onSelected: (_) => onMovementTypeChanged(type),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onResetCourt,
              icon: const Icon(Icons.restart_alt),
              label: const Text('Resetar quadra'),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onSave,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Salvar estrategia'),
            ),
          ),
        ],
      ),
    );
  }

  String _movementLabel(MovementType type) {
    switch (type) {
      case MovementType.attack:
        return 'Ataque';
      case MovementType.move:
        return 'Deslocamento';
      case MovementType.block:
        return 'Bloqueio';
      case MovementType.defense:
        return 'Defesa';
      case MovementType.coverage:
        return 'Cobertura';
    }
  }
}

class _ToolbarChip extends StatelessWidget {
  const _ToolbarChip({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.secondary.withOpacity(0.16)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.secondary
                : const Color(0xFFD8DEE4),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}
