import 'package:flutter/material.dart';

import '../../../../utils/app_spacing.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_card.dart';
import '../models/draw_team.dart';
import '../models/team_draw_player.dart';
import '../models/team_draw_result.dart';
import '../services/team_draw_service.dart';
import '../widgets/draw_options_sheet.dart';
import '../widgets/manual_team_builder.dart';
import '../widgets/player_selection_list.dart';
import 'team_draw_result_screen.dart';

class TeamManualBuilderScreen extends StatefulWidget {
  const TeamManualBuilderScreen({super.key});

  @override
  State<TeamManualBuilderScreen> createState() => _TeamManualBuilderScreenState();
}

class _TeamManualBuilderScreenState extends State<TeamManualBuilderScreen> {
  final TeamDrawService _service = TeamDrawService.instance;

  bool _isLoading = true;
  List<TeamDrawPlayer> _players = const [];
  List<String> _selectedIds = [];
  List<DrawTeam> _teams = const [];
  int _teamCount = 2;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final players = await _service.listPlayers();
    final selectedIds = players.map((player) => player.id).take(6).toList();
    if (!mounted) {
      return;
    }
    setState(() {
      _players = players;
      _selectedIds = selectedIds;
      _teams = _buildEmptyTeams(_teamCount);
      _isLoading = false;
    });
  }

  List<DrawTeam> _buildEmptyTeams(int count) {
    return List<DrawTeam>.generate(
      count,
      (index) => DrawTeam(
        id: 'manual-team-$index',
        name: 'Time ${String.fromCharCode(65 + index)}',
        players: const [],
      ),
    );
  }

  void _togglePlayer(String playerId) {
    setState(() {
      if (_selectedIds.contains(playerId)) {
        _selectedIds.remove(playerId);
        _removePlayerFromTeams(playerId);
      } else {
        _selectedIds.add(playerId);
      }
    });
  }

  void _removePlayerFromTeams(String playerId) {
    _teams = [
      for (final team in _teams)
        team.copyWith(
          players: team.players.where((player) => player.id != playerId).toList(),
        ),
    ];
  }

  void _assignPlayer(String playerId, int teamIndex) {
    final player = _players.firstWhere((item) => item.id == playerId);
    setState(() {
      _removePlayerFromTeams(playerId);
      final updatedPlayers = [..._teams[teamIndex].players, player];
      _teams = [
        for (var index = 0; index < _teams.length; index++)
          if (index == teamIndex)
            _teams[index].copyWith(players: updatedPlayers)
          else
            _teams[index],
      ];
    });
  }

  Future<void> _fillAutomatically(DrawMode mode) async {
    final selectedPlayers = _players.where((player) => _selectedIds.contains(player.id)).toList();
    var oddHandling = OddPlayerHandling.extraPlayerOnTeam;
    if (selectedPlayers.length.isOdd) {
      final selection = await DrawOptionsSheet.show(context);
      if (selection == null) {
        return;
      }
      oddHandling = selection;
    }
    try {
      final result = await _service.createDraw(
        selectedPlayers: selectedPlayers,
        numberOfTeams: _teamCount,
        drawMode: mode,
        oddPlayerHandling: oddHandling,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _teams = result.teams;
      });
    } on ArgumentError catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message?.toString() ?? 'Não foi possível preencher as equipes.')),
      );
    }
  }

  Future<void> _saveManual() async {
    final selectedPlayers = _players.where((player) => _selectedIds.contains(player.id)).toList();
    var oddHandling = OddPlayerHandling.extraPlayerOnTeam;
    if (selectedPlayers.length.isOdd) {
      final selection = await DrawOptionsSheet.show(context);
      if (selection == null) {
        return;
      }
      oddHandling = selection;
    }
    try {
      final result = _service.validateManualSetup(
        selectedPlayers: selectedPlayers,
        teams: _teams,
        oddPlayerHandling: oddHandling,
      );
      await _service.saveManualResult(result);
      if (!mounted) {
        return;
      }
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => TeamDrawResultScreen(result: result),
        ),
      );
    } on ArgumentError catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message?.toString() ?? 'Formação manual inválida.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final selectedPlayers = _players.where((player) => _selectedIds.contains(player.id)).toList();
    final availablePlayers = selectedPlayers
        .where((player) => !_teams.any((team) => team.players.any((member) => member.id == player.id)))
        .toList();
    final allowedCounts = _service.allowedTeamCounts(selectedPlayers.length);

    return Scaffold(
      appBar: AppBar(title: const Text('Montagem Manual')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Configuração', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  initialValue: allowedCounts.contains(_teamCount)
                      ? _teamCount
                      : allowedCounts.firstOrNull ?? 2,
                  decoration: const InputDecoration(labelText: 'Quantidade de equipes'),
                  items: allowedCounts
                      .map(
                        (count) => DropdownMenuItem<int>(
                          value: count,
                          child: Text('$count equipes'),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _teamCount = value;
                      _teams = _buildEmptyTeams(value);
                    });
                  },
                ),
              ],
            ),
          ),
          AppSpacing.gapMedium,
          PlayerSelectionList(
            players: _players,
            selectedIds: _selectedIds.toSet(),
            onChanged: _togglePlayer,
            title: 'Jogadores Participantes',
          ),
          AppSpacing.gapMedium,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              AppButton(
                label: 'Equilibrar Automaticamente',
                icon: Icons.balance,
                onPressed: () => _fillAutomatically(DrawMode.balanced),
              ),
              AppButton(
                label: 'Preencher por Sorteio',
                icon: Icons.shuffle,
                onPressed: () => _fillAutomatically(DrawMode.random),
              ),
              AppButton(
                label: 'Limpar Formação',
                icon: Icons.clear_all,
                onPressed: () => setState(() => _teams = _buildEmptyTeams(_teamCount)),
              ),
            ],
          ),
          AppSpacing.gapMedium,
          ManualTeamBuilder(
            availablePlayers: availablePlayers,
            teams: _teams,
            onAssignPlayer: _assignPlayer,
            onRemovePlayer: (playerId) => setState(() => _removePlayerFromTeams(playerId)),
          ),
          AppSpacing.gapMedium,
          AppButton(
            label: 'Salvar Montagem',
            icon: Icons.save_outlined,
            onPressed: _saveManual,
          ),
        ],
      ),
    );
  }
}
