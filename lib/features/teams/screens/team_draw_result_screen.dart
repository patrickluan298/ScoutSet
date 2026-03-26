import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/app_routes.dart';
import '../../../../utils/app_spacing.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_card.dart';
import '../../../../widgets/app_text_field.dart';
import '../../scoreboard/models/match_score.dart';
import '../../scoreboard/services/scoreboard_service.dart';
import '../models/draw_team.dart';
import '../models/team_draw_result.dart';
import '../services/team_draw_service.dart';
import '../widgets/draw_summary_card.dart';
import '../widgets/team_draw_card.dart';
import '../widgets/waiting_queue_banner.dart';

class TeamDrawResultScreen extends StatefulWidget {
  const TeamDrawResultScreen({
    required this.result,
    super.key,
  });

  static const int _maxTeamNameLength = 10;
  static final RegExp _allowedTeamNameCharacters = RegExp(r'[A-Za-z0-9À-ÖØ-öø-ÿ ]');
  static final RegExp _allowedTeamNamePattern = RegExp(r'^[A-Za-z0-9À-ÖØ-öø-ÿ ]+$');

  final TeamDrawResult result;

  @override
  State<TeamDrawResultScreen> createState() => _TeamDrawResultScreenState();
}

class _TeamDrawResultScreenState extends State<TeamDrawResultScreen> {
  late TeamDrawResult _currentResult;

  @override
  void initState() {
    super.initState();
    _currentResult = widget.result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado da rodada')),
      body: ListView(
        padding: AppSpacing.screen,
        children: [
          DrawSummaryCard(result: _currentResult),
          if (_currentResult.waitingPlayers.isNotEmpty) ...[
            AppSpacing.gapMedium,
            WaitingQueueBanner(
              waitingPlayers: _currentResult.waitingPlayers,
              title: 'Jogador aguardando a próxima partida',
            ),
          ],
          AppSpacing.gapMedium,
          ...List.generate(
            _currentResult.teams.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TeamDrawCard(
                team: _currentResult.teams[index],
                color: _teamColor(index),
              ),
            ),
          ),
          AppSpacing.gapMedium,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              AppButton(
                label: 'Salvar Resultado',
                icon: Icons.save_outlined,
                onPressed: () => _save(context),
              ),
              AppButton(
                label: 'Iniciar Partida com Estes Times',
                icon: Icons.sports_score_outlined,
                onPressed: () => _startMatch(context),
              ),
              AppButton(
                label: 'Nova Rodada',
                icon: Icons.refresh,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          AppSpacing.gapSmall,
          AppCard(
            child: Text(
              'Use este resultado como base para salvar formações, repetir confronto ou iniciar o placar com equipes reais.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _save(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final formationController = TextEditingController();
    final teamControllers = List<TextEditingController>.generate(
      _currentResult.teams.length,
      (index) => TextEditingController(text: _currentResult.teams[index].name),
    );
    final shouldSave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Salvar Formação',
            textAlign: TextAlign.center,
          ),
        ),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField(
                  label: 'Nome da formação',
                  controller: formationController,
                  hintText: 'Ex.: Treino de hoje',
                  validator: (value) {
                    if ((value ?? '').trim().isEmpty) {
                      return 'Informe o nome da formação.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                ...List.generate(
                  _currentResult.teams.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: index == _currentResult.teams.length - 1 ? 0 : 12),
                    child: TextFormField(
                      controller: teamControllers[index],
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(TeamDrawResultScreen._allowedTeamNameCharacters),
                        LengthLimitingTextInputFormatter(TeamDrawResultScreen._maxTeamNameLength),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Nome da equipe ${index + 1}',
                        hintText: 'Ex.: Time ${String.fromCharCode(65 + index)}',
                      ),
                      validator: (value) => _validateTeamName(
                        value,
                        index,
                        teamControllers,
                      ),
                    ),
                  ),
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
      ),
    );

    if (shouldSave != true || !context.mounted) {
      return;
    }

    final renamedTeams = List<DrawTeam>.generate(
      _currentResult.teams.length,
      (index) => _currentResult.teams[index].copyWith(
        name: teamControllers[index].text.trim().toUpperCase(),
      ),
    );
    final renamedResult = TeamDrawResult(
      id: _currentResult.id,
      contextKey: _currentResult.contextKey,
      createdAt: _currentResult.createdAt,
      totalPlayers: _currentResult.totalPlayers,
      numberOfTeams: _currentResult.numberOfTeams,
      teams: renamedTeams,
      waitingPlayers: _currentResult.waitingPlayers,
      drawMode: _currentResult.drawMode,
      oddPlayerHandling: _currentResult.oddPlayerHandling,
    );

    await TeamDrawService.instance.saveResultAsGroup(
      result: renamedResult,
      title: formationController.text.trim(),
    );

    if (!context.mounted) {
      return;
    }
    setState(() {
      _currentResult = renamedResult;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Formação salva com sucesso.')),
    );
  }

  String? _validateTeamName(
    String? value,
    int index,
    List<TextEditingController> controllers,
  ) {
    final normalizedValue = (value ?? '').trim();
    if (normalizedValue.isEmpty) {
      return 'Informe o nome da equipe ${index + 1}.';
    }
    if (!TeamDrawResultScreen._allowedTeamNamePattern.hasMatch(normalizedValue)) {
      return 'Use apenas letras, numeros e espacos.';
    }

    final normalizedNames = controllers
        .map((controller) => controller.text.trim().toLowerCase())
        .where((name) => name.isNotEmpty)
        .toList();
    final currentName = normalizedValue.toLowerCase();
    final duplicates = normalizedNames.where((name) => name == currentName).length;
    if (duplicates > 1) {
      return 'Os nomes das equipes precisam ser diferentes.';
    }
    return null;
  }

  Future<void> _startMatch(BuildContext context) async {
    final selection = await _pickTeamsForMatch(context, _currentResult.teams);
    if (selection == null || !context.mounted) {
      return;
    }

    final scoreboardService = ScoreboardService.instance;
    scoreboardService.prepareForNewMatch();
    scoreboardService.startMatch(
      teamAName: selection.$1.name,
      teamBName: selection.$2.name,
      sourceType: MatchSourceType.savedTeamGroup,
      savedTeamGroupTitle: 'Rodada ${_currentResult.createdAt.day}/${_currentResult.createdAt.month}',
      teamAPlayers: selection.$1.players,
      teamBPlayers: selection.$2.players,
      teamAOriginTeamId: selection.$1.id,
      teamBOriginTeamId: selection.$2.id,
      waitingPlayersSnapshot: _currentResult.waitingPlayers,
    );

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.scoreboard,
      (route) => route.isFirst,
    );
  }

  Future<(DrawTeam, DrawTeam)?> _pickTeamsForMatch(BuildContext context, List<DrawTeam> teams) async {
    if (teams.length == 2) {
      return (teams[0], teams[1]);
    }

    var firstIndex = 0;
    var secondIndex = 1;
    return showDialog<(DrawTeam, DrawTeam)>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text('Escolha o confronto'),
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
                child: const Text('Usar times'),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _teamColor(int index) {
    const colors = [
      Color(0xFF0F58B5),
      Color(0xFFD86C1F),
      Color(0xFF21845B),
    ];
    return colors[index % colors.length];
  }
}
