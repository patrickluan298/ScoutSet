import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

import '../data/local/database/app_services.dart';
import '../data/local/repositories/auth_repository.dart';
import '../models/user.dart';
import 'sport_mode_service.dart';

class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  static const _nameMaxLength = 20;
  static const _emailMaxLength = 40;
  static const _passwordMaxLength = 12;
  static final RegExp _emailPattern = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
  );

  final ValueNotifier<User?> authState = ValueNotifier<User?>(null);
  final Random _random = Random.secure();

  bool _initialized = false;

  User? get currentUser => authState.value;
  bool get isAuthenticated => currentUser != null;
  AuthRepository get _repository => AppServices.authRepository;

  Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    await AppServices.initialize();

    final sessionUserId = await _repository.getActiveSessionUserId();
    if (sessionUserId != null) {
      final sessionAccount = await _repository.findUserById(sessionUserId);
      authState.value = sessionAccount?.toUser();
    } else {
      authState.value = null;
    }

    _initialized = true;
  }

  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    await initialize();

    final trimmedEmail = email.trim().toLowerCase();
    final trimmedPassword = password.trim();
    if (trimmedEmail.isEmpty || trimmedPassword.isEmpty) {
      throw ArgumentError('E-mail e senha são obrigatórios.');
    }
    if (!isValidEmail(trimmedEmail)) {
      throw ArgumentError('Digite um e-mail válido.');
    }
    if (trimmedEmail.length > _emailMaxLength) {
      final legacyAccount = await _repository.findUserByEmail(trimmedEmail);
      if (legacyAccount == null) {
        throw ArgumentError('O e-mail ultrapassa o limite permitido.');
      }
    }

    await Future<void>.delayed(const Duration(milliseconds: 350));

    final matchingAccount = await _repository.findUserByEmail(trimmedEmail);
    if (matchingAccount == null ||
        matchingAccount.passwordHash !=
            _hashPassword(trimmedPassword, matchingAccount.passwordSalt)) {
      throw ArgumentError('Usuário não encontrado ou senha incorreta.');
    }

    authState.value = matchingAccount.toUser();
    await _repository.replaceSession(matchingAccount.id);
    return matchingAccount.toUser();
  }

  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await initialize();

    final trimmedName = name.trim();
    final trimmedEmail = email.trim().toLowerCase();
    final trimmedPassword = password.trim();
    _validateFieldLengths(
      name: trimmedName,
      email: trimmedEmail,
      password: trimmedPassword,
    );
    if (trimmedName.isEmpty || trimmedEmail.isEmpty || trimmedPassword.isEmpty) {
      throw ArgumentError('Nome, e-mail e senha são obrigatórios.');
    }
    if (!isValidEmail(trimmedEmail)) {
      throw ArgumentError('Digite um e-mail válido.');
    }
    if (!_isStrongPassword(trimmedPassword)) {
      throw ArgumentError(
        'A senha deve ter ao menos 8 caracteres, com número, letra maiúscula e caractere especial.',
      );
    }

    await Future<void>.delayed(const Duration(milliseconds: 350));

    final existingAccount = await _repository.findUserByEmail(trimmedEmail);
    if (existingAccount != null) {
      throw ArgumentError('Já existe um usuário cadastrado com esse e-mail.');
    }

    final salt = _generateSalt();
    final account = StoredAuthAccount(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: trimmedName,
      email: trimmedEmail,
      passwordHash: _hashPassword(trimmedPassword, salt),
      passwordSalt: salt,
      teamId: 'team-1',
      createdAt: DateTime.now(),
    );

    await _repository.upsertUser(account);
    return account.toUser();
  }

  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    await initialize();

    final trimmedEmail = email.trim().toLowerCase();
    final trimmedPassword = newPassword.trim();
    if (trimmedEmail.isEmpty || trimmedPassword.isEmpty) {
      throw ArgumentError('E-mail e nova senha são obrigatórios.');
    }
    if (!isValidEmail(trimmedEmail)) {
      throw ArgumentError('Digite um e-mail válido.');
    }
    if (trimmedEmail.length > _emailMaxLength) {
      throw ArgumentError('O e-mail ultrapassa o limite permitido.');
    }
    if (trimmedPassword.length > _passwordMaxLength) {
      throw ArgumentError('A senha ultrapassa o limite permitido.');
    }
    if (!_isStrongPassword(trimmedPassword)) {
      throw ArgumentError(
        'A senha deve ter ao menos 8 caracteres, com número, letra maiúscula e caractere especial.',
      );
    }

    final existingAccount = await _repository.findUserByEmail(trimmedEmail);
    if (existingAccount == null) {
      throw ArgumentError('Nenhum usuário encontrado com esse e-mail.');
    }

    final salt = _generateSalt();
    await _repository.upsertUser(
      StoredAuthAccount(
        id: existingAccount.id,
        name: existingAccount.name,
        email: existingAccount.email,
        passwordHash: _hashPassword(trimmedPassword, salt),
        passwordSalt: salt,
        teamId: existingAccount.teamId,
        createdAt: existingAccount.createdAt,
      ),
    );
  }

  Future<void> signOut() async {
    await initialize();
    authState.value = null;
    SportModeService.instance.clearSelection();
    await _repository.clearSession();
  }

  bool _isStrongPassword(String password) {
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSpecial = password.contains(RegExp(r'[^A-Za-z0-9]'));
    return password.length >= 8 && hasUppercase && hasNumber && hasSpecial;
  }

  bool isValidEmail(String email) => _emailPattern.hasMatch(email.trim());

  void _validateFieldLengths({
    String? name,
    required String email,
    required String password,
  }) {
    if (name != null && name.length > _nameMaxLength) {
      throw ArgumentError('O nome ultrapassa o limite permitido.');
    }
    if (email.length > _emailMaxLength) {
      throw ArgumentError('O e-mail ultrapassa o limite permitido.');
    }
    if (password.length > _passwordMaxLength) {
      throw ArgumentError('A senha ultrapassa o limite permitido.');
    }
  }

  String _generateSalt() {
    final bytes = List<int>.generate(16, (_) => _random.nextInt(256));
    return base64Encode(bytes);
  }

  String _hashPassword(String password, String salt) {
    final input = utf8.encode('$salt:$password');
    return sha256.convert(input).toString();
  }

  @visibleForTesting
  Future<void> reset() async {
    _initialized = false;
    authState.value = null;
    SportModeService.instance.resetState();
    await AppServices.initialize();
    await _repository.clearAll();
  }

  @visibleForTesting
  void clearCachedStateForTesting() {
    _initialized = false;
    authState.value = null;
    SportModeService.instance.resetState();
  }
}
