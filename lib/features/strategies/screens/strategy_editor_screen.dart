import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../utils/app_spacing.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/section_title.dart';
import '../models/movement.dart';
import '../models/player_position.dart';
import '../models/strategy.dart';
import '../models/substitution.dart';
import '../services/strategy_service.dart';
import '../widgets/strategy_toolbar.dart';
import '../widgets/volleyball_court.dart';

class StrategyEditorScreen extends StatefulWidget {
  const StrategyEditorScreen({
    super.key,
    this.strategy,
  });

  final Strategy? strategy;

  @override
  State<StrategyEditorScreen> createState() => _StrategyEditorScreenState();
}

class _StrategyEditorScreenState extends State<StrategyEditorScreen> {
  final StrategyService _strategyService = StrategyService.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late StrategyGameMode _gameMode;
  late List<PlayerPosition> _players;
  late List<PlayerPosition> _benchPlayers;
  late List<Movement> _movements;
  late List<Substitution> _substitutions;

  StrategyInteractionMode _interactionMode = StrategyInteractionMode.movePlayers;
  MovementType _selectedMovementType = MovementType.move;
  String? _selectedPlayerId;
  String? _selectedMovementId;
  String? _selectedOutgoingPlayerId;
  String? _selectedIncomingPlayerId;
  bool _isLiberoExchange = false;

  bool get _isEditing => widget.strategy != null;

