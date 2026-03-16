import 'package:flutter/material.dart';

import '../../../config/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/section_title.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: 'coach@scoutset.app');
  final _passwordController = TextEditingController(text: '123456');
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);

    await _authService.signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) {
      return;
    }

    setState(() => _isLoading = false);
    Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: AppSpacing.screen,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle(
                      title: 'ScoutSet',
                      subtitle: 'Entre para acessar o painel esportivo da sua equipe.',
                    ),
                    AppSpacing.gapLarge,
                    AppTextField(
                      label: 'E-mail',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.mail_outline,
                    ),
                    AppSpacing.gapSmall,
                    AppTextField(
                      label: 'Senha',
                      controller: _passwordController,
                      obscureText: true,
                      prefixIcon: Icons.lock_outline,
                    ),
                    AppSpacing.gapMedium,
                    AppButton(
                      label: 'Entrar',
                      icon: Icons.login,
                      isLoading: _isLoading,
                      onPressed: _handleLogin,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.register);
                        },
                        child: const Text('Criar conta'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

