import 'package:flutter/material.dart';

import '../../../../widgets/app_card.dart';
import '../models/draw_team.dart';

class TeamDrawCard extends StatelessWidget {
  const TeamDrawCard({
    required this.team,
    super.key,
    this.color,
    this.trailing,
  });

  final DrawTeam team;
  final Color? color;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final accent = color ?? Theme.of(context).colorScheme.primary;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  team.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: accent,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${team.players.length} jogador(es)',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          ...team.players.map(
            (player) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(player.name),
                subtitle: Text('${player.position} • ${player.level.label}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
