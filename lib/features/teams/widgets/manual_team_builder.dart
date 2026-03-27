import 'package:flutter/material.dart';

import '../../../../widgets/app_card.dart';
import '../models/draw_team.dart';
import '../models/team_draw_player.dart';
import '../services/team_draw_service.dart';

class ManualTeamBuilder extends StatelessWidget {
  const ManualTeamBuilder({
    required this.availablePlayers,
    required this.teams,
    required this.onAssignPlayer,
    required this.onRemovePlayer,
    super.key,
  });

  final List<TeamDrawPlayer> availablePlayers;
  final List<DrawTeam> teams;
  final void Function(String playerId, int teamIndex) onAssignPlayer;
  final void Function(String playerId) onRemovePlayer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Jogadores Disponíveis', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              if (availablePlayers.isEmpty)
                Text(
                  'Todos os jogadores já foram alocados.',
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              else
                ...availablePlayers.map(
                  (player) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(player.name),
                      subtitle: Text('${player.position} • ${player.level.label}'),
                      trailing: PopupMenuButton<int>(
                        icon: const Icon(Icons.add_circle_outline),
                        onSelected: (teamIndex) => onAssignPlayer(player.id, teamIndex),
                        itemBuilder: (_) => [
                          for (var index = 0; index < teams.length; index++)
                            PopupMenuItem<int>(
                              enabled: teams[index].players.length < TeamDrawService.maxPlayersPerTeam,
                              value: index,
                              child: Text(
                                teams[index].players.length >= TeamDrawService.maxPlayersPerTeam
                                    ? '${teams[index].name} (lotado)'
                                    : 'Adicionar ao ${teams[index].name}',
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(
          teams.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(teams[index].name, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text('${teams[index].players.length} jogador(es) • máx. 6'),
                  const SizedBox(height: 12),
                  if (teams[index].players.isEmpty)
                    Text(
                      'Sem jogadores neste time.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  else
                    ...teams[index].players.map(
                      (player) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(player.name),
                          subtitle: Text('${player.position} • ${player.level.label}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.undo),
                            onPressed: () => onRemovePlayer(player.id),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
