import 'package:flutter/material.dart';

import '../../../utils/app_spacing.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/section_title.dart';
import '../models/player_position.dart';
import '../models/strategy.dart';
import '../services/strategy_service.dart';
import '../widgets/volleyball_court.dart';
import '../widgets/strategy_toolbar.dart';

class StrategyDetailScreen extends StatelessWidget {
  const StrategyDetailScreen({
    required this.strategyId,
    super.key,
  });

  final String strategyId;

  @override
  Widget build(BuildContext context) {
    final Strategy? strategy = StrategyService.instance.getStrategyById(strategyId);

    if (strategy == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Estrategia')),
        body: const Center(
          child: Text('Estrategia nao encontrada.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(strategy.name)),
      body: SingleChildScrollView(
        padding: AppSpacing.screen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              title: strategy.name,
              subtitle: strategy.description.isEmpty
                  ? 'Visualizacao apenas leitura da estrategia salva.'
                  : strategy.description,
            ),
            AppSpacing.gapMedium,
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quadra tatica',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  VolleyballCourt(
                    players: strategy.playersPositions,
                    movements: strategy.movements,
                    selectedPlayerId: null,
                    selectedMovementId: null,
                    interactionMode: StrategyInteractionMode.movePlayers,
                    isReadOnly: true,
                    onPlayerTap: (_) {},
                    onPlayerDrag: (_, __, ___) {},
                    onPlayerReset: (_) {},
                    onCourtTap: (_) {},
                  ),
                ],
              ),
            ),
            AppSpacing.gapMedium,
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resumo',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Modo: ${strategy.gameMode == StrategyGameMode.indoor ? 'Quadra' : 'Praia'}',
                  ),
                  const SizedBox(height: 8),
                  Text('Criada em: ${_formatDate(strategy.createdAt)}'),
                  const SizedBox(height: 8),
                  Text('Jogadores: ${strategy.playersCount}'),
                  const SizedBox(height: 8),
                  Text('Banco: ${strategy.benchPlayers.length}'),
                  const SizedBox(height: 8),
                  Text('Movimentos desenhados: ${strategy.movements.length}'),
                  const SizedBox(height: 8),
                  Text('Substituicoes regulamentares: ${strategy.regulationSubstitutionsCount}/6'),
                  const SizedBox(height: 8),
                  Text('Trocas de libero: ${strategy.liberoExchangesCount}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    String twoDigits(int value) => value.toString().padLeft(2, '0');
    return '${twoDigits(date.day)}/${twoDigits(date.month)}/${date.year}';
  }
}
