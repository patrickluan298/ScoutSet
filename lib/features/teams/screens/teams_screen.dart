import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/app_routes.dart';
import '../../../../utils/app_spacing.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_card.dart';
import '../../../../widgets/dashboard_profile_bottom_navigation.dart';
import '../models/team_draw_player.dart';
import '../services/saved_team_service.dart';
import '../services/team_draw_service.dart';
import '../widgets/waiting_queue_banner.dart';
import 'draw_history_screen.dart';
import 'saved_teams_screen.dart';
import 'team_draw_screen.dart';
import 'team_manual_builder_screen.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({
    super.key,
    this.showScaffold = true,
  });

  final bool showScaffold;

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  static const int _maxPlayerNameLength = 10;
  static const List<String> _playerPositions = [
    'Levantador',
    'Ponteiro',
    'Central',
    'Oposto',
    'Líbero',
  ];

  final TeamDrawService _drawService = TeamDrawService.instance;
  final SavedTeamService _savedTeamService = SavedTeamService.instance;

  bool _isLoading = true;
  List<TeamDrawPlayer> _players = const [];
  String? _latestGroupTitle;
  String? _latestDrawLabel;
  int _waitingCount = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await _drawService.initialize();
    await _savedTeamService.initialize();
    final players = await _drawService.listPlayers();
    final waiting = await _drawService.listLatestWaitingPlayers();
    final latestGroup = await _savedTeamService.getLatestSavedGroup();
    final latestDraw = await _drawService.getLatestDrawResult();
    if (!mounted) {
      return;
    }
    setState(() {
      _players = players;
      _waitingCount = waiting.length;
      _latestGroupTitle = latestGroup?.title;
      _latestDrawLabel = latestDraw == null
          ? null
          : '${latestDraw.numberOfTeams} time(s) • ${latestDraw.drawMode.label.toLowerCase()}';
      _isLoading = false;
    });
  }

  Future<void> _openAddPlayerDialog() async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    var selectedPosition = _playerPositions.first;
    var selectedLevel = PlayerLevel.intermediario;

    final created = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Align(
                alignment: Alignment.center,
                child: Text(
                  'Novo Jogador',
                  textAlign: TextAlign.center,
                ),
              ),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(_maxPlayerNameLength),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                          helperText: 'Máximo de 10 caracteres',
                        ),
                        validator: (value) {
                          if ((value ?? '').trim().isEmpty) {
                            return 'Informe o nome do jogador.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: selectedPosition,
                        decoration: const InputDecoration(labelText: 'Posição'),
                        items: _playerPositions
                            .map(
                              (position) => DropdownMenuItem<String>(
                                value: position,
                                child: Text(position),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() => selectedPosition = value);
                        },
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<PlayerLevel>(
                        initialValue: selectedLevel,
                        decoration: const InputDecoration(labelText: 'Nível'),
                        items: PlayerLevel.values
                            .map(
                              (level) => DropdownMenuItem<PlayerLevel>(
                                value: level,
                                child: Text(level.label),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() => selectedLevel = value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final isValid = formKey.currentState?.validate() ?? false;
                        if (!isValid) {
                          return;
                        }
                        Navigator.of(context).pop(true);
                      },
                      child: const Text('Salvar'),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancelar'),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );

    if (created != true) {
      return;
    }

    try {
      await _drawService.savePlayer(
        name: nameController.text,
        position: selectedPosition,
        level: selectedLevel,
      );
    } on ArgumentError catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message?.toString() ?? 'Não foi possível salvar o jogador.'),
        ),
      );
      return;
    }
    await _load();
  }

  Future<void> _goTo(Widget screen) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => screen),
    );
    await _load();
  }

  Future<void> _removePlayer(TeamDrawPlayer player) async {
    final shouldRemove = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remover jogador'),
        content: Text('Deseja remover "${player.name}" da lista de jogadores?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Não'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sim'),
          ),
        ],
      ),
    );

    if (shouldRemove != true) {
      return;
    }

    await _drawService.deactivatePlayer(player.id);
    await _load();
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Jogador "${player.name}" removido.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      final loading = const Center(child: CircularProgressIndicator());

      if (!widget.showScaffold) {
        return SafeArea(child: loading);
      }

      return Scaffold(
        body: SafeArea(child: loading),
        bottomNavigationBar: const DashboardProfileBottomNavigation(
          currentRoute: AppRoutes.teams,
        ),
      );
    }

    final content = ListView(
      padding: AppSpacing.screen,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Equipes e Sorteio', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                'Organize jogadores, monte times, salve formações e reutilize tudo no placar.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  AppButton(
                    label: 'Sortear Times',
                    icon: Icons.shuffle,
                    onPressed: () => _goTo(const TeamDrawScreen()),
                  ),
                  AppButton(
                    label: 'Montagem Manual',
                    icon: Icons.touch_app_outlined,
                    onPressed: () => _goTo(const TeamManualBuilderScreen()),
                  ),
                ],
              ),
            ],
          ),
        ),
        AppSpacing.gapMedium,
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: 'Jogadores Disponíveis',
                value: _players.length.toString(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: 'Fila de Espera',
                value: _waitingCount.toString(),
              ),
            ),
          ],
        ),
        AppSpacing.gapMedium,
        if (_waitingCount > 0)
          FutureBuilder(
            future: _drawService.listLatestWaitingPlayers(),
            builder: (context, snapshot) {
              final waiting = snapshot.data ?? const [];
              return WaitingQueueBanner(waitingPlayers: waiting);
            },
          ),
        if (_waitingCount > 0) AppSpacing.gapMedium,
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ações Rápidas', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.save_outlined),
                title: const Text('Equipes salvas'),
                subtitle: Text(_latestGroupTitle ?? 'Nenhuma formação salva ainda.'),
                onTap: () => _goTo(const SavedTeamsScreen()),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.history),
                title: const Text('Histórico de Sorteios'),
                subtitle: Text(_latestDrawLabel ?? 'Nenhum sorteio registrado ainda.'),
                onTap: () => _goTo(const DrawHistoryScreen()),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.sports_score_outlined),
                title: const Text('Abrir placar'),
                subtitle: const Text('Use nomes manuais ou selecione equipes salvas.'),
                onTap: () => Navigator.pushNamed(context, AppRoutes.scoreboard),
              ),
            ],
          ),
        ),
        AppSpacing.gapMedium,
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text('Lista de Jogadores', style: Theme.of(context).textTheme.titleMedium),
                  ),
                  IconButton(
                    onPressed: _openAddPlayerDialog,
                    icon: const Icon(Icons.person_add_alt_1),
                    tooltip: 'Adicionar jogador',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (_players.isEmpty)
                Text(
                  'Nenhum jogador cadastrado.',
                  style: Theme.of(context).textTheme.bodyLarge,
                )
                else
                  ..._players.map(
                    (player) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(player.name),
                      subtitle: Text('${player.position} • ${player.level.label}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        tooltip: 'Remover jogador',
                        onPressed: () => _removePlayer(player),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ],
    );

    if (!widget.showScaffold) {
      return SafeArea(child: content);
    }

    return Scaffold(
      body: SafeArea(child: content),
      bottomNavigationBar: const DashboardProfileBottomNavigation(
        currentRoute: AppRoutes.teams,
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
