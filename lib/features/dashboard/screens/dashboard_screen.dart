import 'package:flutter/material.dart';

import '../../../config/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/dashboard_tile.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    this.showScaffold = true,
  });

  final bool showScaffold;

  static const _shellRoutes = {
    AppRoutes.dashboard,
    AppRoutes.scoreboard,
    AppRoutes.strategies,
    AppRoutes.reports,
    AppRoutes.profile,
  };

  static const _tiles = [
    _DashboardItem('Placar', 'Controle o jogo em tempo real', Icons.sports_volleyball, AppRoutes.scoreboard),
    _DashboardItem('Estratégias', 'Monte cenários e simulações', Icons.schema, AppRoutes.strategies),
    _DashboardItem('Drills', 'Organize treinos e exercícios', Icons.fitness_center, AppRoutes.drills),
    _DashboardItem('Regras', 'Consulte regras e observações', Icons.gavel, AppRoutes.rules),
    _DashboardItem('Vídeos', 'Central de análise de vídeo', Icons.videocam_outlined, AppRoutes.videos),
    _DashboardItem('Relatórios', 'Acompanhe dados e métricas', Icons.bar_chart, AppRoutes.reports),
    _DashboardItem('Equipes', 'Gerencie times e atletas', Icons.groups_outlined, AppRoutes.teams),
    _DashboardItem('Perfil', 'Preferências e conta', Icons.person_outline, AppRoutes.profile),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = AuthService.instance.currentUser;
    final userName = (user?.name.trim().isNotEmpty ?? false) ? user!.name.trim() : 'Usuário';

    final content = SingleChildScrollView(
      padding: AppSpacing.screen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSpacing.gapMedium,
          AppCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Vamos começar os treinos?', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(
                        'Bem-vindo, $userName. Escolha um módulo para continuar.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFF5BE00),
                        Color(0xFFFFD84D),
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.sports_volleyball,
                    color: Color(0xFF081426),
                    size: 32,
                  ),
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
                onTap: () {
                  if (_shellRoutes.contains(item.route)) {
                    Navigator.pushReplacementNamed(context, item.route);
                    return;
                  }

                  Navigator.pushNamed(context, item.route);
                },
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
