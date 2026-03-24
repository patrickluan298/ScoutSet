import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/section_title.dart';
import '../models/drill.dart';
import '../services/drill_mock_service.dart';
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
  late final Drill _drill;
  late final DrillAnimationController _animationController;
  int _activeStepIndex = 0;

  @override
  void initState() {
    super.initState();
    _drill = DrillMockService.instance.getById(widget.drillId);
    _animationController = DrillAnimationController();
  }

  void _handleStepTap(int index) {
    _animationController.jumpToStep?.call(index);
    setState(() {
      _activeStepIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_drill.name)),
      body: SingleChildScrollView(
        padding: AppSpacing.screen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _drill.category.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.secondaryBlueColor,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(_drill.name, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 12),
                  Text(_drill.objective, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _MetaPill(label: 'Dificuldade', value: _drill.difficulty),
                      _MetaPill(label: 'Jogadores', value: '${_drill.playersCount}'),
                      _MetaPill(label: 'Duração', value: _drill.duration),
                      _MetaPill(label: 'Categoria', value: _drill.category),
                    ],
                  ),
                ],
              ),
            ),
            AppSpacing.gapMedium,
            DrillAnimationView(
              drill: _drill,
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
                  for (var index = 0; index < _drill.steps.length; index++)
                    _StepTile(
                      index: index,
                      text: _drill.steps[index],
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
              items: _drill.tips,
              accentColor: AppTheme.secondaryBlueColor,
              icon: Icons.tips_and_updates_outlined,
            ),
            AppSpacing.gapMedium,
            _InfoListCard(
              title: 'Erros comuns',
              subtitle: 'Pontos de atenção para evitar vícios técnicos.',
              items: _drill.commonErrors,
              accentColor: const Color(0xFFD14343),
              icon: Icons.warning_amber_rounded,
            ),
            AppSpacing.gapMedium,
            _InfoListCard(
              title: 'Variações',
              subtitle: 'Formas de evoluir a tarefa sem perder o objetivo técnico.',
              items: _drill.variations,
              accentColor: AppTheme.accentColor,
              icon: Icons.alt_route_rounded,
            ),
          ],
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
          color: isActive ? AppTheme.secondaryBlueColor.withOpacity(0.08) : Colors.white,
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
                      color: accentColor.withOpacity(0.12),
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
