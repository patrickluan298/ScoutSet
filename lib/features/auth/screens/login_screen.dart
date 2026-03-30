import 'package:flutter/material.dart';

import '../../../config/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/scoutset_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const _emailMaxLength = 40;
  static const _passwordMaxLength = 12;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService.instance;
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return 'Informe seu e-mail.';
    }
    if (!_authService.isValidEmail(email)) {
      return 'Digite um e-mail válido.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final password = value?.trim() ?? '';
    if (password.isEmpty) {
      return 'Informe sua senha.';
    }
    return null;
  }

  void _resetFormState() {
    _emailController.value = TextEditingValue.empty;
    _passwordController.value = TextEditingValue.empty;
    _formKey.currentState?.reset();
  }

  Future<void> _handleLogin() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) {
        return;
      }

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.dashboard,
        (route) => false,
      );
    } on ArgumentError catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message.toString())),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _openRegister() async {
    final result = await Navigator.pushNamed(context, AppRoutes.register);
    if (!mounted || result != true) {
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() {
      _obscurePassword = true;
    });
    _resetFormState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _emailController.value = TextEditingValue.empty;
      _passwordController.value = TextEditingValue.empty;
      _formKey.currentState?.reset();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Conta criada com sucesso. Agora faça login.'),
      ),
    );
  }

  Future<void> _openForgotPassword() async {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController(text: _emailController.text.trim());
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    var obscureNewPassword = true;
    var obscureConfirmPassword = true;

    final shouldSubmit = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Align(
                alignment: Alignment.center,
                child: Text(
                  'Esqueci minha senha',
                  textAlign: TextAlign.center,
                ),
              ),
              content: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextField(
                        label: 'E-mail',
                        hintText: 'usuario@exemplo.com',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.mail_outline,
                        validator: _validateEmail,
                        maxLength: _emailMaxLength,
                      ),
                      AppSpacing.gapSmall,
                      AppTextField(
                        label: 'Nova senha',
                        hintText: 'Digite a nova senha',
                        controller: newPasswordController,
                        obscureText: obscureNewPassword,
                        prefixIcon: Icons.lock_reset_outlined,
                        maxLength: 12,
                        validator: (value) {
                          final password = value?.trim() ?? '';
                          if (password.isEmpty) {
                            return 'Informe a nova senha.';
                          }
                          if (password.length < 8) {
                            return 'A senha deve ter ao menos 8 caracteres.';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() => obscureNewPassword = !obscureNewPassword);
                          },
                          icon: Icon(
                            obscureNewPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      AppSpacing.gapSmall,
                      AppTextField(
                        label: 'Confirmar nova senha',
                        hintText: 'Repita a nova senha',
                        controller: confirmPasswordController,
                        obscureText: obscureConfirmPassword,
                        prefixIcon: Icons.verified_user_outlined,
                        maxLength: 12,
                        validator: (value) {
                          final confirmation = value?.trim() ?? '';
                          if (confirmation.isEmpty) {
                            return 'Confirme a nova senha.';
                          }
                          if (confirmation != newPasswordController.text.trim()) {
                            return 'As senhas precisam ser iguais.';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() => obscureConfirmPassword = !obscureConfirmPassword);
                          },
                          icon: Icon(
                            obscureConfirmPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final isValid = formKey.currentState?.validate() ?? false;
                        if (!isValid) {
                          return;
                        }
                        Navigator.of(context).pop(true);
                      },
                      child: const Text('Redefinir'),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancelar'),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );

    if (shouldSubmit != true || !mounted) {
      return;
    }

    try {
      await _authService.resetPassword(
        email: emailController.text.trim(),
        newPassword: newPasswordController.text,
      );
      if (!mounted) {
        return;
      }
      _emailController.text = emailController.text.trim();
      _passwordController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Senha redefinida com sucesso. Faça login com a nova senha.'),
        ),
      );
    } on ArgumentError catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: ScoutSetLogo(showTagline: true, center: true),
                    ),
                    AppSpacing.gapLarge,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        'Acesse sua conta para gerenciar seu desempenho.',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: const Color(0xFFD9E2EC),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    AppSpacing.gapLarge,
                    AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'LOGIN',
                                textAlign: TextAlign.center,
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                          AppSpacing.gapLarge,
                          AppTextField(
                            label: 'E-mail',
                            hintText: 'usuario@exemplo.com',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.mail_outline,
                        validator: _validateEmail,
                        maxLength: _emailMaxLength,
                      ),
                          AppSpacing.gapSmall,
                          AppTextField(
                            label: 'Senha',
                            hintText: 'Digite sua senha',
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            prefixIcon: Icons.lock_outline,
                            validator: _validatePassword,
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
                              onPressed: _openRegister,
                              child: const Text('Criar conta'),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: _openForgotPassword,
                              child: const Text('Esqueci minha senha'),
                            ),
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
