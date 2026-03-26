import 'package:flutter/material.dart';

import '../../../../widgets/app_card.dart';
import '../models/team_draw_result.dart';

class DrawSummaryCard extends StatelessWidget {
  const DrawSummaryCard({
    required this.result,
    super.key,
  });

  final TeamDrawResult result;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Resumo da rodada',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Text('Modo: ${result.drawMode.label}'),
          Text('Equipes: ${result.numberOfTeams}'),
          Text('Jogadores: ${result.totalPlayers}'),
          Text('Aguardando: ${result.waitingPlayers.length}'),
        ],
      ),
    );
  }
}
