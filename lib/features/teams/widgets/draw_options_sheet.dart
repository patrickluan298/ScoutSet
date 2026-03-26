import 'package:flutter/material.dart';

import '../models/team_draw_result.dart';

class DrawOptionsSheet extends StatelessWidget {
  const DrawOptionsSheet({super.key});

  static Future<OddPlayerHandling?> show(BuildContext context) {
    return showModalBottomSheet<OddPlayerHandling>(
      context: context,
      builder: (_) => const DrawOptionsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quantidade ímpar de jogadores',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Deseja deixar um time com 1 jogador a mais ou colocar 1 jogador na fila de espera?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.groups_2_outlined),
              title: const Text('Deixar uma equipe com 1 jogador a mais'),
              onTap: () => Navigator.of(context).pop(OddPlayerHandling.extraPlayerOnTeam),
            ),
            ListTile(
              leading: const Icon(Icons.hourglass_bottom),
              title: const Text('Deixar 1 jogador aguardando'),
              onTap: () => Navigator.of(context).pop(OddPlayerHandling.waitingQueue),
            ),
          ],
        ),
      ),
    );
  }
}