  @override
  void initState() {
    super.initState();
    final strategy = widget.strategy;
    _nameController = TextEditingController(text: strategy?.name ?? '');
    _descriptionController = TextEditingController(text: strategy?.description ?? '');
    _gameMode = strategy?.gameMode ?? StrategyGameMode.indoor;
    _players = strategy == null
        ? _strategyService.defaultPlayersForMode(_gameMode)
        : strategy.playersPositions.map((player) => player.copyWith()).toList();
    _benchPlayers = strategy == null
        ? _strategyService.defaultBenchPlayersForMode(_gameMode)
        : strategy.benchPlayers.map((player) => player.copyWith()).toList();
    _movements = strategy == null
        ? <Movement>[]
        : strategy.movements.map((movement) => movement.copyWith()).toList();
    _substitutions = strategy == null
        ? <Substitution>[]
        : strategy.substitutions.map((substitution) => substitution.copyWith()).toList();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handlePlayerTap(String playerId) {
    if (_interactionMode == StrategyInteractionMode.eraseMovement) {
      return;
    }

    setState(() {
      _selectedPlayerId = _selectedPlayerId == playerId ? null : playerId;
      _selectedMovementId = null;
    });
  }

  void _handlePlayerDrag(String playerId, Offset delta, Size courtSize) {
    if (_interactionMode != StrategyInteractionMode.movePlayers) {
      return;
    }

    setState(() {
      _players = _players.map((player) {
        if (player.playerId != playerId) {
          return player;
        }

        final nextPosition = Offset(
          (player.position.dx + (delta.dx / courtSize.width)).clamp(0.08, 0.92),
          (player.position.dy + (delta.dy / courtSize.height)).clamp(0.08, 0.92),
        );
        return player.copyWith(position: nextPosition);
      }).toList();

      _movements = _movements.map((movement) {
        if (movement.playerId != playerId) {
          return movement;
        }
        final updatedPlayer = _players.firstWhere((player) => player.playerId == playerId);
        return movement.copyWith(startPosition: updatedPlayer.position);
      }).toList();
    });
  }

  void _handlePlayerReset(String playerId) {
    setState(() {
      _players = _players.map((player) {
        if (player.playerId != playerId) {
          return player;
        }

        return player.copyWith(
          position: player.defaultPosition ?? player.position,
        );
      }).toList();

      _movements = _movements.where((movement) => movement.playerId != playerId).toList();
      _selectedPlayerId = playerId;
    });
  }

  void _handleCourtTap(Offset normalizedPosition) {
    switch (_interactionMode) {
      case StrategyInteractionMode.movePlayers:
        break;
      case StrategyInteractionMode.drawMovement:
        final selectedPlayerId = _selectedPlayerId;
        if (selectedPlayerId == null) {
          _showSnackBar('Selecione um jogador antes de desenhar o movimento.');
          return;
        }
        final player = _players.firstWhere((item) => item.playerId == selectedPlayerId);
        final newMovement = Movement(
          id: _strategyService.nextMovementId(),
          playerId: selectedPlayerId,
          startPosition: player.position,
          endPosition: normalizedPosition,
          movementType: _selectedMovementType,
        );
        setState(() {
          _movements = [..._movements, newMovement];
          _selectedMovementId = newMovement.id;
        });
        break;
      case StrategyInteractionMode.eraseMovement:
        final movement = _findClosestMovement(normalizedPosition);
        if (movement == null) {
          return;
        }
        setState(() {
          _movements.removeWhere((item) => item.id == movement.id);
          _selectedMovementId = null;
        });
    }
  }

  Movement? _findClosestMovement(Offset point) {
    Movement? closest;
    var closestDistance = 0.045;

    for (final movement in _movements) {
      final distance = _distanceToSegment(point, movement.startPosition, movement.endPosition);
      if (distance < closestDistance) {
        closestDistance = distance;
        closest = movement;
      }
    }

    return closest;
  }

  double _distanceToSegment(Offset point, Offset start, Offset end) {
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    if (dx == 0 && dy == 0) {
      return (point - start).distance;
    }

    final projection = ((point.dx - start.dx) * dx + (point.dy - start.dy) * dy) /
        (dx * dx + dy * dy);
    final t = projection.clamp(0.0, 1.0);
    final projected = Offset(start.dx + t * dx, start.dy + t * dy);
    return (point - projected).distance;
  }

  void _handleModeChanged(StrategyGameMode mode) {
    if (mode == _gameMode) {
      return;
    }

    setState(() {
      _gameMode = mode;
      _players = _strategyService.resetPlayersForMode(mode);
      _benchPlayers = _strategyService.defaultBenchPlayersForMode(mode);
      _movements = [];
      _substitutions = [];
      _selectedPlayerId = null;
      _selectedMovementId = null;
      _selectedOutgoingPlayerId = null;
      _selectedIncomingPlayerId = null;
      _isLiberoExchange = false;
      _interactionMode = StrategyInteractionMode.movePlayers;
    });
  }

  void _handleResetCourt() {
    setState(() {
      _players = _strategyService.resetPlayersForMode(_gameMode, existingPlayers: _players);
      _benchPlayers = _strategyService.defaultBenchPlayersForMode(_gameMode);
      _movements = [];
      _substitutions = [];
      _selectedPlayerId = null;
      _selectedMovementId = null;
      _selectedOutgoingPlayerId = null;
      _selectedIncomingPlayerId = null;
      _isLiberoExchange = false;
      _interactionMode = StrategyInteractionMode.movePlayers;
    });
  }

  void _applySubstitution() {
    if (_gameMode == StrategyGameMode.beach) {
      _showSnackBar('No volei de praia nao sao permitidas substituicoes.');
      return;
    }

    final outgoingId = _selectedOutgoingPlayerId;
    final incomingId = _selectedIncomingPlayerId;
    if (outgoingId == null || incomingId == null) {
      _showSnackBar('Selecione quem sai e quem entra.');
      return;
    }

    final outgoing = _players.firstWhere((player) => player.playerId == outgoingId);
    final incoming = _benchPlayers.firstWhere((player) => player.playerId == incomingId);

    if (_isLiberoExchange) {
      if (!(outgoing.isLibero ^ incoming.isLibero)) {
        _showSnackBar('A troca de libero deve envolver exatamente um libero.');
        return;
      }
    } else {
      if (_substitutions.where((item) => item.countsTowardLimit).length >= 6) {
        _showSnackBar('Cada equipe pode fazer ate 6 substituicoes por set.');
        return;
      }

      if (incoming.isLibero) {
        _showSnackBar('O libero deve entrar apenas em troca de libero.');
        return;
      }

      final validation = _validateRegulationSubstitution(outgoing, incoming);
      if (validation != null) {
        _showSnackBar(validation);
        return;
      }
    }

    setState(() {
      final outgoingIndex = _players.indexWhere((player) => player.playerId == outgoing.playerId);
      final incomingIndex =
          _benchPlayers.indexWhere((player) => player.playerId == incoming.playerId);
      final incomingOnCourt = incoming.copyWith(
        position: outgoing.position,
        defaultPosition: outgoing.defaultPosition,
      );
      final outgoingToBench = outgoing.copyWith(position: Offset.zero);

      _players[outgoingIndex] = incomingOnCourt;
      _benchPlayers[incomingIndex] = outgoingToBench;
      _substitutions = [
        ..._substitutions,
        Substitution(
          id: _strategyService.nextSubstitutionId(),
          playerOutId: outgoing.playerId,
          playerInId: incoming.playerId,
          createdAt: DateTime.now(),
          isLiberoExchange: _isLiberoExchange,
          countsTowardLimit: !_isLiberoExchange,
        ),
      ];
      _movements = _movements
          .where(
            (movement) =>
                movement.playerId != outgoing.playerId &&
                movement.playerId != incoming.playerId,
          )
          .toList();
      _selectedOutgoingPlayerId = null;
      _selectedIncomingPlayerId = null;
      _selectedPlayerId = null;
      _selectedMovementId = null;
      _isLiberoExchange = false;
    });
  }

  String? _validateRegulationSubstitution(
    PlayerPosition outgoing,
    PlayerPosition incoming,
  ) {
    final regulationSubs = _substitutions.where((item) => item.countsTowardLimit).toList();

    if (outgoing.isStarter) {
      final hasAlreadyLeft =
          regulationSubs.any((item) => item.playerOutId == outgoing.playerId);
      final hasAlreadyReturned =
          regulationSubs.any((item) => item.playerInId == outgoing.playerId);
      if (hasAlreadyLeft && hasAlreadyReturned) {
        return 'O titular ${outgoing.label} ja saiu e retornou neste set.';
      }
      if (hasAlreadyLeft && !hasAlreadyReturned) {
        return 'O titular ${outgoing.label} so pode voltar para o lugar de quem o substituiu.';
      }
      return null;
    }

    Substitution? firstEntry;
    for (final substitution in regulationSubs) {
      if (substitution.playerInId == outgoing.playerId) {
        firstEntry = substitution;
        break;
      }
    }
    if (firstEntry == null) {
      return 'Jogadores reservas so podem sair para o retorno do titular correspondente.';
    }

    if (incoming.playerId != firstEntry.playerOutId) {
      return 'O reserva ${outgoing.label} so pode sair para o retorno de ${firstEntry.playerOutId}.';
    }

    final starterAlreadyReturned = regulationSubs.any(
      (item) =>
          item.playerInId == incoming.playerId &&
          item.playerOutId == outgoing.playerId,
    );
    if (starterAlreadyReturned) {
      return 'Esse titular ja retornou ao jogo neste set.';
    }

    return null;
  }

  List<PlayerPosition> _eligibleBenchPlayers() {
    if (_gameMode == StrategyGameMode.beach) {
      return const [];
    }

    if (_isLiberoExchange) {
      return _benchPlayers;
    }

    return _benchPlayers.where((player) => !player.isLibero).toList();
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final baseStrategy = Strategy(
      id: widget.strategy?.id ?? '',
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      playersPositions: _players,
      benchPlayers: _benchPlayers,
      movements: _movements,
      substitutions: _substitutions,
      createdAt: widget.strategy?.createdAt ?? DateTime.now(),
      gameMode: _gameMode,
    );

    if (_isEditing) {
      _strategyService.updateStrategy(baseStrategy);
    } else {
      _strategyService.createStrategy(baseStrategy);
    }

    Navigator.of(context).pop();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = math.min(MediaQuery.of(context).size.width, 980.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar estrategia' : 'Nova estrategia'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: SingleChildScrollView(
            padding: AppSpacing.screen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(
                  title: _isEditing ? 'Ajuste a jogada' : 'Crie uma nova estrategia',
                  subtitle: 'Posicione os jogadores, desenhe movimentos e salve uma versao pronta para consulta.',
                ),
                AppSpacing.gapMedium,
                AppCard(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          key: const Key('strategy-name-field'),
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nome da estrategia',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Informe um nome para a estrategia.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Descricao',
                            hintText: 'Ex.: recepcao com cobertura curta no fundo.',
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Modo de jogo',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        SegmentedButton<StrategyGameMode>(
                          segments: const [
                            ButtonSegment<StrategyGameMode>(
                              value: StrategyGameMode.indoor,
                              label: Text('Quadra'),
                              icon: Icon(Icons.grid_view_rounded),
                            ),
                            ButtonSegment<StrategyGameMode>(
                              value: StrategyGameMode.beach,
                              label: Text('Praia'),
                              icon: Icon(Icons.wb_sunny_outlined),
                            ),
                          ],
                          selected: {_gameMode},
                          onSelectionChanged: (selection) => _handleModeChanged(selection.first),
                        ),
                      ],
                    ),
                  ),
                ),
                AppSpacing.gapMedium,
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                        'Editor de quadra',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _interactionHint(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 18),
                      VolleyballCourt(
                        players: _players,
                        movements: _movements,
                        selectedPlayerId: _selectedPlayerId,
                        selectedMovementId: _selectedMovementId,
                        interactionMode: _interactionMode,
                        isReadOnly: false,
                        onPlayerTap: _handlePlayerTap,
                        onPlayerDrag: _handlePlayerDrag,
                        onPlayerReset: _handlePlayerReset,
                        onCourtTap: _handleCourtTap,
                      ),
                    ],
                  ),
                ),
                AppSpacing.gapMedium,
                StrategyToolbar(
                  interactionMode: _interactionMode,
                  selectedMovementType: _selectedMovementType,
                  onInteractionModeChanged: (mode) {
                    setState(() {
                      _interactionMode = mode;
                      _selectedMovementId = null;
                    });
                  },
                  onMovementTypeChanged: (type) {
                    setState(() {
                      _selectedMovementType = type;
                    });
                  },
                  onResetCourt: _handleResetCourt,
                  onSave: _handleSave,
                ),
                AppSpacing.gapMedium,
                _buildSubstitutionCard(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _interactionHint() {
    switch (_interactionMode) {
      case StrategyInteractionMode.movePlayers:
        return 'Arraste os marcadores para reposicionar os atletas. Toque duas vezes no jogador para resetar sua posicao.';
      case StrategyInteractionMode.drawMovement:
        return 'Selecione um jogador e toque na quadra para criar uma seta de movimento.';
      case StrategyInteractionMode.eraseMovement:
        return 'Toque proximo de uma seta desenhada para remove-la.';
    }
  }

  Widget _buildSubstitutionCard(BuildContext context) {
    if (_gameMode == StrategyGameMode.beach) {
      return AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Substituicoes',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'No volei de praia nao sao permitidas substituicoes durante o set.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    final eligibleBenchPlayers = _eligibleBenchPlayers();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Substituicoes',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Quadra: ate 6 substituicoes regulamentares por set. Trocas de libero sao ilimitadas e nao contam nesse limite.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _StatPill(label: 'Regulamentares', value: '${_substitutions.where((item) => item.countsTowardLimit).length}/6'),
              _StatPill(label: 'Libero', value: '${_substitutions.where((item) => item.isLiberoExchange).length}'),
              _StatPill(label: 'Banco', value: '${_benchPlayers.length}'),
            ],
          ),
          const SizedBox(height: 16),
          SwitchListTile.adaptive(
            value: _isLiberoExchange,
            contentPadding: EdgeInsets.zero,
            title: const Text('Troca de libero'),
            subtitle: const Text('Ilimitada e fora do limite regulamentar.'),
            onChanged: (value) {
              setState(() {
                _isLiberoExchange = value;
                _selectedIncomingPlayerId = null;
              });
            },
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            key: const Key('sub-out-dropdown'),
            initialValue: _selectedOutgoingPlayerId,
            decoration: const InputDecoration(labelText: 'Jogador que sai'),
            items: _players
                .map(
                  (player) => DropdownMenuItem<String>(
                    value: player.playerId,
                    child: Text('${player.label} - ${player.playerId}${player.isLibero ? ' (Libero)' : ''}'),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedOutgoingPlayerId = value;
              });
            },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            key: const Key('sub-in-dropdown'),
            initialValue: eligibleBenchPlayers.any((item) => item.playerId == _selectedIncomingPlayerId)
                ? _selectedIncomingPlayerId
                : null,
            decoration: const InputDecoration(labelText: 'Jogador que entra'),
            items: eligibleBenchPlayers
                .map(
                  (player) => DropdownMenuItem<String>(
                    value: player.playerId,
                    child: Text('${player.label} - ${player.playerId}${player.isLibero ? ' (Libero)' : ''}'),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedIncomingPlayerId = value;
              });
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _applySubstitution,
              icon: const Icon(Icons.swap_horiz),
              label: const Text('Aplicar substituicao'),
            ),
          ),
          if (_substitutions.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              'Historico do set',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ..._substitutions.take(6).map(
              (substitution) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  '${substitution.playerOutId} -> ${substitution.playerInId}${substitution.isLiberoExchange ? ' (Libero)' : ''}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 4),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
