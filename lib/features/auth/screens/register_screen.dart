import 'package:flutter/material.dart';

import '../auth_validators.dart';
import '../../../services/auth_service.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/ui_feedback.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/scoutset_logo.dart';
import '../../../widgets/section_title.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const _nameMaxLength = 20;
  static const _emailMaxLength = 40;
  static const _passwordMaxLength = 12;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService.instance;
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_handlePasswordChanged);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_handlePasswordChanged);
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handlePasswordChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  String? _validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) {
      return 'Informe seu nome.';
    }
    return null;
  }

  Future<void> _submitRegister() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) {
        return;
      }

      Navigator.pop(context, true);
    } on ArgumentError catch (error) {
      if (!mounted) {
        return;
      }
      showAppSnackBar(context, error.message.toString());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final strength = PasswordValidators.evaluate(_passwordController.text);

    return Scaffold(
      backgroundColor: const Color(0xFF081426),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: AppSpacing.screen,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: ScoutSetLogo(showTagline: true, center: true),
                    ),
                    AppSpacing.gapLarge,
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: SectionTitle(
                              title: 'Cadastro de Usuário',
                              centered: true,
                            ),
                          ),
                          AppSpacing.gapLarge,
                          AppTextField(
                            label: 'Nome',
                            hintText: 'Como deseja ser identificado',
                            controller: _nameController,
                            prefixIcon: Icons.person_outline,
                            validator: _validateName,
                            maxLength: _nameMaxLength,
                          ),
                          AppSpacing.gapSmall,
                          AppTextField(
                            label: 'E-mail',
                            hintText: 'usuario@exemplo.com',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icons.mail_outline,
                            validator: AuthValidators.validateEmail,
                            maxLength: _emailMaxLength,
                          ),
                          AppSpacing.gapSmall,
                          AppTextField(
                            label: 'Senha',
                            hintText: 'Crie uma senha segura',
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            prefixIcon: Icons.lock_outline,
                            validator: PasswordValidators.validateNewPassword,
                            maxLength: _passwordMaxLength,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Use 8+ caracteres, pelo menos 1 número, 1 maiúscula e 1 caractere especial.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: LinearProgressIndicator(
                              minHeight: 8,
                              value: strength.score / 4,
                              color: strength.color,
                              backgroundColor: const Color(0xFFE5E7EB),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            strength.label,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: strength.color,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          AppSpacing.gapMedium,
                          AppButton(
                            label: 'Cadastrar',
                            icon: Icons.person_add_alt_1,
                            isLoading: _isLoading,
                            onPressed: _submitRegister,
                          ),
                        ],
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
