import 'package:flutter/material.dart';

import '../../../../utils/app_spacing.dart';
import '../../../../utils/navigation_helpers.dart';
import '../../../../utils/ui_feedback.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_card.dart';
import '../team_draw_flow.dart';
import '../models/team_draw_player.dart';
import '../models/team_draw_result.dart';
import '../models/waiting_player.dart';
import '../services/team_draw_service.dart';
import '../widgets/player_selection_list.dart';
import '../widgets/waiting_queue_banner.dart';
import 'team_draw_result_screen.dart';

class TeamDrawScreen extends StatefulWidget {
  const TeamDrawScreen({
    super.key,
    this.initialSelectedPlayerIds = const [],
  });

  final List<String> initialSelectedPlayerIds;

  @override
  State<TeamDrawScreen> createState() => _TeamDrawScreenState();
}

class _TeamDrawScreenState extends State<TeamDrawScreen> {
  final TeamDrawService _service = TeamDrawService.instance;

  bool _isLoading = true;
  bool _isSubmitting = false;
  List<TeamDrawPlayer> _players = const [];
  List<String> _selectedIds = [];
  List<int> _allowedTeamCounts = const [2];
  int _selectedTeamCount = 2;
  DrawMode _drawMode = DrawMode.random;
  final List<String> _teamNames = ['Time A', 'Time B', 'Time C'];
  List<WaitingPlayer> _waitingQueue = const [];

  @override
  void initState() {
    super.initState();
    _selectedIds = List<String>.from(widget.initialSelectedPlayerIds);
    _load();
  }

  Future<void> _load() async {
    final players = await _service.listPlayers();
    final waitingQueue = await _service.listLatestWaitingPlayers();
    final selectedIds = List<String>.from(_selectedIds);
    final selectedPlayers = players.where((player) => selectedIds.contains(player.id)).toList();
    final allowedCounts = _service.allowedTeamCounts(selectedPlayers.length);
    if (!mounted) {
      return;
    }
    setState(() {
      _players = players;
      _selectedIds = selectedIds;
      _allowedTeamCounts = allowedCounts.isEmpty ? const [2] : allowedCounts;
      _selectedTeamCount =
          (allowedCounts.contains(_selectedTeamCount) ? _selectedTeamCount : allowedCounts.firstOrNull) ?? 2;
      _waitingQueue = waitingQueue;
      _isLoading = false;
    });
  }

  void _selectAllPlayers() {
    setState(() {
      _selectedIds = _players.map((player) => player.id).toList();
      final allowedCounts = _service.allowedTeamCounts(_selectedIds.length);
      _allowedTeamCounts = allowedCounts.isEmpty ? const [2] : allowedCounts;
      if (!_allowedTeamCounts.contains(_selectedTeamCount)) {
        _selectedTeamCount = _allowedTeamCounts.first;
      }
    });
  }

  void _togglePlayer(String playerId) {
    setState(() {
      if (_selectedIds.contains(playerId)) {
        _selectedIds.remove(playerId);
      } else {
        _selectedIds.add(playerId);
      }
      final allowedCounts = _service.allowedTeamCounts(_selectedIds.length);
      _allowedTeamCounts = allowedCounts.isEmpty ? const [2] : allowedCounts;
      if (!_allowedTeamCounts.contains(_selectedTeamCount)) {
        _selectedTeamCount = _allowedTeamCounts.first;
      }
    });
  }

  Future<void> _runDraw() async {
    final selectedPlayers = _players.where((player) => _selectedIds.contains(player.id)).toList();
    final oddHandling = await resolveOddPlayerHandling(context, selectedPlayers.length);
    if (oddHandling == null) {
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final result = await _service.createDraw(
        selectedPlayers: selectedPlayers,
        numberOfTeams: _selectedTeamCount,
        drawMode: _drawMode,
        oddPlayerHandling: oddHandling,
        teamNames: _teamNames.take(_selectedTeamCount).toList(),
      );
      if (!mounted) {
        return;
      }
      await pushPageAndReload(
        context,
        TeamDrawResultScreen(result: result),
        onReturn: _load,
      );
    } on ArgumentError catch (error) {
      if (!mounted) {
        return;
      }
      showAppSnackBar(
        context,
        error.message?.toString() ?? 'Não foi possível sortear os times.',
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Sorteio de Times')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          if (_waitingQueue.isNotEmpty) ...[
            WaitingQueueBanner(waitingPlayers: _waitingQueue),
            AppSpacing.gapMedium,
          ],
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Configurações do Sorteio', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  initialValue: _selectedTeamCount,
                  decoration: const InputDecoration(labelText: 'Quantidade de equipes'),
                  items: _allowedTeamCounts
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
                    setState(() => _selectedTeamCount = value);
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<DrawMode>(
                  initialValue: _drawMode,
                  decoration: const InputDecoration(labelText: 'Modo'),
                  items: const [
                    DropdownMenuItem(
                      value: DrawMode.random,
                      child: Text('Aleatório'),
                    ),
                    DropdownMenuItem(
                      value: DrawMode.balanced,
                      child: Text('Balanceado simples'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() => _drawMode = value);
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
            onSelectAll: _players.isEmpty ? null : _selectAllPlayers,
          ),
          AppSpacing.gapMedium,
          AppButton(
            label: 'Sortear equipes',
            icon: Icons.shuffle,
            isLoading: _isSubmitting,
            onPressed: _runDraw,
          ),
        ],
      ),
    );
  }
}
