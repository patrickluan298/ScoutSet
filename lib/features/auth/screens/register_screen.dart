import 'package:flutter/material.dart';

import '../../../config/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/section_title.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    setState(() => _isLoading = true);

    await _authService.register(
      name: _nameController.text.trim().isEmpty ? 'Novo usuario' : _nameController.text.trim(),
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
      appBar: AppBar(title: const Text('Criar conta')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screen,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle(
                      title: 'Cadastro inicial',
                      subtitle: 'Base pronta para conectar autenticacao real depois.',
                    ),
                    AppSpacing.gapLarge,
                    AppTextField(
                      label: 'Nome',
                      controller: _nameController,
                      prefixIcon: Icons.person_outline,
                    ),
                    AppSpacing.gapSmall,
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
                      label: 'Cadastrar',
                      icon: Icons.person_add_alt_1,
                      isLoading: _isLoading,
                      onPressed: _handleRegister,
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

