import 'package:flutter/material.dart';

import '../../../utils/app_spacing.dart';
import '../../../utils/confirmation_dialogs.dart';
import '../../../utils/navigation_helpers.dart';
import '../../../utils/ui_feedback.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_page_scaffold.dart';
import '../../../widgets/section_title.dart';
import '../models/player_position.dart';
import '../models/strategy.dart';
import '../services/strategy_service.dart';
import 'strategy_detail_screen.dart';
import 'strategy_editor_screen.dart';

class StrategiesScreen extends StatefulWidget {
  const StrategiesScreen({
    super.key,
    this.showScaffold = true,
  });

  final bool showScaffold;

  @override
  State<StrategiesScreen> createState() => _StrategiesScreenState();
}

class _StrategiesScreenState extends State<StrategiesScreen> {
  final StrategyService _strategyService = StrategyService.instance;
  List<Strategy> _strategies = const [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStrategies();
  }

  Future<void> _loadStrategies() async {
    final strategies = await _strategyService.listStrategies();
    if (!mounted) {
      return;
    }
    setState(() {
      _strategies = strategies;
      _isLoading = false;
    });
  }

  Future<void> _openEditor([Strategy? strategy]) async {
    await pushPageAndReload(
      context,
      StrategyEditorScreen(strategy: strategy),
      onReturn: _loadStrategies,
    );
  }

  Future<void> _openDetail(Strategy strategy) async {
    await pushPageAndReload(
      context,
      StrategyDetailScreen(strategyId: strategy.id),
      onReturn: _loadStrategies,
    );
  }

  Future<void> _deleteStrategy(Strategy strategy) async {
    final shouldDelete = await showConfirmationDialog(
      context,
      title: 'Excluir estratégia',
      message: 'Deseja remover "${strategy.name}" da lista?',
      confirmLabel: 'Excluir',
      destructive: true,
    );

    if (shouldDelete != true || !mounted) {
      return;
    }

    await _strategyService.deleteStrategy(strategy.id);
    await _loadStrategies();
    if (!mounted) {
      return;
    }
    showAppSnackBar(context, 'Estratégia "${strategy.name}" removida.');
  }

  @override
  Widget build(BuildContext context) {
    return AppPageScaffold(
      showScaffold: widget.showScaffold,
      child: RefreshIndicator(
        onRefresh: _loadStrategies,
        child: ListView(
          padding: AppSpacing.screen,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: SectionTitle(
                    title: 'Estratégias',
                    subtitle: 'Monte formações, desenhe jogadas e organize cenários táticos para quadra e praia.',
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 170,
                  child: AppButton(
                    label: 'Nova estratégia',
                    icon: Icons.add,
                    onPressed: () => _openEditor(),
                  ),
                ),
              ],
            ),
            AppSpacing.gapMedium,
            if (_isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (_strategies.isEmpty)
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sua área tática está pronta para começar.',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Crie a primeira estratégia para posicionar atletas, desenhar movimentações e salvar modelos de jogo.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    AppButton(
                      label: 'Criar primeira estratégia',
                      icon: Icons.sports_volleyball,
                      onPressed: () => _openEditor(),
                    ),
                  ],
                ),
              )
            else
              ..._strategies.map(_buildStrategyCard),
          ],
        ),
      ),
    );
  }

  Widget _buildStrategyCard(Strategy strategy) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(strategy.name, style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(
                        strategy.description.isEmpty
                            ? 'Sem descrição adicional.'
                            : strategy.description,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Chip(
                  label: Text(
                    strategy.gameMode == StrategyGameMode.indoor
                        ? 'Quadra'
                        : 'Praia',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _MetaPill(
                  icon: Icons.calendar_today_outlined,
                  label: _formatDate(strategy.createdAt),
                ),
                _MetaPill(
                  icon: Icons.group_outlined,
                  label: '${strategy.playersCount} jogadores',
                ),
                _MetaPill(
                  icon: Icons.alt_route,
                  label: '${strategy.movements.length} movimentos',
                ),
                _MetaPill(
                  icon: Icons.swap_horiz,
                  label: '${strategy.regulationSubstitutionsCount} subs',
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _openDetail(strategy),
                    icon: const Icon(Icons.visibility_outlined),
                    label: const Text('Visualizar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _openEditor(strategy),
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Editar'),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: () => _deleteStrategy(strategy),
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Excluir estratégia',
                ),
              ],
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

class _MetaPill extends StatelessWidget {
  const _MetaPill({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
