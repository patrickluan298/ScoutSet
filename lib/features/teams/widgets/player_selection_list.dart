import 'package:flutter/material.dart';

import '../../../../utils/app_spacing.dart';
import '../../../../widgets/app_card.dart';
import '../models/team_draw_player.dart';

class PlayerSelectionList extends StatelessWidget {
  const PlayerSelectionList({
    required this.players,
    required this.selectedIds,
    required this.onChanged,
    super.key,
    this.onSelectAll,
    this.showPriorityBadge = true,
    this.title = 'Jogadores',
  });

  final List<TeamDrawPlayer> players;
  final Set<String> selectedIds;
  final ValueChanged<String> onChanged;
  final VoidCallback? onSelectAll;
  final bool showPriorityBadge;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(title, style: Theme.of(context).textTheme.titleMedium),
              ),
              if (players.isNotEmpty && onSelectAll != null)
                TextButton(
                  onPressed: onSelectAll,
                  child: const Text('Selecionar todos'),
                ),
            ],
          ),
          const SizedBox(height: 12),
          if (players.isEmpty)
            Text(
              'Nenhum jogador disponível.',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          else
            ...players.map(
              (player) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CheckboxListTile(
                  value: selectedIds.contains(player.id),
                  onChanged: (_) => onChanged(player.id),
                  contentPadding: EdgeInsets.zero,
                  title: Text(player.name),
                  subtitle: Text('${player.position} • ${player.level.label}'),
                  secondary: showPriorityBadge && player.wasWaitingLastRound
                      ? const _PriorityBadge()
                      : null,
                ),
              ),
            ),
          AppSpacing.gapSmall,
          Text(
            'Selecionados: ${selectedIds.length}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  const _PriorityBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'Prioridade',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
