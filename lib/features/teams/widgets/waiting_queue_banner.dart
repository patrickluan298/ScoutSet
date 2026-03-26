import 'package:flutter/material.dart';

import '../models/waiting_player.dart';

class WaitingQueueBanner extends StatelessWidget {
  const WaitingQueueBanner({
    required this.waitingPlayers,
    super.key,
    this.title = 'Fila de Espera',
  });

  final List<WaitingPlayer> waitingPlayers;
  final String title;

  @override
  Widget build(BuildContext context) {
    if (waitingPlayers.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.amber.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          ...waitingPlayers.map(
            (player) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text('${player.playerName} • prioridade ${player.priorityOrder}'),
            ),
          ),
        ],
      ),
    );
  }
}
