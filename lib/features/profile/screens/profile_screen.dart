import 'package:flutter/material.dart';

import '../../../config/app_routes.dart';
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
