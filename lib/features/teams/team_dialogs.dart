import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/sport_mode.dart';
import '../../utils/team_name_validator.dart';
import '../../widgets/app_text_field.dart';
import 'models/draw_team.dart';
import 'models/team_draw_player.dart';

class TeamMatchupSelection {
  const TeamMatchupSelection({
    required this.teamA,
    required this.teamB,
  });

  final DrawTeam teamA;
  final DrawTeam teamB;
}

class TeamStartingRotationSelection {
  const TeamStartingRotationSelection({
    required this.teamAPlayers,
    required this.teamBPlayers,
  });

  final List<TeamDrawPlayer> teamAPlayers;
  final List<TeamDrawPlayer> teamBPlayers;
}

class TeamPlayerDraft {
  const TeamPlayerDraft({
    required this.name,
    required this.position,
    required this.level,
  });

  final String name;
  final String position;
  final PlayerLevel level;
}

class TeamSaveDraft {
  const TeamSaveDraft({
    required this.title,
    required this.teamNames,
  });

  final String title;
  final List<String> teamNames;
}

Future<TeamPlayerDraft?> showAddPlayerDialog(
  BuildContext context, {
  required List<String> positions,
  required int maxPlayerNameLength,
  Iterable<String> existingPlayerNames = const [],
}) {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  var selectedPosition = positions.first;
  var selectedLevel = PlayerLevel.intermediario;
  final normalizedExistingNames =
      existingPlayerNames.map((name) => name.trim().toLowerCase()).toSet();

  return showDialog<TeamPlayerDraft>(
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
                        LengthLimitingTextInputFormatter(maxPlayerNameLength),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        helperText: 'Máximo de 10 caracteres',
                      ),
                      validator: (value) {
                        final rawValue = value ?? '';
                        if (rawValue.trim().isEmpty) {
                          return 'Informe o nome do jogador.';
                        }
                        if (rawValue != rawValue.trim()) {
                          return 'Remova espaços no início ou no final do nome.';
                        }
                        final normalizedName = rawValue.toLowerCase();
                        if (normalizedExistingNames.contains(normalizedName)) {
                          return 'Já existe um jogador com esse nome.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: selectedPosition,
                      decoration: const InputDecoration(labelText: 'Posição'),
                      items: positions
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
                      Navigator.of(context).pop(
                        TeamPlayerDraft(
                          name: nameController.text,
                          position: selectedPosition,
                          level: selectedLevel,
                        ),
                      );
                    },
                    child: const Text('Salvar'),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
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
}

Future<TeamStartingRotationSelection?> showStartingRotationDialog(
  BuildContext context, {
  required DrawTeam teamA,
  required DrawTeam teamB,
  required SportMode sportMode,
}) {
  final maxPlayersOnCourt = sportMode == SportMode.beach ? 2 : 6;
  final teamASlotCount = teamA.players.length < maxPlayersOnCourt
      ? teamA.players.length
      : maxPlayersOnCourt;
  final teamBSlotCount = teamB.players.length < maxPlayersOnCourt
      ? teamB.players.length
      : maxPlayersOnCourt;

  if (teamASlotCount == 0 && teamBSlotCount == 0) {
    return Future.value(
      const TeamStartingRotationSelection(
        teamAPlayers: [],
        teamBPlayers: [],
      ),
    );
  }

  final teamASelectedIds = teamA.players
      .take(teamASlotCount)
      .map((player) => player.id)
      .toList(growable: true);
  final teamBSelectedIds = teamB.players
      .take(teamBSlotCount)
      .map((player) => player.id)
      .toList(growable: true);

  List<TeamDrawPlayer> resolveSelection(
    DrawTeam team,
    List<String> selectedIds,
  ) {
    return selectedIds
        .map(
          (id) => team.players.firstWhere(
            (player) => player.id == id,
          ),
        )
        .toList(growable: false);
  }

  String positionLabel(int index) {
    final position = index + 1;
    if (position == 1) {
      return 'Posicao $position (sacador inicial)';
    }
    return 'Posicao $position';
  }

  List<DropdownMenuItem<String>> buildItems(
    DrawTeam team,
    List<String> selectedIds,
    int currentIndex,
  ) {
    return team.players
        .where(
          (player) =>
              player.id == selectedIds[currentIndex] ||
              !selectedIds.contains(player.id),
        )
        .map(
          (player) => DropdownMenuItem<String>(
            value: player.id,
            child: Text('${player.name} - ${player.position}'),
          ),
        )
        .toList(growable: false);
  }

  return showModalBottomSheet<TeamStartingRotationSelection>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                8,
                20,
                24 + MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rotacao inicial',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      sportMode == SportMode.beach
                          ? 'Defina a ordem inicial de saque dos atletas. A posicao 1 sera usada como referencia do primeiro sacador da dupla.'
                          : 'Defina quem comeca em cada posicao de rotacao. A posicao 1 sera usada como referencia do sacador inicial.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    _RotationTeamSection(
                      teamName: teamA.name,
                      slotCount: teamASlotCount,
                      selectedIds: teamASelectedIds,
                      positionLabelBuilder: positionLabel,
                      itemBuilder: (index) => buildItems(
                        teamA,
                        teamASelectedIds,
                        index,
                      ),
                      onChanged: (index, value) {
                        if (value == null) {
                          return;
                        }
                        setState(() => teamASelectedIds[index] = value);
                      },
                    ),
                    const SizedBox(height: 20),
                    _RotationTeamSection(
                      teamName: teamB.name,
                      slotCount: teamBSlotCount,
                      selectedIds: teamBSelectedIds,
                      positionLabelBuilder: positionLabel,
                      itemBuilder: (index) => buildItems(
                        teamB,
                        teamBSelectedIds,
                        index,
                      ),
                      onChanged: (index, value) {
                        if (value == null) {
                          return;
                        }
                        setState(() => teamBSelectedIds[index] = value);
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(
                            TeamStartingRotationSelection(
                              teamAPlayers:
                                  resolveSelection(teamA, teamASelectedIds),
                              teamBPlayers:
                                  resolveSelection(teamB, teamBSelectedIds),
                            ),
                          );
                        },
                        child: const Text('Confirmar rotacao'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancelar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

Future<String?> showRenameGroupDialog(
  BuildContext context, {
  required String initialValue,
}) {
  final controller = TextEditingController(text: initialValue);
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Renomear Formação'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(labelText: 'Nome'),
      ),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pop(controller.text.trim()),
              child: const Text('Salvar'),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _RotationTeamSection extends StatelessWidget {
  const _RotationTeamSection({
    required this.teamName,
    required this.slotCount,
    required this.selectedIds,
    required this.positionLabelBuilder,
    required this.itemBuilder,
    required this.onChanged,
  });

  final String teamName;
  final int slotCount;
  final List<String> selectedIds;
  final String Function(int index) positionLabelBuilder;
  final List<DropdownMenuItem<String>> Function(int index) itemBuilder;
  final void Function(int index, String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          teamName,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 12),
        if (slotCount == 0)
          Text(
            'Este time nao possui atletas cadastrados para definir a rotacao.',
            style: Theme.of(context).textTheme.bodyMedium,
          )
        else
          for (var index = 0; index < slotCount; index++) ...[
            DropdownButtonFormField<String>(
              key: Key('starting-rotation-${teamName.toLowerCase()}-$index'),
              initialValue: selectedIds[index],
              decoration: InputDecoration(
                labelText: positionLabelBuilder(index),
              ),
              items: itemBuilder(index),
              onChanged: (value) => onChanged(index, value),
            ),
            if (index < slotCount - 1) const SizedBox(height: 12),
          ],
      ],
    );
  }
}

