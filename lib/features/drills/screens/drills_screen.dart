import 'package:flutter/material.dart';

import '../../../config/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/dashboard_profile_bottom_navigation.dart';
import '../../../widgets/section_title.dart';
import '../models/drill.dart';
import '../services/drills_service.dart';

enum _DrillFilter {
  all,
  recepcao,
  ataque,
  saque,
  favoritos,
}

class DrillsScreen extends StatefulWidget {
  const DrillsScreen({super.key});

  @override
  State<DrillsScreen> createState() => _DrillsScreenState();
}

class _DrillsScreenState extends State<DrillsScreen> {
  _DrillFilter _activeFilter = _DrillFilter.all;
  List<Drill> _drills = const [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDrills();
  }

  Future<void> _loadDrills() async {
    final drills = await DrillsService.instance.listDrills();
    if (!mounted) {
      return;
    }
    setState(() {
      _drills = drills;
      _isLoading = false;
    });
  }

  Future<void> _toggleFavorite(String drillId) async {
    await DrillsService.instance.toggleFavorite(drillId);
    await _loadDrills();
  }

  Future<void> _openDetail(String drillId) async {
    await Navigator.pushNamed(
      context,
      AppRoutes.drillDetail,
      arguments: drillId,
    );
    await _loadDrills();
  }

  List<Drill> get _filteredDrills {
    final drills = _drills;
    switch (_activeFilter) {
      case _DrillFilter.all:
        return drills;
      case _DrillFilter.recepcao:
        return drills.where((drill) => drill.category == 'Recepção').toList();
      case _DrillFilter.ataque:
        return drills.where((drill) => drill.category == 'Ataque').toList();
      case _DrillFilter.saque:
        return drills.where((drill) => drill.category == 'Saque').toList();
      case _DrillFilter.favoritos:
        return drills.where((drill) => drill.isFavorite).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final drills = _filteredDrills;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: AppSpacing.screen,
          children: [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(
                    title: 'Biblioteca de Drills',
                    subtitle: 'Visualize, entenda e execute exercícios com animação 2D, passos guiados e dicas práticas.',
                    centered: true,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _FilterChipLabel(
                        label: 'Todos',
                        isSelected: _activeFilter == _DrillFilter.all,
                        onTap: () => setState(() => _activeFilter = _DrillFilter.all),
                      ),
                      _FilterChipLabel(
                        label: 'Recepção',
                        isSelected: _activeFilter == _DrillFilter.recepcao,
                        onTap: () => setState(() => _activeFilter = _DrillFilter.recepcao),
                      ),
                      _FilterChipLabel(
                        label: 'Ataque',
                        isSelected: _activeFilter == _DrillFilter.ataque,
                        onTap: () => setState(() => _activeFilter = _DrillFilter.ataque),
                      ),
                      _FilterChipLabel(
                        label: 'Saque',
                        isSelected: _activeFilter == _DrillFilter.saque,
                        onTap: () => setState(() => _activeFilter = _DrillFilter.saque),
                      ),
                      _FilterChipLabel(
                        label: 'Favoritos',
                        isSelected: _activeFilter == _DrillFilter.favoritos,
                        onTap: () => setState(() => _activeFilter = _DrillFilter.favoritos),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppSpacing.gapMedium,
            if (_isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (drills.isEmpty)
              AppCard(
                child: Text(
                  'Nenhum drill encontrado para esse filtro.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            else
              for (final drill in drills) ...[
                _DrillLibraryCard(
                  title: drill.name,
                  category: drill.category,
                  objective: drill.objective,
                  difficulty: drill.difficulty,
                  duration: drill.duration,
                  playersCount: drill.playersCount,
                  isFavorite: drill.isFavorite,
                  onToggleFavorite: () => _toggleFavorite(drill.id),
                  onTap: () => _openDetail(drill.id),
                ),
                AppSpacing.gapMedium,
              ],
          ],
        ),
      ),
      bottomNavigationBar: const DashboardProfileBottomNavigation(
        currentRoute: AppRoutes.drills,
      ),
    );
  }
}

class _FilterChipLabel extends StatelessWidget {
  const _FilterChipLabel({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.secondaryBlueColor
              : AppTheme.secondaryBlueColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected ? Colors.white : AppTheme.secondaryBlueColor,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}

class _DrillLibraryCard extends StatelessWidget {
  const _DrillLibraryCard({
    required this.title,
    required this.category,
    required this.objective,
    required this.difficulty,
    required this.duration,
    required this.playersCount,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onTap,
  });

  final String title;
  final String category;
  final String objective;
  final String difficulty;
  final String duration;
  final int playersCount;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.accentColor.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    category,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: onToggleFavorite,
                    tooltip: isFavorite ? 'Desfavoritar drill' : 'Favoritar drill',
                    icon: Icon(
                      isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: AppTheme.accentColor,
                    ),
                  ),
                ),
                const Icon(Icons.play_circle_fill_rounded, color: AppTheme.secondaryBlueColor),
              ],
            ),
            const SizedBox(height: 14),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(objective, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _MetaTag(label: difficulty),
                _MetaTag(label: '$playersCount jogadores'),
                _MetaTag(label: duration),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaTag extends StatelessWidget {
  const _MetaTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.lightGrayColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
