import 'package:drift/drift.dart';

import '../../local/database/app_database.dart';
import '../../../models/user.dart' as domain;

class StoredAuthAccount {
  const StoredAuthAccount({
    required this.id,
    required this.name,
    required this.email,
    required this.passwordHash,
    required this.passwordSalt,
    required this.teamId,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String email;
  final String passwordHash;
  final String passwordSalt;
  final String teamId;
  final DateTime createdAt;

  domain.User toUser() {
    return domain.User(
      id: id,
      name: name,
      email: email,
      teamId: teamId,
    );
  }
}

class AuthRepository {
  AuthRepository(this._database);

  final AppDatabase _database;

  Future<List<StoredAuthAccount>> listUsers() async {
    final rows = await (_database.select(_database.users)
          ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]))
        .get();
    return rows.map(_mapUser).toList();
  }

  Future<StoredAuthAccount?> findUserByEmail(String email) async {
    final row = await (_database.select(_database.users)
          ..where((tbl) => tbl.email.equals(email.toLowerCase())))
        .getSingleOrNull();
    return row == null ? null : _mapUser(row);
  }

  Future<StoredAuthAccount?> findUserById(String id) async {
    final row = await (_database.select(_database.users)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _mapUser(row);
  }

  Future<void> upsertUser(StoredAuthAccount account) async {
    await _database.into(_database.users).insertOnConflictUpdate(
          UsersCompanion.insert(
            id: account.id,
            name: account.name,
            email: account.email.toLowerCase(),
            passwordHash: account.passwordHash,
            passwordSalt: account.passwordSalt,
            teamId: Value(account.teamId),
            createdAt: account.createdAt.toIso8601String(),
          ),
        );
  }

  Future<void> replaceSession(String userId) async {
    await _database.transaction(() async {
      await _database.delete(_database.userSessions).go();
      await _database.into(_database.userSessions).insert(
            UserSessionsCompanion.insert(
              id: 'active-session',
              userId: userId,
              startedAt: DateTime.now().toIso8601String(),
              isActive: true,
            ),
          );
    });
  }

  Future<String?> getActiveSessionUserId() async {
    final session = await (_database.select(_database.userSessions)
          ..where((tbl) => tbl.isActive.equals(true)))
        .getSingleOrNull();
    return session?.userId;
  }

  Future<void> clearSession() async {
    await _database.delete(_database.userSessions).go();
  }

  Future<void> clearAll() async {
    await _database.transaction(() async {
      await _database.delete(_database.userSessions).go();
      await _database.delete(_database.users).go();
    });
  }

  StoredAuthAccount _mapUser(User row) {
    return StoredAuthAccount(
      id: row.id,
      name: row.name,
      email: row.email,
      passwordHash: row.passwordHash,
      passwordSalt: row.passwordSalt,
      teamId: row.teamId ?? 'team-1',
      createdAt: DateTime.parse(row.createdAt),
    );
  }
}
