import 'package:flutter/material.dart';

import '../../../../config/app_routes.dart';
import '../../../../utils/app_spacing.dart';
import '../../../../utils/confirmation_dialogs.dart';
import '../../scoreboard/models/match_score.dart';
import '../../scoreboard/services/scoreboard_service.dart';
import '../team_dialogs.dart';
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
    final title = await showRenameGroupDialog(
      context,
      initialValue: group.title,
    );

    if (title == null || title.isEmpty) {
      return;
    }
    await _service.renameGroup(group.id, title);
    await _load();
  }

  Future<void> _deleteGroup(SavedTeamGroup group) async {
    final confirmed = await showConfirmationDialog(
      context,
      title: 'Excluir formação',
      message: 'Deseja excluir "${group.title}"?',
      confirmLabel: 'Excluir',
      destructive: true,
    );
    if (confirmed != true) {
      return;
    }
    await _service.deleteGroup(group.id);
    await _load();
  }

  Future<void> _useInScoreboard(SavedTeamGroup group) async {
    final selection = await showTeamsMatchupDialog(
      context,
      teams: group.teams,
      title: 'Escolha duas equipes',
      confirmLabel: 'Confirmar',
    );
    if (selection == null || !mounted) {
      return;
    }

    final scoreboardService = ScoreboardService.instance;
    scoreboardService.prepareForNewMatch();
    scoreboardService.startMatch(
      teamAName: selection.teamA.name,
      teamBName: selection.teamB.name,
      sourceType: MatchSourceType.savedTeamGroup,
      savedTeamGroupId: group.id,
      savedTeamGroupTitle: group.title,
      teamAPlayers: selection.teamA.players,
      teamBPlayers: selection.teamB.players,
      teamAOriginTeamId: selection.teamA.id,
      teamBOriginTeamId: selection.teamB.id,
      waitingPlayersSnapshot: group.waitingPlayers,
    );

    if (!mounted) {
      return;
    }
    Navigator.pushNamed(context, AppRoutes.scoreboard);
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