Future<TeamSaveDraft?> showSaveTeamsDialog(
  BuildContext context, {
  required List<String> initialTeamNames,
}) {
  final formKey = GlobalKey<FormState>();
  final formationController = TextEditingController();
  final teamControllers = List<TextEditingController>.generate(
    initialTeamNames.length,
    (index) => TextEditingController(text: initialTeamNames[index]),
  );

  return showDialog<TeamSaveDraft>(
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
                teamControllers.length,
                (index) => Padding(
                  padding: EdgeInsets.only(
                      bottom: index == teamControllers.length - 1 ? 0 : 12),
                  child: TextFormField(
                    controller: teamControllers[index],
                    inputFormatters: teamNameInputFormatters(),
                    decoration: InputDecoration(
                      labelText: 'Nome da equipe ${index + 1}',
                      hintText: 'Ex.: Time ${String.fromCharCode(65 + index)}',
                    ),
                    validator: (value) => validateDistinctTeamName(
                      value,
                      'equipe ${index + 1}',
                      teamControllers.map((controller) => controller.text),
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
                Navigator.of(context).pop(
                  TeamSaveDraft(
                    title: formationController.text.trim(),
                    teamNames: teamControllers
                        .map((controller) =>
                            controller.text.trim().toUpperCase())
                        .toList(),
                  ),
                );
              },
              child: const Text('Salvar'),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Future<TeamMatchupSelection?> showTeamsMatchupDialog(
  BuildContext context, {
  required List<DrawTeam> teams,
  required String title,
  required String confirmLabel,
  String firstTeamLabel = 'Time A',
  String secondTeamLabel = 'Time B',
}) async {
  if (teams.length == 2) {
    return TeamMatchupSelection(teamA: teams[0], teamB: teams[1]);
  }

  var firstIndex = 0;
  var secondIndex = 1;

  return showDialog<TeamMatchupSelection>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<int>(
              initialValue: firstIndex,
              decoration: InputDecoration(labelText: firstTeamLabel),
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
              decoration: InputDecoration(labelText: secondTeamLabel),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: firstIndex == secondIndex
                    ? null
                    : () => Navigator.of(context).pop(
                          TeamMatchupSelection(
                            teamA: teams[firstIndex],
                            teamB: teams[secondIndex],
                          ),
                        ),
                child: Text(confirmLabel),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
