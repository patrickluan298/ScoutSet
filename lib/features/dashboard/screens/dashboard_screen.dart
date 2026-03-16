import 'package:flutter/material.dart';

import '../../../config/app_routes.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/dashboard_tile.dart';
import '../../../widgets/section_title.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    this.showScaffold = true,
  });

  final bool showScaffold;

  static const _tiles = [
    _DashboardItem('Placar', 'Controle o jogo em tempo real', Icons.sports_volleyball, AppRoutes.scoreboard),
    _DashboardItem('Estrategias', 'Monte cenarios e simulacoes', Icons.schema, AppRoutes.strategies),
    _DashboardItem('Drills', 'Organize treinos e exercicios', Icons.fitness_center, AppRoutes.drills),
    _DashboardItem('Regras', 'Consulte regras e observacoes', Icons.gavel, AppRoutes.rules),
    _DashboardItem('Videos', 'Central de analise de video', Icons.videocam_outlined, AppRoutes.videos),
    _DashboardItem('Relatorios', 'Acompanhe dados e metricas', Icons.bar_chart, AppRoutes.reports),
    _DashboardItem('Equipes', 'Gerencie times e atletas', Icons.groups_outlined, AppRoutes.teams),
    _DashboardItem('Perfil', 'Preferencias e conta', Icons.person_outline, AppRoutes.profile),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final content = SingleChildScrollView(
      padding: AppSpacing.screen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Dashboard',
            subtitle: 'Bem-vindo, Coach Patrick. Escolha um modulo para continuar.',
          ),
          AppSpacing.gapMedium,
          AppCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Base pronta para crescer', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(
                        'Arquitetura modular preparada para backend em Python, analise de video com IA e dashboards avancados.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                CircleAvatar(
                  radius: 28,
                  backgroundColor: theme.colorScheme.secondary,
                  child: const Icon(Icons.sports_volleyball, color: Colors.white),
                ),
              ],
            ),
          ),
          AppSpacing.gapMedium,
          GridView.builder(
            itemCount: _tiles.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              final item = _tiles[index];

              return DashboardTile(
                title: item.title,
                subtitle: item.subtitle,
                icon: item.icon,
                onTap: () => Navigator.pushNamed(context, item.route),
              );
            },
          ),
        ],
      ),
    );

    if (!showScaffold) {
      return SafeArea(child: content);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('ScoutSet'),
      ),
      body: content,
    );
  }
}

class _DashboardItem {
  const _DashboardItem(this.title, this.subtitle, this.icon, this.route);

  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
}
