import 'package:flutter/material.dart';

import '../../../../config/app_routes.dart';
import '../../../../utils/app_spacing.dart';
import '../../scoreboard/models/match_score.dart';
import '../../scoreboard/services/scoreboard_service.dart';
import '../models/draw_team.dart';
import '../models/saved_team_group.dart';
import '../services/saved_team_service.dart';
import '../widgets/saved_team_card.dart';

class SavedTeamsScreen extends StatefulWidget {
  const SavedTeamsScreen({super.key});

  @override
  State<SavedTeamsScreen> createState() => _SavedTeamsScreenState();
}

class _SavedTeamsScreenState extends State<SavedTeamsScreen> {
  final SavedTeamService _service = SavedTeamService.instance;

  bool _isLoading = true;
  List<SavedTeamGroup> _groups = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final groups = await _service.listSavedGroups();
    if (!mounted) {
      return;
    }
    setState(() {
      _groups = groups;
      _isLoading = false;
    });
  }

  Future<void> _renameGroup(SavedTeamGroup group) async {
    final controller = TextEditingController(text: group.title);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Renomear formação'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Nome'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );

    if (confirmed != true) {
      return;
    }
    await _service.renameGroup(group.id, controller.text);
    await _load();
  }

  Future<void> _deleteGroup(SavedTeamGroup group) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir formação'),
        content: Text('Deseja excluir "${group.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    if (confirmed != true) {
      return;
    }
    await _service.deleteGroup(group.id);
    await _load();
  }

  Future<void> _useInScoreboard(SavedTeamGroup group) async {
    final selection = await _pickTeamsForMatch(group.teams);
    if (selection == null || !mounted) {
      return;
    }

    final scoreboardService = ScoreboardService.instance;
    scoreboardService.prepareForNewMatch();
    scoreboardService.startMatch(
      teamAName: selection.$1.name,
      teamBName: selection.$2.name,
      sourceType: MatchSourceType.savedTeamGroup,
      savedTeamGroupId: group.id,
      savedTeamGroupTitle: group.title,
      teamAPlayers: selection.$1.players,
      teamBPlayers: selection.$2.players,
      teamAOriginTeamId: selection.$1.id,
      teamBOriginTeamId: selection.$2.id,
      waitingPlayersSnapshot: group.waitingPlayers,
    );

    if (!mounted) {
      return;
    }
    Navigator.pushNamed(context, AppRoutes.scoreboard);
  }

  Future<(DrawTeam, DrawTeam)?> _pickTeamsForMatch(List<DrawTeam> teams) async {
    if (teams.length == 2) {
      return (teams[0], teams[1]);
    }

    var firstIndex = 0;
    var secondIndex = 1;
    return showDialog<(DrawTeam, DrawTeam)>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Escolha duas equipes'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<int>(
                initialValue: firstIndex,
                decoration: const InputDecoration(labelText: 'Time A'),
                items: List.generate(
                  teams.length,
                  (index) => DropdownMenuItem<int>(
                    value: index,
                    child: Text(teams[index].name),
                  ),
                ),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() => firstIndex = value);
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                initialValue: secondIndex,
                decoration: const InputDecoration(labelText: 'Time B'),
                items: List.generate(
                  teams.length,
                  (index) => DropdownMenuItem<int>(
                    value: index,
                    child: Text(teams[index].name),
                  ),
                ),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() => secondIndex = value);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: firstIndex == secondIndex
                  ? null
                  : () => Navigator.of(context).pop((teams[firstIndex], teams[secondIndex])),
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Equipes salvas')),
      body: _groups.isEmpty
          ? ListView(
              padding: AppSpacing.screen,
              children: [
                Text(
                  'Nenhuma formação salva ainda.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            )
          : ListView.separated(
              padding: AppSpacing.screen,
              itemCount: _groups.length,
              separatorBuilder: (_, __) => AppSpacing.gapMedium,
              itemBuilder: (context, index) {
                final group = _groups[index];
                return SavedTeamCard(
                  group: group,
                  onUse: () => _useInScoreboard(group),
                  onDuplicate: () async {
                    await _service.duplicateGroup(group.id);
                    await _load();
                  },
                  onRename: () => _renameGroup(group),
                  onDelete: () => _deleteGroup(group),
                );
              },
            ),
    );
  }
}
