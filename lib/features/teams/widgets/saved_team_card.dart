import 'package:flutter/material.dart';

import '../../../../widgets/app_card.dart';
import '../models/saved_team_group.dart';

class SavedTeamCard extends StatelessWidget {
  const SavedTeamCard({
    required this.group,
    required this.onUse,
    required this.onRename,
    required this.onDelete,
    super.key,
  });

  final SavedTeamGroup group;
  final VoidCallback onUse;
  final VoidCallback onRename;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  group.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Chip(label: Text(group.sourceType.label)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            group.teams.map((team) => '${team.name} (${team.players.length})').join(' • '),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          if (group.waitingPlayers.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              'Aguardando: ${group.waitingPlayers.map((player) => player.playerName).join(', ')}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: onUse,
                icon: const Icon(Icons.sports_score_outlined),
                label: const Text('Usar no placar'),
              ),
              OutlinedButton.icon(
                onPressed: onRename,
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Renomear'),
              ),
              OutlinedButton.icon(
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline),
                label: const Text('Excluir'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
