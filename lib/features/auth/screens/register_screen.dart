import 'package:flutter/material.dart';

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
  static const _nameMaxLength = 80;
  static const _emailMaxLength = 120;
  static const _passwordMaxLength = 64;

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

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return 'Informe seu e-mail.';
    }
    if (!email.contains('@') || !email.contains('.')) {
      return 'Digite um e-mail valido.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final password = value?.trim() ?? '';
    if (password.isEmpty) {
      return 'Crie uma senha.';
    }
    if (password.length < 8) {
      return 'A senha deve ter ao menos 8 caracteres.';
    }
    if (!_hasUppercase(password)) {
      return 'Use ao menos uma letra maiuscula.';
    }
    if (!_hasNumber(password)) {
      return 'Use ao menos um numero.';
    }
    if (!_hasSpecial(password)) {
      return 'Use ao menos um caractere especial.';
    }
    return null;
  }

  Future<void> _handleRegister() async {
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message.toString())),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  bool _hasUppercase(String value) => value.contains(RegExp(r'[A-Z]'));
  bool _hasNumber(String value) => value.contains(RegExp(r'[0-9]'));
  bool _hasSpecial(String value) => value.contains(RegExp(r'[^A-Za-z0-9]'));

  int _passwordScore(String password) {
    var score = 0;
    if (password.length >= 8) {
      score++;
    }
    if (_hasUppercase(password)) {
      score++;
    }
    if (_hasNumber(password)) {
      score++;
    }
    if (_hasSpecial(password)) {
      score++;
    }
    return score;
  }

  Color _passwordColor(int score) {
    if (score <= 1) {
      return const Color(0xFFDC2626);
    }
    if (score <= 3) {
      return const Color(0xFFF59E0B);
    }
    return const Color(0xFF16A34A);
  }

  String _passwordLabel(int score) {
    if (score <= 1) {
      return 'Senha fraca';
    }
    if (score <= 3) {
      return 'Senha media';
    }
    return 'Senha forte';
  }

  @override
  Widget build(BuildContext context) {
    final password = _passwordController.text;
    final score = _passwordScore(password);
    final strengthColor = _passwordColor(score);

    return Scaffold(
      appBar: AppBar(title: const Text('Criar conta')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screen,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _formKey,
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionTitle(
                        title: 'Cadastro de usuario',
                        subtitle: 'Crie sua conta. Depois do cadastro, voce retorna ao login para entrar no app.',
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
                        validator: _validateEmail,
                        maxLength: _emailMaxLength,
                      ),
                      AppSpacing.gapSmall,
                      AppTextField(
                        label: 'Senha',
                        hintText: 'Crie uma senha segura',
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
                      const SizedBox(height: 4),
                      Text(
                        'Use 8+ caracteres, 1 numero, 1 maiuscula e 1 caractere especial.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          minHeight: 8,
                          value: score / 4,
                          color: strengthColor,
                          backgroundColor: const Color(0xFFE5E7EB),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _passwordLabel(score),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: strengthColor,
                          fontWeight: FontWeight.w700,
                        ),
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
      ),
    );
  }
}
