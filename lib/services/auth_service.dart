import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

import '../models/user.dart';
import 'storage_service.dart';

class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  static const _usersKey = 'auth_users';
  static const _sessionKey = 'auth_session_user_id';
  static const _nameMaxLength = 80;
  static const _emailMaxLength = 120;
  static const _passwordMaxLength = 64;

  final ValueNotifier<User?> authState = ValueNotifier<User?>(null);
  final StorageService _storage = StorageService.instance;
  final Random _random = Random.secure();

  bool _initialized = false;

  User? get currentUser => authState.value;
  bool get isAuthenticated => currentUser != null;

  Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    await _storage.initialize();
    final accounts = await _loadAccounts();
    final sessionUserId = await _storage.read(_sessionKey);
    if (sessionUserId != null) {
      try {
        final sessionAccount = accounts.firstWhere(
          (account) => account.id == sessionUserId,
        );
        authState.value = sessionAccount.toUser();
      } catch (_) {
        authState.value = null;
      }
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
    _validateFieldLengths(
      email: trimmedEmail,
      password: trimmedPassword,
    );
    if (trimmedEmail.isEmpty || trimmedPassword.isEmpty) {
      throw ArgumentError('E-mail e senha sao obrigatorios.');
    }

    await Future<void>.delayed(const Duration(milliseconds: 350));

    final accounts = await _loadAccounts();
    final matchingAccount = accounts.cast<_StoredAuthUser?>().firstWhere(
          (account) =>
              account != null &&
              account.email.toLowerCase() == trimmedEmail &&
              account.passwordHash == _hashPassword(trimmedPassword, account.passwordSalt),
          orElse: () => null,
        );

    if (matchingAccount == null) {
      throw ArgumentError('Usuario nao encontrado ou senha incorreta.');
    }

    authState.value = matchingAccount.toUser();
    await _storage.save(key: _sessionKey, value: matchingAccount.id);
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
      throw ArgumentError('Nome, e-mail e senha sao obrigatorios.');
    }
    if (!_isStrongPassword(trimmedPassword)) {
      throw ArgumentError(
        'A senha deve ter ao menos 8 caracteres, com numero, letra maiuscula e caractere especial.',
      );
    }

    await Future<void>.delayed(const Duration(milliseconds: 350));

    final accounts = await _loadAccounts();
    final emailAlreadyExists = accounts.any(
      (account) => account.email.toLowerCase() == trimmedEmail,
    );
    if (emailAlreadyExists) {
      throw ArgumentError('Ja existe um usuario cadastrado com esse e-mail.');
    }

    final salt = _generateSalt();
    final account = _StoredAuthUser(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: trimmedName,
      email: trimmedEmail,
      passwordHash: _hashPassword(trimmedPassword, salt),
      passwordSalt: salt,
      teamId: 'team-1',
    );

    final updatedAccounts = [...accounts, account];
    await _saveAccounts(updatedAccounts);
    return account.toUser();
  }

  Future<void> signOut() async {
    await initialize();
    authState.value = null;
    await _storage.remove(_sessionKey);
  }

  bool _isStrongPassword(String password) {
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSpecial = password.contains(RegExp(r'[^A-Za-z0-9]'));
    return password.length >= 8 && hasUppercase && hasNumber && hasSpecial;
  }

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

  Future<List<_StoredAuthUser>> _loadAccounts() async {
    final raw = await _storage.read(_usersKey);
    if (raw == null || raw.isEmpty) {
      return [];
    }

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => _StoredAuthUser.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> _saveAccounts(List<_StoredAuthUser> accounts) async {
    final encoded = jsonEncode(accounts.map((account) => account.toJson()).toList());
    await _storage.save(key: _usersKey, value: encoded);
  }

  @visibleForTesting
  Future<void> reset() async {
    _initialized = false;
    authState.value = null;
    await _storage.removeMany(const [_usersKey, _sessionKey]);
  }
}

class _StoredAuthUser {
  const _StoredAuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.passwordHash,
    required this.passwordSalt,
    required this.teamId,
  });

  final String id;
  final String name;
  final String email;
  final String passwordHash;
  final String passwordSalt;
  final String teamId;

  User toUser() {
    return User(
      id: id,
      name: name,
      email: email,
      teamId: teamId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'passwordHash': passwordHash,
      'passwordSalt': passwordSalt,
      'teamId': teamId,
    };
  }

  factory _StoredAuthUser.fromJson(Map<String, dynamic> json) {
    return _StoredAuthUser(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      passwordHash: json['passwordHash'] as String,
      passwordSalt: json['passwordSalt'] as String,
      teamId: json['teamId'] as String,
    );
  }
}
