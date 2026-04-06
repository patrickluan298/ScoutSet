import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

class AuthValidators {
  AuthValidators._();

  static String? validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return 'Informe seu e-mail.';
    }
    if (!AuthService.instance.isValidEmail(email)) {
      return 'Digite um e-mail válido.';
    }
    return null;
  }
}

class PasswordStrength {
  const PasswordStrength({
    required this.score,
    required this.color,
    required this.label,
  });

  final int score;
  final Color color;
  final String label;
}

class PasswordValidators {
  PasswordValidators._();

  static bool hasUppercase(String value) => value.contains(RegExp(r'[A-Z]'));
  static bool hasNumber(String value) => value.contains(RegExp(r'[0-9]'));
  static bool hasSpecial(String value) => value.contains(RegExp(r'[^A-Za-z0-9]'));

  static String? validateNewPassword(String? value, {String emptyMessage = 'Crie uma senha.'}) {
    final password = value?.trim() ?? '';
    if (password.isEmpty) {
      return emptyMessage;
    }
    if (password.length < 8) {
      return 'A senha deve ter ao menos 8 caracteres.';
    }
    if (!hasUppercase(password)) {
      return 'Use ao menos uma letra maiuscula.';
    }
    if (!hasNumber(password)) {
      return 'Use ao menos um numero.';
    }
    if (!hasSpecial(password)) {
      return 'Use ao menos um caractere especial.';
    }
    return null;
  }

  static String? validateConfirmation(
    String? value, {
    required String expectedPassword,
    String emptyMessage = 'Confirme a senha.',
  }) {
    final confirmation = value?.trim() ?? '';
    if (confirmation.isEmpty) {
      return emptyMessage;
    }
    if (confirmation != expectedPassword.trim()) {
      return 'As senhas precisam ser iguais.';
    }
    return null;
  }

  static PasswordStrength evaluate(String password) {
    var score = 0;
    if (password.length >= 8) {
      score++;
    }
    if (hasUppercase(password)) {
      score++;
    }
    if (hasNumber(password)) {
      score++;
    }
    if (hasSpecial(password)) {
      score++;
    }

    if (score <= 1) {
      return PasswordStrength(
        score: score,
        color: Color(0xFFDC2626),
        label: 'Senha fraca',
      );
    }
    if (score <= 3) {
      return PasswordStrength(
        score: score,
        color: Color(0xFFF59E0B),
        label: 'Senha media',
      );
    }
    return const PasswordStrength(
      score: 4,
      color: Color(0xFF16A34A),
      label: 'Senha forte',
    );
  }
}
