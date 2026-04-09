import 'package:flutter/material.dart';

import '../../../config/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../services/auth_service.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_page_scaffold.dart';
import '../../../widgets/section_title.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    this.showScaffold = true,
  });

  final bool showScaffold;

  @override
  Widget build(BuildContext context) {
    final authService = AuthService.instance;
    final user = authService.currentUser;
    final themeController = ThemeController.instance;
    final colors = AppTheme.colorsOf(context);

    return AppPageScaffold(
      showScaffold: showScaffold,
      child: SingleChildScrollView(
        child: Padding(
          padding: AppSpacing.screen,
          child: AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SectionTitle(
                  title: 'Perfil',
                  subtitle: 'Dados da sua conta e acesso ao app.',
                ),
                const SizedBox(height: 16),
                Text(
                  user == null
                      ? 'Nenhum usuário autenticado.'
                      : 'Usuário conectado: ${user.name.isEmpty ? user.email : user.name}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                AnimatedBuilder(
                  animation: themeController,
                  builder: (context, _) {
                    final isDarkMode = themeController.isDarkMode;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: colors.subtleBorder),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isDarkMode
                                ? Icons.dark_mode_outlined
                                : Icons.light_mode_outlined,
                            size: 18,
                            color: colors.primaryDetail,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Tema',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontSize: 15,
                                      ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  isDarkMode ? 'Escuro' : 'Claro',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: isDarkMode,
                            onChanged: (value) async {
                              await themeController.setThemeMode(
                                value ? ThemeMode.dark : ThemeMode.light,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                AppButton(
                  label: 'Sair',
                  icon: Icons.logout,
                  onPressed: () async {
                    await authService.signOut();
                    if (!context.mounted) {
                      return;
                    }
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.login,
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
