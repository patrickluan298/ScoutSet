import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/section_title.dart';
import '../models/drill.dart';
import '../services/drills_service.dart';
import '../widgets/drill_animation_view.dart';

class DrillDetailScreen extends StatefulWidget {
  const DrillDetailScreen({
    required this.drillId,
    super.key,
  });

  final String drillId;

  @override
  State<DrillDetailScreen> createState() => _DrillDetailScreenState();
}

class _DrillDetailScreenState extends State<DrillDetailScreen> {
  final DrillAnimationController _animationController = DrillAnimationController();
  Drill? _drill;
  int _activeStepIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDrill();
  }

  Future<void> _loadDrill() async {
    final drill = await DrillsService.instance.getById(widget.drillId);
    if (!mounted) {
      return;
    }
    setState(() {
      _drill = drill;
      _isLoading = false;
    });
  }

  Future<void> _toggleFavorite() async {
    final drill = _drill;
    if (drill == null) {
      return;
    }
    await DrillsService.instance.toggleFavorite(drill.id);
    await _loadDrill();
  }

  void _handleStepTap(int index) {
    _animationController.jumpToStep?.call(index);
    setState(() {
      _activeStepIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final drill = _drill;
    if (drill == null) {
      return Scaffold(
        body: const SafeArea(
          child: Center(
            child: Text('Drill não encontrado.'),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            drill.category.toUpperCase(),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppTheme.secondaryBlueColor,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        IconButton(
                          onPressed: _toggleFavorite,
                          tooltip: drill.isFavorite ? 'Desfavoritar drill' : 'Favoritar drill',
                          icon: Icon(
                            drill.isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(drill.name, style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 12),
                    Text(drill.objective, style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _MetaPill(label: 'Dificuldade', value: drill.difficulty),
                        _MetaPill(label: 'Jogadores', value: '${drill.playersCount}'),
                        _MetaPill(label: 'Duração', value: drill.duration),
                        _MetaPill(label: 'Categoria', value: drill.category),
                      ],
                    ),
                  ],
                ),
              ),
              AppSpacing.gapMedium,
              DrillAnimationView(
                drill: drill,
                controller: _animationController,
                onStepChanged: (stepIndex) {
                  if (_activeStepIndex == stepIndex) {
                    return;
                  }

                  setState(() {
                    _activeStepIndex = stepIndex;
                  });
                },
              ),
              AppSpacing.gapMedium,
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle(
                      title: 'Passo a passo',
                      subtitle: 'Toque em qualquer etapa para sincronizar a animação com o momento desejado.',
                    ),
                    const SizedBox(height: 16),
                    for (var index = 0; index < drill.steps.length; index++)
                      _StepTile(
                        index: index,
                        text: drill.steps[index],
                        isActive: index == _activeStepIndex,
                        onTap: () => _handleStepTap(index),
                      ),
                  ],
                ),
              ),
              AppSpacing.gapMedium,
              _InfoListCard(
                title: 'Dicas',
                subtitle: 'Boas práticas para melhorar a execução do drill.',
                items: drill.tips,
                accentColor: AppTheme.secondaryBlueColor,
                icon: Icons.tips_and_updates_outlined,
              ),
              AppSpacing.gapMedium,
              _InfoListCard(
                title: 'Erros comuns',
                subtitle: 'Pontos de atenção para evitar vícios técnicos.',
                items: drill.commonErrors,
                accentColor: const Color(0xFFD14343),
                icon: Icons.warning_amber_rounded,
              ),
              AppSpacing.gapMedium,
              _InfoListCard(
                title: 'Variações',
                subtitle: 'Formas de evoluir a tarefa sem perder o objetivo técnico.',
                items: drill.variations,
                accentColor: AppTheme.accentColor,
                icon: Icons.alt_route_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  const _MetaPill({
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
        color: AppTheme.lightGrayColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({
    required this.index,
    required this.text,
    required this.isActive,
    required this.onTap,
  });

  final int index;
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppTheme.secondaryBlueColor : AppTheme.mediumGrayColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.secondaryBlueColor.withValues(alpha: 0.08) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? AppTheme.secondaryBlueColor : const Color(0xFFD9E2EC),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${index + 1}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoListCard extends StatelessWidget {
  const _InfoListCard({
    required this.title,
    required this.subtitle,
    required this.items,
    required this.accentColor,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final List<String> items;
  final Color accentColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: title, subtitle: subtitle),
          const SizedBox(height: 16),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Icon(icon, size: 16, color: accentColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(item, style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
