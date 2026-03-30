// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordHashMeta =
      const VerificationMeta('passwordHash');
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
      'password_hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordSaltMeta =
      const VerificationMeta('passwordSalt');
  @override
  late final GeneratedColumn<String> passwordSalt = GeneratedColumn<String>(
      'password_salt', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
      'team_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, email, passwordHash, passwordSalt, teamId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
          _passwordHashMeta,
          passwordHash.isAcceptableOrUnknown(
              data['password_hash']!, _passwordHashMeta));
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('password_salt')) {
      context.handle(
          _passwordSaltMeta,
          passwordSalt.isAcceptableOrUnknown(
              data['password_salt']!, _passwordSaltMeta));
    } else if (isInserting) {
      context.missing(_passwordSaltMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(_teamIdMeta,
          teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {email},
      ];
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      passwordHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password_hash'])!,
      passwordSalt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password_salt'])!,
      teamId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}team_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String name;
  final String email;
  final String passwordHash;
  final String passwordSalt;
  final String? teamId;
  final String createdAt;
  const User(
      {required this.id,
      required this.name,
      required this.email,
      required this.passwordHash,
      required this.passwordSalt,
      this.teamId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['password_hash'] = Variable<String>(passwordHash);
    map['password_salt'] = Variable<String>(passwordSalt);
    if (!nullToAbsent || teamId != null) {
      map['team_id'] = Variable<String>(teamId);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      passwordHash: Value(passwordHash),
      passwordSalt: Value(passwordSalt),
      teamId:
          teamId == null && nullToAbsent ? const Value.absent() : Value(teamId),
      createdAt: Value(createdAt),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      passwordSalt: serializer.fromJson<String>(json['passwordSalt']),
      teamId: serializer.fromJson<String?>(json['teamId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'passwordSalt': serializer.toJson<String>(passwordSalt),
      'teamId': serializer.toJson<String?>(teamId),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  User copyWith(
          {String? id,
          String? name,
          String? email,
          String? passwordHash,
          String? passwordSalt,
          Value<String?> teamId = const Value.absent(),
          String? createdAt}) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        passwordHash: passwordHash ?? this.passwordHash,
        passwordSalt: passwordSalt ?? this.passwordSalt,
        teamId: teamId.present ? teamId.value : this.teamId,
        createdAt: createdAt ?? this.createdAt,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      passwordSalt: data.passwordSalt.present
          ? data.passwordSalt.value
          : this.passwordSalt,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('passwordSalt: $passwordSalt, ')
          ..write('teamId: $teamId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, email, passwordHash, passwordSalt, teamId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.passwordHash == this.passwordHash &&
          other.passwordSalt == this.passwordSalt &&
          other.teamId == this.teamId &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> passwordHash;
  final Value<String> passwordSalt;
  final Value<String?> teamId;
  final Value<String> createdAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.passwordSalt = const Value.absent(),
    this.teamId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String name,
    required String email,
    required String passwordHash,
    required String passwordSalt,
    this.teamId = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        email = Value(email),
        passwordHash = Value(passwordHash),
        passwordSalt = Value(passwordSalt),
        createdAt = Value(createdAt);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? passwordHash,
    Expression<String>? passwordSalt,
    Expression<String>? teamId,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (passwordSalt != null) 'password_salt': passwordSalt,
      if (teamId != null) 'team_id': teamId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? email,
      Value<String>? passwordHash,
      Value<String>? passwordSalt,
      Value<String?>? teamId,
      Value<String>? createdAt,
      Value<int>? rowid}) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      passwordSalt: passwordSalt ?? this.passwordSalt,
      teamId: teamId ?? this.teamId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (passwordSalt.present) {
      map['password_salt'] = Variable<String>(passwordSalt.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('passwordSalt: $passwordSalt, ')
          ..write('teamId: $teamId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserSessionsTable extends UserSessions
    with TableInfo<$UserSessionsTable, UserSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<String> startedAt = GeneratedColumn<String>(
      'started_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [id, userId, startedAt, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<UserSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}started_at'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $UserSessionsTable createAlias(String alias) {
    return $UserSessionsTable(attachedDatabase, alias);
  }
}

class UserSession extends DataClass implements Insertable<UserSession> {
  final String id;
  final String userId;
  final String startedAt;
  final bool isActive;
  const UserSession(
      {required this.id,
      required this.userId,
      required this.startedAt,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['started_at'] = Variable<String>(startedAt);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  UserSessionsCompanion toCompanion(bool nullToAbsent) {
    return UserSessionsCompanion(
      id: Value(id),
      userId: Value(userId),
      startedAt: Value(startedAt),
      isActive: Value(isActive),
    );
  }

  factory UserSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSession(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      startedAt: serializer.fromJson<String>(json['startedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'startedAt': serializer.toJson<String>(startedAt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  UserSession copyWith(
          {String? id, String? userId, String? startedAt, bool? isActive}) =>
      UserSession(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        startedAt: startedAt ?? this.startedAt,
        isActive: isActive ?? this.isActive,
      );
  UserSession copyWithCompanion(UserSessionsCompanion data) {
    return UserSession(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSession(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('startedAt: $startedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, startedAt, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSession &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.startedAt == this.startedAt &&
          other.isActive == this.isActive);
}

class UserSessionsCompanion extends UpdateCompanion<UserSession> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> startedAt;
  final Value<bool> isActive;
  final Value<int> rowid;
  const UserSessionsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserSessionsCompanion.insert({
    required String id,
    required String userId,
    required String startedAt,
    required bool isActive,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        startedAt = Value(startedAt),
        isActive = Value(isActive);
  static Insertable<UserSession> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? startedAt,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (startedAt != null) 'started_at': startedAt,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserSessionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? startedAt,
      Value<bool>? isActive,
      Value<int>? rowid}) {
    return UserSessionsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      startedAt: startedAt ?? this.startedAt,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<String>(startedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSessionsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('startedAt: $startedAt, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TeamsTable extends Teams with TableInfo<$TeamsTable, Team> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teams';
  @override
  VerificationContext validateIntegrity(Insertable<Team> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Team map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Team(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $TeamsTable createAlias(String alias) {
    return $TeamsTable(attachedDatabase, alias);
  }
}

class Team extends DataClass implements Insertable<Team> {
  final String id;
  final String name;
  final String createdAt;
  const Team({required this.id, required this.name, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  TeamsCompanion toCompanion(bool nullToAbsent) {
    return TeamsCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory Team.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Team(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  Team copyWith({String? id, String? name, String? createdAt}) => Team(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );
  Team copyWithCompanion(TeamsCompanion data) {
    return Team(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Team(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Team &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class TeamsCompanion extends UpdateCompanion<Team> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> createdAt;
  final Value<int> rowid;
  const TeamsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TeamsCompanion.insert({
    required String id,
    required String name,
    required String createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt);
  static Insertable<Team> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TeamsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? createdAt,
      Value<int>? rowid}) {
    return TeamsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AthletesTable extends Athletes with TableInfo<$AthletesTable, Athlete> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AthletesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
      'team_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES teams (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
      'position', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
      'height', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, teamId, name, position, height, age];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'athletes';
  @override
  VerificationContext validateIntegrity(Insertable<Athlete> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(_teamIdMeta,
          teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta));
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Athlete map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Athlete(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      teamId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}team_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}position'])!,
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height'])!,
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age'])!,
    );
  }

  @override
  $AthletesTable createAlias(String alias) {
    return $AthletesTable(attachedDatabase, alias);
  }
}

class Athlete extends DataClass implements Insertable<Athlete> {
  final String id;
  final String teamId;
  final String name;
  final String position;
  final double height;
  final int age;
  const Athlete(
      {required this.id,
      required this.teamId,
      required this.name,
      required this.position,
      required this.height,
      required this.age});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['team_id'] = Variable<String>(teamId);
    map['name'] = Variable<String>(name);
    map['position'] = Variable<String>(position);
    map['height'] = Variable<double>(height);
    map['age'] = Variable<int>(age);
    return map;
  }

  AthletesCompanion toCompanion(bool nullToAbsent) {
    return AthletesCompanion(
      id: Value(id),
      teamId: Value(teamId),
      name: Value(name),
      position: Value(position),
      height: Value(height),
      age: Value(age),
    );
  }

  factory Athlete.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Athlete(
      id: serializer.fromJson<String>(json['id']),
      teamId: serializer.fromJson<String>(json['teamId']),
      name: serializer.fromJson<String>(json['name']),
      position: serializer.fromJson<String>(json['position']),
      height: serializer.fromJson<double>(json['height']),
      age: serializer.fromJson<int>(json['age']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'teamId': serializer.toJson<String>(teamId),
      'name': serializer.toJson<String>(name),
      'position': serializer.toJson<String>(position),
      'height': serializer.toJson<double>(height),
      'age': serializer.toJson<int>(age),
    };
  }

  Athlete copyWith(
          {String? id,
          String? teamId,
          String? name,
          String? position,
          double? height,
          int? age}) =>
      Athlete(
        id: id ?? this.id,
        teamId: teamId ?? this.teamId,
        name: name ?? this.name,
        position: position ?? this.position,
        height: height ?? this.height,
        age: age ?? this.age,
      );
  Athlete copyWithCompanion(AthletesCompanion data) {
    return Athlete(
      id: data.id.present ? data.id.value : this.id,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      name: data.name.present ? data.name.value : this.name,
      position: data.position.present ? data.position.value : this.position,
      height: data.height.present ? data.height.value : this.height,
      age: data.age.present ? data.age.value : this.age,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Athlete(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('name: $name, ')
          ..write('position: $position, ')
          ..write('height: $height, ')
          ..write('age: $age')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, teamId, name, position, height, age);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Athlete &&
          other.id == this.id &&
          other.teamId == this.teamId &&
          other.name == this.name &&
          other.position == this.position &&
          other.height == this.height &&
          other.age == this.age);
}

class AthletesCompanion extends UpdateCompanion<Athlete> {
  final Value<String> id;
  final Value<String> teamId;
  final Value<String> name;
  final Value<String> position;
  final Value<double> height;
  final Value<int> age;
  final Value<int> rowid;
  const AthletesCompanion({
    this.id = const Value.absent(),
    this.teamId = const Value.absent(),
    this.name = const Value.absent(),
    this.position = const Value.absent(),
    this.height = const Value.absent(),
    this.age = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AthletesCompanion.insert({
    required String id,
    required String teamId,
    required String name,
    required String position,
    required double height,
    required int age,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        teamId = Value(teamId),
        name = Value(name),
        position = Value(position),
        height = Value(height),
        age = Value(age);
  static Insertable<Athlete> custom({
    Expression<String>? id,
    Expression<String>? teamId,
    Expression<String>? name,
    Expression<String>? position,
    Expression<double>? height,
    Expression<int>? age,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (teamId != null) 'team_id': teamId,
      if (name != null) 'name': name,
      if (position != null) 'position': position,
      if (height != null) 'height': height,
      if (age != null) 'age': age,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AthletesCompanion copyWith(
      {Value<String>? id,
      Value<String>? teamId,
      Value<String>? name,
      Value<String>? position,
      Value<double>? height,
      Value<int>? age,
      Value<int>? rowid}) {
    return AthletesCompanion(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      name: name ?? this.name,
      position: position ?? this.position,
      height: height ?? this.height,
      age: age ?? this.age,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AthletesCompanion(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('name: $name, ')
          ..write('position: $position, ')
          ..write('height: $height, ')
          ..write('age: $age, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StrategiesTable extends Strategies
    with TableInfo<$StrategiesTable, Strategy> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StrategiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _gameModeMeta =
      const VerificationMeta('gameMode');
  @override
  late final GeneratedColumn<String> gameMode = GeneratedColumn<String>(
      'game_mode', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, gameMode, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'strategies';
  @override
  VerificationContext validateIntegrity(Insertable<Strategy> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('game_mode')) {
      context.handle(_gameModeMeta,
          gameMode.isAcceptableOrUnknown(data['game_mode']!, _gameModeMeta));
    } else if (isInserting) {
      context.missing(_gameModeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Strategy map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Strategy(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      gameMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}game_mode'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $StrategiesTable createAlias(String alias) {
    return $StrategiesTable(attachedDatabase, alias);
  }
}

class Strategy extends DataClass implements Insertable<Strategy> {
  final String id;
  final String name;
  final String description;
  final String gameMode;
  final String createdAt;
  const Strategy(
      {required this.id,
      required this.name,
      required this.description,
      required this.gameMode,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['game_mode'] = Variable<String>(gameMode);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  StrategiesCompanion toCompanion(bool nullToAbsent) {
    return StrategiesCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      gameMode: Value(gameMode),
      createdAt: Value(createdAt),
    );
  }

  factory Strategy.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Strategy(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      gameMode: serializer.fromJson<String>(json['gameMode']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'gameMode': serializer.toJson<String>(gameMode),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  Strategy copyWith(
          {String? id,
          String? name,
          String? description,
          String? gameMode,
          String? createdAt}) =>
      Strategy(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        gameMode: gameMode ?? this.gameMode,
        createdAt: createdAt ?? this.createdAt,
      );
  Strategy copyWithCompanion(StrategiesCompanion data) {
    return Strategy(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      gameMode: data.gameMode.present ? data.gameMode.value : this.gameMode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Strategy(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('gameMode: $gameMode, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, gameMode, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Strategy &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.gameMode == this.gameMode &&
          other.createdAt == this.createdAt);
}

class StrategiesCompanion extends UpdateCompanion<Strategy> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> gameMode;
  final Value<String> createdAt;
  final Value<int> rowid;
  const StrategiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.gameMode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StrategiesCompanion.insert({
    required String id,
    required String name,
    required String description,
    required String gameMode,
    required String createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        description = Value(description),
        gameMode = Value(gameMode),
        createdAt = Value(createdAt);
  static Insertable<Strategy> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? gameMode,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (gameMode != null) 'game_mode': gameMode,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StrategiesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? description,
      Value<String>? gameMode,
      Value<String>? createdAt,
      Value<int>? rowid}) {
    return StrategiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      gameMode: gameMode ?? this.gameMode,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (gameMode.present) {
      map['game_mode'] = Variable<String>(gameMode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StrategiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('gameMode: $gameMode, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StrategyPlayersTable extends StrategyPlayers
    with TableInfo<$StrategyPlayersTable, StrategyPlayer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StrategyPlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _strategyIdMeta =
      const VerificationMeta('strategyId');
  @override
  late final GeneratedColumn<String> strategyId = GeneratedColumn<String>(
      'strategy_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES strategies (id)'));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _playerIdMeta =
      const VerificationMeta('playerId');
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
      'player_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _xMeta = const VerificationMeta('x');
  @override
  late final GeneratedColumn<double> x = GeneratedColumn<double>(
      'x', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _yMeta = const VerificationMeta('y');
  @override
  late final GeneratedColumn<double> y = GeneratedColumn<double>(
      'y', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _defaultXMeta =
      const VerificationMeta('defaultX');
  @override
  late final GeneratedColumn<double> defaultX = GeneratedColumn<double>(
      'default_x', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _defaultYMeta =
      const VerificationMeta('defaultY');
  @override
  late final GeneratedColumn<double> defaultY = GeneratedColumn<double>(
      'default_y', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isStarterMeta =
      const VerificationMeta('isStarter');
  @override
  late final GeneratedColumn<bool> isStarter = GeneratedColumn<bool>(
      'is_starter', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_starter" IN (0, 1))'));
  static const VerificationMeta _isLiberoMeta =
      const VerificationMeta('isLibero');
  @override
  late final GeneratedColumn<bool> isLibero = GeneratedColumn<bool>(
      'is_libero', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_libero" IN (0, 1))'));
  static const VerificationMeta _isBenchMeta =
      const VerificationMeta('isBench');
  @override
  late final GeneratedColumn<bool> isBench = GeneratedColumn<bool>(
      'is_bench', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_bench" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        strategyId,
        sortOrder,
        playerId,
        label,
        x,
        y,
        defaultX,
        defaultY,
        isStarter,
        isLibero,
        isBench
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'strategy_players';
  @override
  VerificationContext validateIntegrity(Insertable<StrategyPlayer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('strategy_id')) {
      context.handle(
          _strategyIdMeta,
          strategyId.isAcceptableOrUnknown(
              data['strategy_id']!, _strategyIdMeta));
    } else if (isInserting) {
      context.missing(_strategyIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('player_id')) {
      context.handle(_playerIdMeta,
          playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta));
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('x')) {
      context.handle(_xMeta, x.isAcceptableOrUnknown(data['x']!, _xMeta));
    } else if (isInserting) {
      context.missing(_xMeta);
    }
    if (data.containsKey('y')) {
      context.handle(_yMeta, y.isAcceptableOrUnknown(data['y']!, _yMeta));
    } else if (isInserting) {
      context.missing(_yMeta);
    }
    if (data.containsKey('default_x')) {
      context.handle(_defaultXMeta,
          defaultX.isAcceptableOrUnknown(data['default_x']!, _defaultXMeta));
    }
    if (data.containsKey('default_y')) {
      context.handle(_defaultYMeta,
          defaultY.isAcceptableOrUnknown(data['default_y']!, _defaultYMeta));
    }
    if (data.containsKey('is_starter')) {
      context.handle(_isStarterMeta,
          isStarter.isAcceptableOrUnknown(data['is_starter']!, _isStarterMeta));
    } else if (isInserting) {
      context.missing(_isStarterMeta);
    }
    if (data.containsKey('is_libero')) {
      context.handle(_isLiberoMeta,
          isLibero.isAcceptableOrUnknown(data['is_libero']!, _isLiberoMeta));
    } else if (isInserting) {
      context.missing(_isLiberoMeta);
    }
    if (data.containsKey('is_bench')) {
      context.handle(_isBenchMeta,
          isBench.isAcceptableOrUnknown(data['is_bench']!, _isBenchMeta));
    } else if (isInserting) {
      context.missing(_isBenchMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StrategyPlayer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StrategyPlayer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      strategyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}strategy_id'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      playerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      x: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}x'])!,
      y: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}y'])!,
      defaultX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}default_x']),
      defaultY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}default_y']),
      isStarter: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_starter'])!,
      isLibero: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_libero'])!,
      isBench: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_bench'])!,
    );
  }

  @override
  $StrategyPlayersTable createAlias(String alias) {
    return $StrategyPlayersTable(attachedDatabase, alias);
  }
}

class StrategyPlayer extends DataClass implements Insertable<StrategyPlayer> {
  final String id;
  final String strategyId;
  final int sortOrder;
  final String playerId;
  final String label;
  final double x;
  final double y;
  final double? defaultX;
  final double? defaultY;
  final bool isStarter;
  final bool isLibero;
  final bool isBench;
  const StrategyPlayer(
      {required this.id,
      required this.strategyId,
      required this.sortOrder,
      required this.playerId,
      required this.label,
      required this.x,
      required this.y,
      this.defaultX,
      this.defaultY,
      required this.isStarter,
      required this.isLibero,
      required this.isBench});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['strategy_id'] = Variable<String>(strategyId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['player_id'] = Variable<String>(playerId);
    map['label'] = Variable<String>(label);
    map['x'] = Variable<double>(x);
    map['y'] = Variable<double>(y);
    if (!nullToAbsent || defaultX != null) {
      map['default_x'] = Variable<double>(defaultX);
    }
    if (!nullToAbsent || defaultY != null) {
      map['default_y'] = Variable<double>(defaultY);
    }
    map['is_starter'] = Variable<bool>(isStarter);
    map['is_libero'] = Variable<bool>(isLibero);
    map['is_bench'] = Variable<bool>(isBench);
    return map;
  }

  StrategyPlayersCompanion toCompanion(bool nullToAbsent) {
    return StrategyPlayersCompanion(
      id: Value(id),
      strategyId: Value(strategyId),
      sortOrder: Value(sortOrder),
      playerId: Value(playerId),
      label: Value(label),
      x: Value(x),
      y: Value(y),
      defaultX: defaultX == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultX),
      defaultY: defaultY == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultY),
      isStarter: Value(isStarter),
      isLibero: Value(isLibero),
      isBench: Value(isBench),
    );
  }

  factory StrategyPlayer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StrategyPlayer(
      id: serializer.fromJson<String>(json['id']),
      strategyId: serializer.fromJson<String>(json['strategyId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      playerId: serializer.fromJson<String>(json['playerId']),
      label: serializer.fromJson<String>(json['label']),
      x: serializer.fromJson<double>(json['x']),
      y: serializer.fromJson<double>(json['y']),
      defaultX: serializer.fromJson<double?>(json['defaultX']),
      defaultY: serializer.fromJson<double?>(json['defaultY']),
      isStarter: serializer.fromJson<bool>(json['isStarter']),
      isLibero: serializer.fromJson<bool>(json['isLibero']),
      isBench: serializer.fromJson<bool>(json['isBench']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'strategyId': serializer.toJson<String>(strategyId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'playerId': serializer.toJson<String>(playerId),
      'label': serializer.toJson<String>(label),
      'x': serializer.toJson<double>(x),
      'y': serializer.toJson<double>(y),
      'defaultX': serializer.toJson<double?>(defaultX),
      'defaultY': serializer.toJson<double?>(defaultY),
      'isStarter': serializer.toJson<bool>(isStarter),
      'isLibero': serializer.toJson<bool>(isLibero),
      'isBench': serializer.toJson<bool>(isBench),
    };
  }

  StrategyPlayer copyWith(
          {String? id,
          String? strategyId,
          int? sortOrder,
          String? playerId,
          String? label,
          double? x,
          double? y,
          Value<double?> defaultX = const Value.absent(),
          Value<double?> defaultY = const Value.absent(),
          bool? isStarter,
          bool? isLibero,
          bool? isBench}) =>
      StrategyPlayer(
        id: id ?? this.id,
        strategyId: strategyId ?? this.strategyId,
        sortOrder: sortOrder ?? this.sortOrder,
        playerId: playerId ?? this.playerId,
        label: label ?? this.label,
        x: x ?? this.x,
        y: y ?? this.y,
        defaultX: defaultX.present ? defaultX.value : this.defaultX,
        defaultY: defaultY.present ? defaultY.value : this.defaultY,
        isStarter: isStarter ?? this.isStarter,
        isLibero: isLibero ?? this.isLibero,
        isBench: isBench ?? this.isBench,
      );
  StrategyPlayer copyWithCompanion(StrategyPlayersCompanion data) {
    return StrategyPlayer(
      id: data.id.present ? data.id.value : this.id,
      strategyId:
          data.strategyId.present ? data.strategyId.value : this.strategyId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      label: data.label.present ? data.label.value : this.label,
      x: data.x.present ? data.x.value : this.x,
      y: data.y.present ? data.y.value : this.y,
      defaultX: data.defaultX.present ? data.defaultX.value : this.defaultX,
      defaultY: data.defaultY.present ? data.defaultY.value : this.defaultY,
      isStarter: data.isStarter.present ? data.isStarter.value : this.isStarter,
      isLibero: data.isLibero.present ? data.isLibero.value : this.isLibero,
      isBench: data.isBench.present ? data.isBench.value : this.isBench,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StrategyPlayer(')
          ..write('id: $id, ')
          ..write('strategyId: $strategyId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('playerId: $playerId, ')
          ..write('label: $label, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('defaultX: $defaultX, ')
          ..write('defaultY: $defaultY, ')
          ..write('isStarter: $isStarter, ')
          ..write('isLibero: $isLibero, ')
          ..write('isBench: $isBench')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, strategyId, sortOrder, playerId, label, x,
      y, defaultX, defaultY, isStarter, isLibero, isBench);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StrategyPlayer &&
          other.id == this.id &&
          other.strategyId == this.strategyId &&
          other.sortOrder == this.sortOrder &&
          other.playerId == this.playerId &&
          other.label == this.label &&
          other.x == this.x &&
          other.y == this.y &&
          other.defaultX == this.defaultX &&
          other.defaultY == this.defaultY &&
          other.isStarter == this.isStarter &&
          other.isLibero == this.isLibero &&
          other.isBench == this.isBench);
}

class StrategyPlayersCompanion extends UpdateCompanion<StrategyPlayer> {
  final Value<String> id;
  final Value<String> strategyId;
  final Value<int> sortOrder;
  final Value<String> playerId;
  final Value<String> label;
  final Value<double> x;
  final Value<double> y;
  final Value<double?> defaultX;
  final Value<double?> defaultY;
  final Value<bool> isStarter;
  final Value<bool> isLibero;
  final Value<bool> isBench;
  final Value<int> rowid;
  const StrategyPlayersCompanion({
    this.id = const Value.absent(),
    this.strategyId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.playerId = const Value.absent(),
    this.label = const Value.absent(),
    this.x = const Value.absent(),
    this.y = const Value.absent(),
    this.defaultX = const Value.absent(),
    this.defaultY = const Value.absent(),
    this.isStarter = const Value.absent(),
    this.isLibero = const Value.absent(),
    this.isBench = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StrategyPlayersCompanion.insert({
    required String id,
    required String strategyId,
    this.sortOrder = const Value.absent(),
    required String playerId,
    required String label,
    required double x,
    required double y,
    this.defaultX = const Value.absent(),
    this.defaultY = const Value.absent(),
    required bool isStarter,
    required bool isLibero,
    required bool isBench,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        strategyId = Value(strategyId),
        playerId = Value(playerId),
        label = Value(label),
        x = Value(x),
        y = Value(y),
        isStarter = Value(isStarter),
        isLibero = Value(isLibero),
        isBench = Value(isBench);
  static Insertable<StrategyPlayer> custom({
    Expression<String>? id,
    Expression<String>? strategyId,
    Expression<int>? sortOrder,
    Expression<String>? playerId,
    Expression<String>? label,
    Expression<double>? x,
    Expression<double>? y,
    Expression<double>? defaultX,
    Expression<double>? defaultY,
    Expression<bool>? isStarter,
    Expression<bool>? isLibero,
    Expression<bool>? isBench,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (strategyId != null) 'strategy_id': strategyId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (playerId != null) 'player_id': playerId,
      if (label != null) 'label': label,
      if (x != null) 'x': x,
      if (y != null) 'y': y,
      if (defaultX != null) 'default_x': defaultX,
      if (defaultY != null) 'default_y': defaultY,
      if (isStarter != null) 'is_starter': isStarter,
      if (isLibero != null) 'is_libero': isLibero,
      if (isBench != null) 'is_bench': isBench,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StrategyPlayersCompanion copyWith(
      {Value<String>? id,
      Value<String>? strategyId,
      Value<int>? sortOrder,
      Value<String>? playerId,
      Value<String>? label,
      Value<double>? x,
      Value<double>? y,
      Value<double?>? defaultX,
      Value<double?>? defaultY,
      Value<bool>? isStarter,
      Value<bool>? isLibero,
      Value<bool>? isBench,
      Value<int>? rowid}) {
    return StrategyPlayersCompanion(
      id: id ?? this.id,
      strategyId: strategyId ?? this.strategyId,
      sortOrder: sortOrder ?? this.sortOrder,
      playerId: playerId ?? this.playerId,
      label: label ?? this.label,
      x: x ?? this.x,
      y: y ?? this.y,
      defaultX: defaultX ?? this.defaultX,
      defaultY: defaultY ?? this.defaultY,
      isStarter: isStarter ?? this.isStarter,
      isLibero: isLibero ?? this.isLibero,
      isBench: isBench ?? this.isBench,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (strategyId.present) {
      map['strategy_id'] = Variable<String>(strategyId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (x.present) {
      map['x'] = Variable<double>(x.value);
    }
    if (y.present) {
      map['y'] = Variable<double>(y.value);
    }
    if (defaultX.present) {
      map['default_x'] = Variable<double>(defaultX.value);
    }
    if (defaultY.present) {
      map['default_y'] = Variable<double>(defaultY.value);
    }
    if (isStarter.present) {
      map['is_starter'] = Variable<bool>(isStarter.value);
    }
    if (isLibero.present) {
      map['is_libero'] = Variable<bool>(isLibero.value);
    }
    if (isBench.present) {
      map['is_bench'] = Variable<bool>(isBench.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StrategyPlayersCompanion(')
          ..write('id: $id, ')
          ..write('strategyId: $strategyId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('playerId: $playerId, ')
          ..write('label: $label, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('defaultX: $defaultX, ')
          ..write('defaultY: $defaultY, ')
          ..write('isStarter: $isStarter, ')
          ..write('isLibero: $isLibero, ')
          ..write('isBench: $isBench, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StrategyMovementsTable extends StrategyMovements
    with TableInfo<$StrategyMovementsTable, StrategyMovement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StrategyMovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _strategyIdMeta =
      const VerificationMeta('strategyId');
  @override
  late final GeneratedColumn<String> strategyId = GeneratedColumn<String>(
      'strategy_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES strategies (id)'));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _playerIdMeta =
      const VerificationMeta('playerId');
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
      'player_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fromXMeta = const VerificationMeta('fromX');
  @override
  late final GeneratedColumn<double> fromX = GeneratedColumn<double>(
      'from_x', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fromYMeta = const VerificationMeta('fromY');
  @override
  late final GeneratedColumn<double> fromY = GeneratedColumn<double>(
      'from_y', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _toXMeta = const VerificationMeta('toX');
  @override
  late final GeneratedColumn<double> toX = GeneratedColumn<double>(
      'to_x', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _toYMeta = const VerificationMeta('toY');
  @override
  late final GeneratedColumn<double> toY = GeneratedColumn<double>(
      'to_y', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _movementTypeMeta =
      const VerificationMeta('movementType');
  @override
  late final GeneratedColumn<String> movementType = GeneratedColumn<String>(
      'movement_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        strategyId,
        sortOrder,
        playerId,
        fromX,
        fromY,
        toX,
        toY,
        movementType
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'strategy_movements';
  @override
  VerificationContext validateIntegrity(Insertable<StrategyMovement> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('strategy_id')) {
      context.handle(
          _strategyIdMeta,
          strategyId.isAcceptableOrUnknown(
              data['strategy_id']!, _strategyIdMeta));
    } else if (isInserting) {
      context.missing(_strategyIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('player_id')) {
      context.handle(_playerIdMeta,
          playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta));
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('from_x')) {
      context.handle(
          _fromXMeta, fromX.isAcceptableOrUnknown(data['from_x']!, _fromXMeta));
    } else if (isInserting) {
      context.missing(_fromXMeta);
    }
    if (data.containsKey('from_y')) {
      context.handle(
          _fromYMeta, fromY.isAcceptableOrUnknown(data['from_y']!, _fromYMeta));
    } else if (isInserting) {
      context.missing(_fromYMeta);
    }
    if (data.containsKey('to_x')) {
      context.handle(
          _toXMeta, toX.isAcceptableOrUnknown(data['to_x']!, _toXMeta));
    } else if (isInserting) {
      context.missing(_toXMeta);
    }
    if (data.containsKey('to_y')) {
      context.handle(
          _toYMeta, toY.isAcceptableOrUnknown(data['to_y']!, _toYMeta));
    } else if (isInserting) {
      context.missing(_toYMeta);
    }
    if (data.containsKey('movement_type')) {
      context.handle(
          _movementTypeMeta,
          movementType.isAcceptableOrUnknown(
              data['movement_type']!, _movementTypeMeta));
    } else if (isInserting) {
      context.missing(_movementTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StrategyMovement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StrategyMovement(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      strategyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}strategy_id'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      playerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_id'])!,
      fromX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}from_x'])!,
      fromY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}from_y'])!,
      toX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}to_x'])!,
      toY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}to_y'])!,
      movementType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}movement_type'])!,
    );
  }

  @override
  $StrategyMovementsTable createAlias(String alias) {
    return $StrategyMovementsTable(attachedDatabase, alias);
  }
}

class StrategyMovement extends DataClass
    implements Insertable<StrategyMovement> {
  final String id;
  final String strategyId;
  final int sortOrder;
  final String playerId;
  final double fromX;
  final double fromY;
  final double toX;
  final double toY;
  final String movementType;
  const StrategyMovement(
      {required this.id,
      required this.strategyId,
      required this.sortOrder,
      required this.playerId,
      required this.fromX,
      required this.fromY,
      required this.toX,
      required this.toY,
      required this.movementType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['strategy_id'] = Variable<String>(strategyId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['player_id'] = Variable<String>(playerId);
    map['from_x'] = Variable<double>(fromX);
    map['from_y'] = Variable<double>(fromY);
    map['to_x'] = Variable<double>(toX);
    map['to_y'] = Variable<double>(toY);
    map['movement_type'] = Variable<String>(movementType);
    return map;
  }

  StrategyMovementsCompanion toCompanion(bool nullToAbsent) {
    return StrategyMovementsCompanion(
      id: Value(id),
      strategyId: Value(strategyId),
      sortOrder: Value(sortOrder),
      playerId: Value(playerId),
      fromX: Value(fromX),
      fromY: Value(fromY),
      toX: Value(toX),
      toY: Value(toY),
      movementType: Value(movementType),
    );
  }

  factory StrategyMovement.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StrategyMovement(
      id: serializer.fromJson<String>(json['id']),
      strategyId: serializer.fromJson<String>(json['strategyId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      playerId: serializer.fromJson<String>(json['playerId']),
      fromX: serializer.fromJson<double>(json['fromX']),
      fromY: serializer.fromJson<double>(json['fromY']),
      toX: serializer.fromJson<double>(json['toX']),
      toY: serializer.fromJson<double>(json['toY']),
      movementType: serializer.fromJson<String>(json['movementType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'strategyId': serializer.toJson<String>(strategyId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'playerId': serializer.toJson<String>(playerId),
      'fromX': serializer.toJson<double>(fromX),
      'fromY': serializer.toJson<double>(fromY),
      'toX': serializer.toJson<double>(toX),
      'toY': serializer.toJson<double>(toY),
      'movementType': serializer.toJson<String>(movementType),
    };
  }

  StrategyMovement copyWith(
          {String? id,
          String? strategyId,
          int? sortOrder,
          String? playerId,
          double? fromX,
          double? fromY,
          double? toX,
          double? toY,
          String? movementType}) =>
      StrategyMovement(
        id: id ?? this.id,
        strategyId: strategyId ?? this.strategyId,
        sortOrder: sortOrder ?? this.sortOrder,
        playerId: playerId ?? this.playerId,
        fromX: fromX ?? this.fromX,
        fromY: fromY ?? this.fromY,
        toX: toX ?? this.toX,
        toY: toY ?? this.toY,
        movementType: movementType ?? this.movementType,
      );
  StrategyMovement copyWithCompanion(StrategyMovementsCompanion data) {
    return StrategyMovement(
      id: data.id.present ? data.id.value : this.id,
      strategyId:
          data.strategyId.present ? data.strategyId.value : this.strategyId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      fromX: data.fromX.present ? data.fromX.value : this.fromX,
      fromY: data.fromY.present ? data.fromY.value : this.fromY,
      toX: data.toX.present ? data.toX.value : this.toX,
      toY: data.toY.present ? data.toY.value : this.toY,
      movementType: data.movementType.present
          ? data.movementType.value
          : this.movementType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StrategyMovement(')
          ..write('id: $id, ')
          ..write('strategyId: $strategyId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('playerId: $playerId, ')
          ..write('fromX: $fromX, ')
          ..write('fromY: $fromY, ')
          ..write('toX: $toX, ')
          ..write('toY: $toY, ')
          ..write('movementType: $movementType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, strategyId, sortOrder, playerId, fromX,
      fromY, toX, toY, movementType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StrategyMovement &&
          other.id == this.id &&
          other.strategyId == this.strategyId &&
          other.sortOrder == this.sortOrder &&
          other.playerId == this.playerId &&
          other.fromX == this.fromX &&
          other.fromY == this.fromY &&
          other.toX == this.toX &&
          other.toY == this.toY &&
          other.movementType == this.movementType);
}

class StrategyMovementsCompanion extends UpdateCompanion<StrategyMovement> {
  final Value<String> id;
  final Value<String> strategyId;
  final Value<int> sortOrder;
  final Value<String> playerId;
  final Value<double> fromX;
  final Value<double> fromY;
  final Value<double> toX;
  final Value<double> toY;
  final Value<String> movementType;
  final Value<int> rowid;
  const StrategyMovementsCompanion({
    this.id = const Value.absent(),
    this.strategyId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.playerId = const Value.absent(),
    this.fromX = const Value.absent(),
    this.fromY = const Value.absent(),
    this.toX = const Value.absent(),
    this.toY = const Value.absent(),
    this.movementType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StrategyMovementsCompanion.insert({
    required String id,
    required String strategyId,
    this.sortOrder = const Value.absent(),
    required String playerId,
    required double fromX,
    required double fromY,
    required double toX,
    required double toY,
    required String movementType,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        strategyId = Value(strategyId),
        playerId = Value(playerId),
        fromX = Value(fromX),
        fromY = Value(fromY),
        toX = Value(toX),
        toY = Value(toY),
        movementType = Value(movementType);
  static Insertable<StrategyMovement> custom({
    Expression<String>? id,
    Expression<String>? strategyId,
    Expression<int>? sortOrder,
    Expression<String>? playerId,
    Expression<double>? fromX,
    Expression<double>? fromY,
    Expression<double>? toX,
    Expression<double>? toY,
    Expression<String>? movementType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (strategyId != null) 'strategy_id': strategyId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (playerId != null) 'player_id': playerId,
      if (fromX != null) 'from_x': fromX,
      if (fromY != null) 'from_y': fromY,
      if (toX != null) 'to_x': toX,
      if (toY != null) 'to_y': toY,
      if (movementType != null) 'movement_type': movementType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StrategyMovementsCompanion copyWith(
      {Value<String>? id,
      Value<String>? strategyId,
      Value<int>? sortOrder,
      Value<String>? playerId,
      Value<double>? fromX,
      Value<double>? fromY,
      Value<double>? toX,
      Value<double>? toY,
      Value<String>? movementType,
      Value<int>? rowid}) {
    return StrategyMovementsCompanion(
      id: id ?? this.id,
      strategyId: strategyId ?? this.strategyId,
      sortOrder: sortOrder ?? this.sortOrder,
      playerId: playerId ?? this.playerId,
      fromX: fromX ?? this.fromX,
      fromY: fromY ?? this.fromY,
      toX: toX ?? this.toX,
      toY: toY ?? this.toY,
      movementType: movementType ?? this.movementType,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (strategyId.present) {
      map['strategy_id'] = Variable<String>(strategyId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (fromX.present) {
      map['from_x'] = Variable<double>(fromX.value);
    }
    if (fromY.present) {
      map['from_y'] = Variable<double>(fromY.value);
    }
    if (toX.present) {
      map['to_x'] = Variable<double>(toX.value);
    }
    if (toY.present) {
      map['to_y'] = Variable<double>(toY.value);
    }
    if (movementType.present) {
      map['movement_type'] = Variable<String>(movementType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StrategyMovementsCompanion(')
          ..write('id: $id, ')
          ..write('strategyId: $strategyId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('playerId: $playerId, ')
          ..write('fromX: $fromX, ')
          ..write('fromY: $fromY, ')
          ..write('toX: $toX, ')
          ..write('toY: $toY, ')
          ..write('movementType: $movementType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StrategySubstitutionsTable extends StrategySubstitutions
    with TableInfo<$StrategySubstitutionsTable, StrategySubstitution> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StrategySubstitutionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _strategyIdMeta =
      const VerificationMeta('strategyId');
  @override
  late final GeneratedColumn<String> strategyId = GeneratedColumn<String>(
      'strategy_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES strategies (id)'));
  static const VerificationMeta _playerOutIdMeta =
      const VerificationMeta('playerOutId');
  @override
  late final GeneratedColumn<String> playerOutId = GeneratedColumn<String>(
      'player_out_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _playerInIdMeta =
      const VerificationMeta('playerInId');
  @override
  late final GeneratedColumn<String> playerInId = GeneratedColumn<String>(
      'player_in_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countsTowardLimitMeta =
      const VerificationMeta('countsTowardLimit');
  @override
  late final GeneratedColumn<bool> countsTowardLimit = GeneratedColumn<bool>(
      'counts_toward_limit', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("counts_toward_limit" IN (0, 1))'));
  static const VerificationMeta _isLiberoExchangeMeta =
      const VerificationMeta('isLiberoExchange');
  @override
  late final GeneratedColumn<bool> isLiberoExchange = GeneratedColumn<bool>(
      'is_libero_exchange', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_libero_exchange" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        strategyId,
        playerOutId,
        playerInId,
        createdAt,
        countsTowardLimit,
        isLiberoExchange
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'strategy_substitutions';
  @override
  VerificationContext validateIntegrity(
      Insertable<StrategySubstitution> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('strategy_id')) {
      context.handle(
          _strategyIdMeta,
          strategyId.isAcceptableOrUnknown(
              data['strategy_id']!, _strategyIdMeta));
    } else if (isInserting) {
      context.missing(_strategyIdMeta);
    }
    if (data.containsKey('player_out_id')) {
      context.handle(
          _playerOutIdMeta,
          playerOutId.isAcceptableOrUnknown(
              data['player_out_id']!, _playerOutIdMeta));
    } else if (isInserting) {
      context.missing(_playerOutIdMeta);
    }
    if (data.containsKey('player_in_id')) {
      context.handle(
          _playerInIdMeta,
          playerInId.isAcceptableOrUnknown(
              data['player_in_id']!, _playerInIdMeta));
    } else if (isInserting) {
      context.missing(_playerInIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('counts_toward_limit')) {
      context.handle(
          _countsTowardLimitMeta,
          countsTowardLimit.isAcceptableOrUnknown(
              data['counts_toward_limit']!, _countsTowardLimitMeta));
    } else if (isInserting) {
      context.missing(_countsTowardLimitMeta);
    }
    if (data.containsKey('is_libero_exchange')) {
      context.handle(
          _isLiberoExchangeMeta,
          isLiberoExchange.isAcceptableOrUnknown(
              data['is_libero_exchange']!, _isLiberoExchangeMeta));
    } else if (isInserting) {
      context.missing(_isLiberoExchangeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StrategySubstitution map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StrategySubstitution(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      strategyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}strategy_id'])!,
      playerOutId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_out_id'])!,
      playerInId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_in_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      countsTowardLimit: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}counts_toward_limit'])!,
      isLiberoExchange: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_libero_exchange'])!,
    );
  }

  @override
  $StrategySubstitutionsTable createAlias(String alias) {
    return $StrategySubstitutionsTable(attachedDatabase, alias);
  }
}

class StrategySubstitution extends DataClass
    implements Insertable<StrategySubstitution> {
  final String id;
  final String strategyId;
  final String playerOutId;
  final String playerInId;
  final String createdAt;
  final bool countsTowardLimit;
  final bool isLiberoExchange;
  const StrategySubstitution(
      {required this.id,
      required this.strategyId,
      required this.playerOutId,
      required this.playerInId,
      required this.createdAt,
      required this.countsTowardLimit,
      required this.isLiberoExchange});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['strategy_id'] = Variable<String>(strategyId);
    map['player_out_id'] = Variable<String>(playerOutId);
    map['player_in_id'] = Variable<String>(playerInId);
    map['created_at'] = Variable<String>(createdAt);
    map['counts_toward_limit'] = Variable<bool>(countsTowardLimit);
    map['is_libero_exchange'] = Variable<bool>(isLiberoExchange);
    return map;
  }

  StrategySubstitutionsCompanion toCompanion(bool nullToAbsent) {
    return StrategySubstitutionsCompanion(
      id: Value(id),
      strategyId: Value(strategyId),
      playerOutId: Value(playerOutId),
      playerInId: Value(playerInId),
      createdAt: Value(createdAt),
      countsTowardLimit: Value(countsTowardLimit),
      isLiberoExchange: Value(isLiberoExchange),
    );
  }

  factory StrategySubstitution.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StrategySubstitution(
      id: serializer.fromJson<String>(json['id']),
      strategyId: serializer.fromJson<String>(json['strategyId']),
      playerOutId: serializer.fromJson<String>(json['playerOutId']),
      playerInId: serializer.fromJson<String>(json['playerInId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      countsTowardLimit: serializer.fromJson<bool>(json['countsTowardLimit']),
      isLiberoExchange: serializer.fromJson<bool>(json['isLiberoExchange']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'strategyId': serializer.toJson<String>(strategyId),
      'playerOutId': serializer.toJson<String>(playerOutId),
      'playerInId': serializer.toJson<String>(playerInId),
      'createdAt': serializer.toJson<String>(createdAt),
      'countsTowardLimit': serializer.toJson<bool>(countsTowardLimit),
      'isLiberoExchange': serializer.toJson<bool>(isLiberoExchange),
    };
  }

  StrategySubstitution copyWith(
          {String? id,
          String? strategyId,
          String? playerOutId,
          String? playerInId,
          String? createdAt,
          bool? countsTowardLimit,
          bool? isLiberoExchange}) =>
      StrategySubstitution(
        id: id ?? this.id,
        strategyId: strategyId ?? this.strategyId,
        playerOutId: playerOutId ?? this.playerOutId,
        playerInId: playerInId ?? this.playerInId,
        createdAt: createdAt ?? this.createdAt,
        countsTowardLimit: countsTowardLimit ?? this.countsTowardLimit,
        isLiberoExchange: isLiberoExchange ?? this.isLiberoExchange,
      );
  StrategySubstitution copyWithCompanion(StrategySubstitutionsCompanion data) {
    return StrategySubstitution(
      id: data.id.present ? data.id.value : this.id,
      strategyId:
          data.strategyId.present ? data.strategyId.value : this.strategyId,
      playerOutId:
          data.playerOutId.present ? data.playerOutId.value : this.playerOutId,
      playerInId:
          data.playerInId.present ? data.playerInId.value : this.playerInId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      countsTowardLimit: data.countsTowardLimit.present
          ? data.countsTowardLimit.value
          : this.countsTowardLimit,
      isLiberoExchange: data.isLiberoExchange.present
          ? data.isLiberoExchange.value
          : this.isLiberoExchange,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StrategySubstitution(')
          ..write('id: $id, ')
          ..write('strategyId: $strategyId, ')
          ..write('playerOutId: $playerOutId, ')
          ..write('playerInId: $playerInId, ')
          ..write('createdAt: $createdAt, ')
          ..write('countsTowardLimit: $countsTowardLimit, ')
          ..write('isLiberoExchange: $isLiberoExchange')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, strategyId, playerOutId, playerInId,
      createdAt, countsTowardLimit, isLiberoExchange);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StrategySubstitution &&
          other.id == this.id &&
          other.strategyId == this.strategyId &&
          other.playerOutId == this.playerOutId &&
          other.playerInId == this.playerInId &&
          other.createdAt == this.createdAt &&
          other.countsTowardLimit == this.countsTowardLimit &&
          other.isLiberoExchange == this.isLiberoExchange);
}

class StrategySubstitutionsCompanion
    extends UpdateCompanion<StrategySubstitution> {
  final Value<String> id;
  final Value<String> strategyId;
  final Value<String> playerOutId;
  final Value<String> playerInId;
  final Value<String> createdAt;
  final Value<bool> countsTowardLimit;
  final Value<bool> isLiberoExchange;
  final Value<int> rowid;
  const StrategySubstitutionsCompanion({
    this.id = const Value.absent(),
    this.strategyId = const Value.absent(),
    this.playerOutId = const Value.absent(),
    this.playerInId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.countsTowardLimit = const Value.absent(),
    this.isLiberoExchange = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StrategySubstitutionsCompanion.insert({
    required String id,
    required String strategyId,
    required String playerOutId,
    required String playerInId,
    required String createdAt,
    required bool countsTowardLimit,
    required bool isLiberoExchange,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        strategyId = Value(strategyId),
        playerOutId = Value(playerOutId),
        playerInId = Value(playerInId),
        createdAt = Value(createdAt),
        countsTowardLimit = Value(countsTowardLimit),
        isLiberoExchange = Value(isLiberoExchange);
  static Insertable<StrategySubstitution> custom({
    Expression<String>? id,
    Expression<String>? strategyId,
    Expression<String>? playerOutId,
    Expression<String>? playerInId,
    Expression<String>? createdAt,
    Expression<bool>? countsTowardLimit,
    Expression<bool>? isLiberoExchange,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (strategyId != null) 'strategy_id': strategyId,
      if (playerOutId != null) 'player_out_id': playerOutId,
      if (playerInId != null) 'player_in_id': playerInId,
      if (createdAt != null) 'created_at': createdAt,
      if (countsTowardLimit != null) 'counts_toward_limit': countsTowardLimit,
      if (isLiberoExchange != null) 'is_libero_exchange': isLiberoExchange,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StrategySubstitutionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? strategyId,
      Value<String>? playerOutId,
      Value<String>? playerInId,
      Value<String>? createdAt,
      Value<bool>? countsTowardLimit,
      Value<bool>? isLiberoExchange,
      Value<int>? rowid}) {
    return StrategySubstitutionsCompanion(
      id: id ?? this.id,
      strategyId: strategyId ?? this.strategyId,
      playerOutId: playerOutId ?? this.playerOutId,
      playerInId: playerInId ?? this.playerInId,
      createdAt: createdAt ?? this.createdAt,
      countsTowardLimit: countsTowardLimit ?? this.countsTowardLimit,
      isLiberoExchange: isLiberoExchange ?? this.isLiberoExchange,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (strategyId.present) {
      map['strategy_id'] = Variable<String>(strategyId.value);
    }
    if (playerOutId.present) {
      map['player_out_id'] = Variable<String>(playerOutId.value);
    }
    if (playerInId.present) {
      map['player_in_id'] = Variable<String>(playerInId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (countsTowardLimit.present) {
      map['counts_toward_limit'] = Variable<bool>(countsTowardLimit.value);
    }
    if (isLiberoExchange.present) {
      map['is_libero_exchange'] = Variable<bool>(isLiberoExchange.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StrategySubstitutionsCompanion(')
          ..write('id: $id, ')
          ..write('strategyId: $strategyId, ')
          ..write('playerOutId: $playerOutId, ')
          ..write('playerInId: $playerInId, ')
          ..write('createdAt: $createdAt, ')
          ..write('countsTowardLimit: $countsTowardLimit, ')
          ..write('isLiberoExchange: $isLiberoExchange, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MatchesTable extends Matches with TableInfo<$MatchesTable, Matche> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _teamANameMeta =
      const VerificationMeta('teamAName');
  @override
  late final GeneratedColumn<String> teamAName = GeneratedColumn<String>(
      'team_a_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _teamBNameMeta =
      const VerificationMeta('teamBName');
  @override
  late final GeneratedColumn<String> teamBName = GeneratedColumn<String>(
      'team_b_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _teamASetsWonMeta =
      const VerificationMeta('teamASetsWon');
  @override
  late final GeneratedColumn<int> teamASetsWon = GeneratedColumn<int>(
      'team_a_sets_won', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _teamBSetsWonMeta =
      const VerificationMeta('teamBSetsWon');
  @override
  late final GeneratedColumn<int> teamBSetsWon = GeneratedColumn<int>(
      'team_b_sets_won', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _currentSetMeta =
      const VerificationMeta('currentSet');
  @override
  late final GeneratedColumn<int> currentSet = GeneratedColumn<int>(
      'current_set', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _servingTeamMeta =
      const VerificationMeta('servingTeam');
  @override
  late final GeneratedColumn<String> servingTeam = GeneratedColumn<String>(
      'serving_team', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _matchStatusMeta =
      const VerificationMeta('matchStatus');
  @override
  late final GeneratedColumn<String> matchStatus = GeneratedColumn<String>(
      'match_status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _winnerTeamMeta =
      const VerificationMeta('winnerTeam');
  @override
  late final GeneratedColumn<String> winnerTeam = GeneratedColumn<String>(
      'winner_team', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceTypeMeta =
      const VerificationMeta('sourceType');
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
      'source_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('manual'));
  static const VerificationMeta _savedTeamGroupIdMeta =
      const VerificationMeta('savedTeamGroupId');
  @override
  late final GeneratedColumn<String> savedTeamGroupId = GeneratedColumn<String>(
      'saved_team_group_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _savedTeamGroupTitleMeta =
      const VerificationMeta('savedTeamGroupTitle');
  @override
  late final GeneratedColumn<String> savedTeamGroupTitle =
      GeneratedColumn<String>('saved_team_group_title', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _teamAOriginTeamIdMeta =
      const VerificationMeta('teamAOriginTeamId');
  @override
  late final GeneratedColumn<String> teamAOriginTeamId =
      GeneratedColumn<String>('team_a_origin_team_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _teamBOriginTeamIdMeta =
      const VerificationMeta('teamBOriginTeamId');
  @override
  late final GeneratedColumn<String> teamBOriginTeamId =
      GeneratedColumn<String>('team_b_origin_team_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _teamAPlayersJsonMeta =
      const VerificationMeta('teamAPlayersJson');
  @override
  late final GeneratedColumn<String> teamAPlayersJson = GeneratedColumn<String>(
      'team_a_players_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _teamBPlayersJsonMeta =
      const VerificationMeta('teamBPlayersJson');
  @override
  late final GeneratedColumn<String> teamBPlayersJson = GeneratedColumn<String>(
      'team_b_players_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _waitingPlayersSnapshotJsonMeta =
      const VerificationMeta('waitingPlayersSnapshotJson');
  @override
  late final GeneratedColumn<String> waitingPlayersSnapshotJson =
      GeneratedColumn<String>(
          'waiting_players_snapshot_json', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _finishedAtMeta =
      const VerificationMeta('finishedAt');
  @override
  late final GeneratedColumn<String> finishedAt = GeneratedColumn<String>(
      'finished_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        teamAName,
        teamBName,
        teamASetsWon,
        teamBSetsWon,
        currentSet,
        servingTeam,
        matchStatus,
        winnerTeam,
        sourceType,
        savedTeamGroupId,
        savedTeamGroupTitle,
        teamAOriginTeamId,
        teamBOriginTeamId,
        teamAPlayersJson,
        teamBPlayersJson,
        waitingPlayersSnapshotJson,
        createdAt,
        finishedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'matches';
  @override
  VerificationContext validateIntegrity(Insertable<Matche> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('team_a_name')) {
      context.handle(
          _teamANameMeta,
          teamAName.isAcceptableOrUnknown(
              data['team_a_name']!, _teamANameMeta));
    } else if (isInserting) {
      context.missing(_teamANameMeta);
    }
    if (data.containsKey('team_b_name')) {
      context.handle(
          _teamBNameMeta,
          teamBName.isAcceptableOrUnknown(
              data['team_b_name']!, _teamBNameMeta));
    } else if (isInserting) {
      context.missing(_teamBNameMeta);
    }
    if (data.containsKey('team_a_sets_won')) {
      context.handle(
          _teamASetsWonMeta,
          teamASetsWon.isAcceptableOrUnknown(
              data['team_a_sets_won']!, _teamASetsWonMeta));
    } else if (isInserting) {
      context.missing(_teamASetsWonMeta);
    }
    if (data.containsKey('team_b_sets_won')) {
      context.handle(
          _teamBSetsWonMeta,
          teamBSetsWon.isAcceptableOrUnknown(
              data['team_b_sets_won']!, _teamBSetsWonMeta));
    } else if (isInserting) {
      context.missing(_teamBSetsWonMeta);
    }
    if (data.containsKey('current_set')) {
      context.handle(
          _currentSetMeta,
          currentSet.isAcceptableOrUnknown(
              data['current_set']!, _currentSetMeta));
    } else if (isInserting) {
      context.missing(_currentSetMeta);
    }
    if (data.containsKey('serving_team')) {
      context.handle(
          _servingTeamMeta,
          servingTeam.isAcceptableOrUnknown(
              data['serving_team']!, _servingTeamMeta));
    } else if (isInserting) {
      context.missing(_servingTeamMeta);
    }
    if (data.containsKey('match_status')) {
      context.handle(
          _matchStatusMeta,
          matchStatus.isAcceptableOrUnknown(
              data['match_status']!, _matchStatusMeta));
    } else if (isInserting) {
      context.missing(_matchStatusMeta);
    }
    if (data.containsKey('winner_team')) {
      context.handle(
          _winnerTeamMeta,
          winnerTeam.isAcceptableOrUnknown(
              data['winner_team']!, _winnerTeamMeta));
    }
    if (data.containsKey('source_type')) {
      context.handle(
          _sourceTypeMeta,
          sourceType.isAcceptableOrUnknown(
              data['source_type']!, _sourceTypeMeta));
    }
    if (data.containsKey('saved_team_group_id')) {
      context.handle(
          _savedTeamGroupIdMeta,
          savedTeamGroupId.isAcceptableOrUnknown(
              data['saved_team_group_id']!, _savedTeamGroupIdMeta));
    }
    if (data.containsKey('saved_team_group_title')) {
      context.handle(
          _savedTeamGroupTitleMeta,
          savedTeamGroupTitle.isAcceptableOrUnknown(
              data['saved_team_group_title']!, _savedTeamGroupTitleMeta));
    }
    if (data.containsKey('team_a_origin_team_id')) {
      context.handle(
          _teamAOriginTeamIdMeta,
          teamAOriginTeamId.isAcceptableOrUnknown(
              data['team_a_origin_team_id']!, _teamAOriginTeamIdMeta));
    }
    if (data.containsKey('team_b_origin_team_id')) {
      context.handle(
          _teamBOriginTeamIdMeta,
          teamBOriginTeamId.isAcceptableOrUnknown(
              data['team_b_origin_team_id']!, _teamBOriginTeamIdMeta));
    }
    if (data.containsKey('team_a_players_json')) {
      context.handle(
          _teamAPlayersJsonMeta,
          teamAPlayersJson.isAcceptableOrUnknown(
              data['team_a_players_json']!, _teamAPlayersJsonMeta));
    }
    if (data.containsKey('team_b_players_json')) {
      context.handle(
          _teamBPlayersJsonMeta,
          teamBPlayersJson.isAcceptableOrUnknown(
              data['team_b_players_json']!, _teamBPlayersJsonMeta));
    }
    if (data.containsKey('waiting_players_snapshot_json')) {
      context.handle(
          _waitingPlayersSnapshotJsonMeta,
          waitingPlayersSnapshotJson.isAcceptableOrUnknown(
              data['waiting_players_snapshot_json']!,
              _waitingPlayersSnapshotJsonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('finished_at')) {
      context.handle(
          _finishedAtMeta,
          finishedAt.isAcceptableOrUnknown(
              data['finished_at']!, _finishedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Matche map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Matche(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      teamAName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}team_a_name'])!,
      teamBName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}team_b_name'])!,
      teamASetsWon: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}team_a_sets_won'])!,
      teamBSetsWon: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}team_b_sets_won'])!,
      currentSet: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_set'])!,
      servingTeam: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}serving_team'])!,
      matchStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}match_status'])!,
      winnerTeam: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}winner_team']),
      sourceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_type'])!,
      savedTeamGroupId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}saved_team_group_id']),
      savedTeamGroupTitle: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}saved_team_group_title']),
      teamAOriginTeamId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}team_a_origin_team_id']),
      teamBOriginTeamId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}team_b_origin_team_id']),
      teamAPlayersJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}team_a_players_json']),
      teamBPlayersJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}team_b_players_json']),
      waitingPlayersSnapshotJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}waiting_players_snapshot_json']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      finishedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}finished_at']),
    );
  }

  @override
  $MatchesTable createAlias(String alias) {
    return $MatchesTable(attachedDatabase, alias);
  }
}

class Matche extends DataClass implements Insertable<Matche> {
  final String id;
  final String teamAName;
  final String teamBName;
  final int teamASetsWon;
  final int teamBSetsWon;
  final int currentSet;
  final String servingTeam;
  final String matchStatus;
  final String? winnerTeam;
  final String sourceType;
  final String? savedTeamGroupId;
  final String? savedTeamGroupTitle;
  final String? teamAOriginTeamId;
  final String? teamBOriginTeamId;
  final String? teamAPlayersJson;
  final String? teamBPlayersJson;
  final String? waitingPlayersSnapshotJson;
  final String createdAt;
  final String? finishedAt;
  const Matche(
      {required this.id,
      required this.teamAName,
      required this.teamBName,
      required this.teamASetsWon,
      required this.teamBSetsWon,
      required this.currentSet,
      required this.servingTeam,
      required this.matchStatus,
      this.winnerTeam,
      required this.sourceType,
      this.savedTeamGroupId,
      this.savedTeamGroupTitle,
      this.teamAOriginTeamId,
      this.teamBOriginTeamId,
      this.teamAPlayersJson,
      this.teamBPlayersJson,
      this.waitingPlayersSnapshotJson,
      required this.createdAt,
      this.finishedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['team_a_name'] = Variable<String>(teamAName);
    map['team_b_name'] = Variable<String>(teamBName);
    map['team_a_sets_won'] = Variable<int>(teamASetsWon);
    map['team_b_sets_won'] = Variable<int>(teamBSetsWon);
    map['current_set'] = Variable<int>(currentSet);
    map['serving_team'] = Variable<String>(servingTeam);
    map['match_status'] = Variable<String>(matchStatus);
    if (!nullToAbsent || winnerTeam != null) {
      map['winner_team'] = Variable<String>(winnerTeam);
    }
    map['source_type'] = Variable<String>(sourceType);
    if (!nullToAbsent || savedTeamGroupId != null) {
      map['saved_team_group_id'] = Variable<String>(savedTeamGroupId);
    }
    if (!nullToAbsent || savedTeamGroupTitle != null) {
      map['saved_team_group_title'] = Variable<String>(savedTeamGroupTitle);
    }
    if (!nullToAbsent || teamAOriginTeamId != null) {
      map['team_a_origin_team_id'] = Variable<String>(teamAOriginTeamId);
    }
    if (!nullToAbsent || teamBOriginTeamId != null) {
      map['team_b_origin_team_id'] = Variable<String>(teamBOriginTeamId);
    }
    if (!nullToAbsent || teamAPlayersJson != null) {
      map['team_a_players_json'] = Variable<String>(teamAPlayersJson);
    }
    if (!nullToAbsent || teamBPlayersJson != null) {
      map['team_b_players_json'] = Variable<String>(teamBPlayersJson);
    }
    if (!nullToAbsent || waitingPlayersSnapshotJson != null) {
      map['waiting_players_snapshot_json'] =
          Variable<String>(waitingPlayersSnapshotJson);
    }
    map['created_at'] = Variable<String>(createdAt);
    if (!nullToAbsent || finishedAt != null) {
      map['finished_at'] = Variable<String>(finishedAt);
    }
    return map;
  }

  MatchesCompanion toCompanion(bool nullToAbsent) {
    return MatchesCompanion(
      id: Value(id),
      teamAName: Value(teamAName),
      teamBName: Value(teamBName),
      teamASetsWon: Value(teamASetsWon),
      teamBSetsWon: Value(teamBSetsWon),
      currentSet: Value(currentSet),
      servingTeam: Value(servingTeam),
      matchStatus: Value(matchStatus),
      winnerTeam: winnerTeam == null && nullToAbsent
          ? const Value.absent()
          : Value(winnerTeam),
      sourceType: Value(sourceType),
      savedTeamGroupId: savedTeamGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(savedTeamGroupId),
      savedTeamGroupTitle: savedTeamGroupTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(savedTeamGroupTitle),
      teamAOriginTeamId: teamAOriginTeamId == null && nullToAbsent
          ? const Value.absent()
          : Value(teamAOriginTeamId),
      teamBOriginTeamId: teamBOriginTeamId == null && nullToAbsent
          ? const Value.absent()
          : Value(teamBOriginTeamId),
      teamAPlayersJson: teamAPlayersJson == null && nullToAbsent
          ? const Value.absent()
          : Value(teamAPlayersJson),
      teamBPlayersJson: teamBPlayersJson == null && nullToAbsent
          ? const Value.absent()
          : Value(teamBPlayersJson),
      waitingPlayersSnapshotJson:
          waitingPlayersSnapshotJson == null && nullToAbsent
              ? const Value.absent()
              : Value(waitingPlayersSnapshotJson),
      createdAt: Value(createdAt),
      finishedAt: finishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedAt),
    );
  }

  factory Matche.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Matche(
      id: serializer.fromJson<String>(json['id']),
      teamAName: serializer.fromJson<String>(json['teamAName']),
      teamBName: serializer.fromJson<String>(json['teamBName']),
      teamASetsWon: serializer.fromJson<int>(json['teamASetsWon']),
      teamBSetsWon: serializer.fromJson<int>(json['teamBSetsWon']),
      currentSet: serializer.fromJson<int>(json['currentSet']),
      servingTeam: serializer.fromJson<String>(json['servingTeam']),
      matchStatus: serializer.fromJson<String>(json['matchStatus']),
      winnerTeam: serializer.fromJson<String?>(json['winnerTeam']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      savedTeamGroupId: serializer.fromJson<String?>(json['savedTeamGroupId']),
      savedTeamGroupTitle:
          serializer.fromJson<String?>(json['savedTeamGroupTitle']),
      teamAOriginTeamId:
          serializer.fromJson<String?>(json['teamAOriginTeamId']),
      teamBOriginTeamId:
          serializer.fromJson<String?>(json['teamBOriginTeamId']),
      teamAPlayersJson: serializer.fromJson<String?>(json['teamAPlayersJson']),
      teamBPlayersJson: serializer.fromJson<String?>(json['teamBPlayersJson']),
      waitingPlayersSnapshotJson:
          serializer.fromJson<String?>(json['waitingPlayersSnapshotJson']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      finishedAt: serializer.fromJson<String?>(json['finishedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'teamAName': serializer.toJson<String>(teamAName),
      'teamBName': serializer.toJson<String>(teamBName),
      'teamASetsWon': serializer.toJson<int>(teamASetsWon),
      'teamBSetsWon': serializer.toJson<int>(teamBSetsWon),
      'currentSet': serializer.toJson<int>(currentSet),
      'servingTeam': serializer.toJson<String>(servingTeam),
      'matchStatus': serializer.toJson<String>(matchStatus),
      'winnerTeam': serializer.toJson<String?>(winnerTeam),
      'sourceType': serializer.toJson<String>(sourceType),
      'savedTeamGroupId': serializer.toJson<String?>(savedTeamGroupId),
      'savedTeamGroupTitle': serializer.toJson<String?>(savedTeamGroupTitle),
      'teamAOriginTeamId': serializer.toJson<String?>(teamAOriginTeamId),
      'teamBOriginTeamId': serializer.toJson<String?>(teamBOriginTeamId),
      'teamAPlayersJson': serializer.toJson<String?>(teamAPlayersJson),
      'teamBPlayersJson': serializer.toJson<String?>(teamBPlayersJson),
      'waitingPlayersSnapshotJson':
          serializer.toJson<String?>(waitingPlayersSnapshotJson),
      'createdAt': serializer.toJson<String>(createdAt),
      'finishedAt': serializer.toJson<String?>(finishedAt),
    };
  }

  Matche copyWith(
          {String? id,
          String? teamAName,
          String? teamBName,
          int? teamASetsWon,
          int? teamBSetsWon,
          int? currentSet,
          String? servingTeam,
          String? matchStatus,
          Value<String?> winnerTeam = const Value.absent(),
          String? sourceType,
          Value<String?> savedTeamGroupId = const Value.absent(),
          Value<String?> savedTeamGroupTitle = const Value.absent(),
          Value<String?> teamAOriginTeamId = const Value.absent(),
          Value<String?> teamBOriginTeamId = const Value.absent(),
          Value<String?> teamAPlayersJson = const Value.absent(),
          Value<String?> teamBPlayersJson = const Value.absent(),
          Value<String?> waitingPlayersSnapshotJson = const Value.absent(),
          String? createdAt,
          Value<String?> finishedAt = const Value.absent()}) =>
      Matche(
        id: id ?? this.id,
        teamAName: teamAName ?? this.teamAName,
        teamBName: teamBName ?? this.teamBName,
        teamASetsWon: teamASetsWon ?? this.teamASetsWon,
        teamBSetsWon: teamBSetsWon ?? this.teamBSetsWon,
        currentSet: currentSet ?? this.currentSet,
        servingTeam: servingTeam ?? this.servingTeam,
        matchStatus: matchStatus ?? this.matchStatus,
        winnerTeam: winnerTeam.present ? winnerTeam.value : this.winnerTeam,
        sourceType: sourceType ?? this.sourceType,
        savedTeamGroupId: savedTeamGroupId.present
            ? savedTeamGroupId.value
            : this.savedTeamGroupId,
        savedTeamGroupTitle: savedTeamGroupTitle.present
            ? savedTeamGroupTitle.value
            : this.savedTeamGroupTitle,
        teamAOriginTeamId: teamAOriginTeamId.present
            ? teamAOriginTeamId.value
            : this.teamAOriginTeamId,
        teamBOriginTeamId: teamBOriginTeamId.present
            ? teamBOriginTeamId.value
            : this.teamBOriginTeamId,
        teamAPlayersJson: teamAPlayersJson.present
            ? teamAPlayersJson.value
            : this.teamAPlayersJson,
        teamBPlayersJson: teamBPlayersJson.present
            ? teamBPlayersJson.value
            : this.teamBPlayersJson,
        waitingPlayersSnapshotJson: waitingPlayersSnapshotJson.present
            ? waitingPlayersSnapshotJson.value
            : this.waitingPlayersSnapshotJson,
        createdAt: createdAt ?? this.createdAt,
        finishedAt: finishedAt.present ? finishedAt.value : this.finishedAt,
      );
  Matche copyWithCompanion(MatchesCompanion data) {
    return Matche(
      id: data.id.present ? data.id.value : this.id,
      teamAName: data.teamAName.present ? data.teamAName.value : this.teamAName,
      teamBName: data.teamBName.present ? data.teamBName.value : this.teamBName,
      teamASetsWon: data.teamASetsWon.present
          ? data.teamASetsWon.value
          : this.teamASetsWon,
      teamBSetsWon: data.teamBSetsWon.present
          ? data.teamBSetsWon.value
          : this.teamBSetsWon,
      currentSet:
          data.currentSet.present ? data.currentSet.value : this.currentSet,
      servingTeam:
          data.servingTeam.present ? data.servingTeam.value : this.servingTeam,
      matchStatus:
          data.matchStatus.present ? data.matchStatus.value : this.matchStatus,
      winnerTeam:
          data.winnerTeam.present ? data.winnerTeam.value : this.winnerTeam,
      sourceType:
          data.sourceType.present ? data.sourceType.value : this.sourceType,
      savedTeamGroupId: data.savedTeamGroupId.present
          ? data.savedTeamGroupId.value
          : this.savedTeamGroupId,
      savedTeamGroupTitle: data.savedTeamGroupTitle.present
          ? data.savedTeamGroupTitle.value
          : this.savedTeamGroupTitle,
      teamAOriginTeamId: data.teamAOriginTeamId.present
          ? data.teamAOriginTeamId.value
          : this.teamAOriginTeamId,
      teamBOriginTeamId: data.teamBOriginTeamId.present
          ? data.teamBOriginTeamId.value
          : this.teamBOriginTeamId,
      teamAPlayersJson: data.teamAPlayersJson.present
          ? data.teamAPlayersJson.value
          : this.teamAPlayersJson,
      teamBPlayersJson: data.teamBPlayersJson.present
          ? data.teamBPlayersJson.value
          : this.teamBPlayersJson,
      waitingPlayersSnapshotJson: data.waitingPlayersSnapshotJson.present
          ? data.waitingPlayersSnapshotJson.value
          : this.waitingPlayersSnapshotJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      finishedAt:
          data.finishedAt.present ? data.finishedAt.value : this.finishedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Matche(')
          ..write('id: $id, ')
          ..write('teamAName: $teamAName, ')
          ..write('teamBName: $teamBName, ')
          ..write('teamASetsWon: $teamASetsWon, ')
          ..write('teamBSetsWon: $teamBSetsWon, ')
          ..write('currentSet: $currentSet, ')
          ..write('servingTeam: $servingTeam, ')
          ..write('matchStatus: $matchStatus, ')
          ..write('winnerTeam: $winnerTeam, ')
          ..write('sourceType: $sourceType, ')
          ..write('savedTeamGroupId: $savedTeamGroupId, ')
          ..write('savedTeamGroupTitle: $savedTeamGroupTitle, ')
          ..write('teamAOriginTeamId: $teamAOriginTeamId, ')
          ..write('teamBOriginTeamId: $teamBOriginTeamId, ')
          ..write('teamAPlayersJson: $teamAPlayersJson, ')
          ..write('teamBPlayersJson: $teamBPlayersJson, ')
          ..write('waitingPlayersSnapshotJson: $waitingPlayersSnapshotJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('finishedAt: $finishedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      teamAName,
      teamBName,
      teamASetsWon,
      teamBSetsWon,
      currentSet,
      servingTeam,
      matchStatus,
      winnerTeam,
      sourceType,
      savedTeamGroupId,
      savedTeamGroupTitle,
      teamAOriginTeamId,
      teamBOriginTeamId,
      teamAPlayersJson,
      teamBPlayersJson,
      waitingPlayersSnapshotJson,
      createdAt,
      finishedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Matche &&
          other.id == this.id &&
          other.teamAName == this.teamAName &&
          other.teamBName == this.teamBName &&
          other.teamASetsWon == this.teamASetsWon &&
          other.teamBSetsWon == this.teamBSetsWon &&
          other.currentSet == this.currentSet &&
          other.servingTeam == this.servingTeam &&
          other.matchStatus == this.matchStatus &&
          other.winnerTeam == this.winnerTeam &&
          other.sourceType == this.sourceType &&
          other.savedTeamGroupId == this.savedTeamGroupId &&
          other.savedTeamGroupTitle == this.savedTeamGroupTitle &&
          other.teamAOriginTeamId == this.teamAOriginTeamId &&
          other.teamBOriginTeamId == this.teamBOriginTeamId &&
          other.teamAPlayersJson == this.teamAPlayersJson &&
          other.teamBPlayersJson == this.teamBPlayersJson &&
          other.waitingPlayersSnapshotJson == this.waitingPlayersSnapshotJson &&
          other.createdAt == this.createdAt &&
          other.finishedAt == this.finishedAt);
}

class MatchesCompanion extends UpdateCompanion<Matche> {
  final Value<String> id;
  final Value<String> teamAName;
  final Value<String> teamBName;
  final Value<int> teamASetsWon;
  final Value<int> teamBSetsWon;
  final Value<int> currentSet;
  final Value<String> servingTeam;
  final Value<String> matchStatus;
  final Value<String?> winnerTeam;
  final Value<String> sourceType;
  final Value<String?> savedTeamGroupId;
  final Value<String?> savedTeamGroupTitle;
  final Value<String?> teamAOriginTeamId;
  final Value<String?> teamBOriginTeamId;
  final Value<String?> teamAPlayersJson;
  final Value<String?> teamBPlayersJson;
  final Value<String?> waitingPlayersSnapshotJson;
  final Value<String> createdAt;
  final Value<String?> finishedAt;
  final Value<int> rowid;
  const MatchesCompanion({
    this.id = const Value.absent(),
    this.teamAName = const Value.absent(),
    this.teamBName = const Value.absent(),
    this.teamASetsWon = const Value.absent(),
    this.teamBSetsWon = const Value.absent(),
    this.currentSet = const Value.absent(),
    this.servingTeam = const Value.absent(),
    this.matchStatus = const Value.absent(),
    this.winnerTeam = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.savedTeamGroupId = const Value.absent(),
    this.savedTeamGroupTitle = const Value.absent(),
    this.teamAOriginTeamId = const Value.absent(),
    this.teamBOriginTeamId = const Value.absent(),
    this.teamAPlayersJson = const Value.absent(),
    this.teamBPlayersJson = const Value.absent(),
    this.waitingPlayersSnapshotJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.finishedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MatchesCompanion.insert({
    required String id,
    required String teamAName,
    required String teamBName,
    required int teamASetsWon,
    required int teamBSetsWon,
    required int currentSet,
    required String servingTeam,
    required String matchStatus,
    this.winnerTeam = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.savedTeamGroupId = const Value.absent(),
    this.savedTeamGroupTitle = const Value.absent(),
    this.teamAOriginTeamId = const Value.absent(),
    this.teamBOriginTeamId = const Value.absent(),
    this.teamAPlayersJson = const Value.absent(),
    this.teamBPlayersJson = const Value.absent(),
    this.waitingPlayersSnapshotJson = const Value.absent(),
    required String createdAt,
    this.finishedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        teamAName = Value(teamAName),
        teamBName = Value(teamBName),
        teamASetsWon = Value(teamASetsWon),
        teamBSetsWon = Value(teamBSetsWon),
        currentSet = Value(currentSet),
        servingTeam = Value(servingTeam),
        matchStatus = Value(matchStatus),
        createdAt = Value(createdAt);
  static Insertable<Matche> custom({
    Expression<String>? id,
    Expression<String>? teamAName,
    Expression<String>? teamBName,
    Expression<int>? teamASetsWon,
    Expression<int>? teamBSetsWon,
    Expression<int>? currentSet,
    Expression<String>? servingTeam,
    Expression<String>? matchStatus,
    Expression<String>? winnerTeam,
    Expression<String>? sourceType,
    Expression<String>? savedTeamGroupId,
    Expression<String>? savedTeamGroupTitle,
    Expression<String>? teamAOriginTeamId,
    Expression<String>? teamBOriginTeamId,
    Expression<String>? teamAPlayersJson,
    Expression<String>? teamBPlayersJson,
    Expression<String>? waitingPlayersSnapshotJson,
    Expression<String>? createdAt,
    Expression<String>? finishedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (teamAName != null) 'team_a_name': teamAName,
      if (teamBName != null) 'team_b_name': teamBName,
      if (teamASetsWon != null) 'team_a_sets_won': teamASetsWon,
      if (teamBSetsWon != null) 'team_b_sets_won': teamBSetsWon,
      if (currentSet != null) 'current_set': currentSet,
      if (servingTeam != null) 'serving_team': servingTeam,
      if (matchStatus != null) 'match_status': matchStatus,
      if (winnerTeam != null) 'winner_team': winnerTeam,
      if (sourceType != null) 'source_type': sourceType,
      if (savedTeamGroupId != null) 'saved_team_group_id': savedTeamGroupId,
      if (savedTeamGroupTitle != null)
        'saved_team_group_title': savedTeamGroupTitle,
      if (teamAOriginTeamId != null) 'team_a_origin_team_id': teamAOriginTeamId,
      if (teamBOriginTeamId != null) 'team_b_origin_team_id': teamBOriginTeamId,
      if (teamAPlayersJson != null) 'team_a_players_json': teamAPlayersJson,
      if (teamBPlayersJson != null) 'team_b_players_json': teamBPlayersJson,
      if (waitingPlayersSnapshotJson != null)
        'waiting_players_snapshot_json': waitingPlayersSnapshotJson,
      if (createdAt != null) 'created_at': createdAt,
      if (finishedAt != null) 'finished_at': finishedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MatchesCompanion copyWith(
      {Value<String>? id,
      Value<String>? teamAName,
      Value<String>? teamBName,
      Value<int>? teamASetsWon,
      Value<int>? teamBSetsWon,
      Value<int>? currentSet,
      Value<String>? servingTeam,
      Value<String>? matchStatus,
      Value<String?>? winnerTeam,
      Value<String>? sourceType,
      Value<String?>? savedTeamGroupId,
      Value<String?>? savedTeamGroupTitle,
      Value<String?>? teamAOriginTeamId,
      Value<String?>? teamBOriginTeamId,
      Value<String?>? teamAPlayersJson,
      Value<String?>? teamBPlayersJson,
      Value<String?>? waitingPlayersSnapshotJson,
      Value<String>? createdAt,
      Value<String?>? finishedAt,
      Value<int>? rowid}) {
    return MatchesCompanion(
      id: id ?? this.id,
      teamAName: teamAName ?? this.teamAName,
      teamBName: teamBName ?? this.teamBName,
      teamASetsWon: teamASetsWon ?? this.teamASetsWon,
      teamBSetsWon: teamBSetsWon ?? this.teamBSetsWon,
      currentSet: currentSet ?? this.currentSet,
      servingTeam: servingTeam ?? this.servingTeam,
      matchStatus: matchStatus ?? this.matchStatus,
      winnerTeam: winnerTeam ?? this.winnerTeam,
      sourceType: sourceType ?? this.sourceType,
      savedTeamGroupId: savedTeamGroupId ?? this.savedTeamGroupId,
      savedTeamGroupTitle: savedTeamGroupTitle ?? this.savedTeamGroupTitle,
      teamAOriginTeamId: teamAOriginTeamId ?? this.teamAOriginTeamId,
      teamBOriginTeamId: teamBOriginTeamId ?? this.teamBOriginTeamId,
      teamAPlayersJson: teamAPlayersJson ?? this.teamAPlayersJson,
      teamBPlayersJson: teamBPlayersJson ?? this.teamBPlayersJson,
      waitingPlayersSnapshotJson:
          waitingPlayersSnapshotJson ?? this.waitingPlayersSnapshotJson,
      createdAt: createdAt ?? this.createdAt,
      finishedAt: finishedAt ?? this.finishedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (teamAName.present) {
      map['team_a_name'] = Variable<String>(teamAName.value);
    }
    if (teamBName.present) {
      map['team_b_name'] = Variable<String>(teamBName.value);
    }
    if (teamASetsWon.present) {
      map['team_a_sets_won'] = Variable<int>(teamASetsWon.value);
    }
    if (teamBSetsWon.present) {
      map['team_b_sets_won'] = Variable<int>(teamBSetsWon.value);
    }
    if (currentSet.present) {
      map['current_set'] = Variable<int>(currentSet.value);
    }
    if (servingTeam.present) {
      map['serving_team'] = Variable<String>(servingTeam.value);
    }
    if (matchStatus.present) {
      map['match_status'] = Variable<String>(matchStatus.value);
    }
    if (winnerTeam.present) {
      map['winner_team'] = Variable<String>(winnerTeam.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (savedTeamGroupId.present) {
      map['saved_team_group_id'] = Variable<String>(savedTeamGroupId.value);
    }
    if (savedTeamGroupTitle.present) {
      map['saved_team_group_title'] =
          Variable<String>(savedTeamGroupTitle.value);
    }
    if (teamAOriginTeamId.present) {
      map['team_a_origin_team_id'] = Variable<String>(teamAOriginTeamId.value);
    }
    if (teamBOriginTeamId.present) {
      map['team_b_origin_team_id'] = Variable<String>(teamBOriginTeamId.value);
    }
    if (teamAPlayersJson.present) {
      map['team_a_players_json'] = Variable<String>(teamAPlayersJson.value);
    }
    if (teamBPlayersJson.present) {
      map['team_b_players_json'] = Variable<String>(teamBPlayersJson.value);
    }
    if (waitingPlayersSnapshotJson.present) {
      map['waiting_players_snapshot_json'] =
          Variable<String>(waitingPlayersSnapshotJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (finishedAt.present) {
      map['finished_at'] = Variable<String>(finishedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatchesCompanion(')
          ..write('id: $id, ')
          ..write('teamAName: $teamAName, ')
          ..write('teamBName: $teamBName, ')
          ..write('teamASetsWon: $teamASetsWon, ')
          ..write('teamBSetsWon: $teamBSetsWon, ')
          ..write('currentSet: $currentSet, ')
          ..write('servingTeam: $servingTeam, ')
          ..write('matchStatus: $matchStatus, ')
          ..write('winnerTeam: $winnerTeam, ')
          ..write('sourceType: $sourceType, ')
          ..write('savedTeamGroupId: $savedTeamGroupId, ')
          ..write('savedTeamGroupTitle: $savedTeamGroupTitle, ')
          ..write('teamAOriginTeamId: $teamAOriginTeamId, ')
          ..write('teamBOriginTeamId: $teamBOriginTeamId, ')
          ..write('teamAPlayersJson: $teamAPlayersJson, ')
          ..write('teamBPlayersJson: $teamBPlayersJson, ')
          ..write('waitingPlayersSnapshotJson: $waitingPlayersSnapshotJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MatchSetsTable extends MatchSets
    with TableInfo<$MatchSetsTable, MatchSet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _matchIdMeta =
      const VerificationMeta('matchId');
  @override
  late final GeneratedColumn<String> matchId = GeneratedColumn<String>(
      'match_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES matches (id)'));
  static const VerificationMeta _setNumberMeta =
      const VerificationMeta('setNumber');
  @override
  late final GeneratedColumn<int> setNumber = GeneratedColumn<int>(
      'set_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _teamAScoreMeta =
      const VerificationMeta('teamAScore');
  @override
  late final GeneratedColumn<int> teamAScore = GeneratedColumn<int>(
      'team_a_score', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _teamBScoreMeta =
      const VerificationMeta('teamBScore');
  @override
  late final GeneratedColumn<int> teamBScore = GeneratedColumn<int>(
      'team_b_score', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _winnerTeamIdMeta =
      const VerificationMeta('winnerTeamId');
  @override
  late final GeneratedColumn<String> winnerTeamId = GeneratedColumn<String>(
      'winner_team_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetPointsMeta =
      const VerificationMeta('targetPoints');
  @override
  late final GeneratedColumn<int> targetPoints = GeneratedColumn<int>(
      'target_points', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _durationSecondsMeta =
      const VerificationMeta('durationSeconds');
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
      'duration_seconds', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _pointEventsJsonMeta =
      const VerificationMeta('pointEventsJson');
  @override
  late final GeneratedColumn<String> pointEventsJson = GeneratedColumn<String>(
      'point_events_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        matchId,
        setNumber,
        teamAScore,
        teamBScore,
        winnerTeamId,
        targetPoints,
        durationSeconds,
        pointEventsJson
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'match_sets';
  @override
  VerificationContext validateIntegrity(Insertable<MatchSet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('match_id')) {
      context.handle(_matchIdMeta,
          matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta));
    } else if (isInserting) {
      context.missing(_matchIdMeta);
    }
    if (data.containsKey('set_number')) {
      context.handle(_setNumberMeta,
          setNumber.isAcceptableOrUnknown(data['set_number']!, _setNumberMeta));
    } else if (isInserting) {
      context.missing(_setNumberMeta);
    }
    if (data.containsKey('team_a_score')) {
      context.handle(
          _teamAScoreMeta,
          teamAScore.isAcceptableOrUnknown(
              data['team_a_score']!, _teamAScoreMeta));
    } else if (isInserting) {
      context.missing(_teamAScoreMeta);
    }
    if (data.containsKey('team_b_score')) {
      context.handle(
          _teamBScoreMeta,
          teamBScore.isAcceptableOrUnknown(
              data['team_b_score']!, _teamBScoreMeta));
    } else if (isInserting) {
      context.missing(_teamBScoreMeta);
    }
    if (data.containsKey('winner_team_id')) {
      context.handle(
          _winnerTeamIdMeta,
          winnerTeamId.isAcceptableOrUnknown(
              data['winner_team_id']!, _winnerTeamIdMeta));
    } else if (isInserting) {
      context.missing(_winnerTeamIdMeta);
    }
    if (data.containsKey('target_points')) {
      context.handle(
          _targetPointsMeta,
          targetPoints.isAcceptableOrUnknown(
              data['target_points']!, _targetPointsMeta));
    } else if (isInserting) {
      context.missing(_targetPointsMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
          _durationSecondsMeta,
          durationSeconds.isAcceptableOrUnknown(
              data['duration_seconds']!, _durationSecondsMeta));
    }
    if (data.containsKey('point_events_json')) {
      context.handle(
          _pointEventsJsonMeta,
          pointEventsJson.isAcceptableOrUnknown(
              data['point_events_json']!, _pointEventsJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MatchSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MatchSet(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      matchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}match_id'])!,
      setNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}set_number'])!,
      teamAScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}team_a_score'])!,
      teamBScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}team_b_score'])!,
      winnerTeamId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}winner_team_id'])!,
      targetPoints: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_points'])!,
      durationSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_seconds'])!,
      pointEventsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}point_events_json']),
    );
  }

  @override
  $MatchSetsTable createAlias(String alias) {
    return $MatchSetsTable(attachedDatabase, alias);
  }
}

class MatchSet extends DataClass implements Insertable<MatchSet> {
  final String id;
  final String matchId;
  final int setNumber;
  final int teamAScore;
  final int teamBScore;
  final String winnerTeamId;
  final int targetPoints;
  final int durationSeconds;
  final String? pointEventsJson;
  const MatchSet(
      {required this.id,
      required this.matchId,
      required this.setNumber,
      required this.teamAScore,
      required this.teamBScore,
      required this.winnerTeamId,
      required this.targetPoints,
      required this.durationSeconds,
      this.pointEventsJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['match_id'] = Variable<String>(matchId);
    map['set_number'] = Variable<int>(setNumber);
    map['team_a_score'] = Variable<int>(teamAScore);
    map['team_b_score'] = Variable<int>(teamBScore);
    map['winner_team_id'] = Variable<String>(winnerTeamId);
    map['target_points'] = Variable<int>(targetPoints);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    if (!nullToAbsent || pointEventsJson != null) {
      map['point_events_json'] = Variable<String>(pointEventsJson);
    }
    return map;
  }

  MatchSetsCompanion toCompanion(bool nullToAbsent) {
    return MatchSetsCompanion(
      id: Value(id),
      matchId: Value(matchId),
      setNumber: Value(setNumber),
      teamAScore: Value(teamAScore),
      teamBScore: Value(teamBScore),
      winnerTeamId: Value(winnerTeamId),
      targetPoints: Value(targetPoints),
      durationSeconds: Value(durationSeconds),
      pointEventsJson: pointEventsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(pointEventsJson),
    );
  }

  factory MatchSet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MatchSet(
      id: serializer.fromJson<String>(json['id']),
      matchId: serializer.fromJson<String>(json['matchId']),
      setNumber: serializer.fromJson<int>(json['setNumber']),
      teamAScore: serializer.fromJson<int>(json['teamAScore']),
      teamBScore: serializer.fromJson<int>(json['teamBScore']),
      winnerTeamId: serializer.fromJson<String>(json['winnerTeamId']),
      targetPoints: serializer.fromJson<int>(json['targetPoints']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      pointEventsJson: serializer.fromJson<String?>(json['pointEventsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'matchId': serializer.toJson<String>(matchId),
      'setNumber': serializer.toJson<int>(setNumber),
      'teamAScore': serializer.toJson<int>(teamAScore),
      'teamBScore': serializer.toJson<int>(teamBScore),
      'winnerTeamId': serializer.toJson<String>(winnerTeamId),
      'targetPoints': serializer.toJson<int>(targetPoints),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'pointEventsJson': serializer.toJson<String?>(pointEventsJson),
    };
  }

  MatchSet copyWith(
          {String? id,
          String? matchId,
          int? setNumber,
          int? teamAScore,
          int? teamBScore,
          String? winnerTeamId,
          int? targetPoints,
          int? durationSeconds,
          Value<String?> pointEventsJson = const Value.absent()}) =>
      MatchSet(
        id: id ?? this.id,
        matchId: matchId ?? this.matchId,
        setNumber: setNumber ?? this.setNumber,
        teamAScore: teamAScore ?? this.teamAScore,
        teamBScore: teamBScore ?? this.teamBScore,
        winnerTeamId: winnerTeamId ?? this.winnerTeamId,
        targetPoints: targetPoints ?? this.targetPoints,
        durationSeconds: durationSeconds ?? this.durationSeconds,
        pointEventsJson: pointEventsJson.present
            ? pointEventsJson.value
            : this.pointEventsJson,
      );
  MatchSet copyWithCompanion(MatchSetsCompanion data) {
    return MatchSet(
      id: data.id.present ? data.id.value : this.id,
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      setNumber: data.setNumber.present ? data.setNumber.value : this.setNumber,
      teamAScore:
          data.teamAScore.present ? data.teamAScore.value : this.teamAScore,
      teamBScore:
          data.teamBScore.present ? data.teamBScore.value : this.teamBScore,
      winnerTeamId: data.winnerTeamId.present
          ? data.winnerTeamId.value
          : this.winnerTeamId,
      targetPoints: data.targetPoints.present
          ? data.targetPoints.value
          : this.targetPoints,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      pointEventsJson: data.pointEventsJson.present
          ? data.pointEventsJson.value
          : this.pointEventsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MatchSet(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('setNumber: $setNumber, ')
          ..write('teamAScore: $teamAScore, ')
          ..write('teamBScore: $teamBScore, ')
          ..write('winnerTeamId: $winnerTeamId, ')
          ..write('targetPoints: $targetPoints, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('pointEventsJson: $pointEventsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, matchId, setNumber, teamAScore,
      teamBScore, winnerTeamId, targetPoints, durationSeconds, pointEventsJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchSet &&
          other.id == this.id &&
          other.matchId == this.matchId &&
          other.setNumber == this.setNumber &&
          other.teamAScore == this.teamAScore &&
          other.teamBScore == this.teamBScore &&
          other.winnerTeamId == this.winnerTeamId &&
          other.targetPoints == this.targetPoints &&
          other.durationSeconds == this.durationSeconds &&
          other.pointEventsJson == this.pointEventsJson);
}

class MatchSetsCompanion extends UpdateCompanion<MatchSet> {
  final Value<String> id;
  final Value<String> matchId;
  final Value<int> setNumber;
  final Value<int> teamAScore;
  final Value<int> teamBScore;
  final Value<String> winnerTeamId;
  final Value<int> targetPoints;
  final Value<int> durationSeconds;
  final Value<String?> pointEventsJson;
  final Value<int> rowid;
  const MatchSetsCompanion({
    this.id = const Value.absent(),
    this.matchId = const Value.absent(),
    this.setNumber = const Value.absent(),
    this.teamAScore = const Value.absent(),
    this.teamBScore = const Value.absent(),
    this.winnerTeamId = const Value.absent(),
    this.targetPoints = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.pointEventsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MatchSetsCompanion.insert({
    required String id,
    required String matchId,
    required int setNumber,
    required int teamAScore,
    required int teamBScore,
    required String winnerTeamId,
    required int targetPoints,
    this.durationSeconds = const Value.absent(),
    this.pointEventsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        matchId = Value(matchId),
        setNumber = Value(setNumber),
        teamAScore = Value(teamAScore),
        teamBScore = Value(teamBScore),
        winnerTeamId = Value(winnerTeamId),
        targetPoints = Value(targetPoints);
  static Insertable<MatchSet> custom({
    Expression<String>? id,
    Expression<String>? matchId,
    Expression<int>? setNumber,
    Expression<int>? teamAScore,
    Expression<int>? teamBScore,
    Expression<String>? winnerTeamId,
    Expression<int>? targetPoints,
    Expression<int>? durationSeconds,
    Expression<String>? pointEventsJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matchId != null) 'match_id': matchId,
      if (setNumber != null) 'set_number': setNumber,
      if (teamAScore != null) 'team_a_score': teamAScore,
      if (teamBScore != null) 'team_b_score': teamBScore,
      if (winnerTeamId != null) 'winner_team_id': winnerTeamId,
      if (targetPoints != null) 'target_points': targetPoints,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (pointEventsJson != null) 'point_events_json': pointEventsJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MatchSetsCompanion copyWith(
      {Value<String>? id,
      Value<String>? matchId,
      Value<int>? setNumber,
      Value<int>? teamAScore,
      Value<int>? teamBScore,
      Value<String>? winnerTeamId,
      Value<int>? targetPoints,
      Value<int>? durationSeconds,
      Value<String?>? pointEventsJson,
      Value<int>? rowid}) {
    return MatchSetsCompanion(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      setNumber: setNumber ?? this.setNumber,
      teamAScore: teamAScore ?? this.teamAScore,
      teamBScore: teamBScore ?? this.teamBScore,
      winnerTeamId: winnerTeamId ?? this.winnerTeamId,
      targetPoints: targetPoints ?? this.targetPoints,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      pointEventsJson: pointEventsJson ?? this.pointEventsJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (matchId.present) {
      map['match_id'] = Variable<String>(matchId.value);
    }
    if (setNumber.present) {
      map['set_number'] = Variable<int>(setNumber.value);
    }
    if (teamAScore.present) {
      map['team_a_score'] = Variable<int>(teamAScore.value);
    }
    if (teamBScore.present) {
      map['team_b_score'] = Variable<int>(teamBScore.value);
    }
    if (winnerTeamId.present) {
      map['winner_team_id'] = Variable<String>(winnerTeamId.value);
    }
    if (targetPoints.present) {
      map['target_points'] = Variable<int>(targetPoints.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (pointEventsJson.present) {
      map['point_events_json'] = Variable<String>(pointEventsJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatchSetsCompanion(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('setNumber: $setNumber, ')
          ..write('teamAScore: $teamAScore, ')
          ..write('teamBScore: $teamBScore, ')
          ..write('winnerTeamId: $winnerTeamId, ')
          ..write('targetPoints: $targetPoints, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('pointEventsJson: $pointEventsJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DrillsTable extends Drills with TableInfo<$DrillsTable, Drill> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _objectiveMeta =
      const VerificationMeta('objective');
  @override
  late final GeneratedColumn<String> objective = GeneratedColumn<String>(
      'objective', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _difficultyMeta =
      const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
      'difficulty', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<String> duration = GeneratedColumn<String>(
      'duration', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_favorite" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, category, objective, difficulty, duration, isFavorite];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drills';
  @override
  VerificationContext validateIntegrity(Insertable<Drill> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('objective')) {
      context.handle(_objectiveMeta,
          objective.isAcceptableOrUnknown(data['objective']!, _objectiveMeta));
    } else if (isInserting) {
      context.missing(_objectiveMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Drill map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Drill(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      objective: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}objective'])!,
      difficulty: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}difficulty'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}duration'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
    );
  }

  @override
  $DrillsTable createAlias(String alias) {
    return $DrillsTable(attachedDatabase, alias);
  }
}

class Drill extends DataClass implements Insertable<Drill> {
  final String id;
  final String name;
  final String category;
  final String objective;
  final String difficulty;
  final String duration;
  final bool isFavorite;
  const Drill(
      {required this.id,
      required this.name,
      required this.category,
      required this.objective,
      required this.difficulty,
      required this.duration,
      required this.isFavorite});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['objective'] = Variable<String>(objective);
    map['difficulty'] = Variable<String>(difficulty);
    map['duration'] = Variable<String>(duration);
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  DrillsCompanion toCompanion(bool nullToAbsent) {
    return DrillsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      objective: Value(objective),
      difficulty: Value(difficulty),
      duration: Value(duration),
      isFavorite: Value(isFavorite),
    );
  }

  factory Drill.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Drill(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      objective: serializer.fromJson<String>(json['objective']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      duration: serializer.fromJson<String>(json['duration']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'objective': serializer.toJson<String>(objective),
      'difficulty': serializer.toJson<String>(difficulty),
      'duration': serializer.toJson<String>(duration),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  Drill copyWith(
          {String? id,
          String? name,
          String? category,
          String? objective,
          String? difficulty,
          String? duration,
          bool? isFavorite}) =>
      Drill(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        objective: objective ?? this.objective,
        difficulty: difficulty ?? this.difficulty,
        duration: duration ?? this.duration,
        isFavorite: isFavorite ?? this.isFavorite,
      );
  Drill copyWithCompanion(DrillsCompanion data) {
    return Drill(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      objective: data.objective.present ? data.objective.value : this.objective,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      duration: data.duration.present ? data.duration.value : this.duration,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Drill(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('objective: $objective, ')
          ..write('difficulty: $difficulty, ')
          ..write('duration: $duration, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, category, objective, difficulty, duration, isFavorite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Drill &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.objective == this.objective &&
          other.difficulty == this.difficulty &&
          other.duration == this.duration &&
          other.isFavorite == this.isFavorite);
}

class DrillsCompanion extends UpdateCompanion<Drill> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String> objective;
  final Value<String> difficulty;
  final Value<String> duration;
  final Value<bool> isFavorite;
  final Value<int> rowid;
  const DrillsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.objective = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.duration = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrillsCompanion.insert({
    required String id,
    required String name,
    required String category,
    required String objective,
    required String difficulty,
    required String duration,
    required bool isFavorite,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        category = Value(category),
        objective = Value(objective),
        difficulty = Value(difficulty),
        duration = Value(duration),
        isFavorite = Value(isFavorite);
  static Insertable<Drill> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? objective,
    Expression<String>? difficulty,
    Expression<String>? duration,
    Expression<bool>? isFavorite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (objective != null) 'objective': objective,
      if (difficulty != null) 'difficulty': difficulty,
      if (duration != null) 'duration': duration,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrillsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? category,
      Value<String>? objective,
      Value<String>? difficulty,
      Value<String>? duration,
      Value<bool>? isFavorite,
      Value<int>? rowid}) {
    return DrillsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      objective: objective ?? this.objective,
      difficulty: difficulty ?? this.difficulty,
      duration: duration ?? this.duration,
      isFavorite: isFavorite ?? this.isFavorite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (objective.present) {
      map['objective'] = Variable<String>(objective.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (duration.present) {
      map['duration'] = Variable<String>(duration.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrillsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('objective: $objective, ')
          ..write('difficulty: $difficulty, ')
          ..write('duration: $duration, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DrillPlayersTable extends DrillPlayers
    with TableInfo<$DrillPlayersTable, DrillPlayer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrillPlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _drillIdMeta =
      const VerificationMeta('drillId');
  @override
  late final GeneratedColumn<String> drillId = GeneratedColumn<String>(
      'drill_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES drills (id)'));
  static const VerificationMeta _playerIdMeta =
      const VerificationMeta('playerId');
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
      'player_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<int> colorHex = GeneratedColumn<int>(
      'color_hex', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, drillId, playerId, label, role, colorHex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drill_players';
  @override
  VerificationContext validateIntegrity(Insertable<DrillPlayer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('drill_id')) {
      context.handle(_drillIdMeta,
          drillId.isAcceptableOrUnknown(data['drill_id']!, _drillIdMeta));
    } else if (isInserting) {
      context.missing(_drillIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(_playerIdMeta,
          playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta));
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    } else if (isInserting) {
      context.missing(_colorHexMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrillPlayer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrillPlayer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      drillId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}drill_id'])!,
      playerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color_hex'])!,
    );
  }

  @override
  $DrillPlayersTable createAlias(String alias) {
    return $DrillPlayersTable(attachedDatabase, alias);
  }
}

class DrillPlayer extends DataClass implements Insertable<DrillPlayer> {
  final String id;
  final String drillId;
  final String playerId;
  final String label;
  final String role;
  final int colorHex;
  const DrillPlayer(
      {required this.id,
      required this.drillId,
      required this.playerId,
      required this.label,
      required this.role,
      required this.colorHex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['drill_id'] = Variable<String>(drillId);
    map['player_id'] = Variable<String>(playerId);
    map['label'] = Variable<String>(label);
    map['role'] = Variable<String>(role);
    map['color_hex'] = Variable<int>(colorHex);
    return map;
  }

  DrillPlayersCompanion toCompanion(bool nullToAbsent) {
    return DrillPlayersCompanion(
      id: Value(id),
      drillId: Value(drillId),
      playerId: Value(playerId),
      label: Value(label),
      role: Value(role),
      colorHex: Value(colorHex),
    );
  }

  factory DrillPlayer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrillPlayer(
      id: serializer.fromJson<String>(json['id']),
      drillId: serializer.fromJson<String>(json['drillId']),
      playerId: serializer.fromJson<String>(json['playerId']),
      label: serializer.fromJson<String>(json['label']),
      role: serializer.fromJson<String>(json['role']),
      colorHex: serializer.fromJson<int>(json['colorHex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'drillId': serializer.toJson<String>(drillId),
      'playerId': serializer.toJson<String>(playerId),
      'label': serializer.toJson<String>(label),
      'role': serializer.toJson<String>(role),
      'colorHex': serializer.toJson<int>(colorHex),
    };
  }

  DrillPlayer copyWith(
          {String? id,
          String? drillId,
          String? playerId,
          String? label,
          String? role,
          int? colorHex}) =>
      DrillPlayer(
        id: id ?? this.id,
        drillId: drillId ?? this.drillId,
        playerId: playerId ?? this.playerId,
        label: label ?? this.label,
        role: role ?? this.role,
        colorHex: colorHex ?? this.colorHex,
      );
  DrillPlayer copyWithCompanion(DrillPlayersCompanion data) {
    return DrillPlayer(
      id: data.id.present ? data.id.value : this.id,
      drillId: data.drillId.present ? data.drillId.value : this.drillId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      label: data.label.present ? data.label.value : this.label,
      role: data.role.present ? data.role.value : this.role,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrillPlayer(')
          ..write('id: $id, ')
          ..write('drillId: $drillId, ')
          ..write('playerId: $playerId, ')
          ..write('label: $label, ')
          ..write('role: $role, ')
          ..write('colorHex: $colorHex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, drillId, playerId, label, role, colorHex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrillPlayer &&
          other.id == this.id &&
          other.drillId == this.drillId &&
          other.playerId == this.playerId &&
          other.label == this.label &&
          other.role == this.role &&
          other.colorHex == this.colorHex);
}

class DrillPlayersCompanion extends UpdateCompanion<DrillPlayer> {
  final Value<String> id;
  final Value<String> drillId;
  final Value<String> playerId;
  final Value<String> label;
  final Value<String> role;
  final Value<int> colorHex;
  final Value<int> rowid;
  const DrillPlayersCompanion({
    this.id = const Value.absent(),
    this.drillId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.label = const Value.absent(),
    this.role = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrillPlayersCompanion.insert({
    required String id,
    required String drillId,
    required String playerId,
    required String label,
    required String role,
    required int colorHex,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        drillId = Value(drillId),
        playerId = Value(playerId),
        label = Value(label),
        role = Value(role),
        colorHex = Value(colorHex);
  static Insertable<DrillPlayer> custom({
    Expression<String>? id,
    Expression<String>? drillId,
    Expression<String>? playerId,
    Expression<String>? label,
    Expression<String>? role,
    Expression<int>? colorHex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (drillId != null) 'drill_id': drillId,
      if (playerId != null) 'player_id': playerId,
      if (label != null) 'label': label,
      if (role != null) 'role': role,
      if (colorHex != null) 'color_hex': colorHex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrillPlayersCompanion copyWith(
      {Value<String>? id,
      Value<String>? drillId,
      Value<String>? playerId,
      Value<String>? label,
      Value<String>? role,
      Value<int>? colorHex,
      Value<int>? rowid}) {
    return DrillPlayersCompanion(
      id: id ?? this.id,
      drillId: drillId ?? this.drillId,
      playerId: playerId ?? this.playerId,
      label: label ?? this.label,
      role: role ?? this.role,
      colorHex: colorHex ?? this.colorHex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (drillId.present) {
      map['drill_id'] = Variable<String>(drillId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<int>(colorHex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrillPlayersCompanion(')
          ..write('id: $id, ')
          ..write('drillId: $drillId, ')
          ..write('playerId: $playerId, ')
          ..write('label: $label, ')
          ..write('role: $role, ')
          ..write('colorHex: $colorHex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DrillStepsTable extends DrillSteps
    with TableInfo<$DrillStepsTable, DrillStep> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrillStepsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _drillIdMeta =
      const VerificationMeta('drillId');
  @override
  late final GeneratedColumn<String> drillId = GeneratedColumn<String>(
      'drill_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES drills (id)'));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _textValueMeta =
      const VerificationMeta('textValue');
  @override
  late final GeneratedColumn<String> textValue = GeneratedColumn<String>(
      'text_value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, drillId, sortOrder, textValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drill_steps';
  @override
  VerificationContext validateIntegrity(Insertable<DrillStep> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('drill_id')) {
      context.handle(_drillIdMeta,
          drillId.isAcceptableOrUnknown(data['drill_id']!, _drillIdMeta));
    } else if (isInserting) {
      context.missing(_drillIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('text_value')) {
      context.handle(_textValueMeta,
          textValue.isAcceptableOrUnknown(data['text_value']!, _textValueMeta));
    } else if (isInserting) {
      context.missing(_textValueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrillStep map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrillStep(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      drillId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}drill_id'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      textValue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_value'])!,
    );
  }

  @override
  $DrillStepsTable createAlias(String alias) {
    return $DrillStepsTable(attachedDatabase, alias);
  }
}

class DrillStep extends DataClass implements Insertable<DrillStep> {
  final String id;
  final String drillId;
  final int sortOrder;
  final String textValue;
  const DrillStep(
      {required this.id,
      required this.drillId,
      required this.sortOrder,
      required this.textValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['drill_id'] = Variable<String>(drillId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['text_value'] = Variable<String>(textValue);
    return map;
  }

  DrillStepsCompanion toCompanion(bool nullToAbsent) {
    return DrillStepsCompanion(
      id: Value(id),
      drillId: Value(drillId),
      sortOrder: Value(sortOrder),
      textValue: Value(textValue),
    );
  }

  factory DrillStep.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrillStep(
      id: serializer.fromJson<String>(json['id']),
      drillId: serializer.fromJson<String>(json['drillId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      textValue: serializer.fromJson<String>(json['textValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'drillId': serializer.toJson<String>(drillId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'textValue': serializer.toJson<String>(textValue),
    };
  }

  DrillStep copyWith(
          {String? id, String? drillId, int? sortOrder, String? textValue}) =>
      DrillStep(
        id: id ?? this.id,
        drillId: drillId ?? this.drillId,
        sortOrder: sortOrder ?? this.sortOrder,
        textValue: textValue ?? this.textValue,
      );
  DrillStep copyWithCompanion(DrillStepsCompanion data) {
    return DrillStep(
      id: data.id.present ? data.id.value : this.id,
      drillId: data.drillId.present ? data.drillId.value : this.drillId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      textValue: data.textValue.present ? data.textValue.value : this.textValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrillStep(')
          ..write('id: $id, ')
          ..write('drillId: $drillId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('textValue: $textValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, drillId, sortOrder, textValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrillStep &&
          other.id == this.id &&
          other.drillId == this.drillId &&
          other.sortOrder == this.sortOrder &&
          other.textValue == this.textValue);
}

class DrillStepsCompanion extends UpdateCompanion<DrillStep> {
  final Value<String> id;
  final Value<String> drillId;
  final Value<int> sortOrder;
  final Value<String> textValue;
  final Value<int> rowid;
  const DrillStepsCompanion({
    this.id = const Value.absent(),
    this.drillId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.textValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrillStepsCompanion.insert({
    required String id,
    required String drillId,
    required int sortOrder,
    required String textValue,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        drillId = Value(drillId),
        sortOrder = Value(sortOrder),
        textValue = Value(textValue);
  static Insertable<DrillStep> custom({
    Expression<String>? id,
    Expression<String>? drillId,
    Expression<int>? sortOrder,
    Expression<String>? textValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (drillId != null) 'drill_id': drillId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (textValue != null) 'text_value': textValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrillStepsCompanion copyWith(
      {Value<String>? id,
      Value<String>? drillId,
      Value<int>? sortOrder,
      Value<String>? textValue,
      Value<int>? rowid}) {
    return DrillStepsCompanion(
      id: id ?? this.id,
      drillId: drillId ?? this.drillId,
      sortOrder: sortOrder ?? this.sortOrder,
      textValue: textValue ?? this.textValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (drillId.present) {
      map['drill_id'] = Variable<String>(drillId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (textValue.present) {
      map['text_value'] = Variable<String>(textValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrillStepsCompanion(')
          ..write('id: $id, ')
          ..write('drillId: $drillId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('textValue: $textValue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DrillTipsTable extends DrillTips
    with TableInfo<$DrillTipsTable, DrillTip> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrillTipsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _drillIdMeta =
      const VerificationMeta('drillId');
  @override
  late final GeneratedColumn<String> drillId = GeneratedColumn<String>(
      'drill_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES drills (id)'));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _textValueMeta =
      const VerificationMeta('textValue');
  @override
  late final GeneratedColumn<String> textValue = GeneratedColumn<String>(
      'text_value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, drillId, sortOrder, textValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drill_tips';
  @override
  VerificationContext validateIntegrity(Insertable<DrillTip> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('drill_id')) {
      context.handle(_drillIdMeta,
          drillId.isAcceptableOrUnknown(data['drill_id']!, _drillIdMeta));
    } else if (isInserting) {
      context.missing(_drillIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('text_value')) {
      context.handle(_textValueMeta,
          textValue.isAcceptableOrUnknown(data['text_value']!, _textValueMeta));
    } else if (isInserting) {
      context.missing(_textValueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrillTip map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrillTip(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      drillId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}drill_id'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      textValue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_value'])!,
    );
  }

  @override
  $DrillTipsTable createAlias(String alias) {
    return $DrillTipsTable(attachedDatabase, alias);
  }
}

class DrillTip extends DataClass implements Insertable<DrillTip> {
  final String id;
  final String drillId;
  final int sortOrder;
  final String textValue;
  const DrillTip(
      {required this.id,
      required this.drillId,
      required this.sortOrder,
      required this.textValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['drill_id'] = Variable<String>(drillId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['text_value'] = Variable<String>(textValue);
    return map;
  }

  DrillTipsCompanion toCompanion(bool nullToAbsent) {
    return DrillTipsCompanion(
      id: Value(id),
      drillId: Value(drillId),
      sortOrder: Value(sortOrder),
      textValue: Value(textValue),
    );
  }

  factory DrillTip.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrillTip(
      id: serializer.fromJson<String>(json['id']),
      drillId: serializer.fromJson<String>(json['drillId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      textValue: serializer.fromJson<String>(json['textValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'drillId': serializer.toJson<String>(drillId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'textValue': serializer.toJson<String>(textValue),
    };
  }

  DrillTip copyWith(
          {String? id, String? drillId, int? sortOrder, String? textValue}) =>
      DrillTip(
        id: id ?? this.id,
        drillId: drillId ?? this.drillId,
        sortOrder: sortOrder ?? this.sortOrder,
        textValue: textValue ?? this.textValue,
      );
  DrillTip copyWithCompanion(DrillTipsCompanion data) {
    return DrillTip(
      id: data.id.present ? data.id.value : this.id,
      drillId: data.drillId.present ? data.drillId.value : this.drillId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      textValue: data.textValue.present ? data.textValue.value : this.textValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrillTip(')
          ..write('id: $id, ')
          ..write('drillId: $drillId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('textValue: $textValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, drillId, sortOrder, textValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrillTip &&
          other.id == this.id &&
          other.drillId == this.drillId &&
          other.sortOrder == this.sortOrder &&
          other.textValue == this.textValue);
}

class DrillTipsCompanion extends UpdateCompanion<DrillTip> {
  final Value<String> id;
  final Value<String> drillId;
  final Value<int> sortOrder;
  final Value<String> textValue;
  final Value<int> rowid;
  const DrillTipsCompanion({
    this.id = const Value.absent(),
    this.drillId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.textValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrillTipsCompanion.insert({
    required String id,
    required String drillId,
    required int sortOrder,
    required String textValue,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        drillId = Value(drillId),
        sortOrder = Value(sortOrder),
        textValue = Value(textValue);
  static Insertable<DrillTip> custom({
    Expression<String>? id,
    Expression<String>? drillId,
    Expression<int>? sortOrder,
    Expression<String>? textValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (drillId != null) 'drill_id': drillId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (textValue != null) 'text_value': textValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrillTipsCompanion copyWith(
      {Value<String>? id,
      Value<String>? drillId,
      Value<int>? sortOrder,
      Value<String>? textValue,
      Value<int>? rowid}) {
    return DrillTipsCompanion(
      id: id ?? this.id,
      drillId: drillId ?? this.drillId,
      sortOrder: sortOrder ?? this.sortOrder,
      textValue: textValue ?? this.textValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (drillId.present) {
      map['drill_id'] = Variable<String>(drillId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (textValue.present) {
      map['text_value'] = Variable<String>(textValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrillTipsCompanion(')
          ..write('id: $id, ')
          ..write('drillId: $drillId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('textValue: $textValue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DrillErrorsTable extends DrillErrors
    with TableInfo<$DrillErrorsTable, DrillError> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrillErrorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _drillIdMeta =
      const VerificationMeta('drillId');
  @override
  late final GeneratedColumn<String> drillId = GeneratedColumn<String>(
      'drill_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES drills (id)'));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _textValueMeta =
      const VerificationMeta('textValue');
  @override
  late final GeneratedColumn<String> textValue = GeneratedColumn<String>(
      'text_value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, drillId, sortOrder, textValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drill_errors';
  @override
  VerificationContext validateIntegrity(Insertable<DrillError> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('drill_id')) {
      context.handle(_drillIdMeta,
          drillId.isAcceptableOrUnknown(data['drill_id']!, _drillIdMeta));
    } else if (isInserting) {
      context.missing(_drillIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('text_value')) {
      context.handle(_textValueMeta,
          textValue.isAcceptableOrUnknown(data['text_value']!, _textValueMeta));
    } else if (isInserting) {
      context.missing(_textValueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrillError map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrillError(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      drillId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}drill_id'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      textValue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_value'])!,
    );
  }

  @override
  $DrillErrorsTable createAlias(String alias) {
    return $DrillErrorsTable(attachedDatabase, alias);
  }
}

class DrillError extends DataClass implements Insertable<DrillError> {
  final String id;
  final String drillId;
  final int sortOrder;
  final String textValue;
  const DrillError(
      {required this.id,
      required this.drillId,
      required this.sortOrder,
      required this.textValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['drill_id'] = Variable<String>(drillId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['text_value'] = Variable<String>(textValue);
    return map;
  }

  DrillErrorsCompanion toCompanion(bool nullToAbsent) {
    return DrillErrorsCompanion(
      id: Value(id),
      drillId: Value(drillId),
      sortOrder: Value(sortOrder),
      textValue: Value(textValue),
    );
  }

  factory DrillError.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrillError(
      id: serializer.fromJson<String>(json['id']),
      drillId: serializer.fromJson<String>(json['drillId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      textValue: serializer.fromJson<String>(json['textValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'drillId': serializer.toJson<String>(drillId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'textValue': serializer.toJson<String>(textValue),
    };
  }

  DrillError copyWith(
          {String? id, String? drillId, int? sortOrder, String? textValue}) =>
      DrillError(
        id: id ?? this.id,
        drillId: drillId ?? this.drillId,
        sortOrder: sortOrder ?? this.sortOrder,
        textValue: textValue ?? this.textValue,
      );
  DrillError copyWithCompanion(DrillErrorsCompanion data) {
    return DrillError(
      id: data.id.present ? data.id.value : this.id,
      drillId: data.drillId.present ? data.drillId.value : this.drillId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      textValue: data.textValue.present ? data.textValue.value : this.textValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrillError(')
          ..write('id: $id, ')
          ..write('drillId: $drillId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('textValue: $textValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, drillId, sortOrder, textValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrillError &&
          other.id == this.id &&
          other.drillId == this.drillId &&
          other.sortOrder == this.sortOrder &&
          other.textValue == this.textValue);
}

class DrillErrorsCompanion extends UpdateCompanion<DrillError> {
  final Value<String> id;
  final Value<String> drillId;
  final Value<int> sortOrder;
  final Value<String> textValue;
  final Value<int> rowid;
  const DrillErrorsCompanion({
    this.id = const Value.absent(),
    this.drillId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.textValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrillErrorsCompanion.insert({
    required String id,
    required String drillId,
    required int sortOrder,
    required String textValue,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        drillId = Value(drillId),
        sortOrder = Value(sortOrder),
        textValue = Value(textValue);
  static Insertable<DrillError> custom({
    Expression<String>? id,
    Expression<String>? drillId,
    Expression<int>? sortOrder,
    Expression<String>? textValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (drillId != null) 'drill_id': drillId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (textValue != null) 'text_value': textValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrillErrorsCompanion copyWith(
      {Value<String>? id,
      Value<String>? drillId,
      Value<int>? sortOrder,
      Value<String>? textValue,
      Value<int>? rowid}) {
    return DrillErrorsCompanion(
      id: id ?? this.id,
      drillId: drillId ?? this.drillId,
      sortOrder: sortOrder ?? this.sortOrder,
      textValue: textValue ?? this.textValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (drillId.present) {
      map['drill_id'] = Variable<String>(drillId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (textValue.present) {
      map['text_value'] = Variable<String>(textValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrillErrorsCompanion(')
          ..write('id: $id, ')
          ..write('drillId: $drillId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('textValue: $textValue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DrillVariationsTable extends DrillVariations
    with TableInfo<$DrillVariationsTable, DrillVariation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrillVariationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _drillIdMeta =
      const VerificationMeta('drillId');
  @override
  late final GeneratedColumn<String> drillId = GeneratedColumn<String>(
      'drill_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES drills (id)'));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _textValueMeta =
      const VerificationMeta('textValue');
  @override
  late final GeneratedColumn<String> textValue = GeneratedColumn<String>(
      'text_value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, drillId, sortOrder, textValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drill_variations';
  @override
  VerificationContext validateIntegrity(Insertable<DrillVariation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('drill_id')) {
      context.handle(_drillIdMeta,
          drillId.isAcceptableOrUnknown(data['drill_id']!, _drillIdMeta));
    } else if (isInserting) {
      context.missing(_drillIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('text_value')) {
      context.handle(_textValueMeta,
          textValue.isAcceptableOrUnknown(data['text_value']!, _textValueMeta));
    } else if (isInserting) {
      context.missing(_textValueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrillVariation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrillVariation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      drillId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}drill_id'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      textValue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_value'])!,
    );
  }

  @override
  $DrillVariationsTable createAlias(String alias) {
    return $DrillVariationsTable(attachedDatabase, alias);
  }
}

class DrillVariation extends DataClass implements Insertable<DrillVariation> {
  final String id;
  final String drillId;
  final int sortOrder;
  final String textValue;
  const DrillVariation(
      {required this.id,
      required this.drillId,
      required this.sortOrder,
      required this.textValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['drill_id'] = Variable<String>(drillId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['text_value'] = Variable<String>(textValue);
    return map;
  }

  DrillVariationsCompanion toCompanion(bool nullToAbsent) {
    return DrillVariationsCompanion(
      id: Value(id),
      drillId: Value(drillId),
      sortOrder: Value(sortOrder),
      textValue: Value(textValue),
    );
  }

  factory DrillVariation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrillVariation(
      id: serializer.fromJson<String>(json['id']),
      drillId: serializer.fromJson<String>(json['drillId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      textValue: serializer.fromJson<String>(json['textValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'drillId': serializer.toJson<String>(drillId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'textValue': serializer.toJson<String>(textValue),
    };
  }

  DrillVariation copyWith(
          {String? id, String? drillId, int? sortOrder, String? textValue}) =>
      DrillVariation(
        id: id ?? this.id,
        drillId: drillId ?? this.drillId,
        sortOrder: sortOrder ?? this.sortOrder,
        textValue: textValue ?? this.textValue,
      );
  DrillVariation copyWithCompanion(DrillVariationsCompanion data) {
    return DrillVariation(
      id: data.id.present ? data.id.value : this.id,
      drillId: data.drillId.present ? data.drillId.value : this.drillId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      textValue: data.textValue.present ? data.textValue.value : this.textValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrillVariation(')
          ..write('id: $id, ')
          ..write('drillId: $drillId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('textValue: $textValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, drillId, sortOrder, textValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrillVariation &&
          other.id == this.id &&
          other.drillId == this.drillId &&
          other.sortOrder == this.sortOrder &&
          other.textValue == this.textValue);
}

class DrillVariationsCompanion extends UpdateCompanion<DrillVariation> {
  final Value<String> id;
  final Value<String> drillId;
  final Value<int> sortOrder;
  final Value<String> textValue;
  final Value<int> rowid;
  const DrillVariationsCompanion({
    this.id = const Value.absent(),
    this.drillId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.textValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrillVariationsCompanion.insert({
    required String id,
    required String drillId,
    required int sortOrder,
    required String textValue,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        drillId = Value(drillId),
        sortOrder = Value(sortOrder),
        textValue = Value(textValue);
  static Insertable<DrillVariation> custom({
    Expression<String>? id,
    Expression<String>? drillId,
    Expression<int>? sortOrder,
    Expression<String>? textValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (drillId != null) 'drill_id': drillId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (textValue != null) 'text_value': textValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrillVariationsCompanion copyWith(
      {Value<String>? id,
      Value<String>? drillId,
      Value<int>? sortOrder,
      Value<String>? textValue,
      Value<int>? rowid}) {
    return DrillVariationsCompanion(
      id: id ?? this.id,
      drillId: drillId ?? this.drillId,
      sortOrder: sortOrder ?? this.sortOrder,
      textValue: textValue ?? this.textValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (drillId.present) {
      map['drill_id'] = Variable<String>(drillId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (textValue.present) {
      map['text_value'] = Variable<String>(textValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrillVariationsCompanion(')
          ..write('id: $id, ')
          ..write('drillId: $drillId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('textValue: $textValue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DrillAnimationFramesTable extends DrillAnimationFrames
    with TableInfo<$DrillAnimationFramesTable, DrillAnimationFrame> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrillAnimationFramesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _drillIdMeta =
      const VerificationMeta('drillId');
  @override
  late final GeneratedColumn<String> drillId = GeneratedColumn<String>(
      'drill_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES drills (id)'));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<int> timestamp = GeneratedColumn<int>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _stepIndexMeta =
      const VerificationMeta('stepIndex');
  @override
  late final GeneratedColumn<int> stepIndex = GeneratedColumn<int>(
      'step_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _highlightPlayerIdMeta =
      const VerificationMeta('highlightPlayerId');
  @override
  late final GeneratedColumn<String> highlightPlayerId =
      GeneratedColumn<String>('highlight_player_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _instructionTextMeta =
      const VerificationMeta('instructionText');
  @override
  late final GeneratedColumn<String> instructionText = GeneratedColumn<String>(
      'instruction_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ballXMeta = const VerificationMeta('ballX');
  @override
  late final GeneratedColumn<double> ballX = GeneratedColumn<double>(
      'ball_x', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _ballYMeta = const VerificationMeta('ballY');
  @override
  late final GeneratedColumn<double> ballY = GeneratedColumn<double>(
      'ball_y', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        drillId,
        sortOrder,
        timestamp,
        stepIndex,
        highlightPlayerId,
        instructionText,
        ballX,
        ballY
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drill_animation_frames';
  @override
  VerificationContext validateIntegrity(
      Insertable<DrillAnimationFrame> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('drill_id')) {
      context.handle(_drillIdMeta,
          drillId.isAcceptableOrUnknown(data['drill_id']!, _drillIdMeta));
    } else if (isInserting) {
      context.missing(_drillIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('step_index')) {
      context.handle(_stepIndexMeta,
          stepIndex.isAcceptableOrUnknown(data['step_index']!, _stepIndexMeta));
    } else if (isInserting) {
      context.missing(_stepIndexMeta);
    }
    if (data.containsKey('highlight_player_id')) {
      context.handle(
          _highlightPlayerIdMeta,
          highlightPlayerId.isAcceptableOrUnknown(
              data['highlight_player_id']!, _highlightPlayerIdMeta));
    }
    if (data.containsKey('instruction_text')) {
      context.handle(
          _instructionTextMeta,
          instructionText.isAcceptableOrUnknown(
              data['instruction_text']!, _instructionTextMeta));
    }
    if (data.containsKey('ball_x')) {
      context.handle(
          _ballXMeta, ballX.isAcceptableOrUnknown(data['ball_x']!, _ballXMeta));
    }
    if (data.containsKey('ball_y')) {
      context.handle(
          _ballYMeta, ballY.isAcceptableOrUnknown(data['ball_y']!, _ballYMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrillAnimationFrame map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrillAnimationFrame(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      drillId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}drill_id'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}timestamp'])!,
      stepIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}step_index'])!,
      highlightPlayerId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}highlight_player_id']),
      instructionText: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}instruction_text']),
      ballX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}ball_x']),
      ballY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}ball_y']),
    );
  }

  @override
  $DrillAnimationFramesTable createAlias(String alias) {
    return $DrillAnimationFramesTable(attachedDatabase, alias);
  }
}

class DrillAnimationFrame extends DataClass
    implements Insertable<DrillAnimationFrame> {
  final String id;
  final String drillId;
  final int sortOrder;
  final int timestamp;
  final int stepIndex;
  final String? highlightPlayerId;
  final String? instructionText;
  final double? ballX;
  final double? ballY;
  const DrillAnimationFrame(
      {required this.id,
      required this.drillId,
      required this.sortOrder,
      required this.timestamp,
      required this.stepIndex,
      this.highlightPlayerId,
      this.instructionText,
      this.ballX,
      this.ballY});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['drill_id'] = Variable<String>(drillId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['timestamp'] = Variable<int>(timestamp);
    map['step_index'] = Variable<int>(stepIndex);
    if (!nullToAbsent || highlightPlayerId != null) {
      map['highlight_player_id'] = Variable<String>(highlightPlayerId);
    }
    if (!nullToAbsent || instructionText != null) {
      map['instruction_text'] = Variable<String>(instructionText);
    }
    if (!nullToAbsent || ballX != null) {
      map['ball_x'] = Variable<double>(ballX);
    }
    if (!nullToAbsent || ballY != null) {
      map['ball_y'] = Variable<double>(ballY);
    }
    return map;
  }

  DrillAnimationFramesCompanion toCompanion(bool nullToAbsent) {
    return DrillAnimationFramesCompanion(
      id: Value(id),
      drillId: Value(drillId),
      sortOrder: Value(sortOrder),
      timestamp: Value(timestamp),
      stepIndex: Value(stepIndex),
      highlightPlayerId: highlightPlayerId == null && nullToAbsent
          ? const Value.absent()
          : Value(highlightPlayerId),
      instructionText: instructionText == null && nullToAbsent
          ? const Value.absent()
          : Value(instructionText),
      ballX:
          ballX == null && nullToAbsent ? const Value.absent() : Value(ballX),
      ballY:
          ballY == null && nullToAbsent ? const Value.absent() : Value(ballY),
    );
  }

  factory DrillAnimationFrame.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrillAnimationFrame(
      id: serializer.fromJson<String>(json['id']),
      drillId: serializer.fromJson<String>(json['drillId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      stepIndex: serializer.fromJson<int>(json['stepIndex']),
      highlightPlayerId:
          serializer.fromJson<String?>(json['highlightPlayerId']),
      instructionText: serializer.fromJson<String?>(json['instructionText']),
      ballX: serializer.fromJson<double?>(json['ballX']),
      ballY: serializer.fromJson<double?>(json['ballY']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'drillId': serializer.toJson<String>(drillId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'timestamp': serializer.toJson<int>(timestamp),
      'stepIndex': serializer.toJson<int>(stepIndex),
      'highlightPlayerId': serializer.toJson<String?>(highlightPlayerId),
      'instructionText': serializer.toJson<String?>(instructionText),
      'ballX': serializer.toJson<double?>(ballX),
      'ballY': serializer.toJson<double?>(ballY),
    };
  }

  DrillAnimationFrame copyWith(
          {String? id,
          String? drillId,
          int? sortOrder,
          int? timestamp,
          int? stepIndex,
          Value<String?> highlightPlayerId = const Value.absent(),
          Value<String?> instructionText = const Value.absent(),
          Value<double?> ballX = const Value.absent(),
          Value<double?> ballY = const Value.absent()}) =>
      DrillAnimationFrame(
        id: id ?? this.id,
        drillId: drillId ?? this.drillId,
        sortOrder: sortOrder ?? this.sortOrder,
        timestamp: timestamp ?? this.timestamp,
        stepIndex: stepIndex ?? this.stepIndex,
        highlightPlayerId: highlightPlayerId.present
            ? highlightPlayerId.value
            : this.highlightPlayerId,
        instructionText: instructionText.present
            ? instructionText.value
            : this.instructionText,
        ballX: ballX.present ? ballX.value : this.ballX,
        ballY: ballY.present ? ballY.value : this.ballY,
      );
  DrillAnimationFrame copyWithCompanion(DrillAnimationFramesCompanion data) {
    return DrillAnimationFrame(
      id: data.id.present ? data.id.value : this.id,
      drillId: data.drillId.present ? data.drillId.value : this.drillId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      stepIndex: data.stepIndex.present ? data.stepIndex.value : this.stepIndex,
      highlightPlayerId: data.highlightPlayerId.present
          ? data.highlightPlayerId.value
          : this.highlightPlayerId,
      instructionText: data.instructionText.present
          ? data.instructionText.value
          : this.instructionText,
      ballX: data.ballX.present ? data.ballX.value : this.ballX,
      ballY: data.ballY.present ? data.ballY.value : this.ballY,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrillAnimationFrame(')
          ..write('id: $id, ')
          ..write('drillId: $drillId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('timestamp: $timestamp, ')
          ..write('stepIndex: $stepIndex, ')
          ..write('highlightPlayerId: $highlightPlayerId, ')
          ..write('instructionText: $instructionText, ')
          ..write('ballX: $ballX, ')
          ..write('ballY: $ballY')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, drillId, sortOrder, timestamp, stepIndex,
      highlightPlayerId, instructionText, ballX, ballY);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrillAnimationFrame &&
          other.id == this.id &&
          other.drillId == this.drillId &&
          other.sortOrder == this.sortOrder &&
          other.timestamp == this.timestamp &&
          other.stepIndex == this.stepIndex &&
          other.highlightPlayerId == this.highlightPlayerId &&
          other.instructionText == this.instructionText &&
          other.ballX == this.ballX &&
          other.ballY == this.ballY);
}

class DrillAnimationFramesCompanion
    extends UpdateCompanion<DrillAnimationFrame> {
  final Value<String> id;
  final Value<String> drillId;
  final Value<int> sortOrder;
  final Value<int> timestamp;
  final Value<int> stepIndex;
  final Value<String?> highlightPlayerId;
  final Value<String?> instructionText;
  final Value<double?> ballX;
  final Value<double?> ballY;
  final Value<int> rowid;
  const DrillAnimationFramesCompanion({
    this.id = const Value.absent(),
    this.drillId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.stepIndex = const Value.absent(),
    this.highlightPlayerId = const Value.absent(),
    this.instructionText = const Value.absent(),
    this.ballX = const Value.absent(),
    this.ballY = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrillAnimationFramesCompanion.insert({
    required String id,
    required String drillId,
    required int sortOrder,
    required int timestamp,
    required int stepIndex,
    this.highlightPlayerId = const Value.absent(),
    this.instructionText = const Value.absent(),
    this.ballX = const Value.absent(),
    this.ballY = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        drillId = Value(drillId),
        sortOrder = Value(sortOrder),
        timestamp = Value(timestamp),
        stepIndex = Value(stepIndex);
  static Insertable<DrillAnimationFrame> custom({
    Expression<String>? id,
    Expression<String>? drillId,
    Expression<int>? sortOrder,
    Expression<int>? timestamp,
    Expression<int>? stepIndex,
    Expression<String>? highlightPlayerId,
    Expression<String>? instructionText,
    Expression<double>? ballX,
    Expression<double>? ballY,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (drillId != null) 'drill_id': drillId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (timestamp != null) 'timestamp': timestamp,
      if (stepIndex != null) 'step_index': stepIndex,
      if (highlightPlayerId != null) 'highlight_player_id': highlightPlayerId,
      if (instructionText != null) 'instruction_text': instructionText,
      if (ballX != null) 'ball_x': ballX,
      if (ballY != null) 'ball_y': ballY,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrillAnimationFramesCompanion copyWith(
      {Value<String>? id,
      Value<String>? drillId,
      Value<int>? sortOrder,
      Value<int>? timestamp,
      Value<int>? stepIndex,
      Value<String?>? highlightPlayerId,
      Value<String?>? instructionText,
      Value<double?>? ballX,
      Value<double?>? ballY,
      Value<int>? rowid}) {
    return DrillAnimationFramesCompanion(
      id: id ?? this.id,
      drillId: drillId ?? this.drillId,
      sortOrder: sortOrder ?? this.sortOrder,
      timestamp: timestamp ?? this.timestamp,
      stepIndex: stepIndex ?? this.stepIndex,
      highlightPlayerId: highlightPlayerId ?? this.highlightPlayerId,
      instructionText: instructionText ?? this.instructionText,
      ballX: ballX ?? this.ballX,
      ballY: ballY ?? this.ballY,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (drillId.present) {
      map['drill_id'] = Variable<String>(drillId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (stepIndex.present) {
      map['step_index'] = Variable<int>(stepIndex.value);
    }
    if (highlightPlayerId.present) {
      map['highlight_player_id'] = Variable<String>(highlightPlayerId.value);
    }
    if (instructionText.present) {
      map['instruction_text'] = Variable<String>(instructionText.value);
    }
    if (ballX.present) {
      map['ball_x'] = Variable<double>(ballX.value);
    }
    if (ballY.present) {
      map['ball_y'] = Variable<double>(ballY.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrillAnimationFramesCompanion(')
          ..write('id: $id, ')
          ..write('drillId: $drillId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('timestamp: $timestamp, ')
          ..write('stepIndex: $stepIndex, ')
          ..write('highlightPlayerId: $highlightPlayerId, ')
          ..write('instructionText: $instructionText, ')
          ..write('ballX: $ballX, ')
          ..write('ballY: $ballY, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DrillFramePlayersTable extends DrillFramePlayers
    with TableInfo<$DrillFramePlayersTable, DrillFramePlayer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrillFramePlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _frameIdMeta =
      const VerificationMeta('frameId');
  @override
  late final GeneratedColumn<String> frameId = GeneratedColumn<String>(
      'frame_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES drill_animation_frames (id)'));
  static const VerificationMeta _playerIdMeta =
      const VerificationMeta('playerId');
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
      'player_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _xMeta = const VerificationMeta('x');
  @override
  late final GeneratedColumn<double> x = GeneratedColumn<double>(
      'x', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _yMeta = const VerificationMeta('y');
  @override
  late final GeneratedColumn<double> y = GeneratedColumn<double>(
      'y', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, frameId, playerId, x, y];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drill_frame_players';
  @override
  VerificationContext validateIntegrity(Insertable<DrillFramePlayer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('frame_id')) {
      context.handle(_frameIdMeta,
          frameId.isAcceptableOrUnknown(data['frame_id']!, _frameIdMeta));
    } else if (isInserting) {
      context.missing(_frameIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(_playerIdMeta,
          playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta));
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('x')) {
      context.handle(_xMeta, x.isAcceptableOrUnknown(data['x']!, _xMeta));
    } else if (isInserting) {
      context.missing(_xMeta);
    }
    if (data.containsKey('y')) {
      context.handle(_yMeta, y.isAcceptableOrUnknown(data['y']!, _yMeta));
    } else if (isInserting) {
      context.missing(_yMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrillFramePlayer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrillFramePlayer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      frameId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frame_id'])!,
      playerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_id'])!,
      x: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}x'])!,
      y: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}y'])!,
    );
  }

  @override
  $DrillFramePlayersTable createAlias(String alias) {
    return $DrillFramePlayersTable(attachedDatabase, alias);
  }
}

class DrillFramePlayer extends DataClass
    implements Insertable<DrillFramePlayer> {
  final String id;
  final String frameId;
  final String playerId;
  final double x;
  final double y;
  const DrillFramePlayer(
      {required this.id,
      required this.frameId,
      required this.playerId,
      required this.x,
      required this.y});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['frame_id'] = Variable<String>(frameId);
    map['player_id'] = Variable<String>(playerId);
    map['x'] = Variable<double>(x);
    map['y'] = Variable<double>(y);
    return map;
  }

  DrillFramePlayersCompanion toCompanion(bool nullToAbsent) {
    return DrillFramePlayersCompanion(
      id: Value(id),
      frameId: Value(frameId),
      playerId: Value(playerId),
      x: Value(x),
      y: Value(y),
    );
  }

  factory DrillFramePlayer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrillFramePlayer(
      id: serializer.fromJson<String>(json['id']),
      frameId: serializer.fromJson<String>(json['frameId']),
      playerId: serializer.fromJson<String>(json['playerId']),
      x: serializer.fromJson<double>(json['x']),
      y: serializer.fromJson<double>(json['y']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'frameId': serializer.toJson<String>(frameId),
      'playerId': serializer.toJson<String>(playerId),
      'x': serializer.toJson<double>(x),
      'y': serializer.toJson<double>(y),
    };
  }

  DrillFramePlayer copyWith(
          {String? id,
          String? frameId,
          String? playerId,
          double? x,
          double? y}) =>
      DrillFramePlayer(
        id: id ?? this.id,
        frameId: frameId ?? this.frameId,
        playerId: playerId ?? this.playerId,
        x: x ?? this.x,
        y: y ?? this.y,
      );
  DrillFramePlayer copyWithCompanion(DrillFramePlayersCompanion data) {
    return DrillFramePlayer(
      id: data.id.present ? data.id.value : this.id,
      frameId: data.frameId.present ? data.frameId.value : this.frameId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      x: data.x.present ? data.x.value : this.x,
      y: data.y.present ? data.y.value : this.y,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrillFramePlayer(')
          ..write('id: $id, ')
          ..write('frameId: $frameId, ')
          ..write('playerId: $playerId, ')
          ..write('x: $x, ')
          ..write('y: $y')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, frameId, playerId, x, y);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrillFramePlayer &&
          other.id == this.id &&
          other.frameId == this.frameId &&
          other.playerId == this.playerId &&
          other.x == this.x &&
          other.y == this.y);
}

class DrillFramePlayersCompanion extends UpdateCompanion<DrillFramePlayer> {
  final Value<String> id;
  final Value<String> frameId;
  final Value<String> playerId;
  final Value<double> x;
  final Value<double> y;
  final Value<int> rowid;
  const DrillFramePlayersCompanion({
    this.id = const Value.absent(),
    this.frameId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.x = const Value.absent(),
    this.y = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrillFramePlayersCompanion.insert({
    required String id,
    required String frameId,
    required String playerId,
    required double x,
    required double y,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        frameId = Value(frameId),
        playerId = Value(playerId),
        x = Value(x),
        y = Value(y);
  static Insertable<DrillFramePlayer> custom({
    Expression<String>? id,
    Expression<String>? frameId,
    Expression<String>? playerId,
    Expression<double>? x,
    Expression<double>? y,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (frameId != null) 'frame_id': frameId,
      if (playerId != null) 'player_id': playerId,
      if (x != null) 'x': x,
      if (y != null) 'y': y,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrillFramePlayersCompanion copyWith(
      {Value<String>? id,
      Value<String>? frameId,
      Value<String>? playerId,
      Value<double>? x,
      Value<double>? y,
      Value<int>? rowid}) {
    return DrillFramePlayersCompanion(
      id: id ?? this.id,
      frameId: frameId ?? this.frameId,
      playerId: playerId ?? this.playerId,
      x: x ?? this.x,
      y: y ?? this.y,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (frameId.present) {
      map['frame_id'] = Variable<String>(frameId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (x.present) {
      map['x'] = Variable<double>(x.value);
    }
    if (y.present) {
      map['y'] = Variable<double>(y.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrillFramePlayersCompanion(')
          ..write('id: $id, ')
          ..write('frameId: $frameId, ')
          ..write('playerId: $playerId, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DrillFrameMovementsTable extends DrillFrameMovements
    with TableInfo<$DrillFrameMovementsTable, DrillFrameMovement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrillFrameMovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _frameIdMeta =
      const VerificationMeta('frameId');
  @override
  late final GeneratedColumn<String> frameId = GeneratedColumn<String>(
      'frame_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES drill_animation_frames (id)'));
  static const VerificationMeta _playerIdMeta =
      const VerificationMeta('playerId');
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
      'player_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fromXMeta = const VerificationMeta('fromX');
  @override
  late final GeneratedColumn<double> fromX = GeneratedColumn<double>(
      'from_x', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fromYMeta = const VerificationMeta('fromY');
  @override
  late final GeneratedColumn<double> fromY = GeneratedColumn<double>(
      'from_y', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _toXMeta = const VerificationMeta('toX');
  @override
  late final GeneratedColumn<double> toX = GeneratedColumn<double>(
      'to_x', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _toYMeta = const VerificationMeta('toY');
  @override
  late final GeneratedColumn<double> toY = GeneratedColumn<double>(
      'to_y', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, frameId, playerId, fromX, fromY, toX, toY, label];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drill_frame_movements';
  @override
  VerificationContext validateIntegrity(Insertable<DrillFrameMovement> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('frame_id')) {
      context.handle(_frameIdMeta,
          frameId.isAcceptableOrUnknown(data['frame_id']!, _frameIdMeta));
    } else if (isInserting) {
      context.missing(_frameIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(_playerIdMeta,
          playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta));
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('from_x')) {
      context.handle(
          _fromXMeta, fromX.isAcceptableOrUnknown(data['from_x']!, _fromXMeta));
    } else if (isInserting) {
      context.missing(_fromXMeta);
    }
    if (data.containsKey('from_y')) {
      context.handle(
          _fromYMeta, fromY.isAcceptableOrUnknown(data['from_y']!, _fromYMeta));
    } else if (isInserting) {
      context.missing(_fromYMeta);
    }
    if (data.containsKey('to_x')) {
      context.handle(
          _toXMeta, toX.isAcceptableOrUnknown(data['to_x']!, _toXMeta));
    } else if (isInserting) {
      context.missing(_toXMeta);
    }
    if (data.containsKey('to_y')) {
      context.handle(
          _toYMeta, toY.isAcceptableOrUnknown(data['to_y']!, _toYMeta));
    } else if (isInserting) {
      context.missing(_toYMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrillFrameMovement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrillFrameMovement(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      frameId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frame_id'])!,
      playerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_id'])!,
      fromX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}from_x'])!,
      fromY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}from_y'])!,
      toX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}to_x'])!,
      toY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}to_y'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
    );
  }

  @override
  $DrillFrameMovementsTable createAlias(String alias) {
    return $DrillFrameMovementsTable(attachedDatabase, alias);
  }
}

class DrillFrameMovement extends DataClass
    implements Insertable<DrillFrameMovement> {
  final String id;
  final String frameId;
  final String playerId;
  final double fromX;
  final double fromY;
  final double toX;
  final double toY;
  final String label;
  const DrillFrameMovement(
      {required this.id,
      required this.frameId,
      required this.playerId,
      required this.fromX,
      required this.fromY,
      required this.toX,
      required this.toY,
      required this.label});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['frame_id'] = Variable<String>(frameId);
    map['player_id'] = Variable<String>(playerId);
    map['from_x'] = Variable<double>(fromX);
    map['from_y'] = Variable<double>(fromY);
    map['to_x'] = Variable<double>(toX);
    map['to_y'] = Variable<double>(toY);
    map['label'] = Variable<String>(label);
    return map;
  }

  DrillFrameMovementsCompanion toCompanion(bool nullToAbsent) {
    return DrillFrameMovementsCompanion(
      id: Value(id),
      frameId: Value(frameId),
      playerId: Value(playerId),
      fromX: Value(fromX),
      fromY: Value(fromY),
      toX: Value(toX),
      toY: Value(toY),
      label: Value(label),
    );
  }

  factory DrillFrameMovement.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrillFrameMovement(
      id: serializer.fromJson<String>(json['id']),
      frameId: serializer.fromJson<String>(json['frameId']),
      playerId: serializer.fromJson<String>(json['playerId']),
      fromX: serializer.fromJson<double>(json['fromX']),
      fromY: serializer.fromJson<double>(json['fromY']),
      toX: serializer.fromJson<double>(json['toX']),
      toY: serializer.fromJson<double>(json['toY']),
      label: serializer.fromJson<String>(json['label']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'frameId': serializer.toJson<String>(frameId),
      'playerId': serializer.toJson<String>(playerId),
      'fromX': serializer.toJson<double>(fromX),
      'fromY': serializer.toJson<double>(fromY),
      'toX': serializer.toJson<double>(toX),
      'toY': serializer.toJson<double>(toY),
      'label': serializer.toJson<String>(label),
    };
  }

  DrillFrameMovement copyWith(
          {String? id,
          String? frameId,
          String? playerId,
          double? fromX,
          double? fromY,
          double? toX,
          double? toY,
          String? label}) =>
      DrillFrameMovement(
        id: id ?? this.id,
        frameId: frameId ?? this.frameId,
        playerId: playerId ?? this.playerId,
        fromX: fromX ?? this.fromX,
        fromY: fromY ?? this.fromY,
        toX: toX ?? this.toX,
        toY: toY ?? this.toY,
        label: label ?? this.label,
      );
  DrillFrameMovement copyWithCompanion(DrillFrameMovementsCompanion data) {
    return DrillFrameMovement(
      id: data.id.present ? data.id.value : this.id,
      frameId: data.frameId.present ? data.frameId.value : this.frameId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      fromX: data.fromX.present ? data.fromX.value : this.fromX,
      fromY: data.fromY.present ? data.fromY.value : this.fromY,
      toX: data.toX.present ? data.toX.value : this.toX,
      toY: data.toY.present ? data.toY.value : this.toY,
      label: data.label.present ? data.label.value : this.label,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrillFrameMovement(')
          ..write('id: $id, ')
          ..write('frameId: $frameId, ')
          ..write('playerId: $playerId, ')
          ..write('fromX: $fromX, ')
          ..write('fromY: $fromY, ')
          ..write('toX: $toX, ')
          ..write('toY: $toY, ')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, frameId, playerId, fromX, fromY, toX, toY, label);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrillFrameMovement &&
          other.id == this.id &&
          other.frameId == this.frameId &&
          other.playerId == this.playerId &&
          other.fromX == this.fromX &&
          other.fromY == this.fromY &&
          other.toX == this.toX &&
          other.toY == this.toY &&
          other.label == this.label);
}

class DrillFrameMovementsCompanion extends UpdateCompanion<DrillFrameMovement> {
  final Value<String> id;
  final Value<String> frameId;
  final Value<String> playerId;
  final Value<double> fromX;
  final Value<double> fromY;
  final Value<double> toX;
  final Value<double> toY;
  final Value<String> label;
  final Value<int> rowid;
  const DrillFrameMovementsCompanion({
    this.id = const Value.absent(),
    this.frameId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.fromX = const Value.absent(),
    this.fromY = const Value.absent(),
    this.toX = const Value.absent(),
    this.toY = const Value.absent(),
    this.label = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrillFrameMovementsCompanion.insert({
    required String id,
    required String frameId,
    required String playerId,
    required double fromX,
    required double fromY,
    required double toX,
    required double toY,
    required String label,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        frameId = Value(frameId),
        playerId = Value(playerId),
        fromX = Value(fromX),
        fromY = Value(fromY),
        toX = Value(toX),
        toY = Value(toY),
        label = Value(label);
  static Insertable<DrillFrameMovement> custom({
    Expression<String>? id,
    Expression<String>? frameId,
    Expression<String>? playerId,
    Expression<double>? fromX,
    Expression<double>? fromY,
    Expression<double>? toX,
    Expression<double>? toY,
    Expression<String>? label,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (frameId != null) 'frame_id': frameId,
      if (playerId != null) 'player_id': playerId,
      if (fromX != null) 'from_x': fromX,
      if (fromY != null) 'from_y': fromY,
      if (toX != null) 'to_x': toX,
      if (toY != null) 'to_y': toY,
      if (label != null) 'label': label,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrillFrameMovementsCompanion copyWith(
      {Value<String>? id,
      Value<String>? frameId,
      Value<String>? playerId,
      Value<double>? fromX,
      Value<double>? fromY,
      Value<double>? toX,
      Value<double>? toY,
      Value<String>? label,
      Value<int>? rowid}) {
    return DrillFrameMovementsCompanion(
      id: id ?? this.id,
      frameId: frameId ?? this.frameId,
      playerId: playerId ?? this.playerId,
      fromX: fromX ?? this.fromX,
      fromY: fromY ?? this.fromY,
      toX: toX ?? this.toX,
      toY: toY ?? this.toY,
      label: label ?? this.label,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (frameId.present) {
      map['frame_id'] = Variable<String>(frameId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (fromX.present) {
      map['from_x'] = Variable<double>(fromX.value);
    }
    if (fromY.present) {
      map['from_y'] = Variable<double>(fromY.value);
    }
    if (toX.present) {
      map['to_x'] = Variable<double>(toX.value);
    }
    if (toY.present) {
      map['to_y'] = Variable<double>(toY.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrillFrameMovementsCompanion(')
          ..write('id: $id, ')
          ..write('frameId: $frameId, ')
          ..write('playerId: $playerId, ')
          ..write('fromX: $fromX, ')
          ..write('fromY: $fromY, ')
          ..write('toX: $toX, ')
          ..write('toY: $toY, ')
          ..write('label: $label, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DrillFrameZonesTable extends DrillFrameZones
    with TableInfo<$DrillFrameZonesTable, DrillFrameZone> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrillFrameZonesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _frameIdMeta =
      const VerificationMeta('frameId');
  @override
  late final GeneratedColumn<String> frameId = GeneratedColumn<String>(
      'frame_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES drill_animation_frames (id)'));
  static const VerificationMeta _xMeta = const VerificationMeta('x');
  @override
  late final GeneratedColumn<double> x = GeneratedColumn<double>(
      'x', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _yMeta = const VerificationMeta('y');
  @override
  late final GeneratedColumn<double> y = GeneratedColumn<double>(
      'y', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<double> width = GeneratedColumn<double>(
      'width', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
      'height', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, frameId, x, y, width, height, label];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drill_frame_zones';
  @override
  VerificationContext validateIntegrity(Insertable<DrillFrameZone> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('frame_id')) {
      context.handle(_frameIdMeta,
          frameId.isAcceptableOrUnknown(data['frame_id']!, _frameIdMeta));
    } else if (isInserting) {
      context.missing(_frameIdMeta);
    }
    if (data.containsKey('x')) {
      context.handle(_xMeta, x.isAcceptableOrUnknown(data['x']!, _xMeta));
    } else if (isInserting) {
      context.missing(_xMeta);
    }
    if (data.containsKey('y')) {
      context.handle(_yMeta, y.isAcceptableOrUnknown(data['y']!, _yMeta));
    } else if (isInserting) {
      context.missing(_yMeta);
    }
    if (data.containsKey('width')) {
      context.handle(
          _widthMeta, width.isAcceptableOrUnknown(data['width']!, _widthMeta));
    } else if (isInserting) {
      context.missing(_widthMeta);
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrillFrameZone map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrillFrameZone(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      frameId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frame_id'])!,
      x: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}x'])!,
      y: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}y'])!,
      width: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}width'])!,
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
    );
  }

  @override
  $DrillFrameZonesTable createAlias(String alias) {
    return $DrillFrameZonesTable(attachedDatabase, alias);
  }
}

class DrillFrameZone extends DataClass implements Insertable<DrillFrameZone> {
  final String id;
  final String frameId;
  final double x;
  final double y;
  final double width;
  final double height;
  final String label;
  const DrillFrameZone(
      {required this.id,
      required this.frameId,
      required this.x,
      required this.y,
      required this.width,
      required this.height,
      required this.label});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['frame_id'] = Variable<String>(frameId);
    map['x'] = Variable<double>(x);
    map['y'] = Variable<double>(y);
    map['width'] = Variable<double>(width);
    map['height'] = Variable<double>(height);
    map['label'] = Variable<String>(label);
    return map;
  }

  DrillFrameZonesCompanion toCompanion(bool nullToAbsent) {
    return DrillFrameZonesCompanion(
      id: Value(id),
      frameId: Value(frameId),
      x: Value(x),
      y: Value(y),
      width: Value(width),
      height: Value(height),
      label: Value(label),
    );
  }

  factory DrillFrameZone.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrillFrameZone(
      id: serializer.fromJson<String>(json['id']),
      frameId: serializer.fromJson<String>(json['frameId']),
      x: serializer.fromJson<double>(json['x']),
      y: serializer.fromJson<double>(json['y']),
      width: serializer.fromJson<double>(json['width']),
      height: serializer.fromJson<double>(json['height']),
      label: serializer.fromJson<String>(json['label']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'frameId': serializer.toJson<String>(frameId),
      'x': serializer.toJson<double>(x),
      'y': serializer.toJson<double>(y),
      'width': serializer.toJson<double>(width),
      'height': serializer.toJson<double>(height),
      'label': serializer.toJson<String>(label),
    };
  }

  DrillFrameZone copyWith(
          {String? id,
          String? frameId,
          double? x,
          double? y,
          double? width,
          double? height,
          String? label}) =>
      DrillFrameZone(
        id: id ?? this.id,
        frameId: frameId ?? this.frameId,
        x: x ?? this.x,
        y: y ?? this.y,
        width: width ?? this.width,
        height: height ?? this.height,
        label: label ?? this.label,
      );
  DrillFrameZone copyWithCompanion(DrillFrameZonesCompanion data) {
    return DrillFrameZone(
      id: data.id.present ? data.id.value : this.id,
      frameId: data.frameId.present ? data.frameId.value : this.frameId,
      x: data.x.present ? data.x.value : this.x,
      y: data.y.present ? data.y.value : this.y,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      label: data.label.present ? data.label.value : this.label,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrillFrameZone(')
          ..write('id: $id, ')
          ..write('frameId: $frameId, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, frameId, x, y, width, height, label);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrillFrameZone &&
          other.id == this.id &&
          other.frameId == this.frameId &&
          other.x == this.x &&
          other.y == this.y &&
          other.width == this.width &&
          other.height == this.height &&
          other.label == this.label);
}

class DrillFrameZonesCompanion extends UpdateCompanion<DrillFrameZone> {
  final Value<String> id;
  final Value<String> frameId;
  final Value<double> x;
  final Value<double> y;
  final Value<double> width;
  final Value<double> height;
  final Value<String> label;
  final Value<int> rowid;
  const DrillFrameZonesCompanion({
    this.id = const Value.absent(),
    this.frameId = const Value.absent(),
    this.x = const Value.absent(),
    this.y = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.label = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrillFrameZonesCompanion.insert({
    required String id,
    required String frameId,
    required double x,
    required double y,
    required double width,
    required double height,
    required String label,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        frameId = Value(frameId),
        x = Value(x),
        y = Value(y),
        width = Value(width),
        height = Value(height),
        label = Value(label);
  static Insertable<DrillFrameZone> custom({
    Expression<String>? id,
    Expression<String>? frameId,
    Expression<double>? x,
    Expression<double>? y,
    Expression<double>? width,
    Expression<double>? height,
    Expression<String>? label,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (frameId != null) 'frame_id': frameId,
      if (x != null) 'x': x,
      if (y != null) 'y': y,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (label != null) 'label': label,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrillFrameZonesCompanion copyWith(
      {Value<String>? id,
      Value<String>? frameId,
      Value<double>? x,
      Value<double>? y,
      Value<double>? width,
      Value<double>? height,
      Value<String>? label,
      Value<int>? rowid}) {
    return DrillFrameZonesCompanion(
      id: id ?? this.id,
      frameId: frameId ?? this.frameId,
      x: x ?? this.x,
      y: y ?? this.y,
      width: width ?? this.width,
      height: height ?? this.height,
      label: label ?? this.label,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (frameId.present) {
      map['frame_id'] = Variable<String>(frameId.value);
    }
    if (x.present) {
      map['x'] = Variable<double>(x.value);
    }
    if (y.present) {
      map['y'] = Variable<double>(y.value);
    }
    if (width.present) {
      map['width'] = Variable<double>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrillFrameZonesCompanion(')
          ..write('id: $id, ')
          ..write('frameId: $frameId, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('label: $label, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TeamDrawPlayersTable extends TeamDrawPlayers
    with TableInfo<$TeamDrawPlayersTable, TeamDrawPlayer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamDrawPlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
      'position', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
      'level', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, position, level, isActive, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'team_draw_players';
  @override
  VerificationContext validateIntegrity(Insertable<TeamDrawPlayer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TeamDrawPlayer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeamDrawPlayer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}position'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}level'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $TeamDrawPlayersTable createAlias(String alias) {
    return $TeamDrawPlayersTable(attachedDatabase, alias);
  }
}

class TeamDrawPlayer extends DataClass implements Insertable<TeamDrawPlayer> {
  final String id;
  final String name;
  final String position;
  final String level;
  final bool isActive;
  final String createdAt;
  const TeamDrawPlayer(
      {required this.id,
      required this.name,
      required this.position,
      required this.level,
      required this.isActive,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['position'] = Variable<String>(position);
    map['level'] = Variable<String>(level);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  TeamDrawPlayersCompanion toCompanion(bool nullToAbsent) {
    return TeamDrawPlayersCompanion(
      id: Value(id),
      name: Value(name),
      position: Value(position),
      level: Value(level),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory TeamDrawPlayer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeamDrawPlayer(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      position: serializer.fromJson<String>(json['position']),
      level: serializer.fromJson<String>(json['level']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'position': serializer.toJson<String>(position),
      'level': serializer.toJson<String>(level),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  TeamDrawPlayer copyWith(
          {String? id,
          String? name,
          String? position,
          String? level,
          bool? isActive,
          String? createdAt}) =>
      TeamDrawPlayer(
        id: id ?? this.id,
        name: name ?? this.name,
        position: position ?? this.position,
        level: level ?? this.level,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
      );
  TeamDrawPlayer copyWithCompanion(TeamDrawPlayersCompanion data) {
    return TeamDrawPlayer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      position: data.position.present ? data.position.value : this.position,
      level: data.level.present ? data.level.value : this.level,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeamDrawPlayer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('position: $position, ')
          ..write('level: $level, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, position, level, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamDrawPlayer &&
          other.id == this.id &&
          other.name == this.name &&
          other.position == this.position &&
          other.level == this.level &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class TeamDrawPlayersCompanion extends UpdateCompanion<TeamDrawPlayer> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> position;
  final Value<String> level;
  final Value<bool> isActive;
  final Value<String> createdAt;
  final Value<int> rowid;
  const TeamDrawPlayersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.position = const Value.absent(),
    this.level = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TeamDrawPlayersCompanion.insert({
    required String id,
    required String name,
    required String position,
    required String level,
    this.isActive = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        position = Value(position),
        level = Value(level),
        createdAt = Value(createdAt);
  static Insertable<TeamDrawPlayer> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? position,
    Expression<String>? level,
    Expression<bool>? isActive,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (position != null) 'position': position,
      if (level != null) 'level': level,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TeamDrawPlayersCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? position,
      Value<String>? level,
      Value<bool>? isActive,
      Value<String>? createdAt,
      Value<int>? rowid}) {
    return TeamDrawPlayersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      level: level ?? this.level,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamDrawPlayersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('position: $position, ')
          ..write('level: $level, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DrawSessionsTable extends DrawSessions
    with TableInfo<$DrawSessionsTable, DrawSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrawSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contextKeyMeta =
      const VerificationMeta('contextKey');
  @override
  late final GeneratedColumn<String> contextKey = GeneratedColumn<String>(
      'context_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalPlayersMeta =
      const VerificationMeta('totalPlayers');
  @override
  late final GeneratedColumn<int> totalPlayers = GeneratedColumn<int>(
      'total_players', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _numberOfTeamsMeta =
      const VerificationMeta('numberOfTeams');
  @override
  late final GeneratedColumn<int> numberOfTeams = GeneratedColumn<int>(
      'number_of_teams', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _drawModeMeta =
      const VerificationMeta('drawMode');
  @override
  late final GeneratedColumn<String> drawMode = GeneratedColumn<String>(
      'draw_mode', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _oddPlayerHandlingMeta =
      const VerificationMeta('oddPlayerHandling');
  @override
  late final GeneratedColumn<String> oddPlayerHandling =
      GeneratedColumn<String>('odd_player_handling', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        contextKey,
        totalPlayers,
        numberOfTeams,
        drawMode,
        oddPlayerHandling,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'draw_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<DrawSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('context_key')) {
      context.handle(
          _contextKeyMeta,
          contextKey.isAcceptableOrUnknown(
              data['context_key']!, _contextKeyMeta));
    } else if (isInserting) {
      context.missing(_contextKeyMeta);
    }
    if (data.containsKey('total_players')) {
      context.handle(
          _totalPlayersMeta,
          totalPlayers.isAcceptableOrUnknown(
              data['total_players']!, _totalPlayersMeta));
    } else if (isInserting) {
      context.missing(_totalPlayersMeta);
    }
    if (data.containsKey('number_of_teams')) {
      context.handle(
          _numberOfTeamsMeta,
          numberOfTeams.isAcceptableOrUnknown(
              data['number_of_teams']!, _numberOfTeamsMeta));
    } else if (isInserting) {
      context.missing(_numberOfTeamsMeta);
    }
    if (data.containsKey('draw_mode')) {
      context.handle(_drawModeMeta,
          drawMode.isAcceptableOrUnknown(data['draw_mode']!, _drawModeMeta));
    } else if (isInserting) {
      context.missing(_drawModeMeta);
    }
    if (data.containsKey('odd_player_handling')) {
      context.handle(
          _oddPlayerHandlingMeta,
          oddPlayerHandling.isAcceptableOrUnknown(
              data['odd_player_handling']!, _oddPlayerHandlingMeta));
    } else if (isInserting) {
      context.missing(_oddPlayerHandlingMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrawSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrawSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      contextKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}context_key'])!,
      totalPlayers: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_players'])!,
      numberOfTeams: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}number_of_teams'])!,
      drawMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}draw_mode'])!,
      oddPlayerHandling: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}odd_player_handling'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DrawSessionsTable createAlias(String alias) {
    return $DrawSessionsTable(attachedDatabase, alias);
  }
}

class DrawSession extends DataClass implements Insertable<DrawSession> {
  final String id;
  final String contextKey;
  final int totalPlayers;
  final int numberOfTeams;
  final String drawMode;
  final String oddPlayerHandling;
  final String createdAt;
  const DrawSession(
      {required this.id,
      required this.contextKey,
      required this.totalPlayers,
      required this.numberOfTeams,
      required this.drawMode,
      required this.oddPlayerHandling,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['context_key'] = Variable<String>(contextKey);
    map['total_players'] = Variable<int>(totalPlayers);
    map['number_of_teams'] = Variable<int>(numberOfTeams);
    map['draw_mode'] = Variable<String>(drawMode);
    map['odd_player_handling'] = Variable<String>(oddPlayerHandling);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  DrawSessionsCompanion toCompanion(bool nullToAbsent) {
    return DrawSessionsCompanion(
      id: Value(id),
      contextKey: Value(contextKey),
      totalPlayers: Value(totalPlayers),
      numberOfTeams: Value(numberOfTeams),
      drawMode: Value(drawMode),
      oddPlayerHandling: Value(oddPlayerHandling),
      createdAt: Value(createdAt),
    );
  }

  factory DrawSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrawSession(
      id: serializer.fromJson<String>(json['id']),
      contextKey: serializer.fromJson<String>(json['contextKey']),
      totalPlayers: serializer.fromJson<int>(json['totalPlayers']),
      numberOfTeams: serializer.fromJson<int>(json['numberOfTeams']),
      drawMode: serializer.fromJson<String>(json['drawMode']),
      oddPlayerHandling: serializer.fromJson<String>(json['oddPlayerHandling']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'contextKey': serializer.toJson<String>(contextKey),
      'totalPlayers': serializer.toJson<int>(totalPlayers),
      'numberOfTeams': serializer.toJson<int>(numberOfTeams),
      'drawMode': serializer.toJson<String>(drawMode),
      'oddPlayerHandling': serializer.toJson<String>(oddPlayerHandling),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  DrawSession copyWith(
          {String? id,
          String? contextKey,
          int? totalPlayers,
          int? numberOfTeams,
          String? drawMode,
          String? oddPlayerHandling,
          String? createdAt}) =>
      DrawSession(
        id: id ?? this.id,
        contextKey: contextKey ?? this.contextKey,
        totalPlayers: totalPlayers ?? this.totalPlayers,
        numberOfTeams: numberOfTeams ?? this.numberOfTeams,
        drawMode: drawMode ?? this.drawMode,
        oddPlayerHandling: oddPlayerHandling ?? this.oddPlayerHandling,
        createdAt: createdAt ?? this.createdAt,
      );
  DrawSession copyWithCompanion(DrawSessionsCompanion data) {
    return DrawSession(
      id: data.id.present ? data.id.value : this.id,
      contextKey:
          data.contextKey.present ? data.contextKey.value : this.contextKey,
      totalPlayers: data.totalPlayers.present
          ? data.totalPlayers.value
          : this.totalPlayers,
      numberOfTeams: data.numberOfTeams.present
          ? data.numberOfTeams.value
          : this.numberOfTeams,
      drawMode: data.drawMode.present ? data.drawMode.value : this.drawMode,
      oddPlayerHandling: data.oddPlayerHandling.present
          ? data.oddPlayerHandling.value
          : this.oddPlayerHandling,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrawSession(')
          ..write('id: $id, ')
          ..write('contextKey: $contextKey, ')
          ..write('totalPlayers: $totalPlayers, ')
          ..write('numberOfTeams: $numberOfTeams, ')
          ..write('drawMode: $drawMode, ')
          ..write('oddPlayerHandling: $oddPlayerHandling, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, contextKey, totalPlayers, numberOfTeams,
      drawMode, oddPlayerHandling, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrawSession &&
          other.id == this.id &&
          other.contextKey == this.contextKey &&
          other.totalPlayers == this.totalPlayers &&
          other.numberOfTeams == this.numberOfTeams &&
          other.drawMode == this.drawMode &&
          other.oddPlayerHandling == this.oddPlayerHandling &&
          other.createdAt == this.createdAt);
}

class DrawSessionsCompanion extends UpdateCompanion<DrawSession> {
  final Value<String> id;
  final Value<String> contextKey;
  final Value<int> totalPlayers;
  final Value<int> numberOfTeams;
  final Value<String> drawMode;
  final Value<String> oddPlayerHandling;
  final Value<String> createdAt;
  final Value<int> rowid;
  const DrawSessionsCompanion({
    this.id = const Value.absent(),
    this.contextKey = const Value.absent(),
    this.totalPlayers = const Value.absent(),
    this.numberOfTeams = const Value.absent(),
    this.drawMode = const Value.absent(),
    this.oddPlayerHandling = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrawSessionsCompanion.insert({
    required String id,
    required String contextKey,
    required int totalPlayers,
    required int numberOfTeams,
    required String drawMode,
    required String oddPlayerHandling,
    required String createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        contextKey = Value(contextKey),
        totalPlayers = Value(totalPlayers),
        numberOfTeams = Value(numberOfTeams),
        drawMode = Value(drawMode),
        oddPlayerHandling = Value(oddPlayerHandling),
        createdAt = Value(createdAt);
  static Insertable<DrawSession> custom({
    Expression<String>? id,
    Expression<String>? contextKey,
    Expression<int>? totalPlayers,
    Expression<int>? numberOfTeams,
    Expression<String>? drawMode,
    Expression<String>? oddPlayerHandling,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contextKey != null) 'context_key': contextKey,
      if (totalPlayers != null) 'total_players': totalPlayers,
      if (numberOfTeams != null) 'number_of_teams': numberOfTeams,
      if (drawMode != null) 'draw_mode': drawMode,
      if (oddPlayerHandling != null) 'odd_player_handling': oddPlayerHandling,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrawSessionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? contextKey,
      Value<int>? totalPlayers,
      Value<int>? numberOfTeams,
      Value<String>? drawMode,
      Value<String>? oddPlayerHandling,
      Value<String>? createdAt,
      Value<int>? rowid}) {
    return DrawSessionsCompanion(
      id: id ?? this.id,
      contextKey: contextKey ?? this.contextKey,
      totalPlayers: totalPlayers ?? this.totalPlayers,
      numberOfTeams: numberOfTeams ?? this.numberOfTeams,
      drawMode: drawMode ?? this.drawMode,
      oddPlayerHandling: oddPlayerHandling ?? this.oddPlayerHandling,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (contextKey.present) {
      map['context_key'] = Variable<String>(contextKey.value);
    }
    if (totalPlayers.present) {
      map['total_players'] = Variable<int>(totalPlayers.value);
    }
    if (numberOfTeams.present) {
      map['number_of_teams'] = Variable<int>(numberOfTeams.value);
    }
    if (drawMode.present) {
      map['draw_mode'] = Variable<String>(drawMode.value);
    }
    if (oddPlayerHandling.present) {
      map['odd_player_handling'] = Variable<String>(oddPlayerHandling.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrawSessionsCompanion(')
          ..write('id: $id, ')
          ..write('contextKey: $contextKey, ')
          ..write('totalPlayers: $totalPlayers, ')
          ..write('numberOfTeams: $numberOfTeams, ')
          ..write('drawMode: $drawMode, ')
          ..write('oddPlayerHandling: $oddPlayerHandling, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DrawSessionTeamsTable extends DrawSessionTeams
    with TableInfo<$DrawSessionTeamsTable, DrawSessionTeam> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrawSessionTeamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES draw_sessions (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, sessionId, name, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'draw_session_teams';
  @override
  VerificationContext validateIntegrity(Insertable<DrawSessionTeam> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrawSessionTeam map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrawSessionTeam(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $DrawSessionTeamsTable createAlias(String alias) {
    return $DrawSessionTeamsTable(attachedDatabase, alias);
  }
}

class DrawSessionTeam extends DataClass implements Insertable<DrawSessionTeam> {
  final String id;
  final String sessionId;
  final String name;
  final int sortOrder;
  const DrawSessionTeam(
      {required this.id,
      required this.sessionId,
      required this.name,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  DrawSessionTeamsCompanion toCompanion(bool nullToAbsent) {
    return DrawSessionTeamsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      name: Value(name),
      sortOrder: Value(sortOrder),
    );
  }

  factory DrawSessionTeam.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrawSessionTeam(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  DrawSessionTeam copyWith(
          {String? id, String? sessionId, String? name, int? sortOrder}) =>
      DrawSessionTeam(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        name: name ?? this.name,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  DrawSessionTeam copyWithCompanion(DrawSessionTeamsCompanion data) {
    return DrawSessionTeam(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrawSessionTeam(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, name, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrawSessionTeam &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder);
}

class DrawSessionTeamsCompanion extends UpdateCompanion<DrawSessionTeam> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> name;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const DrawSessionTeamsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrawSessionTeamsCompanion.insert({
    required String id,
    required String sessionId,
    required String name,
    required int sortOrder,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sessionId = Value(sessionId),
        name = Value(name),
        sortOrder = Value(sortOrder);
  static Insertable<DrawSessionTeam> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? name,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrawSessionTeamsCompanion copyWith(
      {Value<String>? id,
      Value<String>? sessionId,
      Value<String>? name,
      Value<int>? sortOrder,
      Value<int>? rowid}) {
    return DrawSessionTeamsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrawSessionTeamsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DrawSessionTeamPlayersTable extends DrawSessionTeamPlayers
    with TableInfo<$DrawSessionTeamPlayersTable, DrawSessionTeamPlayer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrawSessionTeamPlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionTeamIdMeta =
      const VerificationMeta('sessionTeamId');
  @override
  late final GeneratedColumn<String> sessionTeamId = GeneratedColumn<String>(
      'session_team_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES draw_session_teams (id)'));
  static const VerificationMeta _playerIdMeta =
      const VerificationMeta('playerId');
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
      'player_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES team_draw_players (id)'));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sessionTeamId, playerId, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'draw_session_team_players';
  @override
  VerificationContext validateIntegrity(
      Insertable<DrawSessionTeamPlayer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_team_id')) {
      context.handle(
          _sessionTeamIdMeta,
          sessionTeamId.isAcceptableOrUnknown(
              data['session_team_id']!, _sessionTeamIdMeta));
    } else if (isInserting) {
      context.missing(_sessionTeamIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(_playerIdMeta,
          playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta));
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrawSessionTeamPlayer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrawSessionTeamPlayer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sessionTeamId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}session_team_id'])!,
      playerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_id'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $DrawSessionTeamPlayersTable createAlias(String alias) {
    return $DrawSessionTeamPlayersTable(attachedDatabase, alias);
  }
}

class DrawSessionTeamPlayer extends DataClass
    implements Insertable<DrawSessionTeamPlayer> {
  final String id;
  final String sessionTeamId;
  final String playerId;
  final int sortOrder;
  const DrawSessionTeamPlayer(
      {required this.id,
      required this.sessionTeamId,
      required this.playerId,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_team_id'] = Variable<String>(sessionTeamId);
    map['player_id'] = Variable<String>(playerId);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  DrawSessionTeamPlayersCompanion toCompanion(bool nullToAbsent) {
    return DrawSessionTeamPlayersCompanion(
      id: Value(id),
      sessionTeamId: Value(sessionTeamId),
      playerId: Value(playerId),
      sortOrder: Value(sortOrder),
    );
  }

  factory DrawSessionTeamPlayer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrawSessionTeamPlayer(
      id: serializer.fromJson<String>(json['id']),
      sessionTeamId: serializer.fromJson<String>(json['sessionTeamId']),
      playerId: serializer.fromJson<String>(json['playerId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionTeamId': serializer.toJson<String>(sessionTeamId),
      'playerId': serializer.toJson<String>(playerId),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  DrawSessionTeamPlayer copyWith(
          {String? id,
          String? sessionTeamId,
          String? playerId,
          int? sortOrder}) =>
      DrawSessionTeamPlayer(
        id: id ?? this.id,
        sessionTeamId: sessionTeamId ?? this.sessionTeamId,
        playerId: playerId ?? this.playerId,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  DrawSessionTeamPlayer copyWithCompanion(
      DrawSessionTeamPlayersCompanion data) {
    return DrawSessionTeamPlayer(
      id: data.id.present ? data.id.value : this.id,
      sessionTeamId: data.sessionTeamId.present
          ? data.sessionTeamId.value
          : this.sessionTeamId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrawSessionTeamPlayer(')
          ..write('id: $id, ')
          ..write('sessionTeamId: $sessionTeamId, ')
          ..write('playerId: $playerId, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionTeamId, playerId, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrawSessionTeamPlayer &&
          other.id == this.id &&
          other.sessionTeamId == this.sessionTeamId &&
          other.playerId == this.playerId &&
          other.sortOrder == this.sortOrder);
}

class DrawSessionTeamPlayersCompanion
    extends UpdateCompanion<DrawSessionTeamPlayer> {
  final Value<String> id;
  final Value<String> sessionTeamId;
  final Value<String> playerId;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const DrawSessionTeamPlayersCompanion({
    this.id = const Value.absent(),
    this.sessionTeamId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrawSessionTeamPlayersCompanion.insert({
    required String id,
    required String sessionTeamId,
    required String playerId,
    required int sortOrder,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sessionTeamId = Value(sessionTeamId),
        playerId = Value(playerId),
        sortOrder = Value(sortOrder);
  static Insertable<DrawSessionTeamPlayer> custom({
    Expression<String>? id,
    Expression<String>? sessionTeamId,
    Expression<String>? playerId,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionTeamId != null) 'session_team_id': sessionTeamId,
      if (playerId != null) 'player_id': playerId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrawSessionTeamPlayersCompanion copyWith(
      {Value<String>? id,
      Value<String>? sessionTeamId,
      Value<String>? playerId,
      Value<int>? sortOrder,
      Value<int>? rowid}) {
    return DrawSessionTeamPlayersCompanion(
      id: id ?? this.id,
      sessionTeamId: sessionTeamId ?? this.sessionTeamId,
      playerId: playerId ?? this.playerId,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionTeamId.present) {
      map['session_team_id'] = Variable<String>(sessionTeamId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrawSessionTeamPlayersCompanion(')
          ..write('id: $id, ')
          ..write('sessionTeamId: $sessionTeamId, ')
          ..write('playerId: $playerId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WaitingQueueEntriesTable extends WaitingQueueEntries
    with TableInfo<$WaitingQueueEntriesTable, WaitingQueueEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WaitingQueueEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contextKeyMeta =
      const VerificationMeta('contextKey');
  @override
  late final GeneratedColumn<String> contextKey = GeneratedColumn<String>(
      'context_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _playerIdMeta =
      const VerificationMeta('playerId');
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
      'player_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES team_draw_players (id)'));
  static const VerificationMeta _playerNameMeta =
      const VerificationMeta('playerName');
  @override
  late final GeneratedColumn<String> playerName = GeneratedColumn<String>(
      'player_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _waitingSinceMeta =
      const VerificationMeta('waitingSince');
  @override
  late final GeneratedColumn<String> waitingSince = GeneratedColumn<String>(
      'waiting_since', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priorityOrderMeta =
      const VerificationMeta('priorityOrder');
  @override
  late final GeneratedColumn<int> priorityOrder = GeneratedColumn<int>(
      'priority_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastSessionIdMeta =
      const VerificationMeta('lastSessionId');
  @override
  late final GeneratedColumn<String> lastSessionId = GeneratedColumn<String>(
      'last_session_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        contextKey,
        playerId,
        playerName,
        waitingSince,
        priorityOrder,
        lastSessionId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'waiting_queue_entries';
  @override
  VerificationContext validateIntegrity(Insertable<WaitingQueueEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('context_key')) {
      context.handle(
          _contextKeyMeta,
          contextKey.isAcceptableOrUnknown(
              data['context_key']!, _contextKeyMeta));
    } else if (isInserting) {
      context.missing(_contextKeyMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(_playerIdMeta,
          playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta));
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('player_name')) {
      context.handle(
          _playerNameMeta,
          playerName.isAcceptableOrUnknown(
              data['player_name']!, _playerNameMeta));
    } else if (isInserting) {
      context.missing(_playerNameMeta);
    }
    if (data.containsKey('waiting_since')) {
      context.handle(
          _waitingSinceMeta,
          waitingSince.isAcceptableOrUnknown(
              data['waiting_since']!, _waitingSinceMeta));
    } else if (isInserting) {
      context.missing(_waitingSinceMeta);
    }
    if (data.containsKey('priority_order')) {
      context.handle(
          _priorityOrderMeta,
          priorityOrder.isAcceptableOrUnknown(
              data['priority_order']!, _priorityOrderMeta));
    } else if (isInserting) {
      context.missing(_priorityOrderMeta);
    }
    if (data.containsKey('last_session_id')) {
      context.handle(
          _lastSessionIdMeta,
          lastSessionId.isAcceptableOrUnknown(
              data['last_session_id']!, _lastSessionIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WaitingQueueEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WaitingQueueEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      contextKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}context_key'])!,
      playerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_id'])!,
      playerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_name'])!,
      waitingSince: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}waiting_since'])!,
      priorityOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority_order'])!,
      lastSessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_session_id']),
    );
  }

  @override
  $WaitingQueueEntriesTable createAlias(String alias) {
    return $WaitingQueueEntriesTable(attachedDatabase, alias);
  }
}

class WaitingQueueEntry extends DataClass
    implements Insertable<WaitingQueueEntry> {
  final String id;
  final String contextKey;
  final String playerId;
  final String playerName;
  final String waitingSince;
  final int priorityOrder;
  final String? lastSessionId;
  const WaitingQueueEntry(
      {required this.id,
      required this.contextKey,
      required this.playerId,
      required this.playerName,
      required this.waitingSince,
      required this.priorityOrder,
      this.lastSessionId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['context_key'] = Variable<String>(contextKey);
    map['player_id'] = Variable<String>(playerId);
    map['player_name'] = Variable<String>(playerName);
    map['waiting_since'] = Variable<String>(waitingSince);
    map['priority_order'] = Variable<int>(priorityOrder);
    if (!nullToAbsent || lastSessionId != null) {
      map['last_session_id'] = Variable<String>(lastSessionId);
    }
    return map;
  }

  WaitingQueueEntriesCompanion toCompanion(bool nullToAbsent) {
    return WaitingQueueEntriesCompanion(
      id: Value(id),
      contextKey: Value(contextKey),
      playerId: Value(playerId),
      playerName: Value(playerName),
      waitingSince: Value(waitingSince),
      priorityOrder: Value(priorityOrder),
      lastSessionId: lastSessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSessionId),
    );
  }

  factory WaitingQueueEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WaitingQueueEntry(
      id: serializer.fromJson<String>(json['id']),
      contextKey: serializer.fromJson<String>(json['contextKey']),
      playerId: serializer.fromJson<String>(json['playerId']),
      playerName: serializer.fromJson<String>(json['playerName']),
      waitingSince: serializer.fromJson<String>(json['waitingSince']),
      priorityOrder: serializer.fromJson<int>(json['priorityOrder']),
      lastSessionId: serializer.fromJson<String?>(json['lastSessionId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'contextKey': serializer.toJson<String>(contextKey),
      'playerId': serializer.toJson<String>(playerId),
      'playerName': serializer.toJson<String>(playerName),
      'waitingSince': serializer.toJson<String>(waitingSince),
      'priorityOrder': serializer.toJson<int>(priorityOrder),
      'lastSessionId': serializer.toJson<String?>(lastSessionId),
    };
  }

  WaitingQueueEntry copyWith(
          {String? id,
          String? contextKey,
          String? playerId,
          String? playerName,
          String? waitingSince,
          int? priorityOrder,
          Value<String?> lastSessionId = const Value.absent()}) =>
      WaitingQueueEntry(
        id: id ?? this.id,
        contextKey: contextKey ?? this.contextKey,
        playerId: playerId ?? this.playerId,
        playerName: playerName ?? this.playerName,
        waitingSince: waitingSince ?? this.waitingSince,
        priorityOrder: priorityOrder ?? this.priorityOrder,
        lastSessionId:
            lastSessionId.present ? lastSessionId.value : this.lastSessionId,
      );
  WaitingQueueEntry copyWithCompanion(WaitingQueueEntriesCompanion data) {
    return WaitingQueueEntry(
      id: data.id.present ? data.id.value : this.id,
      contextKey:
          data.contextKey.present ? data.contextKey.value : this.contextKey,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      playerName:
          data.playerName.present ? data.playerName.value : this.playerName,
      waitingSince: data.waitingSince.present
          ? data.waitingSince.value
          : this.waitingSince,
      priorityOrder: data.priorityOrder.present
          ? data.priorityOrder.value
          : this.priorityOrder,
      lastSessionId: data.lastSessionId.present
          ? data.lastSessionId.value
          : this.lastSessionId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WaitingQueueEntry(')
          ..write('id: $id, ')
          ..write('contextKey: $contextKey, ')
          ..write('playerId: $playerId, ')
          ..write('playerName: $playerName, ')
          ..write('waitingSince: $waitingSince, ')
          ..write('priorityOrder: $priorityOrder, ')
          ..write('lastSessionId: $lastSessionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, contextKey, playerId, playerName,
      waitingSince, priorityOrder, lastSessionId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WaitingQueueEntry &&
          other.id == this.id &&
          other.contextKey == this.contextKey &&
          other.playerId == this.playerId &&
          other.playerName == this.playerName &&
          other.waitingSince == this.waitingSince &&
          other.priorityOrder == this.priorityOrder &&
          other.lastSessionId == this.lastSessionId);
}

class WaitingQueueEntriesCompanion extends UpdateCompanion<WaitingQueueEntry> {
  final Value<String> id;
  final Value<String> contextKey;
  final Value<String> playerId;
  final Value<String> playerName;
  final Value<String> waitingSince;
  final Value<int> priorityOrder;
  final Value<String?> lastSessionId;
  final Value<int> rowid;
  const WaitingQueueEntriesCompanion({
    this.id = const Value.absent(),
    this.contextKey = const Value.absent(),
    this.playerId = const Value.absent(),
    this.playerName = const Value.absent(),
    this.waitingSince = const Value.absent(),
    this.priorityOrder = const Value.absent(),
    this.lastSessionId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WaitingQueueEntriesCompanion.insert({
    required String id,
    required String contextKey,
    required String playerId,
    required String playerName,
    required String waitingSince,
    required int priorityOrder,
    this.lastSessionId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        contextKey = Value(contextKey),
        playerId = Value(playerId),
        playerName = Value(playerName),
        waitingSince = Value(waitingSince),
        priorityOrder = Value(priorityOrder);
  static Insertable<WaitingQueueEntry> custom({
    Expression<String>? id,
    Expression<String>? contextKey,
    Expression<String>? playerId,
    Expression<String>? playerName,
    Expression<String>? waitingSince,
    Expression<int>? priorityOrder,
    Expression<String>? lastSessionId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contextKey != null) 'context_key': contextKey,
      if (playerId != null) 'player_id': playerId,
      if (playerName != null) 'player_name': playerName,
      if (waitingSince != null) 'waiting_since': waitingSince,
      if (priorityOrder != null) 'priority_order': priorityOrder,
      if (lastSessionId != null) 'last_session_id': lastSessionId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WaitingQueueEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? contextKey,
      Value<String>? playerId,
      Value<String>? playerName,
      Value<String>? waitingSince,
      Value<int>? priorityOrder,
      Value<String?>? lastSessionId,
      Value<int>? rowid}) {
    return WaitingQueueEntriesCompanion(
      id: id ?? this.id,
      contextKey: contextKey ?? this.contextKey,
      playerId: playerId ?? this.playerId,
      playerName: playerName ?? this.playerName,
      waitingSince: waitingSince ?? this.waitingSince,
      priorityOrder: priorityOrder ?? this.priorityOrder,
      lastSessionId: lastSessionId ?? this.lastSessionId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (contextKey.present) {
      map['context_key'] = Variable<String>(contextKey.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (playerName.present) {
      map['player_name'] = Variable<String>(playerName.value);
    }
    if (waitingSince.present) {
      map['waiting_since'] = Variable<String>(waitingSince.value);
    }
    if (priorityOrder.present) {
      map['priority_order'] = Variable<int>(priorityOrder.value);
    }
    if (lastSessionId.present) {
      map['last_session_id'] = Variable<String>(lastSessionId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WaitingQueueEntriesCompanion(')
          ..write('id: $id, ')
          ..write('contextKey: $contextKey, ')
          ..write('playerId: $playerId, ')
          ..write('playerName: $playerName, ')
          ..write('waitingSince: $waitingSince, ')
          ..write('priorityOrder: $priorityOrder, ')
          ..write('lastSessionId: $lastSessionId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavedTeamGroupsTable extends SavedTeamGroups
    with TableInfo<$SavedTeamGroupsTable, SavedTeamGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedTeamGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceTypeMeta =
      const VerificationMeta('sourceType');
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
      'source_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contextKeyMeta =
      const VerificationMeta('contextKey');
  @override
  late final GeneratedColumn<String> contextKey = GeneratedColumn<String>(
      'context_key', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, sourceType, contextKey, notes, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_team_groups';
  @override
  VerificationContext validateIntegrity(Insertable<SavedTeamGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('source_type')) {
      context.handle(
          _sourceTypeMeta,
          sourceType.isAcceptableOrUnknown(
              data['source_type']!, _sourceTypeMeta));
    } else if (isInserting) {
      context.missing(_sourceTypeMeta);
    }
    if (data.containsKey('context_key')) {
      context.handle(
          _contextKeyMeta,
          contextKey.isAcceptableOrUnknown(
              data['context_key']!, _contextKeyMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedTeamGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedTeamGroup(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      sourceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_type'])!,
      contextKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}context_key']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SavedTeamGroupsTable createAlias(String alias) {
    return $SavedTeamGroupsTable(attachedDatabase, alias);
  }
}

class SavedTeamGroup extends DataClass implements Insertable<SavedTeamGroup> {
  final String id;
  final String title;
  final String sourceType;
  final String? contextKey;
  final String? notes;
  final String createdAt;
  const SavedTeamGroup(
      {required this.id,
      required this.title,
      required this.sourceType,
      this.contextKey,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['source_type'] = Variable<String>(sourceType);
    if (!nullToAbsent || contextKey != null) {
      map['context_key'] = Variable<String>(contextKey);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  SavedTeamGroupsCompanion toCompanion(bool nullToAbsent) {
    return SavedTeamGroupsCompanion(
      id: Value(id),
      title: Value(title),
      sourceType: Value(sourceType),
      contextKey: contextKey == null && nullToAbsent
          ? const Value.absent()
          : Value(contextKey),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory SavedTeamGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedTeamGroup(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      contextKey: serializer.fromJson<String?>(json['contextKey']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'sourceType': serializer.toJson<String>(sourceType),
      'contextKey': serializer.toJson<String?>(contextKey),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  SavedTeamGroup copyWith(
          {String? id,
          String? title,
          String? sourceType,
          Value<String?> contextKey = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          String? createdAt}) =>
      SavedTeamGroup(
        id: id ?? this.id,
        title: title ?? this.title,
        sourceType: sourceType ?? this.sourceType,
        contextKey: contextKey.present ? contextKey.value : this.contextKey,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  SavedTeamGroup copyWithCompanion(SavedTeamGroupsCompanion data) {
    return SavedTeamGroup(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      sourceType:
          data.sourceType.present ? data.sourceType.value : this.sourceType,
      contextKey:
          data.contextKey.present ? data.contextKey.value : this.contextKey,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedTeamGroup(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('sourceType: $sourceType, ')
          ..write('contextKey: $contextKey, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, sourceType, contextKey, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedTeamGroup &&
          other.id == this.id &&
          other.title == this.title &&
          other.sourceType == this.sourceType &&
          other.contextKey == this.contextKey &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class SavedTeamGroupsCompanion extends UpdateCompanion<SavedTeamGroup> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> sourceType;
  final Value<String?> contextKey;
  final Value<String?> notes;
  final Value<String> createdAt;
  final Value<int> rowid;
  const SavedTeamGroupsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.contextKey = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavedTeamGroupsCompanion.insert({
    required String id,
    required String title,
    required String sourceType,
    this.contextKey = const Value.absent(),
    this.notes = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        sourceType = Value(sourceType),
        createdAt = Value(createdAt);
  static Insertable<SavedTeamGroup> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? sourceType,
    Expression<String>? contextKey,
    Expression<String>? notes,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (sourceType != null) 'source_type': sourceType,
      if (contextKey != null) 'context_key': contextKey,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavedTeamGroupsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? sourceType,
      Value<String?>? contextKey,
      Value<String?>? notes,
      Value<String>? createdAt,
      Value<int>? rowid}) {
    return SavedTeamGroupsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      sourceType: sourceType ?? this.sourceType,
      contextKey: contextKey ?? this.contextKey,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (contextKey.present) {
      map['context_key'] = Variable<String>(contextKey.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedTeamGroupsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('sourceType: $sourceType, ')
          ..write('contextKey: $contextKey, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavedTeamsTable extends SavedTeams
    with TableInfo<$SavedTeamsTable, SavedTeam> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedTeamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES saved_team_groups (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, groupId, name, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_teams';
  @override
  VerificationContext validateIntegrity(Insertable<SavedTeam> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedTeam map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedTeam(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $SavedTeamsTable createAlias(String alias) {
    return $SavedTeamsTable(attachedDatabase, alias);
  }
}

class SavedTeam extends DataClass implements Insertable<SavedTeam> {
  final String id;
  final String groupId;
  final String name;
  final int sortOrder;
  const SavedTeam(
      {required this.id,
      required this.groupId,
      required this.name,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['group_id'] = Variable<String>(groupId);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  SavedTeamsCompanion toCompanion(bool nullToAbsent) {
    return SavedTeamsCompanion(
      id: Value(id),
      groupId: Value(groupId),
      name: Value(name),
      sortOrder: Value(sortOrder),
    );
  }

  factory SavedTeam.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedTeam(
      id: serializer.fromJson<String>(json['id']),
      groupId: serializer.fromJson<String>(json['groupId']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'groupId': serializer.toJson<String>(groupId),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  SavedTeam copyWith(
          {String? id, String? groupId, String? name, int? sortOrder}) =>
      SavedTeam(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        name: name ?? this.name,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  SavedTeam copyWithCompanion(SavedTeamsCompanion data) {
    return SavedTeam(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedTeam(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupId, name, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedTeam &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder);
}

class SavedTeamsCompanion extends UpdateCompanion<SavedTeam> {
  final Value<String> id;
  final Value<String> groupId;
  final Value<String> name;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const SavedTeamsCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavedTeamsCompanion.insert({
    required String id,
    required String groupId,
    required String name,
    required int sortOrder,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        groupId = Value(groupId),
        name = Value(name),
        sortOrder = Value(sortOrder);
  static Insertable<SavedTeam> custom({
    Expression<String>? id,
    Expression<String>? groupId,
    Expression<String>? name,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavedTeamsCompanion copyWith(
      {Value<String>? id,
      Value<String>? groupId,
      Value<String>? name,
      Value<int>? sortOrder,
      Value<int>? rowid}) {
    return SavedTeamsCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedTeamsCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavedTeamPlayersTable extends SavedTeamPlayers
    with TableInfo<$SavedTeamPlayersTable, SavedTeamPlayer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedTeamPlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
      'team_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES saved_teams (id)'));
  static const VerificationMeta _playerIdMeta =
      const VerificationMeta('playerId');
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
      'player_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES team_draw_players (id)'));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, teamId, playerId, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_team_players';
  @override
  VerificationContext validateIntegrity(Insertable<SavedTeamPlayer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(_teamIdMeta,
          teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta));
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(_playerIdMeta,
          playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta));
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedTeamPlayer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedTeamPlayer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      teamId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}team_id'])!,
      playerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_id'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $SavedTeamPlayersTable createAlias(String alias) {
    return $SavedTeamPlayersTable(attachedDatabase, alias);
  }
}

class SavedTeamPlayer extends DataClass implements Insertable<SavedTeamPlayer> {
  final String id;
  final String teamId;
  final String playerId;
  final int sortOrder;
  const SavedTeamPlayer(
      {required this.id,
      required this.teamId,
      required this.playerId,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['team_id'] = Variable<String>(teamId);
    map['player_id'] = Variable<String>(playerId);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  SavedTeamPlayersCompanion toCompanion(bool nullToAbsent) {
    return SavedTeamPlayersCompanion(
      id: Value(id),
      teamId: Value(teamId),
      playerId: Value(playerId),
      sortOrder: Value(sortOrder),
    );
  }

  factory SavedTeamPlayer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedTeamPlayer(
      id: serializer.fromJson<String>(json['id']),
      teamId: serializer.fromJson<String>(json['teamId']),
      playerId: serializer.fromJson<String>(json['playerId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'teamId': serializer.toJson<String>(teamId),
      'playerId': serializer.toJson<String>(playerId),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  SavedTeamPlayer copyWith(
          {String? id, String? teamId, String? playerId, int? sortOrder}) =>
      SavedTeamPlayer(
        id: id ?? this.id,
        teamId: teamId ?? this.teamId,
        playerId: playerId ?? this.playerId,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  SavedTeamPlayer copyWithCompanion(SavedTeamPlayersCompanion data) {
    return SavedTeamPlayer(
      id: data.id.present ? data.id.value : this.id,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedTeamPlayer(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('playerId: $playerId, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, teamId, playerId, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedTeamPlayer &&
          other.id == this.id &&
          other.teamId == this.teamId &&
          other.playerId == this.playerId &&
          other.sortOrder == this.sortOrder);
}

class SavedTeamPlayersCompanion extends UpdateCompanion<SavedTeamPlayer> {
  final Value<String> id;
  final Value<String> teamId;
  final Value<String> playerId;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const SavedTeamPlayersCompanion({
    this.id = const Value.absent(),
    this.teamId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavedTeamPlayersCompanion.insert({
    required String id,
    required String teamId,
    required String playerId,
    required int sortOrder,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        teamId = Value(teamId),
        playerId = Value(playerId),
        sortOrder = Value(sortOrder);
  static Insertable<SavedTeamPlayer> custom({
    Expression<String>? id,
    Expression<String>? teamId,
    Expression<String>? playerId,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (teamId != null) 'team_id': teamId,
      if (playerId != null) 'player_id': playerId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavedTeamPlayersCompanion copyWith(
      {Value<String>? id,
      Value<String>? teamId,
      Value<String>? playerId,
      Value<int>? sortOrder,
      Value<int>? rowid}) {
    return SavedTeamPlayersCompanion(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      playerId: playerId ?? this.playerId,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedTeamPlayersCompanion(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('playerId: $playerId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavedGroupWaitingPlayersTable extends SavedGroupWaitingPlayers
    with TableInfo<$SavedGroupWaitingPlayersTable, SavedGroupWaitingPlayer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedGroupWaitingPlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES saved_team_groups (id)'));
  static const VerificationMeta _playerIdMeta =
      const VerificationMeta('playerId');
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
      'player_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES team_draw_players (id)'));
  static const VerificationMeta _playerNameMeta =
      const VerificationMeta('playerName');
  @override
  late final GeneratedColumn<String> playerName = GeneratedColumn<String>(
      'player_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _waitingSinceMeta =
      const VerificationMeta('waitingSince');
  @override
  late final GeneratedColumn<String> waitingSince = GeneratedColumn<String>(
      'waiting_since', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priorityOrderMeta =
      const VerificationMeta('priorityOrder');
  @override
  late final GeneratedColumn<int> priorityOrder = GeneratedColumn<int>(
      'priority_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        groupId,
        playerId,
        playerName,
        waitingSince,
        priorityOrder,
        sortOrder
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_group_waiting_players';
  @override
  VerificationContext validateIntegrity(
      Insertable<SavedGroupWaitingPlayer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(_playerIdMeta,
          playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta));
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('player_name')) {
      context.handle(
          _playerNameMeta,
          playerName.isAcceptableOrUnknown(
              data['player_name']!, _playerNameMeta));
    } else if (isInserting) {
      context.missing(_playerNameMeta);
    }
    if (data.containsKey('waiting_since')) {
      context.handle(
          _waitingSinceMeta,
          waitingSince.isAcceptableOrUnknown(
              data['waiting_since']!, _waitingSinceMeta));
    } else if (isInserting) {
      context.missing(_waitingSinceMeta);
    }
    if (data.containsKey('priority_order')) {
      context.handle(
          _priorityOrderMeta,
          priorityOrder.isAcceptableOrUnknown(
              data['priority_order']!, _priorityOrderMeta));
    } else if (isInserting) {
      context.missing(_priorityOrderMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedGroupWaitingPlayer map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedGroupWaitingPlayer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id'])!,
      playerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_id'])!,
      playerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_name'])!,
      waitingSince: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}waiting_since'])!,
      priorityOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority_order'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $SavedGroupWaitingPlayersTable createAlias(String alias) {
    return $SavedGroupWaitingPlayersTable(attachedDatabase, alias);
  }
}

class SavedGroupWaitingPlayer extends DataClass
    implements Insertable<SavedGroupWaitingPlayer> {
  final String id;
  final String groupId;
  final String playerId;
  final String playerName;
  final String waitingSince;
  final int priorityOrder;
  final int sortOrder;
  const SavedGroupWaitingPlayer(
      {required this.id,
      required this.groupId,
      required this.playerId,
      required this.playerName,
      required this.waitingSince,
      required this.priorityOrder,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['group_id'] = Variable<String>(groupId);
    map['player_id'] = Variable<String>(playerId);
    map['player_name'] = Variable<String>(playerName);
    map['waiting_since'] = Variable<String>(waitingSince);
    map['priority_order'] = Variable<int>(priorityOrder);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  SavedGroupWaitingPlayersCompanion toCompanion(bool nullToAbsent) {
    return SavedGroupWaitingPlayersCompanion(
      id: Value(id),
      groupId: Value(groupId),
      playerId: Value(playerId),
      playerName: Value(playerName),
      waitingSince: Value(waitingSince),
      priorityOrder: Value(priorityOrder),
      sortOrder: Value(sortOrder),
    );
  }

  factory SavedGroupWaitingPlayer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedGroupWaitingPlayer(
      id: serializer.fromJson<String>(json['id']),
      groupId: serializer.fromJson<String>(json['groupId']),
      playerId: serializer.fromJson<String>(json['playerId']),
      playerName: serializer.fromJson<String>(json['playerName']),
      waitingSince: serializer.fromJson<String>(json['waitingSince']),
      priorityOrder: serializer.fromJson<int>(json['priorityOrder']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'groupId': serializer.toJson<String>(groupId),
      'playerId': serializer.toJson<String>(playerId),
      'playerName': serializer.toJson<String>(playerName),
      'waitingSince': serializer.toJson<String>(waitingSince),
      'priorityOrder': serializer.toJson<int>(priorityOrder),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  SavedGroupWaitingPlayer copyWith(
          {String? id,
          String? groupId,
          String? playerId,
          String? playerName,
          String? waitingSince,
          int? priorityOrder,
          int? sortOrder}) =>
      SavedGroupWaitingPlayer(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        playerId: playerId ?? this.playerId,
        playerName: playerName ?? this.playerName,
        waitingSince: waitingSince ?? this.waitingSince,
        priorityOrder: priorityOrder ?? this.priorityOrder,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  SavedGroupWaitingPlayer copyWithCompanion(
      SavedGroupWaitingPlayersCompanion data) {
    return SavedGroupWaitingPlayer(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      playerName:
          data.playerName.present ? data.playerName.value : this.playerName,
      waitingSince: data.waitingSince.present
          ? data.waitingSince.value
          : this.waitingSince,
      priorityOrder: data.priorityOrder.present
          ? data.priorityOrder.value
          : this.priorityOrder,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedGroupWaitingPlayer(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('playerId: $playerId, ')
          ..write('playerName: $playerName, ')
          ..write('waitingSince: $waitingSince, ')
          ..write('priorityOrder: $priorityOrder, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupId, playerId, playerName,
      waitingSince, priorityOrder, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedGroupWaitingPlayer &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.playerId == this.playerId &&
          other.playerName == this.playerName &&
          other.waitingSince == this.waitingSince &&
          other.priorityOrder == this.priorityOrder &&
          other.sortOrder == this.sortOrder);
}

class SavedGroupWaitingPlayersCompanion
    extends UpdateCompanion<SavedGroupWaitingPlayer> {
  final Value<String> id;
  final Value<String> groupId;
  final Value<String> playerId;
  final Value<String> playerName;
  final Value<String> waitingSince;
  final Value<int> priorityOrder;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const SavedGroupWaitingPlayersCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.playerName = const Value.absent(),
    this.waitingSince = const Value.absent(),
    this.priorityOrder = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavedGroupWaitingPlayersCompanion.insert({
    required String id,
    required String groupId,
    required String playerId,
    required String playerName,
    required String waitingSince,
    required int priorityOrder,
    required int sortOrder,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        groupId = Value(groupId),
        playerId = Value(playerId),
        playerName = Value(playerName),
        waitingSince = Value(waitingSince),
        priorityOrder = Value(priorityOrder),
        sortOrder = Value(sortOrder);
  static Insertable<SavedGroupWaitingPlayer> custom({
    Expression<String>? id,
    Expression<String>? groupId,
    Expression<String>? playerId,
    Expression<String>? playerName,
    Expression<String>? waitingSince,
    Expression<int>? priorityOrder,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (playerId != null) 'player_id': playerId,
      if (playerName != null) 'player_name': playerName,
      if (waitingSince != null) 'waiting_since': waitingSince,
      if (priorityOrder != null) 'priority_order': priorityOrder,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavedGroupWaitingPlayersCompanion copyWith(
      {Value<String>? id,
      Value<String>? groupId,
      Value<String>? playerId,
      Value<String>? playerName,
      Value<String>? waitingSince,
      Value<int>? priorityOrder,
      Value<int>? sortOrder,
      Value<int>? rowid}) {
    return SavedGroupWaitingPlayersCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      playerId: playerId ?? this.playerId,
      playerName: playerName ?? this.playerName,
      waitingSince: waitingSince ?? this.waitingSince,
      priorityOrder: priorityOrder ?? this.priorityOrder,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (playerName.present) {
      map['player_name'] = Variable<String>(playerName.value);
    }
    if (waitingSince.present) {
      map['waiting_since'] = Variable<String>(waitingSince.value);
    }
    if (priorityOrder.present) {
      map['priority_order'] = Variable<int>(priorityOrder.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedGroupWaitingPlayersCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('playerId: $playerId, ')
          ..write('playerName: $playerName, ')
          ..write('waitingSince: $waitingSince, ')
          ..write('priorityOrder: $priorityOrder, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $UserSessionsTable userSessions = $UserSessionsTable(this);
  late final $TeamsTable teams = $TeamsTable(this);
  late final $AthletesTable athletes = $AthletesTable(this);
  late final $StrategiesTable strategies = $StrategiesTable(this);
  late final $StrategyPlayersTable strategyPlayers =
      $StrategyPlayersTable(this);
  late final $StrategyMovementsTable strategyMovements =
      $StrategyMovementsTable(this);
  late final $StrategySubstitutionsTable strategySubstitutions =
      $StrategySubstitutionsTable(this);
  late final $MatchesTable matches = $MatchesTable(this);
  late final $MatchSetsTable matchSets = $MatchSetsTable(this);
  late final $DrillsTable drills = $DrillsTable(this);
  late final $DrillPlayersTable drillPlayers = $DrillPlayersTable(this);
  late final $DrillStepsTable drillSteps = $DrillStepsTable(this);
  late final $DrillTipsTable drillTips = $DrillTipsTable(this);
  late final $DrillErrorsTable drillErrors = $DrillErrorsTable(this);
  late final $DrillVariationsTable drillVariations =
      $DrillVariationsTable(this);
  late final $DrillAnimationFramesTable drillAnimationFrames =
      $DrillAnimationFramesTable(this);
  late final $DrillFramePlayersTable drillFramePlayers =
      $DrillFramePlayersTable(this);
  late final $DrillFrameMovementsTable drillFrameMovements =
      $DrillFrameMovementsTable(this);
  late final $DrillFrameZonesTable drillFrameZones =
      $DrillFrameZonesTable(this);
  late final $TeamDrawPlayersTable teamDrawPlayers =
      $TeamDrawPlayersTable(this);
  late final $DrawSessionsTable drawSessions = $DrawSessionsTable(this);
  late final $DrawSessionTeamsTable drawSessionTeams =
      $DrawSessionTeamsTable(this);
  late final $DrawSessionTeamPlayersTable drawSessionTeamPlayers =
      $DrawSessionTeamPlayersTable(this);
  late final $WaitingQueueEntriesTable waitingQueueEntries =
      $WaitingQueueEntriesTable(this);
  late final $SavedTeamGroupsTable savedTeamGroups =
      $SavedTeamGroupsTable(this);
  late final $SavedTeamsTable savedTeams = $SavedTeamsTable(this);
  late final $SavedTeamPlayersTable savedTeamPlayers =
      $SavedTeamPlayersTable(this);
  late final $SavedGroupWaitingPlayersTable savedGroupWaitingPlayers =
      $SavedGroupWaitingPlayersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        userSessions,
        teams,
        athletes,
        strategies,
        strategyPlayers,
        strategyMovements,
        strategySubstitutions,
        matches,
        matchSets,
        drills,
        drillPlayers,
        drillSteps,
        drillTips,
        drillErrors,
        drillVariations,
        drillAnimationFrames,
        drillFramePlayers,
        drillFrameMovements,
        drillFrameZones,
        teamDrawPlayers,
        drawSessions,
        drawSessionTeams,
        drawSessionTeamPlayers,
        waitingQueueEntries,
        savedTeamGroups,
        savedTeams,
        savedTeamPlayers,
        savedGroupWaitingPlayers
      ];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  required String id,
  required String name,
  required String email,
  required String passwordHash,
  required String passwordSalt,
  Value<String?> teamId,
  required String createdAt,
  Value<int> rowid,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> email,
  Value<String> passwordHash,
  Value<String> passwordSalt,
  Value<String?> teamId,
  Value<String> createdAt,
  Value<int> rowid,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserSessionsTable, List<UserSession>>
      _userSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.userSessions,
          aliasName: $_aliasNameGenerator(db.users.id, db.userSessions.userId));

  $$UserSessionsTableProcessedTableManager get userSessionsRefs {
    final manager = $$UserSessionsTableTableManager($_db, $_db.userSessions)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userSessionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get passwordSalt => $composableBuilder(
      column: $table.passwordSalt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get teamId => $composableBuilder(
      column: $table.teamId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> userSessionsRefs(
      Expression<bool> Function($$UserSessionsTableFilterComposer f) f) {
    final $$UserSessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userSessions,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserSessionsTableFilterComposer(
              $db: $db,
              $table: $db.userSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get passwordSalt => $composableBuilder(
      column: $table.passwordSalt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get teamId => $composableBuilder(
      column: $table.teamId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => column);

  GeneratedColumn<String> get passwordSalt => $composableBuilder(
      column: $table.passwordSalt, builder: (column) => column);

  GeneratedColumn<String> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> userSessionsRefs<T extends Object>(
      Expression<T> Function($$UserSessionsTableAnnotationComposer a) f) {
    final $$UserSessionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userSessions,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserSessionsTableAnnotationComposer(
              $db: $db,
              $table: $db.userSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function({bool userSessionsRefs})> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> passwordHash = const Value.absent(),
            Value<String> passwordSalt = const Value.absent(),
            Value<String?> teamId = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            name: name,
            email: email,
            passwordHash: passwordHash,
            passwordSalt: passwordSalt,
            teamId: teamId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String email,
            required String passwordHash,
            required String passwordSalt,
            Value<String?> teamId = const Value.absent(),
            required String createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            name: name,
            email: email,
            passwordHash: passwordHash,
            passwordSalt: passwordSalt,
            teamId: teamId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UsersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({userSessionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (userSessionsRefs) db.userSessions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userSessionsRefs)
                    await $_getPrefetchedData<User, $UsersTable, UserSession>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._userSessionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .userSessionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function({bool userSessionsRefs})>;
typedef $$UserSessionsTableCreateCompanionBuilder = UserSessionsCompanion
    Function({
  required String id,
  required String userId,
  required String startedAt,
  required bool isActive,
  Value<int> rowid,
});
typedef $$UserSessionsTableUpdateCompanionBuilder = UserSessionsCompanion
    Function({
  Value<String> id,
  Value<String> userId,
  Value<String> startedAt,
  Value<bool> isActive,
  Value<int> rowid,
});

final class $$UserSessionsTableReferences
    extends BaseReferences<_$AppDatabase, $UserSessionsTable, UserSession> {
  $$UserSessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.userSessions.userId, db.users.id));

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$UserSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $UserSessionsTable> {
  $$UserSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserSessionsTable> {
  $$UserSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserSessionsTable> {
  $$UserSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserSessionsTable,
    UserSession,
    $$UserSessionsTableFilterComposer,
    $$UserSessionsTableOrderingComposer,
    $$UserSessionsTableAnnotationComposer,
    $$UserSessionsTableCreateCompanionBuilder,
    $$UserSessionsTableUpdateCompanionBuilder,
    (UserSession, $$UserSessionsTableReferences),
    UserSession,
    PrefetchHooks Function({bool userId})> {
  $$UserSessionsTableTableManager(_$AppDatabase db, $UserSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> startedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserSessionsCompanion(
            id: id,
            userId: userId,
            startedAt: startedAt,
            isActive: isActive,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String startedAt,
            required bool isActive,
            Value<int> rowid = const Value.absent(),
          }) =>
              UserSessionsCompanion.insert(
            id: id,
            userId: userId,
            startedAt: startedAt,
            isActive: isActive,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UserSessionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$UserSessionsTableReferences._userIdTable(db),
                    referencedColumn:
                        $$UserSessionsTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$UserSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserSessionsTable,
    UserSession,
    $$UserSessionsTableFilterComposer,
    $$UserSessionsTableOrderingComposer,
    $$UserSessionsTableAnnotationComposer,
    $$UserSessionsTableCreateCompanionBuilder,
    $$UserSessionsTableUpdateCompanionBuilder,
    (UserSession, $$UserSessionsTableReferences),
    UserSession,
    PrefetchHooks Function({bool userId})>;
typedef $$TeamsTableCreateCompanionBuilder = TeamsCompanion Function({
  required String id,
  required String name,
  required String createdAt,
  Value<int> rowid,
});
typedef $$TeamsTableUpdateCompanionBuilder = TeamsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> createdAt,
  Value<int> rowid,
});

final class $$TeamsTableReferences
    extends BaseReferences<_$AppDatabase, $TeamsTable, Team> {
  $$TeamsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AthletesTable, List<Athlete>> _athletesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.athletes,
          aliasName: $_aliasNameGenerator(db.teams.id, db.athletes.teamId));

  $$AthletesTableProcessedTableManager get athletesRefs {
    final manager = $$AthletesTableTableManager($_db, $_db.athletes)
        .filter((f) => f.teamId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_athletesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TeamsTableFilterComposer extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> athletesRefs(
      Expression<bool> Function($$AthletesTableFilterComposer f) f) {
    final $$AthletesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.athletes,
        getReferencedColumn: (t) => t.teamId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AthletesTableFilterComposer(
              $db: $db,
              $table: $db.athletes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TeamsTableOrderingComposer
    extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$TeamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> athletesRefs<T extends Object>(
      Expression<T> Function($$AthletesTableAnnotationComposer a) f) {
    final $$AthletesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.athletes,
        getReferencedColumn: (t) => t.teamId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AthletesTableAnnotationComposer(
              $db: $db,
              $table: $db.athletes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TeamsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TeamsTable,
    Team,
    $$TeamsTableFilterComposer,
    $$TeamsTableOrderingComposer,
    $$TeamsTableAnnotationComposer,
    $$TeamsTableCreateCompanionBuilder,
    $$TeamsTableUpdateCompanionBuilder,
    (Team, $$TeamsTableReferences),
    Team,
    PrefetchHooks Function({bool athletesRefs})> {
  $$TeamsTableTableManager(_$AppDatabase db, $TeamsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TeamsCompanion(
            id: id,
            name: name,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              TeamsCompanion.insert(
            id: id,
            name: name,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TeamsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({athletesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (athletesRefs) db.athletes],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (athletesRefs)
                    await $_getPrefetchedData<Team, $TeamsTable, Athlete>(
                        currentTable: table,
                        referencedTable:
                            $$TeamsTableReferences._athletesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TeamsTableReferences(db, table, p0).athletesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.teamId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TeamsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TeamsTable,
    Team,
    $$TeamsTableFilterComposer,
    $$TeamsTableOrderingComposer,
    $$TeamsTableAnnotationComposer,
    $$TeamsTableCreateCompanionBuilder,
    $$TeamsTableUpdateCompanionBuilder,
    (Team, $$TeamsTableReferences),
    Team,
    PrefetchHooks Function({bool athletesRefs})>;
typedef $$AthletesTableCreateCompanionBuilder = AthletesCompanion Function({
  required String id,
  required String teamId,
  required String name,
  required String position,
  required double height,
  required int age,
  Value<int> rowid,
});
typedef $$AthletesTableUpdateCompanionBuilder = AthletesCompanion Function({
  Value<String> id,
  Value<String> teamId,
  Value<String> name,
  Value<String> position,
  Value<double> height,
  Value<int> age,
  Value<int> rowid,
});

final class $$AthletesTableReferences
    extends BaseReferences<_$AppDatabase, $AthletesTable, Athlete> {
  $$AthletesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TeamsTable _teamIdTable(_$AppDatabase db) => db.teams
      .createAlias($_aliasNameGenerator(db.athletes.teamId, db.teams.id));

  $$TeamsTableProcessedTableManager get teamId {
    final $_column = $_itemColumn<String>('team_id')!;

    final manager = $$TeamsTableTableManager($_db, $_db.teams)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AthletesTableFilterComposer
    extends Composer<_$AppDatabase, $AthletesTable> {
  $$AthletesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnFilters(column));

  $$TeamsTableFilterComposer get teamId {
    final $$TeamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.teamId,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableFilterComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AthletesTableOrderingComposer
    extends Composer<_$AppDatabase, $AthletesTable> {
  $$AthletesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnOrderings(column));

  $$TeamsTableOrderingComposer get teamId {
    final $$TeamsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.teamId,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableOrderingComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AthletesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AthletesTable> {
  $$AthletesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  $$TeamsTableAnnotationComposer get teamId {
    final $$TeamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.teamId,
        referencedTable: $db.teams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamsTableAnnotationComposer(
              $db: $db,
              $table: $db.teams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AthletesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AthletesTable,
    Athlete,
    $$AthletesTableFilterComposer,
    $$AthletesTableOrderingComposer,
    $$AthletesTableAnnotationComposer,
    $$AthletesTableCreateCompanionBuilder,
    $$AthletesTableUpdateCompanionBuilder,
    (Athlete, $$AthletesTableReferences),
    Athlete,
    PrefetchHooks Function({bool teamId})> {
  $$AthletesTableTableManager(_$AppDatabase db, $AthletesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AthletesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AthletesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AthletesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> teamId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> position = const Value.absent(),
            Value<double> height = const Value.absent(),
            Value<int> age = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AthletesCompanion(
            id: id,
            teamId: teamId,
            name: name,
            position: position,
            height: height,
            age: age,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String teamId,
            required String name,
            required String position,
            required double height,
            required int age,
            Value<int> rowid = const Value.absent(),
          }) =>
              AthletesCompanion.insert(
            id: id,
            teamId: teamId,
            name: name,
            position: position,
            height: height,
            age: age,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$AthletesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({teamId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (teamId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.teamId,
                    referencedTable: $$AthletesTableReferences._teamIdTable(db),
                    referencedColumn:
                        $$AthletesTableReferences._teamIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AthletesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AthletesTable,
    Athlete,
    $$AthletesTableFilterComposer,
    $$AthletesTableOrderingComposer,
    $$AthletesTableAnnotationComposer,
    $$AthletesTableCreateCompanionBuilder,
    $$AthletesTableUpdateCompanionBuilder,
    (Athlete, $$AthletesTableReferences),
    Athlete,
    PrefetchHooks Function({bool teamId})>;
typedef $$StrategiesTableCreateCompanionBuilder = StrategiesCompanion Function({
  required String id,
  required String name,
  required String description,
  required String gameMode,
  required String createdAt,
  Value<int> rowid,
});
typedef $$StrategiesTableUpdateCompanionBuilder = StrategiesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> description,
  Value<String> gameMode,
  Value<String> createdAt,
  Value<int> rowid,
});

final class $$StrategiesTableReferences
    extends BaseReferences<_$AppDatabase, $StrategiesTable, Strategy> {
  $$StrategiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$StrategyPlayersTable, List<StrategyPlayer>>
      _strategyPlayersRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.strategyPlayers,
              aliasName: $_aliasNameGenerator(
                  db.strategies.id, db.strategyPlayers.strategyId));

  $$StrategyPlayersTableProcessedTableManager get strategyPlayersRefs {
    final manager = $$StrategyPlayersTableTableManager(
            $_db, $_db.strategyPlayers)
        .filter((f) => f.strategyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_strategyPlayersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$StrategyMovementsTable, List<StrategyMovement>>
      _strategyMovementsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.strategyMovements,
              aliasName: $_aliasNameGenerator(
                  db.strategies.id, db.strategyMovements.strategyId));

  $$StrategyMovementsTableProcessedTableManager get strategyMovementsRefs {
    final manager = $$StrategyMovementsTableTableManager(
            $_db, $_db.strategyMovements)
        .filter((f) => f.strategyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_strategyMovementsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$StrategySubstitutionsTable,
      List<StrategySubstitution>> _strategySubstitutionsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.strategySubstitutions,
          aliasName: $_aliasNameGenerator(
              db.strategies.id, db.strategySubstitutions.strategyId));

  $$StrategySubstitutionsTableProcessedTableManager
      get strategySubstitutionsRefs {
    final manager = $$StrategySubstitutionsTableTableManager(
            $_db, $_db.strategySubstitutions)
        .filter((f) => f.strategyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_strategySubstitutionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$StrategiesTableFilterComposer
    extends Composer<_$AppDatabase, $StrategiesTable> {
  $$StrategiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gameMode => $composableBuilder(
      column: $table.gameMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> strategyPlayersRefs(
      Expression<bool> Function($$StrategyPlayersTableFilterComposer f) f) {
    final $$StrategyPlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.strategyPlayers,
        getReferencedColumn: (t) => t.strategyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StrategyPlayersTableFilterComposer(
              $db: $db,
              $table: $db.strategyPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> strategyMovementsRefs(
      Expression<bool> Function($$StrategyMovementsTableFilterComposer f) f) {
    final $$StrategyMovementsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.strategyMovements,
        getReferencedColumn: (t) => t.strategyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StrategyMovementsTableFilterComposer(
              $db: $db,
              $table: $db.strategyMovements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> strategySubstitutionsRefs(
      Expression<bool> Function($$StrategySubstitutionsTableFilterComposer f)
          f) {
    final $$StrategySubstitutionsTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.strategySubstitutions,
            getReferencedColumn: (t) => t.strategyId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$StrategySubstitutionsTableFilterComposer(
                  $db: $db,
                  $table: $db.strategySubstitutions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$StrategiesTableOrderingComposer
    extends Composer<_$AppDatabase, $StrategiesTable> {
  $$StrategiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gameMode => $composableBuilder(
      column: $table.gameMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$StrategiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StrategiesTable> {
  $$StrategiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get gameMode =>
      $composableBuilder(column: $table.gameMode, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> strategyPlayersRefs<T extends Object>(
      Expression<T> Function($$StrategyPlayersTableAnnotationComposer a) f) {
    final $$StrategyPlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.strategyPlayers,
        getReferencedColumn: (t) => t.strategyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StrategyPlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.strategyPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> strategyMovementsRefs<T extends Object>(
      Expression<T> Function($$StrategyMovementsTableAnnotationComposer a) f) {
    final $$StrategyMovementsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.strategyMovements,
            getReferencedColumn: (t) => t.strategyId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$StrategyMovementsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.strategyMovements,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> strategySubstitutionsRefs<T extends Object>(
      Expression<T> Function($$StrategySubstitutionsTableAnnotationComposer a)
          f) {
    final $$StrategySubstitutionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.strategySubstitutions,
            getReferencedColumn: (t) => t.strategyId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$StrategySubstitutionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.strategySubstitutions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$StrategiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StrategiesTable,
    Strategy,
    $$StrategiesTableFilterComposer,
    $$StrategiesTableOrderingComposer,
    $$StrategiesTableAnnotationComposer,
    $$StrategiesTableCreateCompanionBuilder,
    $$StrategiesTableUpdateCompanionBuilder,
    (Strategy, $$StrategiesTableReferences),
    Strategy,
    PrefetchHooks Function(
        {bool strategyPlayersRefs,
        bool strategyMovementsRefs,
        bool strategySubstitutionsRefs})> {
  $$StrategiesTableTableManager(_$AppDatabase db, $StrategiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StrategiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StrategiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StrategiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> gameMode = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StrategiesCompanion(
            id: id,
            name: name,
            description: description,
            gameMode: gameMode,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String description,
            required String gameMode,
            required String createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              StrategiesCompanion.insert(
            id: id,
            name: name,
            description: description,
            gameMode: gameMode,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$StrategiesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {strategyPlayersRefs = false,
              strategyMovementsRefs = false,
              strategySubstitutionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (strategyPlayersRefs) db.strategyPlayers,
                if (strategyMovementsRefs) db.strategyMovements,
                if (strategySubstitutionsRefs) db.strategySubstitutions
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (strategyPlayersRefs)
                    await $_getPrefetchedData<Strategy, $StrategiesTable,
                            StrategyPlayer>(
                        currentTable: table,
                        referencedTable: $$StrategiesTableReferences
                            ._strategyPlayersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StrategiesTableReferences(db, table, p0)
                                .strategyPlayersRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.strategyId == item.id),
                        typedResults: items),
                  if (strategyMovementsRefs)
                    await $_getPrefetchedData<Strategy, $StrategiesTable,
                            StrategyMovement>(
                        currentTable: table,
                        referencedTable: $$StrategiesTableReferences
                            ._strategyMovementsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StrategiesTableReferences(db, table, p0)
                                .strategyMovementsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.strategyId == item.id),
                        typedResults: items),
                  if (strategySubstitutionsRefs)
                    await $_getPrefetchedData<Strategy, $StrategiesTable,
                            StrategySubstitution>(
                        currentTable: table,
                        referencedTable: $$StrategiesTableReferences
                            ._strategySubstitutionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StrategiesTableReferences(db, table, p0)
                                .strategySubstitutionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.strategyId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$StrategiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StrategiesTable,
    Strategy,
    $$StrategiesTableFilterComposer,
    $$StrategiesTableOrderingComposer,
    $$StrategiesTableAnnotationComposer,
    $$StrategiesTableCreateCompanionBuilder,
    $$StrategiesTableUpdateCompanionBuilder,
    (Strategy, $$StrategiesTableReferences),
    Strategy,
    PrefetchHooks Function(
        {bool strategyPlayersRefs,
        bool strategyMovementsRefs,
        bool strategySubstitutionsRefs})>;
typedef $$StrategyPlayersTableCreateCompanionBuilder = StrategyPlayersCompanion
    Function({
  required String id,
  required String strategyId,
  Value<int> sortOrder,
  required String playerId,
  required String label,
  required double x,
  required double y,
  Value<double?> defaultX,
  Value<double?> defaultY,
  required bool isStarter,
  required bool isLibero,
  required bool isBench,
  Value<int> rowid,
});
typedef $$StrategyPlayersTableUpdateCompanionBuilder = StrategyPlayersCompanion
    Function({
  Value<String> id,
  Value<String> strategyId,
  Value<int> sortOrder,
  Value<String> playerId,
  Value<String> label,
  Value<double> x,
  Value<double> y,
  Value<double?> defaultX,
  Value<double?> defaultY,
  Value<bool> isStarter,
  Value<bool> isLibero,
  Value<bool> isBench,
  Value<int> rowid,
});

final class $$StrategyPlayersTableReferences extends BaseReferences<
    _$AppDatabase, $StrategyPlayersTable, StrategyPlayer> {
  $$StrategyPlayersTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $StrategiesTable _strategyIdTable(_$AppDatabase db) =>
      db.strategies.createAlias($_aliasNameGenerator(
          db.strategyPlayers.strategyId, db.strategies.id));

  $$StrategiesTableProcessedTableManager get strategyId {
    final $_column = $_itemColumn<String>('strategy_id')!;

    final manager = $$StrategiesTableTableManager($_db, $_db.strategies)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_strategyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$StrategyPlayersTableFilterComposer
    extends Composer<_$AppDatabase, $StrategyPlayersTable> {
  $$StrategyPlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get playerId => $composableBuilder(
      column: $table.playerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get x => $composableBuilder(
      column: $table.x, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get y => $composableBuilder(
      column: $table.y, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get defaultX => $composableBuilder(
      column: $table.defaultX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get defaultY => $composableBuilder(
      column: $table.defaultY, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isStarter => $composableBuilder(
      column: $table.isStarter, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isLibero => $composableBuilder(
      column: $table.isLibero, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isBench => $composableBuilder(
      column: $table.isBench, builder: (column) => ColumnFilters(column));

  $$StrategiesTableFilterComposer get strategyId {
    final $$StrategiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.strategyId,
        referencedTable: $db.strategies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StrategiesTableFilterComposer(
              $db: $db,
              $table: $db.strategies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StrategyPlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $StrategyPlayersTable> {
  $$StrategyPlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get playerId => $composableBuilder(
      column: $table.playerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get x => $composableBuilder(
      column: $table.x, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get y => $composableBuilder(
      column: $table.y, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get defaultX => $composableBuilder(
      column: $table.defaultX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get defaultY => $composableBuilder(
      column: $table.defaultY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isStarter => $composableBuilder(
      column: $table.isStarter, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isLibero => $composableBuilder(
      column: $table.isLibero, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isBench => $composableBuilder(
      column: $table.isBench, builder: (column) => ColumnOrderings(column));

  $$StrategiesTableOrderingComposer get strategyId {
    final $$StrategiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.strategyId,
        referencedTable: $db.strategies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StrategiesTableOrderingComposer(
              $db: $db,
              $table: $db.strategies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StrategyPlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $StrategyPlayersTable> {
  $$StrategyPlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get playerId =>
      $composableBuilder(column: $table.playerId, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<double> get x =>
      $composableBuilder(column: $table.x, builder: (column) => column);

  GeneratedColumn<double> get y =>
      $composableBuilder(column: $table.y, builder: (column) => column);

  GeneratedColumn<double> get defaultX =>
      $composableBuilder(column: $table.defaultX, builder: (column) => column);

  GeneratedColumn<double> get defaultY =>
      $composableBuilder(column: $table.defaultY, builder: (column) => column);

  GeneratedColumn<bool> get isStarter =>
      $composableBuilder(column: $table.isStarter, builder: (column) => column);

  GeneratedColumn<bool> get isLibero =>
      $composableBuilder(column: $table.isLibero, builder: (column) => column);

  GeneratedColumn<bool> get isBench =>
      $composableBuilder(column: $table.isBench, builder: (column) => column);

  $$StrategiesTableAnnotationComposer get strategyId {
    final $$StrategiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.strategyId,
        referencedTable: $db.strategies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StrategiesTableAnnotationComposer(
              $db: $db,
              $table: $db.strategies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StrategyPlayersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StrategyPlayersTable,
    StrategyPlayer,
    $$StrategyPlayersTableFilterComposer,
    $$StrategyPlayersTableOrderingComposer,
    $$StrategyPlayersTableAnnotationComposer,
    $$StrategyPlayersTableCreateCompanionBuilder,
    $$StrategyPlayersTableUpdateCompanionBuilder,
    (StrategyPlayer, $$StrategyPlayersTableReferences),
    StrategyPlayer,
    PrefetchHooks Function({bool strategyId})> {
  $$StrategyPlayersTableTableManager(
      _$AppDatabase db, $StrategyPlayersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StrategyPlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StrategyPlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StrategyPlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> strategyId = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<String> playerId = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<double> x = const Value.absent(),
            Value<double> y = const Value.absent(),
            Value<double?> defaultX = const Value.absent(),
            Value<double?> defaultY = const Value.absent(),
            Value<bool> isStarter = const Value.absent(),
            Value<bool> isLibero = const Value.absent(),
            Value<bool> isBench = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StrategyPlayersCompanion(
            id: id,
            strategyId: strategyId,
            sortOrder: sortOrder,
            playerId: playerId,
            label: label,
            x: x,
            y: y,
            defaultX: defaultX,
            defaultY: defaultY,
            isStarter: isStarter,
            isLibero: isLibero,
            isBench: isBench,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String strategyId,
            Value<int> sortOrder = const Value.absent(),
            required String playerId,
            required String label,
            required double x,
            required double y,
            Value<double?> defaultX = const Value.absent(),
            Value<double?> defaultY = const Value.absent(),
            required bool isStarter,
            required bool isLibero,
            required bool isBench,
            Value<int> rowid = const Value.absent(),
          }) =>
              StrategyPlayersCompanion.insert(
            id: id,
            strategyId: strategyId,
            sortOrder: sortOrder,
            playerId: playerId,
            label: label,
            x: x,
            y: y,
            defaultX: defaultX,
            defaultY: defaultY,
            isStarter: isStarter,
            isLibero: isLibero,
            isBench: isBench,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$StrategyPlayersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({strategyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (strategyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.strategyId,
                    referencedTable:
                        $$StrategyPlayersTableReferences._strategyIdTable(db),
                    referencedColumn: $$StrategyPlayersTableReferences
                        ._strategyIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$StrategyPlayersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StrategyPlayersTable,
    StrategyPlayer,
    $$StrategyPlayersTableFilterComposer,
    $$StrategyPlayersTableOrderingComposer,
    $$StrategyPlayersTableAnnotationComposer,
    $$StrategyPlayersTableCreateCompanionBuilder,
    $$StrategyPlayersTableUpdateCompanionBuilder,
    (StrategyPlayer, $$StrategyPlayersTableReferences),
    StrategyPlayer,
    PrefetchHooks Function({bool strategyId})>;
typedef $$StrategyMovementsTableCreateCompanionBuilder
    = StrategyMovementsCompanion Function({
  required String id,
  required String strategyId,
  Value<int> sortOrder,
  required String playerId,
  required double fromX,
  required double fromY,
  required double toX,
  required double toY,
  required String movementType,
  Value<int> rowid,
});
typedef $$StrategyMovementsTableUpdateCompanionBuilder
    = StrategyMovementsCompanion Function({
  Value<String> id,
  Value<String> strategyId,
  Value<int> sortOrder,
  Value<String> playerId,
  Value<double> fromX,
  Value<double> fromY,
  Value<double> toX,
  Value<double> toY,
  Value<String> movementType,
  Value<int> rowid,
});

final class $$StrategyMovementsTableReferences extends BaseReferences<
    _$AppDatabase, $StrategyMovementsTable, StrategyMovement> {
  $$StrategyMovementsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $StrategiesTable _strategyIdTable(_$AppDatabase db) =>
      db.strategies.createAlias($_aliasNameGenerator(
          db.strategyMovements.strategyId, db.strategies.id));

  $$StrategiesTableProcessedTableManager get strategyId {
    final $_column = $_itemColumn<String>('strategy_id')!;

    final manager = $$StrategiesTableTableManager($_db, $_db.strategies)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_strategyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$StrategyMovementsTableFilterComposer
    extends Composer<_$AppDatabase, $StrategyMovementsTable> {
  $$StrategyMovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get playerId => $composableBuilder(
      column: $table.playerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fromX => $composableBuilder(
      column: $table.fromX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fromY => $composableBuilder(
      column: $table.fromY, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get toX => $composableBuilder(
      column: $table.toX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get toY => $composableBuilder(
      column: $table.toY, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get movementType => $composableBuilder(
      column: $table.movementType, builder: (column) => ColumnFilters(column));

  $$StrategiesTableFilterComposer get strategyId {
    final $$StrategiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.strategyId,
        referencedTable: $db.strategies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StrategiesTableFilterComposer(
              $db: $db,
              $table: $db.strategies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StrategyMovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $StrategyMovementsTable> {
  $$StrategyMovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get playerId => $composableBuilder(
      column: $table.playerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fromX => $composableBuilder(
      column: $table.fromX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fromY => $composableBuilder(
      column: $table.fromY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get toX => $composableBuilder(
      column: $table.toX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get toY => $composableBuilder(
      column: $table.toY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get movementType => $composableBuilder(
      column: $table.movementType,
      builder: (column) => ColumnOrderings(column));

  $$StrategiesTableOrderingComposer get strategyId {
    final $$StrategiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.strategyId,
        referencedTable: $db.strategies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StrategiesTableOrderingComposer(
              $db: $db,
              $table: $db.strategies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StrategyMovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StrategyMovementsTable> {
  $$StrategyMovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get playerId =>
      $composableBuilder(column: $table.playerId, builder: (column) => column);

  GeneratedColumn<double> get fromX =>
      $composableBuilder(column: $table.fromX, builder: (column) => column);

  GeneratedColumn<double> get fromY =>
      $composableBuilder(column: $table.fromY, builder: (column) => column);

  GeneratedColumn<double> get toX =>
      $composableBuilder(column: $table.toX, builder: (column) => column);

  GeneratedColumn<double> get toY =>
      $composableBuilder(column: $table.toY, builder: (column) => column);

  GeneratedColumn<String> get movementType => $composableBuilder(
      column: $table.movementType, builder: (column) => column);

  $$StrategiesTableAnnotationComposer get strategyId {
    final $$StrategiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.strategyId,
        referencedTable: $db.strategies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StrategiesTableAnnotationComposer(
              $db: $db,
              $table: $db.strategies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StrategyMovementsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StrategyMovementsTable,
    StrategyMovement,
    $$StrategyMovementsTableFilterComposer,
    $$StrategyMovementsTableOrderingComposer,
    $$StrategyMovementsTableAnnotationComposer,
    $$StrategyMovementsTableCreateCompanionBuilder,
    $$StrategyMovementsTableUpdateCompanionBuilder,
    (StrategyMovement, $$StrategyMovementsTableReferences),
    StrategyMovement,
    PrefetchHooks Function({bool strategyId})> {
  $$StrategyMovementsTableTableManager(
      _$AppDatabase db, $StrategyMovementsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StrategyMovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StrategyMovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StrategyMovementsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> strategyId = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<String> playerId = const Value.absent(),
            Value<double> fromX = const Value.absent(),
            Value<double> fromY = const Value.absent(),
            Value<double> toX = const Value.absent(),
            Value<double> toY = const Value.absent(),
            Value<String> movementType = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StrategyMovementsCompanion(
            id: id,
            strategyId: strategyId,
            sortOrder: sortOrder,
            playerId: playerId,
            fromX: fromX,
            fromY: fromY,
            toX: toX,
            toY: toY,
            movementType: movementType,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String strategyId,
            Value<int> sortOrder = const Value.absent(),
            required String playerId,
            required double fromX,
            required double fromY,
            required double toX,
            required double toY,
            required String movementType,
            Value<int> rowid = const Value.absent(),
          }) =>
              StrategyMovementsCompanion.insert(
            id: id,
            strategyId: strategyId,
            sortOrder: sortOrder,
            playerId: playerId,
            fromX: fromX,
            fromY: fromY,
            toX: toX,
            toY: toY,
            movementType: movementType,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$StrategyMovementsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({strategyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (strategyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.strategyId,
                    referencedTable:
                        $$StrategyMovementsTableReferences._strategyIdTable(db),
                    referencedColumn: $$StrategyMovementsTableReferences
                        ._strategyIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$StrategyMovementsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StrategyMovementsTable,
    StrategyMovement,
    $$StrategyMovementsTableFilterComposer,
    $$StrategyMovementsTableOrderingComposer,
    $$StrategyMovementsTableAnnotationComposer,
    $$StrategyMovementsTableCreateCompanionBuilder,
    $$StrategyMovementsTableUpdateCompanionBuilder,
    (StrategyMovement, $$StrategyMovementsTableReferences),
    StrategyMovement,
    PrefetchHooks Function({bool strategyId})>;
typedef $$StrategySubstitutionsTableCreateCompanionBuilder
    = StrategySubstitutionsCompanion Function({
  required String id,
  required String strategyId,
  required String playerOutId,
  required String playerInId,
  required String createdAt,
  required bool countsTowardLimit,
  required bool isLiberoExchange,
  Value<int> rowid,
});
typedef $$StrategySubstitutionsTableUpdateCompanionBuilder
    = StrategySubstitutionsCompanion Function({
  Value<String> id,
  Value<String> strategyId,
  Value<String> playerOutId,
  Value<String> playerInId,
  Value<String> createdAt,
  Value<bool> countsTowardLimit,
  Value<bool> isLiberoExchange,
  Value<int> rowid,
});

final class $$StrategySubstitutionsTableReferences extends BaseReferences<
    _$AppDatabase, $StrategySubstitutionsTable, StrategySubstitution> {
  $$StrategySubstitutionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $StrategiesTable _strategyIdTable(_$AppDatabase db) =>
      db.strategies.createAlias($_aliasNameGenerator(
          db.strategySubstitutions.strategyId, db.strategies.id));

  $$StrategiesTableProcessedTableManager get strategyId {
    final $_column = $_itemColumn<String>('strategy_id')!;

    final manager = $$StrategiesTableTableManager($_db, $_db.strategies)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_strategyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$StrategySubstitutionsTableFilterComposer
    extends Composer<_$AppDatabase, $StrategySubstitutionsTable> {
  $$StrategySubstitutionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get playerOutId => $composableBuilder(
      column: $table.playerOutId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get playerInId => $composableBuilder(
      column: $table.playerInId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get countsTowardLimit => $composableBuilder(
      column: $table.countsTowardLimit,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isLiberoExchange => $composableBuilder(
      column: $table.isLiberoExchange,
      builder: (column) => ColumnFilters(column));

  $$StrategiesTableFilterComposer get strategyId {
    final $$StrategiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.strategyId,
        referencedTable: $db.strategies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StrategiesTableFilterComposer(
              $db: $db,
              $table: $db.strategies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StrategySubstitutionsTableOrderingComposer
    extends Composer<_$AppDatabase, $StrategySubstitutionsTable> {
  $$StrategySubstitutionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get playerOutId => $composableBuilder(
      column: $table.playerOutId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get playerInId => $composableBuilder(
      column: $table.playerInId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get countsTowardLimit => $composableBuilder(
      column: $table.countsTowardLimit,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isLiberoExchange => $composableBuilder(
      column: $table.isLiberoExchange,
      builder: (column) => ColumnOrderings(column));

  $$StrategiesTableOrderingComposer get strategyId {
    final $$StrategiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.strategyId,
        referencedTable: $db.strategies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StrategiesTableOrderingComposer(
              $db: $db,
              $table: $db.strategies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StrategySubstitutionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StrategySubstitutionsTable> {
  $$StrategySubstitutionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get playerOutId => $composableBuilder(
      column: $table.playerOutId, builder: (column) => column);

  GeneratedColumn<String> get playerInId => $composableBuilder(
      column: $table.playerInId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get countsTowardLimit => $composableBuilder(
      column: $table.countsTowardLimit, builder: (column) => column);

  GeneratedColumn<bool> get isLiberoExchange => $composableBuilder(
      column: $table.isLiberoExchange, builder: (column) => column);

  $$StrategiesTableAnnotationComposer get strategyId {
    final $$StrategiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.strategyId,
        referencedTable: $db.strategies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StrategiesTableAnnotationComposer(
              $db: $db,
              $table: $db.strategies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StrategySubstitutionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StrategySubstitutionsTable,
    StrategySubstitution,
    $$StrategySubstitutionsTableFilterComposer,
    $$StrategySubstitutionsTableOrderingComposer,
    $$StrategySubstitutionsTableAnnotationComposer,
    $$StrategySubstitutionsTableCreateCompanionBuilder,
    $$StrategySubstitutionsTableUpdateCompanionBuilder,
    (StrategySubstitution, $$StrategySubstitutionsTableReferences),
    StrategySubstitution,
    PrefetchHooks Function({bool strategyId})> {
  $$StrategySubstitutionsTableTableManager(
      _$AppDatabase db, $StrategySubstitutionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StrategySubstitutionsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$StrategySubstitutionsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StrategySubstitutionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> strategyId = const Value.absent(),
            Value<String> playerOutId = const Value.absent(),
            Value<String> playerInId = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<bool> countsTowardLimit = const Value.absent(),
            Value<bool> isLiberoExchange = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StrategySubstitutionsCompanion(
            id: id,
            strategyId: strategyId,
            playerOutId: playerOutId,
            playerInId: playerInId,
            createdAt: createdAt,
            countsTowardLimit: countsTowardLimit,
            isLiberoExchange: isLiberoExchange,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String strategyId,
            required String playerOutId,
            required String playerInId,
            required String createdAt,
            required bool countsTowardLimit,
            required bool isLiberoExchange,
            Value<int> rowid = const Value.absent(),
          }) =>
              StrategySubstitutionsCompanion.insert(
            id: id,
            strategyId: strategyId,
            playerOutId: playerOutId,
            playerInId: playerInId,
            createdAt: createdAt,
            countsTowardLimit: countsTowardLimit,
            isLiberoExchange: isLiberoExchange,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$StrategySubstitutionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({strategyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (strategyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.strategyId,
                    referencedTable: $$StrategySubstitutionsTableReferences
                        ._strategyIdTable(db),
                    referencedColumn: $$StrategySubstitutionsTableReferences
                        ._strategyIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$StrategySubstitutionsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $StrategySubstitutionsTable,
        StrategySubstitution,
        $$StrategySubstitutionsTableFilterComposer,
        $$StrategySubstitutionsTableOrderingComposer,
        $$StrategySubstitutionsTableAnnotationComposer,
        $$StrategySubstitutionsTableCreateCompanionBuilder,
        $$StrategySubstitutionsTableUpdateCompanionBuilder,
        (StrategySubstitution, $$StrategySubstitutionsTableReferences),
        StrategySubstitution,
        PrefetchHooks Function({bool strategyId})>;
typedef $$MatchesTableCreateCompanionBuilder = MatchesCompanion Function({
  required String id,
  required String teamAName,
  required String teamBName,
  required int teamASetsWon,
  required int teamBSetsWon,
  required int currentSet,
  required String servingTeam,
  required String matchStatus,
  Value<String?> winnerTeam,
  Value<String> sourceType,
  Value<String?> savedTeamGroupId,
  Value<String?> savedTeamGroupTitle,
  Value<String?> teamAOriginTeamId,
  Value<String?> teamBOriginTeamId,
  Value<String?> teamAPlayersJson,
  Value<String?> teamBPlayersJson,
  Value<String?> waitingPlayersSnapshotJson,
  required String createdAt,
  Value<String?> finishedAt,
  Value<int> rowid,
});
typedef $$MatchesTableUpdateCompanionBuilder = MatchesCompanion Function({
  Value<String> id,
  Value<String> teamAName,
  Value<String> teamBName,
  Value<int> teamASetsWon,
  Value<int> teamBSetsWon,
  Value<int> currentSet,
  Value<String> servingTeam,
  Value<String> matchStatus,
  Value<String?> winnerTeam,
  Value<String> sourceType,
  Value<String?> savedTeamGroupId,
  Value<String?> savedTeamGroupTitle,
  Value<String?> teamAOriginTeamId,
  Value<String?> teamBOriginTeamId,
  Value<String?> teamAPlayersJson,
  Value<String?> teamBPlayersJson,
  Value<String?> waitingPlayersSnapshotJson,
  Value<String> createdAt,
  Value<String?> finishedAt,
  Value<int> rowid,
});

final class $$MatchesTableReferences
    extends BaseReferences<_$AppDatabase, $MatchesTable, Matche> {
  $$MatchesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MatchSetsTable, List<MatchSet>>
      _matchSetsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.matchSets,
          aliasName: $_aliasNameGenerator(db.matches.id, db.matchSets.matchId));

  $$MatchSetsTableProcessedTableManager get matchSetsRefs {
    final manager = $$MatchSetsTableTableManager($_db, $_db.matchSets)
        .filter((f) => f.matchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_matchSetsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MatchesTableFilterComposer
    extends Composer<_$AppDatabase, $MatchesTable> {
  $$MatchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get teamAName => $composableBuilder(
      column: $table.teamAName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get teamBName => $composableBuilder(
      column: $table.teamBName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get teamASetsWon => $composableBuilder(
      column: $table.teamASetsWon, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get teamBSetsWon => $composableBuilder(
      column: $table.teamBSetsWon, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentSet => $composableBuilder(
      column: $table.currentSet, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get servingTeam => $composableBuilder(
      column: $table.servingTeam, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get matchStatus => $composableBuilder(
      column: $table.matchStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get winnerTeam => $composableBuilder(
      column: $table.winnerTeam, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceType => $composableBuilder(
      column: $table.sourceType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get savedTeamGroupId => $composableBuilder(
      column: $table.savedTeamGroupId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get savedTeamGroupTitle => $composableBuilder(
      column: $table.savedTeamGroupTitle,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get teamAOriginTeamId => $composableBuilder(
      column: $table.teamAOriginTeamId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get teamBOriginTeamId => $composableBuilder(
      column: $table.teamBOriginTeamId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get teamAPlayersJson => $composableBuilder(
      column: $table.teamAPlayersJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get teamBPlayersJson => $composableBuilder(
      column: $table.teamBPlayersJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get waitingPlayersSnapshotJson => $composableBuilder(
      column: $table.waitingPlayersSnapshotJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get finishedAt => $composableBuilder(
      column: $table.finishedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> matchSetsRefs(
      Expression<bool> Function($$MatchSetsTableFilterComposer f) f) {
    final $$MatchSetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.matchSets,
        getReferencedColumn: (t) => t.matchId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchSetsTableFilterComposer(
              $db: $db,
              $table: $db.matchSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MatchesTableOrderingComposer
    extends Composer<_$AppDatabase, $MatchesTable> {
  $$MatchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get teamAName => $composableBuilder(
      column: $table.teamAName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get teamBName => $composableBuilder(
      column: $table.teamBName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get teamASetsWon => $composableBuilder(
      column: $table.teamASetsWon,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get teamBSetsWon => $composableBuilder(
      column: $table.teamBSetsWon,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentSet => $composableBuilder(
      column: $table.currentSet, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get servingTeam => $composableBuilder(
      column: $table.servingTeam, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get matchStatus => $composableBuilder(
      column: $table.matchStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get winnerTeam => $composableBuilder(
      column: $table.winnerTeam, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceType => $composableBuilder(
      column: $table.sourceType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get savedTeamGroupId => $composableBuilder(
      column: $table.savedTeamGroupId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get savedTeamGroupTitle => $composableBuilder(
      column: $table.savedTeamGroupTitle,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get teamAOriginTeamId => $composableBuilder(
      column: $table.teamAOriginTeamId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get teamBOriginTeamId => $composableBuilder(
      column: $table.teamBOriginTeamId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get teamAPlayersJson => $composableBuilder(
      column: $table.teamAPlayersJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get teamBPlayersJson => $composableBuilder(
      column: $table.teamBPlayersJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get waitingPlayersSnapshotJson => $composableBuilder(
      column: $table.waitingPlayersSnapshotJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get finishedAt => $composableBuilder(
      column: $table.finishedAt, builder: (column) => ColumnOrderings(column));
}

class $$MatchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MatchesTable> {
  $$MatchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get teamAName =>
      $composableBuilder(column: $table.teamAName, builder: (column) => column);

  GeneratedColumn<String> get teamBName =>
      $composableBuilder(column: $table.teamBName, builder: (column) => column);

  GeneratedColumn<int> get teamASetsWon => $composableBuilder(
      column: $table.teamASetsWon, builder: (column) => column);

  GeneratedColumn<int> get teamBSetsWon => $composableBuilder(
      column: $table.teamBSetsWon, builder: (column) => column);

  GeneratedColumn<int> get currentSet => $composableBuilder(
      column: $table.currentSet, builder: (column) => column);

  GeneratedColumn<String> get servingTeam => $composableBuilder(
      column: $table.servingTeam, builder: (column) => column);

  GeneratedColumn<String> get matchStatus => $composableBuilder(
      column: $table.matchStatus, builder: (column) => column);

  GeneratedColumn<String> get winnerTeam => $composableBuilder(
      column: $table.winnerTeam, builder: (column) => column);

  GeneratedColumn<String> get sourceType => $composableBuilder(
      column: $table.sourceType, builder: (column) => column);

  GeneratedColumn<String> get savedTeamGroupId => $composableBuilder(
      column: $table.savedTeamGroupId, builder: (column) => column);

  GeneratedColumn<String> get savedTeamGroupTitle => $composableBuilder(
      column: $table.savedTeamGroupTitle, builder: (column) => column);

  GeneratedColumn<String> get teamAOriginTeamId => $composableBuilder(
      column: $table.teamAOriginTeamId, builder: (column) => column);

  GeneratedColumn<String> get teamBOriginTeamId => $composableBuilder(
      column: $table.teamBOriginTeamId, builder: (column) => column);

  GeneratedColumn<String> get teamAPlayersJson => $composableBuilder(
      column: $table.teamAPlayersJson, builder: (column) => column);

  GeneratedColumn<String> get teamBPlayersJson => $composableBuilder(
      column: $table.teamBPlayersJson, builder: (column) => column);

  GeneratedColumn<String> get waitingPlayersSnapshotJson => $composableBuilder(
      column: $table.waitingPlayersSnapshotJson, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get finishedAt => $composableBuilder(
      column: $table.finishedAt, builder: (column) => column);

  Expression<T> matchSetsRefs<T extends Object>(
      Expression<T> Function($$MatchSetsTableAnnotationComposer a) f) {
    final $$MatchSetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.matchSets,
        getReferencedColumn: (t) => t.matchId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchSetsTableAnnotationComposer(
              $db: $db,
              $table: $db.matchSets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MatchesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MatchesTable,
    Matche,
    $$MatchesTableFilterComposer,
    $$MatchesTableOrderingComposer,
    $$MatchesTableAnnotationComposer,
    $$MatchesTableCreateCompanionBuilder,
    $$MatchesTableUpdateCompanionBuilder,
    (Matche, $$MatchesTableReferences),
    Matche,
    PrefetchHooks Function({bool matchSetsRefs})> {
  $$MatchesTableTableManager(_$AppDatabase db, $MatchesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> teamAName = const Value.absent(),
            Value<String> teamBName = const Value.absent(),
            Value<int> teamASetsWon = const Value.absent(),
            Value<int> teamBSetsWon = const Value.absent(),
            Value<int> currentSet = const Value.absent(),
            Value<String> servingTeam = const Value.absent(),
            Value<String> matchStatus = const Value.absent(),
            Value<String?> winnerTeam = const Value.absent(),
            Value<String> sourceType = const Value.absent(),
            Value<String?> savedTeamGroupId = const Value.absent(),
            Value<String?> savedTeamGroupTitle = const Value.absent(),
            Value<String?> teamAOriginTeamId = const Value.absent(),
            Value<String?> teamBOriginTeamId = const Value.absent(),
            Value<String?> teamAPlayersJson = const Value.absent(),
            Value<String?> teamBPlayersJson = const Value.absent(),
            Value<String?> waitingPlayersSnapshotJson = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String?> finishedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MatchesCompanion(
            id: id,
            teamAName: teamAName,
            teamBName: teamBName,
            teamASetsWon: teamASetsWon,
            teamBSetsWon: teamBSetsWon,
            currentSet: currentSet,
            servingTeam: servingTeam,
            matchStatus: matchStatus,
            winnerTeam: winnerTeam,
            sourceType: sourceType,
            savedTeamGroupId: savedTeamGroupId,
            savedTeamGroupTitle: savedTeamGroupTitle,
            teamAOriginTeamId: teamAOriginTeamId,
            teamBOriginTeamId: teamBOriginTeamId,
            teamAPlayersJson: teamAPlayersJson,
            teamBPlayersJson: teamBPlayersJson,
            waitingPlayersSnapshotJson: waitingPlayersSnapshotJson,
            createdAt: createdAt,
            finishedAt: finishedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String teamAName,
            required String teamBName,
            required int teamASetsWon,
            required int teamBSetsWon,
            required int currentSet,
            required String servingTeam,
            required String matchStatus,
            Value<String?> winnerTeam = const Value.absent(),
            Value<String> sourceType = const Value.absent(),
            Value<String?> savedTeamGroupId = const Value.absent(),
            Value<String?> savedTeamGroupTitle = const Value.absent(),
            Value<String?> teamAOriginTeamId = const Value.absent(),
            Value<String?> teamBOriginTeamId = const Value.absent(),
            Value<String?> teamAPlayersJson = const Value.absent(),
            Value<String?> teamBPlayersJson = const Value.absent(),
            Value<String?> waitingPlayersSnapshotJson = const Value.absent(),
            required String createdAt,
            Value<String?> finishedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MatchesCompanion.insert(
            id: id,
            teamAName: teamAName,
            teamBName: teamBName,
            teamASetsWon: teamASetsWon,
            teamBSetsWon: teamBSetsWon,
            currentSet: currentSet,
            servingTeam: servingTeam,
            matchStatus: matchStatus,
            winnerTeam: winnerTeam,
            sourceType: sourceType,
            savedTeamGroupId: savedTeamGroupId,
            savedTeamGroupTitle: savedTeamGroupTitle,
            teamAOriginTeamId: teamAOriginTeamId,
            teamBOriginTeamId: teamBOriginTeamId,
            teamAPlayersJson: teamAPlayersJson,
            teamBPlayersJson: teamBPlayersJson,
            waitingPlayersSnapshotJson: waitingPlayersSnapshotJson,
            createdAt: createdAt,
            finishedAt: finishedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$MatchesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({matchSetsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (matchSetsRefs) db.matchSets],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (matchSetsRefs)
                    await $_getPrefetchedData<Matche, $MatchesTable, MatchSet>(
                        currentTable: table,
                        referencedTable:
                            $$MatchesTableReferences._matchSetsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MatchesTableReferences(db, table, p0)
                                .matchSetsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.matchId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MatchesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MatchesTable,
    Matche,
    $$MatchesTableFilterComposer,
    $$MatchesTableOrderingComposer,
    $$MatchesTableAnnotationComposer,
    $$MatchesTableCreateCompanionBuilder,
    $$MatchesTableUpdateCompanionBuilder,
    (Matche, $$MatchesTableReferences),
    Matche,
    PrefetchHooks Function({bool matchSetsRefs})>;
typedef $$MatchSetsTableCreateCompanionBuilder = MatchSetsCompanion Function({
  required String id,
  required String matchId,
  required int setNumber,
  required int teamAScore,
  required int teamBScore,
  required String winnerTeamId,
  required int targetPoints,
  Value<int> durationSeconds,
  Value<String?> pointEventsJson,
  Value<int> rowid,
});
typedef $$MatchSetsTableUpdateCompanionBuilder = MatchSetsCompanion Function({
  Value<String> id,
  Value<String> matchId,
  Value<int> setNumber,
  Value<int> teamAScore,
  Value<int> teamBScore,
  Value<String> winnerTeamId,
  Value<int> targetPoints,
  Value<int> durationSeconds,
  Value<String?> pointEventsJson,
  Value<int> rowid,
});

final class $$MatchSetsTableReferences
    extends BaseReferences<_$AppDatabase, $MatchSetsTable, MatchSet> {
  $$MatchSetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MatchesTable _matchIdTable(_$AppDatabase db) => db.matches
      .createAlias($_aliasNameGenerator(db.matchSets.matchId, db.matches.id));

  $$MatchesTableProcessedTableManager get matchId {
    final $_column = $_itemColumn<String>('match_id')!;

    final manager = $$MatchesTableTableManager($_db, $_db.matches)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_matchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MatchSetsTableFilterComposer
    extends Composer<_$AppDatabase, $MatchSetsTable> {
  $$MatchSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get setNumber => $composableBuilder(
      column: $table.setNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get teamAScore => $composableBuilder(
      column: $table.teamAScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get teamBScore => $composableBuilder(
      column: $table.teamBScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get winnerTeamId => $composableBuilder(
      column: $table.winnerTeamId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetPoints => $composableBuilder(
      column: $table.targetPoints, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pointEventsJson => $composableBuilder(
      column: $table.pointEventsJson,
      builder: (column) => ColumnFilters(column));

  $$MatchesTableFilterComposer get matchId {
    final $$MatchesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchId,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableFilterComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MatchSetsTableOrderingComposer
    extends Composer<_$AppDatabase, $MatchSetsTable> {
  $$MatchSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get setNumber => $composableBuilder(
      column: $table.setNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get teamAScore => $composableBuilder(
      column: $table.teamAScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get teamBScore => $composableBuilder(
      column: $table.teamBScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get winnerTeamId => $composableBuilder(
      column: $table.winnerTeamId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetPoints => $composableBuilder(
      column: $table.targetPoints,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pointEventsJson => $composableBuilder(
      column: $table.pointEventsJson,
      builder: (column) => ColumnOrderings(column));

  $$MatchesTableOrderingComposer get matchId {
    final $$MatchesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchId,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableOrderingComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MatchSetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MatchSetsTable> {
  $$MatchSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get setNumber =>
      $composableBuilder(column: $table.setNumber, builder: (column) => column);

  GeneratedColumn<int> get teamAScore => $composableBuilder(
      column: $table.teamAScore, builder: (column) => column);

  GeneratedColumn<int> get teamBScore => $composableBuilder(
      column: $table.teamBScore, builder: (column) => column);

  GeneratedColumn<String> get winnerTeamId => $composableBuilder(
      column: $table.winnerTeamId, builder: (column) => column);

  GeneratedColumn<int> get targetPoints => $composableBuilder(
      column: $table.targetPoints, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds, builder: (column) => column);

  GeneratedColumn<String> get pointEventsJson => $composableBuilder(
      column: $table.pointEventsJson, builder: (column) => column);

  $$MatchesTableAnnotationComposer get matchId {
    final $$MatchesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.matchId,
        referencedTable: $db.matches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MatchesTableAnnotationComposer(
              $db: $db,
              $table: $db.matches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MatchSetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MatchSetsTable,
    MatchSet,
    $$MatchSetsTableFilterComposer,
    $$MatchSetsTableOrderingComposer,
    $$MatchSetsTableAnnotationComposer,
    $$MatchSetsTableCreateCompanionBuilder,
    $$MatchSetsTableUpdateCompanionBuilder,
    (MatchSet, $$MatchSetsTableReferences),
    MatchSet,
    PrefetchHooks Function({bool matchId})> {
  $$MatchSetsTableTableManager(_$AppDatabase db, $MatchSetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatchSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatchSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatchSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> matchId = const Value.absent(),
            Value<int> setNumber = const Value.absent(),
            Value<int> teamAScore = const Value.absent(),
            Value<int> teamBScore = const Value.absent(),
            Value<String> winnerTeamId = const Value.absent(),
            Value<int> targetPoints = const Value.absent(),
            Value<int> durationSeconds = const Value.absent(),
            Value<String?> pointEventsJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MatchSetsCompanion(
            id: id,
            matchId: matchId,
            setNumber: setNumber,
            teamAScore: teamAScore,
            teamBScore: teamBScore,
            winnerTeamId: winnerTeamId,
            targetPoints: targetPoints,
            durationSeconds: durationSeconds,
            pointEventsJson: pointEventsJson,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String matchId,
            required int setNumber,
            required int teamAScore,
            required int teamBScore,
            required String winnerTeamId,
            required int targetPoints,
            Value<int> durationSeconds = const Value.absent(),
            Value<String?> pointEventsJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MatchSetsCompanion.insert(
            id: id,
            matchId: matchId,
            setNumber: setNumber,
            teamAScore: teamAScore,
            teamBScore: teamBScore,
            winnerTeamId: winnerTeamId,
            targetPoints: targetPoints,
            durationSeconds: durationSeconds,
            pointEventsJson: pointEventsJson,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MatchSetsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({matchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (matchId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.matchId,
                    referencedTable:
                        $$MatchSetsTableReferences._matchIdTable(db),
                    referencedColumn:
                        $$MatchSetsTableReferences._matchIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MatchSetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MatchSetsTable,
    MatchSet,
    $$MatchSetsTableFilterComposer,
    $$MatchSetsTableOrderingComposer,
    $$MatchSetsTableAnnotationComposer,
    $$MatchSetsTableCreateCompanionBuilder,
    $$MatchSetsTableUpdateCompanionBuilder,
    (MatchSet, $$MatchSetsTableReferences),
    MatchSet,
    PrefetchHooks Function({bool matchId})>;
typedef $$DrillsTableCreateCompanionBuilder = DrillsCompanion Function({
  required String id,
  required String name,
  required String category,
  required String objective,
  required String difficulty,
  required String duration,
  required bool isFavorite,
  Value<int> rowid,
});
typedef $$DrillsTableUpdateCompanionBuilder = DrillsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> category,
  Value<String> objective,
  Value<String> difficulty,
  Value<String> duration,
  Value<bool> isFavorite,
  Value<int> rowid,
});

final class $$DrillsTableReferences
    extends BaseReferences<_$AppDatabase, $DrillsTable, Drill> {
  $$DrillsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DrillPlayersTable, List<DrillPlayer>>
      _drillPlayersRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.drillPlayers,
              aliasName:
                  $_aliasNameGenerator(db.drills.id, db.drillPlayers.drillId));

  $$DrillPlayersTableProcessedTableManager get drillPlayersRefs {
    final manager = $$DrillPlayersTableTableManager($_db, $_db.drillPlayers)
        .filter((f) => f.drillId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_drillPlayersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DrillStepsTable, List<DrillStep>>
      _drillStepsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.drillSteps,
          aliasName: $_aliasNameGenerator(db.drills.id, db.drillSteps.drillId));

  $$DrillStepsTableProcessedTableManager get drillStepsRefs {
    final manager = $$DrillStepsTableTableManager($_db, $_db.drillSteps)
        .filter((f) => f.drillId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_drillStepsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DrillTipsTable, List<DrillTip>>
      _drillTipsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.drillTips,
          aliasName: $_aliasNameGenerator(db.drills.id, db.drillTips.drillId));

  $$DrillTipsTableProcessedTableManager get drillTipsRefs {
    final manager = $$DrillTipsTableTableManager($_db, $_db.drillTips)
        .filter((f) => f.drillId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_drillTipsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DrillErrorsTable, List<DrillError>>
      _drillErrorsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.drillErrors,
              aliasName:
                  $_aliasNameGenerator(db.drills.id, db.drillErrors.drillId));

  $$DrillErrorsTableProcessedTableManager get drillErrorsRefs {
    final manager = $$DrillErrorsTableTableManager($_db, $_db.drillErrors)
        .filter((f) => f.drillId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_drillErrorsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DrillVariationsTable, List<DrillVariation>>
      _drillVariationsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.drillVariations,
              aliasName: $_aliasNameGenerator(
                  db.drills.id, db.drillVariations.drillId));

  $$DrillVariationsTableProcessedTableManager get drillVariationsRefs {
    final manager =
        $$DrillVariationsTableTableManager($_db, $_db.drillVariations)
            .filter((f) => f.drillId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_drillVariationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DrillAnimationFramesTable,
      List<DrillAnimationFrame>> _drillAnimationFramesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.drillAnimationFrames,
          aliasName: $_aliasNameGenerator(
              db.drills.id, db.drillAnimationFrames.drillId));

  $$DrillAnimationFramesTableProcessedTableManager
      get drillAnimationFramesRefs {
    final manager =
        $$DrillAnimationFramesTableTableManager($_db, $_db.drillAnimationFrames)
            .filter((f) => f.drillId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_drillAnimationFramesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DrillsTableFilterComposer
    extends Composer<_$AppDatabase, $DrillsTable> {
  $$DrillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get objective => $composableBuilder(
      column: $table.objective, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnFilters(column));

  Expression<bool> drillPlayersRefs(
      Expression<bool> Function($$DrillPlayersTableFilterComposer f) f) {
    final $$DrillPlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.drillPlayers,
        getReferencedColumn: (t) => t.drillId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillPlayersTableFilterComposer(
              $db: $db,
              $table: $db.drillPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> drillStepsRefs(
      Expression<bool> Function($$DrillStepsTableFilterComposer f) f) {
    final $$DrillStepsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.drillSteps,
        getReferencedColumn: (t) => t.drillId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillStepsTableFilterComposer(
              $db: $db,
              $table: $db.drillSteps,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> drillTipsRefs(
      Expression<bool> Function($$DrillTipsTableFilterComposer f) f) {
    final $$DrillTipsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.drillTips,
        getReferencedColumn: (t) => t.drillId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillTipsTableFilterComposer(
              $db: $db,
              $table: $db.drillTips,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> drillErrorsRefs(
      Expression<bool> Function($$DrillErrorsTableFilterComposer f) f) {
    final $$DrillErrorsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.drillErrors,
        getReferencedColumn: (t) => t.drillId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillErrorsTableFilterComposer(
              $db: $db,
              $table: $db.drillErrors,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> drillVariationsRefs(
      Expression<bool> Function($$DrillVariationsTableFilterComposer f) f) {
    final $$DrillVariationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.drillVariations,
        getReferencedColumn: (t) => t.drillId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillVariationsTableFilterComposer(
              $db: $db,
              $table: $db.drillVariations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> drillAnimationFramesRefs(
      Expression<bool> Function($$DrillAnimationFramesTableFilterComposer f)
          f) {
    final $$DrillAnimationFramesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.drillAnimationFrames,
        getReferencedColumn: (t) => t.drillId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillAnimationFramesTableFilterComposer(
              $db: $db,
              $table: $db.drillAnimationFrames,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DrillsTableOrderingComposer
    extends Composer<_$AppDatabase, $DrillsTable> {
  $$DrillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get objective => $composableBuilder(
      column: $table.objective, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnOrderings(column));
}

class $$DrillsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrillsTable> {
  $$DrillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get objective =>
      $composableBuilder(column: $table.objective, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<String> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);

  Expression<T> drillPlayersRefs<T extends Object>(
      Expression<T> Function($$DrillPlayersTableAnnotationComposer a) f) {
    final $$DrillPlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.drillPlayers,
        getReferencedColumn: (t) => t.drillId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillPlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.drillPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> drillStepsRefs<T extends Object>(
      Expression<T> Function($$DrillStepsTableAnnotationComposer a) f) {
    final $$DrillStepsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.drillSteps,
        getReferencedColumn: (t) => t.drillId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillStepsTableAnnotationComposer(
              $db: $db,
              $table: $db.drillSteps,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> drillTipsRefs<T extends Object>(
      Expression<T> Function($$DrillTipsTableAnnotationComposer a) f) {
    final $$DrillTipsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.drillTips,
        getReferencedColumn: (t) => t.drillId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillTipsTableAnnotationComposer(
              $db: $db,
              $table: $db.drillTips,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> drillErrorsRefs<T extends Object>(
      Expression<T> Function($$DrillErrorsTableAnnotationComposer a) f) {
    final $$DrillErrorsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.drillErrors,
        getReferencedColumn: (t) => t.drillId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillErrorsTableAnnotationComposer(
              $db: $db,
              $table: $db.drillErrors,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> drillVariationsRefs<T extends Object>(
      Expression<T> Function($$DrillVariationsTableAnnotationComposer a) f) {
    final $$DrillVariationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.drillVariations,
        getReferencedColumn: (t) => t.drillId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillVariationsTableAnnotationComposer(
              $db: $db,
              $table: $db.drillVariations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> drillAnimationFramesRefs<T extends Object>(
      Expression<T> Function($$DrillAnimationFramesTableAnnotationComposer a)
          f) {
    final $$DrillAnimationFramesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.drillAnimationFrames,
            getReferencedColumn: (t) => t.drillId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$DrillAnimationFramesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.drillAnimationFrames,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$DrillsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DrillsTable,
    Drill,
    $$DrillsTableFilterComposer,
    $$DrillsTableOrderingComposer,
    $$DrillsTableAnnotationComposer,
    $$DrillsTableCreateCompanionBuilder,
    $$DrillsTableUpdateCompanionBuilder,
    (Drill, $$DrillsTableReferences),
    Drill,
    PrefetchHooks Function(
        {bool drillPlayersRefs,
        bool drillStepsRefs,
        bool drillTipsRefs,
        bool drillErrorsRefs,
        bool drillVariationsRefs,
        bool drillAnimationFramesRefs})> {
  $$DrillsTableTableManager(_$AppDatabase db, $DrillsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> objective = const Value.absent(),
            Value<String> difficulty = const Value.absent(),
            Value<String> duration = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillsCompanion(
            id: id,
            name: name,
            category: category,
            objective: objective,
            difficulty: difficulty,
            duration: duration,
            isFavorite: isFavorite,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String category,
            required String objective,
            required String difficulty,
            required String duration,
            required bool isFavorite,
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillsCompanion.insert(
            id: id,
            name: name,
            category: category,
            objective: objective,
            difficulty: difficulty,
            duration: duration,
            isFavorite: isFavorite,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$DrillsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {drillPlayersRefs = false,
              drillStepsRefs = false,
              drillTipsRefs = false,
              drillErrorsRefs = false,
              drillVariationsRefs = false,
              drillAnimationFramesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (drillPlayersRefs) db.drillPlayers,
                if (drillStepsRefs) db.drillSteps,
                if (drillTipsRefs) db.drillTips,
                if (drillErrorsRefs) db.drillErrors,
                if (drillVariationsRefs) db.drillVariations,
                if (drillAnimationFramesRefs) db.drillAnimationFrames
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (drillPlayersRefs)
                    await $_getPrefetchedData<Drill, $DrillsTable, DrillPlayer>(
                        currentTable: table,
                        referencedTable:
                            $$DrillsTableReferences._drillPlayersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DrillsTableReferences(db, table, p0)
                                .drillPlayersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.drillId == item.id),
                        typedResults: items),
                  if (drillStepsRefs)
                    await $_getPrefetchedData<Drill, $DrillsTable, DrillStep>(
                        currentTable: table,
                        referencedTable:
                            $$DrillsTableReferences._drillStepsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DrillsTableReferences(db, table, p0)
                                .drillStepsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.drillId == item.id),
                        typedResults: items),
                  if (drillTipsRefs)
                    await $_getPrefetchedData<Drill, $DrillsTable, DrillTip>(
                        currentTable: table,
                        referencedTable:
                            $$DrillsTableReferences._drillTipsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DrillsTableReferences(db, table, p0)
                                .drillTipsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.drillId == item.id),
                        typedResults: items),
                  if (drillErrorsRefs)
                    await $_getPrefetchedData<Drill, $DrillsTable, DrillError>(
                        currentTable: table,
                        referencedTable:
                            $$DrillsTableReferences._drillErrorsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DrillsTableReferences(db, table, p0)
                                .drillErrorsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.drillId == item.id),
                        typedResults: items),
                  if (drillVariationsRefs)
                    await $_getPrefetchedData<Drill, $DrillsTable,
                            DrillVariation>(
                        currentTable: table,
                        referencedTable: $$DrillsTableReferences
                            ._drillVariationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DrillsTableReferences(db, table, p0)
                                .drillVariationsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.drillId == item.id),
                        typedResults: items),
                  if (drillAnimationFramesRefs)
                    await $_getPrefetchedData<Drill, $DrillsTable,
                            DrillAnimationFrame>(
                        currentTable: table,
                        referencedTable: $$DrillsTableReferences
                            ._drillAnimationFramesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DrillsTableReferences(db, table, p0)
                                .drillAnimationFramesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.drillId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$DrillsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DrillsTable,
    Drill,
    $$DrillsTableFilterComposer,
    $$DrillsTableOrderingComposer,
    $$DrillsTableAnnotationComposer,
    $$DrillsTableCreateCompanionBuilder,
    $$DrillsTableUpdateCompanionBuilder,
    (Drill, $$DrillsTableReferences),
    Drill,
    PrefetchHooks Function(
        {bool drillPlayersRefs,
        bool drillStepsRefs,
        bool drillTipsRefs,
        bool drillErrorsRefs,
        bool drillVariationsRefs,
        bool drillAnimationFramesRefs})>;
typedef $$DrillPlayersTableCreateCompanionBuilder = DrillPlayersCompanion
    Function({
  required String id,
  required String drillId,
  required String playerId,
  required String label,
  required String role,
  required int colorHex,
  Value<int> rowid,
});
typedef $$DrillPlayersTableUpdateCompanionBuilder = DrillPlayersCompanion
    Function({
  Value<String> id,
  Value<String> drillId,
  Value<String> playerId,
  Value<String> label,
  Value<String> role,
  Value<int> colorHex,
  Value<int> rowid,
});

final class $$DrillPlayersTableReferences
    extends BaseReferences<_$AppDatabase, $DrillPlayersTable, DrillPlayer> {
  $$DrillPlayersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DrillsTable _drillIdTable(_$AppDatabase db) => db.drills
      .createAlias($_aliasNameGenerator(db.drillPlayers.drillId, db.drills.id));

  $$DrillsTableProcessedTableManager get drillId {
    final $_column = $_itemColumn<String>('drill_id')!;

    final manager = $$DrillsTableTableManager($_db, $_db.drills)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_drillIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DrillPlayersTableFilterComposer
    extends Composer<_$AppDatabase, $DrillPlayersTable> {
  $$DrillPlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get playerId => $composableBuilder(
      column: $table.playerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnFilters(column));

  $$DrillsTableFilterComposer get drillId {
    final $$DrillsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.drillId,
        referencedTable: $db.drills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillsTableFilterComposer(
              $db: $db,
              $table: $db.drills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrillPlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $DrillPlayersTable> {
  $$DrillPlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get playerId => $composableBuilder(
      column: $table.playerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnOrderings(column));

  $$DrillsTableOrderingComposer get drillId {
    final $$DrillsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.drillId,
        referencedTable: $db.drills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillsTableOrderingComposer(
              $db: $db,
              $table: $db.drills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrillPlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrillPlayersTable> {
  $$DrillPlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get playerId =>
      $composableBuilder(column: $table.playerId, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<int> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  $$DrillsTableAnnotationComposer get drillId {
    final $$DrillsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.drillId,
        referencedTable: $db.drills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillsTableAnnotationComposer(
              $db: $db,
              $table: $db.drills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrillPlayersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DrillPlayersTable,
    DrillPlayer,
    $$DrillPlayersTableFilterComposer,
    $$DrillPlayersTableOrderingComposer,
    $$DrillPlayersTableAnnotationComposer,
    $$DrillPlayersTableCreateCompanionBuilder,
    $$DrillPlayersTableUpdateCompanionBuilder,
    (DrillPlayer, $$DrillPlayersTableReferences),
    DrillPlayer,
    PrefetchHooks Function({bool drillId})> {
  $$DrillPlayersTableTableManager(_$AppDatabase db, $DrillPlayersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrillPlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrillPlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrillPlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> drillId = const Value.absent(),
            Value<String> playerId = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<int> colorHex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillPlayersCompanion(
            id: id,
            drillId: drillId,
            playerId: playerId,
            label: label,
            role: role,
            colorHex: colorHex,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String drillId,
            required String playerId,
            required String label,
            required String role,
            required int colorHex,
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillPlayersCompanion.insert(
            id: id,
            drillId: drillId,
            playerId: playerId,
            label: label,
            role: role,
            colorHex: colorHex,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DrillPlayersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({drillId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (drillId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.drillId,
                    referencedTable:
                        $$DrillPlayersTableReferences._drillIdTable(db),
                    referencedColumn:
                        $$DrillPlayersTableReferences._drillIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DrillPlayersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DrillPlayersTable,
    DrillPlayer,
    $$DrillPlayersTableFilterComposer,
    $$DrillPlayersTableOrderingComposer,
    $$DrillPlayersTableAnnotationComposer,
    $$DrillPlayersTableCreateCompanionBuilder,
    $$DrillPlayersTableUpdateCompanionBuilder,
    (DrillPlayer, $$DrillPlayersTableReferences),
    DrillPlayer,
    PrefetchHooks Function({bool drillId})>;
typedef $$DrillStepsTableCreateCompanionBuilder = DrillStepsCompanion Function({
  required String id,
  required String drillId,
  required int sortOrder,
  required String textValue,
  Value<int> rowid,
});
typedef $$DrillStepsTableUpdateCompanionBuilder = DrillStepsCompanion Function({
  Value<String> id,
  Value<String> drillId,
  Value<int> sortOrder,
  Value<String> textValue,
  Value<int> rowid,
});

final class $$DrillStepsTableReferences
    extends BaseReferences<_$AppDatabase, $DrillStepsTable, DrillStep> {
  $$DrillStepsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DrillsTable _drillIdTable(_$AppDatabase db) => db.drills
      .createAlias($_aliasNameGenerator(db.drillSteps.drillId, db.drills.id));

  $$DrillsTableProcessedTableManager get drillId {
    final $_column = $_itemColumn<String>('drill_id')!;

    final manager = $$DrillsTableTableManager($_db, $_db.drills)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_drillIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DrillStepsTableFilterComposer
    extends Composer<_$AppDatabase, $DrillStepsTable> {
  $$DrillStepsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textValue => $composableBuilder(
      column: $table.textValue, builder: (column) => ColumnFilters(column));

  $$DrillsTableFilterComposer get drillId {
    final $$DrillsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.drillId,
        referencedTable: $db.drills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillsTableFilterComposer(
              $db: $db,
              $table: $db.drills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrillStepsTableOrderingComposer
    extends Composer<_$AppDatabase, $DrillStepsTable> {
  $$DrillStepsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textValue => $composableBuilder(
      column: $table.textValue, builder: (column) => ColumnOrderings(column));

  $$DrillsTableOrderingComposer get drillId {
    final $$DrillsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.drillId,
        referencedTable: $db.drills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillsTableOrderingComposer(
              $db: $db,
              $table: $db.drills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrillStepsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrillStepsTable> {
  $$DrillStepsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get textValue =>
      $composableBuilder(column: $table.textValue, builder: (column) => column);

  $$DrillsTableAnnotationComposer get drillId {
    final $$DrillsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.drillId,
        referencedTable: $db.drills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillsTableAnnotationComposer(
              $db: $db,
              $table: $db.drills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrillStepsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DrillStepsTable,
    DrillStep,
    $$DrillStepsTableFilterComposer,
    $$DrillStepsTableOrderingComposer,
    $$DrillStepsTableAnnotationComposer,
    $$DrillStepsTableCreateCompanionBuilder,
    $$DrillStepsTableUpdateCompanionBuilder,
    (DrillStep, $$DrillStepsTableReferences),
    DrillStep,
    PrefetchHooks Function({bool drillId})> {
  $$DrillStepsTableTableManager(_$AppDatabase db, $DrillStepsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrillStepsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrillStepsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrillStepsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> drillId = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<String> textValue = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillStepsCompanion(
            id: id,
            drillId: drillId,
            sortOrder: sortOrder,
            textValue: textValue,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String drillId,
            required int sortOrder,
            required String textValue,
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillStepsCompanion.insert(
            id: id,
            drillId: drillId,
            sortOrder: sortOrder,
            textValue: textValue,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DrillStepsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({drillId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (drillId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.drillId,
                    referencedTable:
                        $$DrillStepsTableReferences._drillIdTable(db),
                    referencedColumn:
                        $$DrillStepsTableReferences._drillIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DrillStepsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DrillStepsTable,
    DrillStep,
    $$DrillStepsTableFilterComposer,
    $$DrillStepsTableOrderingComposer,
    $$DrillStepsTableAnnotationComposer,
    $$DrillStepsTableCreateCompanionBuilder,
    $$DrillStepsTableUpdateCompanionBuilder,
    (DrillStep, $$DrillStepsTableReferences),
    DrillStep,
    PrefetchHooks Function({bool drillId})>;
typedef $$DrillTipsTableCreateCompanionBuilder = DrillTipsCompanion Function({
  required String id,
  required String drillId,
  required int sortOrder,
  required String textValue,
  Value<int> rowid,
});
typedef $$DrillTipsTableUpdateCompanionBuilder = DrillTipsCompanion Function({
  Value<String> id,
  Value<String> drillId,
  Value<int> sortOrder,
  Value<String> textValue,
  Value<int> rowid,
});

final class $$DrillTipsTableReferences
    extends BaseReferences<_$AppDatabase, $DrillTipsTable, DrillTip> {
  $$DrillTipsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DrillsTable _drillIdTable(_$AppDatabase db) => db.drills
      .createAlias($_aliasNameGenerator(db.drillTips.drillId, db.drills.id));

  $$DrillsTableProcessedTableManager get drillId {
    final $_column = $_itemColumn<String>('drill_id')!;

    final manager = $$DrillsTableTableManager($_db, $_db.drills)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_drillIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DrillTipsTableFilterComposer
    extends Composer<_$AppDatabase, $DrillTipsTable> {
  $$DrillTipsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textValue => $composableBuilder(
      column: $table.textValue, builder: (column) => ColumnFilters(column));

  $$DrillsTableFilterComposer get drillId {
    final $$DrillsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.drillId,
        referencedTable: $db.drills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillsTableFilterComposer(
              $db: $db,
              $table: $db.drills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrillTipsTableOrderingComposer
    extends Composer<_$AppDatabase, $DrillTipsTable> {
  $$DrillTipsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textValue => $composableBuilder(
      column: $table.textValue, builder: (column) => ColumnOrderings(column));

  $$DrillsTableOrderingComposer get drillId {
    final $$DrillsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.drillId,
        referencedTable: $db.drills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillsTableOrderingComposer(
              $db: $db,
              $table: $db.drills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrillTipsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrillTipsTable> {
  $$DrillTipsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get textValue =>
      $composableBuilder(column: $table.textValue, builder: (column) => column);

  $$DrillsTableAnnotationComposer get drillId {
    final $$DrillsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.drillId,
        referencedTable: $db.drills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillsTableAnnotationComposer(
              $db: $db,
              $table: $db.drills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrillTipsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DrillTipsTable,
    DrillTip,
    $$DrillTipsTableFilterComposer,
    $$DrillTipsTableOrderingComposer,
    $$DrillTipsTableAnnotationComposer,
    $$DrillTipsTableCreateCompanionBuilder,
    $$DrillTipsTableUpdateCompanionBuilder,
    (DrillTip, $$DrillTipsTableReferences),
    DrillTip,
    PrefetchHooks Function({bool drillId})> {
  $$DrillTipsTableTableManager(_$AppDatabase db, $DrillTipsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrillTipsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrillTipsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrillTipsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> drillId = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<String> textValue = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillTipsCompanion(
            id: id,
            drillId: drillId,
            sortOrder: sortOrder,
            textValue: textValue,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String drillId,
            required int sortOrder,
            required String textValue,
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillTipsCompanion.insert(
            id: id,
            drillId: drillId,
            sortOrder: sortOrder,
            textValue: textValue,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DrillTipsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({drillId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (drillId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.drillId,
                    referencedTable:
                        $$DrillTipsTableReferences._drillIdTable(db),
                    referencedColumn:
                        $$DrillTipsTableReferences._drillIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DrillTipsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DrillTipsTable,
    DrillTip,
    $$DrillTipsTableFilterComposer,
    $$DrillTipsTableOrderingComposer,
    $$DrillTipsTableAnnotationComposer,
    $$DrillTipsTableCreateCompanionBuilder,
    $$DrillTipsTableUpdateCompanionBuilder,
    (DrillTip, $$DrillTipsTableReferences),
    DrillTip,
    PrefetchHooks Function({bool drillId})>;
typedef $$DrillErrorsTableCreateCompanionBuilder = DrillErrorsCompanion
    Function({
  required String id,
  required String drillId,
  required int sortOrder,
  required String textValue,
  Value<int> rowid,
});
typedef $$DrillErrorsTableUpdateCompanionBuilder = DrillErrorsCompanion
    Function({
  Value<String> id,
  Value<String> drillId,
  Value<int> sortOrder,
  Value<String> textValue,
  Value<int> rowid,
});

final class $$DrillErrorsTableReferences
    extends BaseReferences<_$AppDatabase, $DrillErrorsTable, DrillError> {
  $$DrillErrorsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DrillsTable _drillIdTable(_$AppDatabase db) => db.drills
      .createAlias($_aliasNameGenerator(db.drillErrors.drillId, db.drills.id));

  $$DrillsTableProcessedTableManager get drillId {
    final $_column = $_itemColumn<String>('drill_id')!;

    final manager = $$DrillsTableTableManager($_db, $_db.drills)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_drillIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DrillErrorsTableFilterComposer
    extends Composer<_$AppDatabase, $DrillErrorsTable> {
  $$DrillErrorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textValue => $composableBuilder(
      column: $table.textValue, builder: (column) => ColumnFilters(column));

  $$DrillsTableFilterComposer get drillId {
    final $$DrillsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.drillId,
        referencedTable: $db.drills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillsTableFilterComposer(
              $db: $db,
              $table: $db.drills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrillErrorsTableOrderingComposer
    extends Composer<_$AppDatabase, $DrillErrorsTable> {
  $$DrillErrorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textValue => $composableBuilder(
      column: $table.textValue, builder: (column) => ColumnOrderings(column));

  $$DrillsTableOrderingComposer get drillId {
    final $$DrillsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.drillId,
        referencedTable: $db.drills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillsTableOrderingComposer(
              $db: $db,
              $table: $db.drills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrillErrorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrillErrorsTable> {
  $$DrillErrorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get textValue =>
      $composableBuilder(column: $table.textValue, builder: (column) => column);

  $$DrillsTableAnnotationComposer get drillId {
    final $$DrillsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.drillId,
        referencedTable: $db.drills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillsTableAnnotationComposer(
              $db: $db,
              $table: $db.drills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrillErrorsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DrillErrorsTable,
    DrillError,
    $$DrillErrorsTableFilterComposer,
    $$DrillErrorsTableOrderingComposer,
    $$DrillErrorsTableAnnotationComposer,
    $$DrillErrorsTableCreateCompanionBuilder,
    $$DrillErrorsTableUpdateCompanionBuilder,
    (DrillError, $$DrillErrorsTableReferences),
    DrillError,
    PrefetchHooks Function({bool drillId})> {
  $$DrillErrorsTableTableManager(_$AppDatabase db, $DrillErrorsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrillErrorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrillErrorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrillErrorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> drillId = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<String> textValue = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillErrorsCompanion(
            id: id,
            drillId: drillId,
            sortOrder: sortOrder,
            textValue: textValue,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String drillId,
            required int sortOrder,
            required String textValue,
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillErrorsCompanion.insert(
            id: id,
            drillId: drillId,
            sortOrder: sortOrder,
            textValue: textValue,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DrillErrorsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({drillId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (drillId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.drillId,
                    referencedTable:
                        $$DrillErrorsTableReferences._drillIdTable(db),
                    referencedColumn:
                        $$DrillErrorsTableReferences._drillIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DrillErrorsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DrillErrorsTable,
    DrillError,
    $$DrillErrorsTableFilterComposer,
    $$DrillErrorsTableOrderingComposer,
    $$DrillErrorsTableAnnotationComposer,
    $$DrillErrorsTableCreateCompanionBuilder,
    $$DrillErrorsTableUpdateCompanionBuilder,
    (DrillError, $$DrillErrorsTableReferences),
    DrillError,
    PrefetchHooks Function({bool drillId})>;
typedef $$DrillVariationsTableCreateCompanionBuilder = DrillVariationsCompanion
    Function({
  required String id,
  required String drillId,
  required int sortOrder,
  required String textValue,
  Value<int> rowid,
});
typedef $$DrillVariationsTableUpdateCompanionBuilder = DrillVariationsCompanion
    Function({
  Value<String> id,
  Value<String> drillId,
  Value<int> sortOrder,
  Value<String> textValue,
  Value<int> rowid,
});

final class $$DrillVariationsTableReferences extends BaseReferences<
    _$AppDatabase, $DrillVariationsTable, DrillVariation> {
  $$DrillVariationsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $DrillsTable _drillIdTable(_$AppDatabase db) => db.drills.createAlias(
      $_aliasNameGenerator(db.drillVariations.drillId, db.drills.id));

  $$DrillsTableProcessedTableManager get drillId {
    final $_column = $_itemColumn<String>('drill_id')!;

    final manager = $$DrillsTableTableManager($_db, $_db.drills)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_drillIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DrillVariationsTableFilterComposer
    extends Composer<_$AppDatabase, $DrillVariationsTable> {
  $$DrillVariationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textValue => $composableBuilder(
      column: $table.textValue, builder: (column) => ColumnFilters(column));

  $$DrillsTableFilterComposer get drillId {
    final $$DrillsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.drillId,
        referencedTable: $db.drills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillsTableFilterComposer(
              $db: $db,
              $table: $db.drills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrillVariationsTableOrderingComposer
    extends Composer<_$AppDatabase, $DrillVariationsTable> {
  $$DrillVariationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textValue => $composableBuilder(
      column: $table.textValue, builder: (column) => ColumnOrderings(column));

  $$DrillsTableOrderingComposer get drillId {
    final $$DrillsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.drillId,
        referencedTable: $db.drills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillsTableOrderingComposer(
              $db: $db,
              $table: $db.drills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrillVariationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrillVariationsTable> {
  $$DrillVariationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get textValue =>
      $composableBuilder(column: $table.textValue, builder: (column) => column);

  $$DrillsTableAnnotationComposer get drillId {
    final $$DrillsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.drillId,
        referencedTable: $db.drills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillsTableAnnotationComposer(
              $db: $db,
              $table: $db.drills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrillVariationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DrillVariationsTable,
    DrillVariation,
    $$DrillVariationsTableFilterComposer,
    $$DrillVariationsTableOrderingComposer,
    $$DrillVariationsTableAnnotationComposer,
    $$DrillVariationsTableCreateCompanionBuilder,
    $$DrillVariationsTableUpdateCompanionBuilder,
    (DrillVariation, $$DrillVariationsTableReferences),
    DrillVariation,
    PrefetchHooks Function({bool drillId})> {
  $$DrillVariationsTableTableManager(
      _$AppDatabase db, $DrillVariationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrillVariationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrillVariationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrillVariationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> drillId = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<String> textValue = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillVariationsCompanion(
            id: id,
            drillId: drillId,
            sortOrder: sortOrder,
            textValue: textValue,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String drillId,
            required int sortOrder,
            required String textValue,
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillVariationsCompanion.insert(
            id: id,
            drillId: drillId,
            sortOrder: sortOrder,
            textValue: textValue,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DrillVariationsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({drillId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (drillId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.drillId,
                    referencedTable:
                        $$DrillVariationsTableReferences._drillIdTable(db),
                    referencedColumn:
                        $$DrillVariationsTableReferences._drillIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DrillVariationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DrillVariationsTable,
    DrillVariation,
    $$DrillVariationsTableFilterComposer,
    $$DrillVariationsTableOrderingComposer,
    $$DrillVariationsTableAnnotationComposer,
    $$DrillVariationsTableCreateCompanionBuilder,
    $$DrillVariationsTableUpdateCompanionBuilder,
    (DrillVariation, $$DrillVariationsTableReferences),
    DrillVariation,
    PrefetchHooks Function({bool drillId})>;
typedef $$DrillAnimationFramesTableCreateCompanionBuilder
    = DrillAnimationFramesCompanion Function({
  required String id,
  required String drillId,
  required int sortOrder,
  required int timestamp,
  required int stepIndex,
  Value<String?> highlightPlayerId,
  Value<String?> instructionText,
  Value<double?> ballX,
  Value<double?> ballY,
  Value<int> rowid,
});
typedef $$DrillAnimationFramesTableUpdateCompanionBuilder
    = DrillAnimationFramesCompanion Function({
  Value<String> id,
  Value<String> drillId,
  Value<int> sortOrder,
  Value<int> timestamp,
  Value<int> stepIndex,
  Value<String?> highlightPlayerId,
  Value<String?> instructionText,
  Value<double?> ballX,
  Value<double?> ballY,
  Value<int> rowid,
});

final class $$DrillAnimationFramesTableReferences extends BaseReferences<
    _$AppDatabase, $DrillAnimationFramesTable, DrillAnimationFrame> {
  $$DrillAnimationFramesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $DrillsTable _drillIdTable(_$AppDatabase db) => db.drills.createAlias(
      $_aliasNameGenerator(db.drillAnimationFrames.drillId, db.drills.id));

  $$DrillsTableProcessedTableManager get drillId {
    final $_column = $_itemColumn<String>('drill_id')!;

    final manager = $$DrillsTableTableManager($_db, $_db.drills)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_drillIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$DrillFramePlayersTable, List<DrillFramePlayer>>
      _drillFramePlayersRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.drillFramePlayers,
              aliasName: $_aliasNameGenerator(
                  db.drillAnimationFrames.id, db.drillFramePlayers.frameId));

  $$DrillFramePlayersTableProcessedTableManager get drillFramePlayersRefs {
    final manager =
        $$DrillFramePlayersTableTableManager($_db, $_db.drillFramePlayers)
            .filter((f) => f.frameId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_drillFramePlayersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DrillFrameMovementsTable,
      List<DrillFrameMovement>> _drillFrameMovementsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.drillFrameMovements,
          aliasName: $_aliasNameGenerator(
              db.drillAnimationFrames.id, db.drillFrameMovements.frameId));

  $$DrillFrameMovementsTableProcessedTableManager get drillFrameMovementsRefs {
    final manager =
        $$DrillFrameMovementsTableTableManager($_db, $_db.drillFrameMovements)
            .filter((f) => f.frameId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_drillFrameMovementsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DrillFrameZonesTable, List<DrillFrameZone>>
      _drillFrameZonesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.drillFrameZones,
              aliasName: $_aliasNameGenerator(
                  db.drillAnimationFrames.id, db.drillFrameZones.frameId));

  $$DrillFrameZonesTableProcessedTableManager get drillFrameZonesRefs {
    final manager =
        $$DrillFrameZonesTableTableManager($_db, $_db.drillFrameZones)
            .filter((f) => f.frameId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_drillFrameZonesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DrillAnimationFramesTableFilterComposer
    extends Composer<_$AppDatabase, $DrillAnimationFramesTable> {
  $$DrillAnimationFramesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stepIndex => $composableBuilder(
      column: $table.stepIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get highlightPlayerId => $composableBuilder(
      column: $table.highlightPlayerId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get instructionText => $composableBuilder(
      column: $table.instructionText,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get ballX => $composableBuilder(
      column: $table.ballX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get ballY => $composableBuilder(
      column: $table.ballY, builder: (column) => ColumnFilters(column));

  $$DrillsTableFilterComposer get drillId {
    final $$DrillsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.drillId,
        referencedTable: $db.drills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillsTableFilterComposer(
              $db: $db,
              $table: $db.drills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> drillFramePlayersRefs(
      Expression<bool> Function($$DrillFramePlayersTableFilterComposer f) f) {
    final $$DrillFramePlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.drillFramePlayers,
        getReferencedColumn: (t) => t.frameId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillFramePlayersTableFilterComposer(
              $db: $db,
              $table: $db.drillFramePlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> drillFrameMovementsRefs(
      Expression<bool> Function($$DrillFrameMovementsTableFilterComposer f) f) {
    final $$DrillFrameMovementsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.drillFrameMovements,
        getReferencedColumn: (t) => t.frameId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillFrameMovementsTableFilterComposer(
              $db: $db,
              $table: $db.drillFrameMovements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> drillFrameZonesRefs(
      Expression<bool> Function($$DrillFrameZonesTableFilterComposer f) f) {
    final $$DrillFrameZonesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.drillFrameZones,
        getReferencedColumn: (t) => t.frameId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillFrameZonesTableFilterComposer(
              $db: $db,
              $table: $db.drillFrameZones,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DrillAnimationFramesTableOrderingComposer
    extends Composer<_$AppDatabase, $DrillAnimationFramesTable> {
  $$DrillAnimationFramesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stepIndex => $composableBuilder(
      column: $table.stepIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get highlightPlayerId => $composableBuilder(
      column: $table.highlightPlayerId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get instructionText => $composableBuilder(
      column: $table.instructionText,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get ballX => $composableBuilder(
      column: $table.ballX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get ballY => $composableBuilder(
      column: $table.ballY, builder: (column) => ColumnOrderings(column));

  $$DrillsTableOrderingComposer get drillId {
    final $$DrillsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.drillId,
        referencedTable: $db.drills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillsTableOrderingComposer(
              $db: $db,
              $table: $db.drills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrillAnimationFramesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrillAnimationFramesTable> {
  $$DrillAnimationFramesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get stepIndex =>
      $composableBuilder(column: $table.stepIndex, builder: (column) => column);

  GeneratedColumn<String> get highlightPlayerId => $composableBuilder(
      column: $table.highlightPlayerId, builder: (column) => column);

  GeneratedColumn<String> get instructionText => $composableBuilder(
      column: $table.instructionText, builder: (column) => column);

  GeneratedColumn<double> get ballX =>
      $composableBuilder(column: $table.ballX, builder: (column) => column);

  GeneratedColumn<double> get ballY =>
      $composableBuilder(column: $table.ballY, builder: (column) => column);

  $$DrillsTableAnnotationComposer get drillId {
    final $$DrillsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.drillId,
        referencedTable: $db.drills,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillsTableAnnotationComposer(
              $db: $db,
              $table: $db.drills,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> drillFramePlayersRefs<T extends Object>(
      Expression<T> Function($$DrillFramePlayersTableAnnotationComposer a) f) {
    final $$DrillFramePlayersTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.drillFramePlayers,
            getReferencedColumn: (t) => t.frameId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$DrillFramePlayersTableAnnotationComposer(
                  $db: $db,
                  $table: $db.drillFramePlayers,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> drillFrameMovementsRefs<T extends Object>(
      Expression<T> Function($$DrillFrameMovementsTableAnnotationComposer a)
          f) {
    final $$DrillFrameMovementsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.drillFrameMovements,
            getReferencedColumn: (t) => t.frameId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$DrillFrameMovementsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.drillFrameMovements,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> drillFrameZonesRefs<T extends Object>(
      Expression<T> Function($$DrillFrameZonesTableAnnotationComposer a) f) {
    final $$DrillFrameZonesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.drillFrameZones,
        getReferencedColumn: (t) => t.frameId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillFrameZonesTableAnnotationComposer(
              $db: $db,
              $table: $db.drillFrameZones,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DrillAnimationFramesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DrillAnimationFramesTable,
    DrillAnimationFrame,
    $$DrillAnimationFramesTableFilterComposer,
    $$DrillAnimationFramesTableOrderingComposer,
    $$DrillAnimationFramesTableAnnotationComposer,
    $$DrillAnimationFramesTableCreateCompanionBuilder,
    $$DrillAnimationFramesTableUpdateCompanionBuilder,
    (DrillAnimationFrame, $$DrillAnimationFramesTableReferences),
    DrillAnimationFrame,
    PrefetchHooks Function(
        {bool drillId,
        bool drillFramePlayersRefs,
        bool drillFrameMovementsRefs,
        bool drillFrameZonesRefs})> {
  $$DrillAnimationFramesTableTableManager(
      _$AppDatabase db, $DrillAnimationFramesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrillAnimationFramesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrillAnimationFramesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrillAnimationFramesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> drillId = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> timestamp = const Value.absent(),
            Value<int> stepIndex = const Value.absent(),
            Value<String?> highlightPlayerId = const Value.absent(),
            Value<String?> instructionText = const Value.absent(),
            Value<double?> ballX = const Value.absent(),
            Value<double?> ballY = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillAnimationFramesCompanion(
            id: id,
            drillId: drillId,
            sortOrder: sortOrder,
            timestamp: timestamp,
            stepIndex: stepIndex,
            highlightPlayerId: highlightPlayerId,
            instructionText: instructionText,
            ballX: ballX,
            ballY: ballY,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String drillId,
            required int sortOrder,
            required int timestamp,
            required int stepIndex,
            Value<String?> highlightPlayerId = const Value.absent(),
            Value<String?> instructionText = const Value.absent(),
            Value<double?> ballX = const Value.absent(),
            Value<double?> ballY = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillAnimationFramesCompanion.insert(
            id: id,
            drillId: drillId,
            sortOrder: sortOrder,
            timestamp: timestamp,
            stepIndex: stepIndex,
            highlightPlayerId: highlightPlayerId,
            instructionText: instructionText,
            ballX: ballX,
            ballY: ballY,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DrillAnimationFramesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {drillId = false,
              drillFramePlayersRefs = false,
              drillFrameMovementsRefs = false,
              drillFrameZonesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (drillFramePlayersRefs) db.drillFramePlayers,
                if (drillFrameMovementsRefs) db.drillFrameMovements,
                if (drillFrameZonesRefs) db.drillFrameZones
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (drillId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.drillId,
                    referencedTable:
                        $$DrillAnimationFramesTableReferences._drillIdTable(db),
                    referencedColumn: $$DrillAnimationFramesTableReferences
                        ._drillIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (drillFramePlayersRefs)
                    await $_getPrefetchedData<DrillAnimationFrame,
                            $DrillAnimationFramesTable, DrillFramePlayer>(
                        currentTable: table,
                        referencedTable: $$DrillAnimationFramesTableReferences
                            ._drillFramePlayersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DrillAnimationFramesTableReferences(db, table, p0)
                                .drillFramePlayersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.frameId == item.id),
                        typedResults: items),
                  if (drillFrameMovementsRefs)
                    await $_getPrefetchedData<DrillAnimationFrame,
                            $DrillAnimationFramesTable, DrillFrameMovement>(
                        currentTable: table,
                        referencedTable: $$DrillAnimationFramesTableReferences
                            ._drillFrameMovementsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DrillAnimationFramesTableReferences(db, table, p0)
                                .drillFrameMovementsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.frameId == item.id),
                        typedResults: items),
                  if (drillFrameZonesRefs)
                    await $_getPrefetchedData<DrillAnimationFrame,
                            $DrillAnimationFramesTable, DrillFrameZone>(
                        currentTable: table,
                        referencedTable: $$DrillAnimationFramesTableReferences
                            ._drillFrameZonesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DrillAnimationFramesTableReferences(db, table, p0)
                                .drillFrameZonesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.frameId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$DrillAnimationFramesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $DrillAnimationFramesTable,
        DrillAnimationFrame,
        $$DrillAnimationFramesTableFilterComposer,
        $$DrillAnimationFramesTableOrderingComposer,
        $$DrillAnimationFramesTableAnnotationComposer,
        $$DrillAnimationFramesTableCreateCompanionBuilder,
        $$DrillAnimationFramesTableUpdateCompanionBuilder,
        (DrillAnimationFrame, $$DrillAnimationFramesTableReferences),
        DrillAnimationFrame,
        PrefetchHooks Function(
            {bool drillId,
            bool drillFramePlayersRefs,
            bool drillFrameMovementsRefs,
            bool drillFrameZonesRefs})>;
typedef $$DrillFramePlayersTableCreateCompanionBuilder
    = DrillFramePlayersCompanion Function({
  required String id,
  required String frameId,
  required String playerId,
  required double x,
  required double y,
  Value<int> rowid,
});
typedef $$DrillFramePlayersTableUpdateCompanionBuilder
    = DrillFramePlayersCompanion Function({
  Value<String> id,
  Value<String> frameId,
  Value<String> playerId,
  Value<double> x,
  Value<double> y,
  Value<int> rowid,
});

final class $$DrillFramePlayersTableReferences extends BaseReferences<
    _$AppDatabase, $DrillFramePlayersTable, DrillFramePlayer> {
  $$DrillFramePlayersTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $DrillAnimationFramesTable _frameIdTable(_$AppDatabase db) =>
      db.drillAnimationFrames.createAlias($_aliasNameGenerator(
          db.drillFramePlayers.frameId, db.drillAnimationFrames.id));

  $$DrillAnimationFramesTableProcessedTableManager get frameId {
    final $_column = $_itemColumn<String>('frame_id')!;

    final manager =
        $$DrillAnimationFramesTableTableManager($_db, $_db.drillAnimationFrames)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_frameIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DrillFramePlayersTableFilterComposer
    extends Composer<_$AppDatabase, $DrillFramePlayersTable> {
  $$DrillFramePlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get playerId => $composableBuilder(
      column: $table.playerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get x => $composableBuilder(
      column: $table.x, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get y => $composableBuilder(
      column: $table.y, builder: (column) => ColumnFilters(column));

  $$DrillAnimationFramesTableFilterComposer get frameId {
    final $$DrillAnimationFramesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.frameId,
        referencedTable: $db.drillAnimationFrames,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillAnimationFramesTableFilterComposer(
              $db: $db,
              $table: $db.drillAnimationFrames,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrillFramePlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $DrillFramePlayersTable> {
  $$DrillFramePlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get playerId => $composableBuilder(
      column: $table.playerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get x => $composableBuilder(
      column: $table.x, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get y => $composableBuilder(
      column: $table.y, builder: (column) => ColumnOrderings(column));

  $$DrillAnimationFramesTableOrderingComposer get frameId {
    final $$DrillAnimationFramesTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.frameId,
            referencedTable: $db.drillAnimationFrames,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$DrillAnimationFramesTableOrderingComposer(
                  $db: $db,
                  $table: $db.drillAnimationFrames,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$DrillFramePlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrillFramePlayersTable> {
  $$DrillFramePlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get playerId =>
      $composableBuilder(column: $table.playerId, builder: (column) => column);

  GeneratedColumn<double> get x =>
      $composableBuilder(column: $table.x, builder: (column) => column);

  GeneratedColumn<double> get y =>
      $composableBuilder(column: $table.y, builder: (column) => column);

  $$DrillAnimationFramesTableAnnotationComposer get frameId {
    final $$DrillAnimationFramesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.frameId,
            referencedTable: $db.drillAnimationFrames,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$DrillAnimationFramesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.drillAnimationFrames,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$DrillFramePlayersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DrillFramePlayersTable,
    DrillFramePlayer,
    $$DrillFramePlayersTableFilterComposer,
    $$DrillFramePlayersTableOrderingComposer,
    $$DrillFramePlayersTableAnnotationComposer,
    $$DrillFramePlayersTableCreateCompanionBuilder,
    $$DrillFramePlayersTableUpdateCompanionBuilder,
    (DrillFramePlayer, $$DrillFramePlayersTableReferences),
    DrillFramePlayer,
    PrefetchHooks Function({bool frameId})> {
  $$DrillFramePlayersTableTableManager(
      _$AppDatabase db, $DrillFramePlayersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrillFramePlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrillFramePlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrillFramePlayersTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> frameId = const Value.absent(),
            Value<String> playerId = const Value.absent(),
            Value<double> x = const Value.absent(),
            Value<double> y = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillFramePlayersCompanion(
            id: id,
            frameId: frameId,
            playerId: playerId,
            x: x,
            y: y,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String frameId,
            required String playerId,
            required double x,
            required double y,
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillFramePlayersCompanion.insert(
            id: id,
            frameId: frameId,
            playerId: playerId,
            x: x,
            y: y,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DrillFramePlayersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({frameId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (frameId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.frameId,
                    referencedTable:
                        $$DrillFramePlayersTableReferences._frameIdTable(db),
                    referencedColumn:
                        $$DrillFramePlayersTableReferences._frameIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DrillFramePlayersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DrillFramePlayersTable,
    DrillFramePlayer,
    $$DrillFramePlayersTableFilterComposer,
    $$DrillFramePlayersTableOrderingComposer,
    $$DrillFramePlayersTableAnnotationComposer,
    $$DrillFramePlayersTableCreateCompanionBuilder,
    $$DrillFramePlayersTableUpdateCompanionBuilder,
    (DrillFramePlayer, $$DrillFramePlayersTableReferences),
    DrillFramePlayer,
    PrefetchHooks Function({bool frameId})>;
typedef $$DrillFrameMovementsTableCreateCompanionBuilder
    = DrillFrameMovementsCompanion Function({
  required String id,
  required String frameId,
  required String playerId,
  required double fromX,
  required double fromY,
  required double toX,
  required double toY,
  required String label,
  Value<int> rowid,
});
typedef $$DrillFrameMovementsTableUpdateCompanionBuilder
    = DrillFrameMovementsCompanion Function({
  Value<String> id,
  Value<String> frameId,
  Value<String> playerId,
  Value<double> fromX,
  Value<double> fromY,
  Value<double> toX,
  Value<double> toY,
  Value<String> label,
  Value<int> rowid,
});

final class $$DrillFrameMovementsTableReferences extends BaseReferences<
    _$AppDatabase, $DrillFrameMovementsTable, DrillFrameMovement> {
  $$DrillFrameMovementsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $DrillAnimationFramesTable _frameIdTable(_$AppDatabase db) =>
      db.drillAnimationFrames.createAlias($_aliasNameGenerator(
          db.drillFrameMovements.frameId, db.drillAnimationFrames.id));

  $$DrillAnimationFramesTableProcessedTableManager get frameId {
    final $_column = $_itemColumn<String>('frame_id')!;

    final manager =
        $$DrillAnimationFramesTableTableManager($_db, $_db.drillAnimationFrames)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_frameIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DrillFrameMovementsTableFilterComposer
    extends Composer<_$AppDatabase, $DrillFrameMovementsTable> {
  $$DrillFrameMovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get playerId => $composableBuilder(
      column: $table.playerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fromX => $composableBuilder(
      column: $table.fromX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fromY => $composableBuilder(
      column: $table.fromY, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get toX => $composableBuilder(
      column: $table.toX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get toY => $composableBuilder(
      column: $table.toY, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  $$DrillAnimationFramesTableFilterComposer get frameId {
    final $$DrillAnimationFramesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.frameId,
        referencedTable: $db.drillAnimationFrames,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillAnimationFramesTableFilterComposer(
              $db: $db,
              $table: $db.drillAnimationFrames,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrillFrameMovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $DrillFrameMovementsTable> {
  $$DrillFrameMovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get playerId => $composableBuilder(
      column: $table.playerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fromX => $composableBuilder(
      column: $table.fromX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fromY => $composableBuilder(
      column: $table.fromY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get toX => $composableBuilder(
      column: $table.toX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get toY => $composableBuilder(
      column: $table.toY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  $$DrillAnimationFramesTableOrderingComposer get frameId {
    final $$DrillAnimationFramesTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.frameId,
            referencedTable: $db.drillAnimationFrames,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$DrillAnimationFramesTableOrderingComposer(
                  $db: $db,
                  $table: $db.drillAnimationFrames,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$DrillFrameMovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrillFrameMovementsTable> {
  $$DrillFrameMovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get playerId =>
      $composableBuilder(column: $table.playerId, builder: (column) => column);

  GeneratedColumn<double> get fromX =>
      $composableBuilder(column: $table.fromX, builder: (column) => column);

  GeneratedColumn<double> get fromY =>
      $composableBuilder(column: $table.fromY, builder: (column) => column);

  GeneratedColumn<double> get toX =>
      $composableBuilder(column: $table.toX, builder: (column) => column);

  GeneratedColumn<double> get toY =>
      $composableBuilder(column: $table.toY, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  $$DrillAnimationFramesTableAnnotationComposer get frameId {
    final $$DrillAnimationFramesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.frameId,
            referencedTable: $db.drillAnimationFrames,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$DrillAnimationFramesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.drillAnimationFrames,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$DrillFrameMovementsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DrillFrameMovementsTable,
    DrillFrameMovement,
    $$DrillFrameMovementsTableFilterComposer,
    $$DrillFrameMovementsTableOrderingComposer,
    $$DrillFrameMovementsTableAnnotationComposer,
    $$DrillFrameMovementsTableCreateCompanionBuilder,
    $$DrillFrameMovementsTableUpdateCompanionBuilder,
    (DrillFrameMovement, $$DrillFrameMovementsTableReferences),
    DrillFrameMovement,
    PrefetchHooks Function({bool frameId})> {
  $$DrillFrameMovementsTableTableManager(
      _$AppDatabase db, $DrillFrameMovementsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrillFrameMovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrillFrameMovementsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrillFrameMovementsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> frameId = const Value.absent(),
            Value<String> playerId = const Value.absent(),
            Value<double> fromX = const Value.absent(),
            Value<double> fromY = const Value.absent(),
            Value<double> toX = const Value.absent(),
            Value<double> toY = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillFrameMovementsCompanion(
            id: id,
            frameId: frameId,
            playerId: playerId,
            fromX: fromX,
            fromY: fromY,
            toX: toX,
            toY: toY,
            label: label,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String frameId,
            required String playerId,
            required double fromX,
            required double fromY,
            required double toX,
            required double toY,
            required String label,
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillFrameMovementsCompanion.insert(
            id: id,
            frameId: frameId,
            playerId: playerId,
            fromX: fromX,
            fromY: fromY,
            toX: toX,
            toY: toY,
            label: label,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DrillFrameMovementsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({frameId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (frameId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.frameId,
                    referencedTable:
                        $$DrillFrameMovementsTableReferences._frameIdTable(db),
                    referencedColumn: $$DrillFrameMovementsTableReferences
                        ._frameIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DrillFrameMovementsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DrillFrameMovementsTable,
    DrillFrameMovement,
    $$DrillFrameMovementsTableFilterComposer,
    $$DrillFrameMovementsTableOrderingComposer,
    $$DrillFrameMovementsTableAnnotationComposer,
    $$DrillFrameMovementsTableCreateCompanionBuilder,
    $$DrillFrameMovementsTableUpdateCompanionBuilder,
    (DrillFrameMovement, $$DrillFrameMovementsTableReferences),
    DrillFrameMovement,
    PrefetchHooks Function({bool frameId})>;
typedef $$DrillFrameZonesTableCreateCompanionBuilder = DrillFrameZonesCompanion
    Function({
  required String id,
  required String frameId,
  required double x,
  required double y,
  required double width,
  required double height,
  required String label,
  Value<int> rowid,
});
typedef $$DrillFrameZonesTableUpdateCompanionBuilder = DrillFrameZonesCompanion
    Function({
  Value<String> id,
  Value<String> frameId,
  Value<double> x,
  Value<double> y,
  Value<double> width,
  Value<double> height,
  Value<String> label,
  Value<int> rowid,
});

final class $$DrillFrameZonesTableReferences extends BaseReferences<
    _$AppDatabase, $DrillFrameZonesTable, DrillFrameZone> {
  $$DrillFrameZonesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $DrillAnimationFramesTable _frameIdTable(_$AppDatabase db) =>
      db.drillAnimationFrames.createAlias($_aliasNameGenerator(
          db.drillFrameZones.frameId, db.drillAnimationFrames.id));

  $$DrillAnimationFramesTableProcessedTableManager get frameId {
    final $_column = $_itemColumn<String>('frame_id')!;

    final manager =
        $$DrillAnimationFramesTableTableManager($_db, $_db.drillAnimationFrames)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_frameIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DrillFrameZonesTableFilterComposer
    extends Composer<_$AppDatabase, $DrillFrameZonesTable> {
  $$DrillFrameZonesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get x => $composableBuilder(
      column: $table.x, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get y => $composableBuilder(
      column: $table.y, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get width => $composableBuilder(
      column: $table.width, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  $$DrillAnimationFramesTableFilterComposer get frameId {
    final $$DrillAnimationFramesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.frameId,
        referencedTable: $db.drillAnimationFrames,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrillAnimationFramesTableFilterComposer(
              $db: $db,
              $table: $db.drillAnimationFrames,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrillFrameZonesTableOrderingComposer
    extends Composer<_$AppDatabase, $DrillFrameZonesTable> {
  $$DrillFrameZonesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get x => $composableBuilder(
      column: $table.x, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get y => $composableBuilder(
      column: $table.y, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get width => $composableBuilder(
      column: $table.width, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  $$DrillAnimationFramesTableOrderingComposer get frameId {
    final $$DrillAnimationFramesTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.frameId,
            referencedTable: $db.drillAnimationFrames,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$DrillAnimationFramesTableOrderingComposer(
                  $db: $db,
                  $table: $db.drillAnimationFrames,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$DrillFrameZonesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrillFrameZonesTable> {
  $$DrillFrameZonesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get x =>
      $composableBuilder(column: $table.x, builder: (column) => column);

  GeneratedColumn<double> get y =>
      $composableBuilder(column: $table.y, builder: (column) => column);

  GeneratedColumn<double> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  $$DrillAnimationFramesTableAnnotationComposer get frameId {
    final $$DrillAnimationFramesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.frameId,
            referencedTable: $db.drillAnimationFrames,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$DrillAnimationFramesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.drillAnimationFrames,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$DrillFrameZonesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DrillFrameZonesTable,
    DrillFrameZone,
    $$DrillFrameZonesTableFilterComposer,
    $$DrillFrameZonesTableOrderingComposer,
    $$DrillFrameZonesTableAnnotationComposer,
    $$DrillFrameZonesTableCreateCompanionBuilder,
    $$DrillFrameZonesTableUpdateCompanionBuilder,
    (DrillFrameZone, $$DrillFrameZonesTableReferences),
    DrillFrameZone,
    PrefetchHooks Function({bool frameId})> {
  $$DrillFrameZonesTableTableManager(
      _$AppDatabase db, $DrillFrameZonesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrillFrameZonesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrillFrameZonesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrillFrameZonesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> frameId = const Value.absent(),
            Value<double> x = const Value.absent(),
            Value<double> y = const Value.absent(),
            Value<double> width = const Value.absent(),
            Value<double> height = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillFrameZonesCompanion(
            id: id,
            frameId: frameId,
            x: x,
            y: y,
            width: width,
            height: height,
            label: label,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String frameId,
            required double x,
            required double y,
            required double width,
            required double height,
            required String label,
            Value<int> rowid = const Value.absent(),
          }) =>
              DrillFrameZonesCompanion.insert(
            id: id,
            frameId: frameId,
            x: x,
            y: y,
            width: width,
            height: height,
            label: label,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DrillFrameZonesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({frameId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (frameId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.frameId,
                    referencedTable:
                        $$DrillFrameZonesTableReferences._frameIdTable(db),
                    referencedColumn:
                        $$DrillFrameZonesTableReferences._frameIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DrillFrameZonesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DrillFrameZonesTable,
    DrillFrameZone,
    $$DrillFrameZonesTableFilterComposer,
    $$DrillFrameZonesTableOrderingComposer,
    $$DrillFrameZonesTableAnnotationComposer,
    $$DrillFrameZonesTableCreateCompanionBuilder,
    $$DrillFrameZonesTableUpdateCompanionBuilder,
    (DrillFrameZone, $$DrillFrameZonesTableReferences),
    DrillFrameZone,
    PrefetchHooks Function({bool frameId})>;
typedef $$TeamDrawPlayersTableCreateCompanionBuilder = TeamDrawPlayersCompanion
    Function({
  required String id,
  required String name,
  required String position,
  required String level,
  Value<bool> isActive,
  required String createdAt,
  Value<int> rowid,
});
typedef $$TeamDrawPlayersTableUpdateCompanionBuilder = TeamDrawPlayersCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String> position,
  Value<String> level,
  Value<bool> isActive,
  Value<String> createdAt,
  Value<int> rowid,
});

final class $$TeamDrawPlayersTableReferences extends BaseReferences<
    _$AppDatabase, $TeamDrawPlayersTable, TeamDrawPlayer> {
  $$TeamDrawPlayersTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DrawSessionTeamPlayersTable,
      List<DrawSessionTeamPlayer>> _drawSessionTeamPlayersRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.drawSessionTeamPlayers,
          aliasName: $_aliasNameGenerator(
              db.teamDrawPlayers.id, db.drawSessionTeamPlayers.playerId));

  $$DrawSessionTeamPlayersTableProcessedTableManager
      get drawSessionTeamPlayersRefs {
    final manager = $$DrawSessionTeamPlayersTableTableManager(
            $_db, $_db.drawSessionTeamPlayers)
        .filter((f) => f.playerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_drawSessionTeamPlayersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WaitingQueueEntriesTable, List<WaitingQueueEntry>>
      _waitingQueueEntriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.waitingQueueEntries,
              aliasName: $_aliasNameGenerator(
                  db.teamDrawPlayers.id, db.waitingQueueEntries.playerId));

  $$WaitingQueueEntriesTableProcessedTableManager get waitingQueueEntriesRefs {
    final manager = $$WaitingQueueEntriesTableTableManager(
            $_db, $_db.waitingQueueEntries)
        .filter((f) => f.playerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_waitingQueueEntriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SavedTeamPlayersTable, List<SavedTeamPlayer>>
      _savedTeamPlayersRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.savedTeamPlayers,
              aliasName: $_aliasNameGenerator(
                  db.teamDrawPlayers.id, db.savedTeamPlayers.playerId));

  $$SavedTeamPlayersTableProcessedTableManager get savedTeamPlayersRefs {
    final manager = $$SavedTeamPlayersTableTableManager(
            $_db, $_db.savedTeamPlayers)
        .filter((f) => f.playerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_savedTeamPlayersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SavedGroupWaitingPlayersTable,
      List<SavedGroupWaitingPlayer>> _savedGroupWaitingPlayersRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.savedGroupWaitingPlayers,
          aliasName: $_aliasNameGenerator(
              db.teamDrawPlayers.id, db.savedGroupWaitingPlayers.playerId));

  $$SavedGroupWaitingPlayersTableProcessedTableManager
      get savedGroupWaitingPlayersRefs {
    final manager = $$SavedGroupWaitingPlayersTableTableManager(
            $_db, $_db.savedGroupWaitingPlayers)
        .filter((f) => f.playerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_savedGroupWaitingPlayersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TeamDrawPlayersTableFilterComposer
    extends Composer<_$AppDatabase, $TeamDrawPlayersTable> {
  $$TeamDrawPlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> drawSessionTeamPlayersRefs(
      Expression<bool> Function($$DrawSessionTeamPlayersTableFilterComposer f)
          f) {
    final $$DrawSessionTeamPlayersTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.drawSessionTeamPlayers,
            getReferencedColumn: (t) => t.playerId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$DrawSessionTeamPlayersTableFilterComposer(
                  $db: $db,
                  $table: $db.drawSessionTeamPlayers,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> waitingQueueEntriesRefs(
      Expression<bool> Function($$WaitingQueueEntriesTableFilterComposer f) f) {
    final $$WaitingQueueEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.waitingQueueEntries,
        getReferencedColumn: (t) => t.playerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WaitingQueueEntriesTableFilterComposer(
              $db: $db,
              $table: $db.waitingQueueEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> savedTeamPlayersRefs(
      Expression<bool> Function($$SavedTeamPlayersTableFilterComposer f) f) {
    final $$SavedTeamPlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.savedTeamPlayers,
        getReferencedColumn: (t) => t.playerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedTeamPlayersTableFilterComposer(
              $db: $db,
              $table: $db.savedTeamPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> savedGroupWaitingPlayersRefs(
      Expression<bool> Function($$SavedGroupWaitingPlayersTableFilterComposer f)
          f) {
    final $$SavedGroupWaitingPlayersTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.savedGroupWaitingPlayers,
            getReferencedColumn: (t) => t.playerId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SavedGroupWaitingPlayersTableFilterComposer(
                  $db: $db,
                  $table: $db.savedGroupWaitingPlayers,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$TeamDrawPlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $TeamDrawPlayersTable> {
  $$TeamDrawPlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$TeamDrawPlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeamDrawPlayersTable> {
  $$TeamDrawPlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> drawSessionTeamPlayersRefs<T extends Object>(
      Expression<T> Function($$DrawSessionTeamPlayersTableAnnotationComposer a)
          f) {
    final $$DrawSessionTeamPlayersTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.drawSessionTeamPlayers,
            getReferencedColumn: (t) => t.playerId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$DrawSessionTeamPlayersTableAnnotationComposer(
                  $db: $db,
                  $table: $db.drawSessionTeamPlayers,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> waitingQueueEntriesRefs<T extends Object>(
      Expression<T> Function($$WaitingQueueEntriesTableAnnotationComposer a)
          f) {
    final $$WaitingQueueEntriesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.waitingQueueEntries,
            getReferencedColumn: (t) => t.playerId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$WaitingQueueEntriesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.waitingQueueEntries,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> savedTeamPlayersRefs<T extends Object>(
      Expression<T> Function($$SavedTeamPlayersTableAnnotationComposer a) f) {
    final $$SavedTeamPlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.savedTeamPlayers,
        getReferencedColumn: (t) => t.playerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedTeamPlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.savedTeamPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> savedGroupWaitingPlayersRefs<T extends Object>(
      Expression<T> Function(
              $$SavedGroupWaitingPlayersTableAnnotationComposer a)
          f) {
    final $$SavedGroupWaitingPlayersTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.savedGroupWaitingPlayers,
            getReferencedColumn: (t) => t.playerId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SavedGroupWaitingPlayersTableAnnotationComposer(
                  $db: $db,
                  $table: $db.savedGroupWaitingPlayers,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$TeamDrawPlayersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TeamDrawPlayersTable,
    TeamDrawPlayer,
    $$TeamDrawPlayersTableFilterComposer,
    $$TeamDrawPlayersTableOrderingComposer,
    $$TeamDrawPlayersTableAnnotationComposer,
    $$TeamDrawPlayersTableCreateCompanionBuilder,
    $$TeamDrawPlayersTableUpdateCompanionBuilder,
    (TeamDrawPlayer, $$TeamDrawPlayersTableReferences),
    TeamDrawPlayer,
    PrefetchHooks Function(
        {bool drawSessionTeamPlayersRefs,
        bool waitingQueueEntriesRefs,
        bool savedTeamPlayersRefs,
        bool savedGroupWaitingPlayersRefs})> {
  $$TeamDrawPlayersTableTableManager(
      _$AppDatabase db, $TeamDrawPlayersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamDrawPlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamDrawPlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamDrawPlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> position = const Value.absent(),
            Value<String> level = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TeamDrawPlayersCompanion(
            id: id,
            name: name,
            position: position,
            level: level,
            isActive: isActive,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String position,
            required String level,
            Value<bool> isActive = const Value.absent(),
            required String createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              TeamDrawPlayersCompanion.insert(
            id: id,
            name: name,
            position: position,
            level: level,
            isActive: isActive,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TeamDrawPlayersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {drawSessionTeamPlayersRefs = false,
              waitingQueueEntriesRefs = false,
              savedTeamPlayersRefs = false,
              savedGroupWaitingPlayersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (drawSessionTeamPlayersRefs) db.drawSessionTeamPlayers,
                if (waitingQueueEntriesRefs) db.waitingQueueEntries,
                if (savedTeamPlayersRefs) db.savedTeamPlayers,
                if (savedGroupWaitingPlayersRefs) db.savedGroupWaitingPlayers
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (drawSessionTeamPlayersRefs)
                    await $_getPrefetchedData<TeamDrawPlayer,
                            $TeamDrawPlayersTable, DrawSessionTeamPlayer>(
                        currentTable: table,
                        referencedTable: $$TeamDrawPlayersTableReferences
                            ._drawSessionTeamPlayersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TeamDrawPlayersTableReferences(db, table, p0)
                                .drawSessionTeamPlayersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.playerId == item.id),
                        typedResults: items),
                  if (waitingQueueEntriesRefs)
                    await $_getPrefetchedData<TeamDrawPlayer,
                            $TeamDrawPlayersTable, WaitingQueueEntry>(
                        currentTable: table,
                        referencedTable: $$TeamDrawPlayersTableReferences
                            ._waitingQueueEntriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TeamDrawPlayersTableReferences(db, table, p0)
                                .waitingQueueEntriesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.playerId == item.id),
                        typedResults: items),
                  if (savedTeamPlayersRefs)
                    await $_getPrefetchedData<TeamDrawPlayer,
                            $TeamDrawPlayersTable, SavedTeamPlayer>(
                        currentTable: table,
                        referencedTable: $$TeamDrawPlayersTableReferences
                            ._savedTeamPlayersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TeamDrawPlayersTableReferences(db, table, p0)
                                .savedTeamPlayersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.playerId == item.id),
                        typedResults: items),
                  if (savedGroupWaitingPlayersRefs)
                    await $_getPrefetchedData<TeamDrawPlayer,
                            $TeamDrawPlayersTable, SavedGroupWaitingPlayer>(
                        currentTable: table,
                        referencedTable: $$TeamDrawPlayersTableReferences
                            ._savedGroupWaitingPlayersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TeamDrawPlayersTableReferences(db, table, p0)
                                .savedGroupWaitingPlayersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.playerId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TeamDrawPlayersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TeamDrawPlayersTable,
    TeamDrawPlayer,
    $$TeamDrawPlayersTableFilterComposer,
    $$TeamDrawPlayersTableOrderingComposer,
    $$TeamDrawPlayersTableAnnotationComposer,
    $$TeamDrawPlayersTableCreateCompanionBuilder,
    $$TeamDrawPlayersTableUpdateCompanionBuilder,
    (TeamDrawPlayer, $$TeamDrawPlayersTableReferences),
    TeamDrawPlayer,
    PrefetchHooks Function(
        {bool drawSessionTeamPlayersRefs,
        bool waitingQueueEntriesRefs,
        bool savedTeamPlayersRefs,
        bool savedGroupWaitingPlayersRefs})>;
typedef $$DrawSessionsTableCreateCompanionBuilder = DrawSessionsCompanion
    Function({
  required String id,
  required String contextKey,
  required int totalPlayers,
  required int numberOfTeams,
  required String drawMode,
  required String oddPlayerHandling,
  required String createdAt,
  Value<int> rowid,
});
typedef $$DrawSessionsTableUpdateCompanionBuilder = DrawSessionsCompanion
    Function({
  Value<String> id,
  Value<String> contextKey,
  Value<int> totalPlayers,
  Value<int> numberOfTeams,
  Value<String> drawMode,
  Value<String> oddPlayerHandling,
  Value<String> createdAt,
  Value<int> rowid,
});

final class $$DrawSessionsTableReferences
    extends BaseReferences<_$AppDatabase, $DrawSessionsTable, DrawSession> {
  $$DrawSessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DrawSessionTeamsTable, List<DrawSessionTeam>>
      _drawSessionTeamsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.drawSessionTeams,
              aliasName: $_aliasNameGenerator(
                  db.drawSessions.id, db.drawSessionTeams.sessionId));

  $$DrawSessionTeamsTableProcessedTableManager get drawSessionTeamsRefs {
    final manager = $$DrawSessionTeamsTableTableManager(
            $_db, $_db.drawSessionTeams)
        .filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_drawSessionTeamsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DrawSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $DrawSessionsTable> {
  $$DrawSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contextKey => $composableBuilder(
      column: $table.contextKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalPlayers => $composableBuilder(
      column: $table.totalPlayers, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get numberOfTeams => $composableBuilder(
      column: $table.numberOfTeams, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get drawMode => $composableBuilder(
      column: $table.drawMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get oddPlayerHandling => $composableBuilder(
      column: $table.oddPlayerHandling,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> drawSessionTeamsRefs(
      Expression<bool> Function($$DrawSessionTeamsTableFilterComposer f) f) {
    final $$DrawSessionTeamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.drawSessionTeams,
        getReferencedColumn: (t) => t.sessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrawSessionTeamsTableFilterComposer(
              $db: $db,
              $table: $db.drawSessionTeams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DrawSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $DrawSessionsTable> {
  $$DrawSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contextKey => $composableBuilder(
      column: $table.contextKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalPlayers => $composableBuilder(
      column: $table.totalPlayers,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get numberOfTeams => $composableBuilder(
      column: $table.numberOfTeams,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get drawMode => $composableBuilder(
      column: $table.drawMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get oddPlayerHandling => $composableBuilder(
      column: $table.oddPlayerHandling,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$DrawSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrawSessionsTable> {
  $$DrawSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contextKey => $composableBuilder(
      column: $table.contextKey, builder: (column) => column);

  GeneratedColumn<int> get totalPlayers => $composableBuilder(
      column: $table.totalPlayers, builder: (column) => column);

  GeneratedColumn<int> get numberOfTeams => $composableBuilder(
      column: $table.numberOfTeams, builder: (column) => column);

  GeneratedColumn<String> get drawMode =>
      $composableBuilder(column: $table.drawMode, builder: (column) => column);

  GeneratedColumn<String> get oddPlayerHandling => $composableBuilder(
      column: $table.oddPlayerHandling, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> drawSessionTeamsRefs<T extends Object>(
      Expression<T> Function($$DrawSessionTeamsTableAnnotationComposer a) f) {
    final $$DrawSessionTeamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.drawSessionTeams,
        getReferencedColumn: (t) => t.sessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrawSessionTeamsTableAnnotationComposer(
              $db: $db,
              $table: $db.drawSessionTeams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DrawSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DrawSessionsTable,
    DrawSession,
    $$DrawSessionsTableFilterComposer,
    $$DrawSessionsTableOrderingComposer,
    $$DrawSessionsTableAnnotationComposer,
    $$DrawSessionsTableCreateCompanionBuilder,
    $$DrawSessionsTableUpdateCompanionBuilder,
    (DrawSession, $$DrawSessionsTableReferences),
    DrawSession,
    PrefetchHooks Function({bool drawSessionTeamsRefs})> {
  $$DrawSessionsTableTableManager(_$AppDatabase db, $DrawSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrawSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrawSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrawSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> contextKey = const Value.absent(),
            Value<int> totalPlayers = const Value.absent(),
            Value<int> numberOfTeams = const Value.absent(),
            Value<String> drawMode = const Value.absent(),
            Value<String> oddPlayerHandling = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DrawSessionsCompanion(
            id: id,
            contextKey: contextKey,
            totalPlayers: totalPlayers,
            numberOfTeams: numberOfTeams,
            drawMode: drawMode,
            oddPlayerHandling: oddPlayerHandling,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String contextKey,
            required int totalPlayers,
            required int numberOfTeams,
            required String drawMode,
            required String oddPlayerHandling,
            required String createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              DrawSessionsCompanion.insert(
            id: id,
            contextKey: contextKey,
            totalPlayers: totalPlayers,
            numberOfTeams: numberOfTeams,
            drawMode: drawMode,
            oddPlayerHandling: oddPlayerHandling,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DrawSessionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({drawSessionTeamsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (drawSessionTeamsRefs) db.drawSessionTeams
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (drawSessionTeamsRefs)
                    await $_getPrefetchedData<DrawSession, $DrawSessionsTable,
                            DrawSessionTeam>(
                        currentTable: table,
                        referencedTable: $$DrawSessionsTableReferences
                            ._drawSessionTeamsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DrawSessionsTableReferences(db, table, p0)
                                .drawSessionTeamsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sessionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$DrawSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DrawSessionsTable,
    DrawSession,
    $$DrawSessionsTableFilterComposer,
    $$DrawSessionsTableOrderingComposer,
    $$DrawSessionsTableAnnotationComposer,
    $$DrawSessionsTableCreateCompanionBuilder,
    $$DrawSessionsTableUpdateCompanionBuilder,
    (DrawSession, $$DrawSessionsTableReferences),
    DrawSession,
    PrefetchHooks Function({bool drawSessionTeamsRefs})>;
typedef $$DrawSessionTeamsTableCreateCompanionBuilder
    = DrawSessionTeamsCompanion Function({
  required String id,
  required String sessionId,
  required String name,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$DrawSessionTeamsTableUpdateCompanionBuilder
    = DrawSessionTeamsCompanion Function({
  Value<String> id,
  Value<String> sessionId,
  Value<String> name,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$DrawSessionTeamsTableReferences extends BaseReferences<
    _$AppDatabase, $DrawSessionTeamsTable, DrawSessionTeam> {
  $$DrawSessionTeamsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $DrawSessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.drawSessions.createAlias($_aliasNameGenerator(
          db.drawSessionTeams.sessionId, db.drawSessions.id));

  $$DrawSessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$DrawSessionsTableTableManager($_db, $_db.drawSessions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$DrawSessionTeamPlayersTable,
      List<DrawSessionTeamPlayer>> _drawSessionTeamPlayersRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.drawSessionTeamPlayers,
          aliasName: $_aliasNameGenerator(
              db.drawSessionTeams.id, db.drawSessionTeamPlayers.sessionTeamId));

  $$DrawSessionTeamPlayersTableProcessedTableManager
      get drawSessionTeamPlayersRefs {
    final manager = $$DrawSessionTeamPlayersTableTableManager(
            $_db, $_db.drawSessionTeamPlayers)
        .filter(
            (f) => f.sessionTeamId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_drawSessionTeamPlayersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DrawSessionTeamsTableFilterComposer
    extends Composer<_$AppDatabase, $DrawSessionTeamsTable> {
  $$DrawSessionTeamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  $$DrawSessionsTableFilterComposer get sessionId {
    final $$DrawSessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.drawSessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrawSessionsTableFilterComposer(
              $db: $db,
              $table: $db.drawSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> drawSessionTeamPlayersRefs(
      Expression<bool> Function($$DrawSessionTeamPlayersTableFilterComposer f)
          f) {
    final $$DrawSessionTeamPlayersTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.drawSessionTeamPlayers,
            getReferencedColumn: (t) => t.sessionTeamId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$DrawSessionTeamPlayersTableFilterComposer(
                  $db: $db,
                  $table: $db.drawSessionTeamPlayers,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$DrawSessionTeamsTableOrderingComposer
    extends Composer<_$AppDatabase, $DrawSessionTeamsTable> {
  $$DrawSessionTeamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  $$DrawSessionsTableOrderingComposer get sessionId {
    final $$DrawSessionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.drawSessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrawSessionsTableOrderingComposer(
              $db: $db,
              $table: $db.drawSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrawSessionTeamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrawSessionTeamsTable> {
  $$DrawSessionTeamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$DrawSessionsTableAnnotationComposer get sessionId {
    final $$DrawSessionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.drawSessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrawSessionsTableAnnotationComposer(
              $db: $db,
              $table: $db.drawSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> drawSessionTeamPlayersRefs<T extends Object>(
      Expression<T> Function($$DrawSessionTeamPlayersTableAnnotationComposer a)
          f) {
    final $$DrawSessionTeamPlayersTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.drawSessionTeamPlayers,
            getReferencedColumn: (t) => t.sessionTeamId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$DrawSessionTeamPlayersTableAnnotationComposer(
                  $db: $db,
                  $table: $db.drawSessionTeamPlayers,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$DrawSessionTeamsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DrawSessionTeamsTable,
    DrawSessionTeam,
    $$DrawSessionTeamsTableFilterComposer,
    $$DrawSessionTeamsTableOrderingComposer,
    $$DrawSessionTeamsTableAnnotationComposer,
    $$DrawSessionTeamsTableCreateCompanionBuilder,
    $$DrawSessionTeamsTableUpdateCompanionBuilder,
    (DrawSessionTeam, $$DrawSessionTeamsTableReferences),
    DrawSessionTeam,
    PrefetchHooks Function({bool sessionId, bool drawSessionTeamPlayersRefs})> {
  $$DrawSessionTeamsTableTableManager(
      _$AppDatabase db, $DrawSessionTeamsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrawSessionTeamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrawSessionTeamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrawSessionTeamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> sessionId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DrawSessionTeamsCompanion(
            id: id,
            sessionId: sessionId,
            name: name,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String sessionId,
            required String name,
            required int sortOrder,
            Value<int> rowid = const Value.absent(),
          }) =>
              DrawSessionTeamsCompanion.insert(
            id: id,
            sessionId: sessionId,
            name: name,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DrawSessionTeamsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {sessionId = false, drawSessionTeamPlayersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (drawSessionTeamPlayersRefs) db.drawSessionTeamPlayers
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (sessionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sessionId,
                    referencedTable:
                        $$DrawSessionTeamsTableReferences._sessionIdTable(db),
                    referencedColumn: $$DrawSessionTeamsTableReferences
                        ._sessionIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (drawSessionTeamPlayersRefs)
                    await $_getPrefetchedData<DrawSessionTeam,
                            $DrawSessionTeamsTable, DrawSessionTeamPlayer>(
                        currentTable: table,
                        referencedTable: $$DrawSessionTeamsTableReferences
                            ._drawSessionTeamPlayersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DrawSessionTeamsTableReferences(db, table, p0)
                                .drawSessionTeamPlayersRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sessionTeamId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$DrawSessionTeamsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DrawSessionTeamsTable,
    DrawSessionTeam,
    $$DrawSessionTeamsTableFilterComposer,
    $$DrawSessionTeamsTableOrderingComposer,
    $$DrawSessionTeamsTableAnnotationComposer,
    $$DrawSessionTeamsTableCreateCompanionBuilder,
    $$DrawSessionTeamsTableUpdateCompanionBuilder,
    (DrawSessionTeam, $$DrawSessionTeamsTableReferences),
    DrawSessionTeam,
    PrefetchHooks Function({bool sessionId, bool drawSessionTeamPlayersRefs})>;
typedef $$DrawSessionTeamPlayersTableCreateCompanionBuilder
    = DrawSessionTeamPlayersCompanion Function({
  required String id,
  required String sessionTeamId,
  required String playerId,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$DrawSessionTeamPlayersTableUpdateCompanionBuilder
    = DrawSessionTeamPlayersCompanion Function({
  Value<String> id,
  Value<String> sessionTeamId,
  Value<String> playerId,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$DrawSessionTeamPlayersTableReferences extends BaseReferences<
    _$AppDatabase, $DrawSessionTeamPlayersTable, DrawSessionTeamPlayer> {
  $$DrawSessionTeamPlayersTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $DrawSessionTeamsTable _sessionTeamIdTable(_$AppDatabase db) =>
      db.drawSessionTeams.createAlias($_aliasNameGenerator(
          db.drawSessionTeamPlayers.sessionTeamId, db.drawSessionTeams.id));

  $$DrawSessionTeamsTableProcessedTableManager get sessionTeamId {
    final $_column = $_itemColumn<String>('session_team_id')!;

    final manager =
        $$DrawSessionTeamsTableTableManager($_db, $_db.drawSessionTeams)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionTeamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TeamDrawPlayersTable _playerIdTable(_$AppDatabase db) =>
      db.teamDrawPlayers.createAlias($_aliasNameGenerator(
          db.drawSessionTeamPlayers.playerId, db.teamDrawPlayers.id));

  $$TeamDrawPlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<String>('player_id')!;

    final manager =
        $$TeamDrawPlayersTableTableManager($_db, $_db.teamDrawPlayers)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DrawSessionTeamPlayersTableFilterComposer
    extends Composer<_$AppDatabase, $DrawSessionTeamPlayersTable> {
  $$DrawSessionTeamPlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  $$DrawSessionTeamsTableFilterComposer get sessionTeamId {
    final $$DrawSessionTeamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionTeamId,
        referencedTable: $db.drawSessionTeams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrawSessionTeamsTableFilterComposer(
              $db: $db,
              $table: $db.drawSessionTeams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamDrawPlayersTableFilterComposer get playerId {
    final $$TeamDrawPlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.teamDrawPlayers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamDrawPlayersTableFilterComposer(
              $db: $db,
              $table: $db.teamDrawPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrawSessionTeamPlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $DrawSessionTeamPlayersTable> {
  $$DrawSessionTeamPlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  $$DrawSessionTeamsTableOrderingComposer get sessionTeamId {
    final $$DrawSessionTeamsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionTeamId,
        referencedTable: $db.drawSessionTeams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrawSessionTeamsTableOrderingComposer(
              $db: $db,
              $table: $db.drawSessionTeams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamDrawPlayersTableOrderingComposer get playerId {
    final $$TeamDrawPlayersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.teamDrawPlayers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamDrawPlayersTableOrderingComposer(
              $db: $db,
              $table: $db.teamDrawPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrawSessionTeamPlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrawSessionTeamPlayersTable> {
  $$DrawSessionTeamPlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$DrawSessionTeamsTableAnnotationComposer get sessionTeamId {
    final $$DrawSessionTeamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionTeamId,
        referencedTable: $db.drawSessionTeams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DrawSessionTeamsTableAnnotationComposer(
              $db: $db,
              $table: $db.drawSessionTeams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamDrawPlayersTableAnnotationComposer get playerId {
    final $$TeamDrawPlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.teamDrawPlayers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamDrawPlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.teamDrawPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DrawSessionTeamPlayersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DrawSessionTeamPlayersTable,
    DrawSessionTeamPlayer,
    $$DrawSessionTeamPlayersTableFilterComposer,
    $$DrawSessionTeamPlayersTableOrderingComposer,
    $$DrawSessionTeamPlayersTableAnnotationComposer,
    $$DrawSessionTeamPlayersTableCreateCompanionBuilder,
    $$DrawSessionTeamPlayersTableUpdateCompanionBuilder,
    (DrawSessionTeamPlayer, $$DrawSessionTeamPlayersTableReferences),
    DrawSessionTeamPlayer,
    PrefetchHooks Function({bool sessionTeamId, bool playerId})> {
  $$DrawSessionTeamPlayersTableTableManager(
      _$AppDatabase db, $DrawSessionTeamPlayersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrawSessionTeamPlayersTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$DrawSessionTeamPlayersTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrawSessionTeamPlayersTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> sessionTeamId = const Value.absent(),
            Value<String> playerId = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DrawSessionTeamPlayersCompanion(
            id: id,
            sessionTeamId: sessionTeamId,
            playerId: playerId,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String sessionTeamId,
            required String playerId,
            required int sortOrder,
            Value<int> rowid = const Value.absent(),
          }) =>
              DrawSessionTeamPlayersCompanion.insert(
            id: id,
            sessionTeamId: sessionTeamId,
            playerId: playerId,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DrawSessionTeamPlayersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({sessionTeamId = false, playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (sessionTeamId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sessionTeamId,
                    referencedTable: $$DrawSessionTeamPlayersTableReferences
                        ._sessionTeamIdTable(db),
                    referencedColumn: $$DrawSessionTeamPlayersTableReferences
                        ._sessionTeamIdTable(db)
                        .id,
                  ) as T;
                }
                if (playerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.playerId,
                    referencedTable: $$DrawSessionTeamPlayersTableReferences
                        ._playerIdTable(db),
                    referencedColumn: $$DrawSessionTeamPlayersTableReferences
                        ._playerIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DrawSessionTeamPlayersTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $DrawSessionTeamPlayersTable,
        DrawSessionTeamPlayer,
        $$DrawSessionTeamPlayersTableFilterComposer,
        $$DrawSessionTeamPlayersTableOrderingComposer,
        $$DrawSessionTeamPlayersTableAnnotationComposer,
        $$DrawSessionTeamPlayersTableCreateCompanionBuilder,
        $$DrawSessionTeamPlayersTableUpdateCompanionBuilder,
        (DrawSessionTeamPlayer, $$DrawSessionTeamPlayersTableReferences),
        DrawSessionTeamPlayer,
        PrefetchHooks Function({bool sessionTeamId, bool playerId})>;
typedef $$WaitingQueueEntriesTableCreateCompanionBuilder
    = WaitingQueueEntriesCompanion Function({
  required String id,
  required String contextKey,
  required String playerId,
  required String playerName,
  required String waitingSince,
  required int priorityOrder,
  Value<String?> lastSessionId,
  Value<int> rowid,
});
typedef $$WaitingQueueEntriesTableUpdateCompanionBuilder
    = WaitingQueueEntriesCompanion Function({
  Value<String> id,
  Value<String> contextKey,
  Value<String> playerId,
  Value<String> playerName,
  Value<String> waitingSince,
  Value<int> priorityOrder,
  Value<String?> lastSessionId,
  Value<int> rowid,
});

final class $$WaitingQueueEntriesTableReferences extends BaseReferences<
    _$AppDatabase, $WaitingQueueEntriesTable, WaitingQueueEntry> {
  $$WaitingQueueEntriesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TeamDrawPlayersTable _playerIdTable(_$AppDatabase db) =>
      db.teamDrawPlayers.createAlias($_aliasNameGenerator(
          db.waitingQueueEntries.playerId, db.teamDrawPlayers.id));

  $$TeamDrawPlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<String>('player_id')!;

    final manager =
        $$TeamDrawPlayersTableTableManager($_db, $_db.teamDrawPlayers)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WaitingQueueEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $WaitingQueueEntriesTable> {
  $$WaitingQueueEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contextKey => $composableBuilder(
      column: $table.contextKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get playerName => $composableBuilder(
      column: $table.playerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get waitingSince => $composableBuilder(
      column: $table.waitingSince, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priorityOrder => $composableBuilder(
      column: $table.priorityOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastSessionId => $composableBuilder(
      column: $table.lastSessionId, builder: (column) => ColumnFilters(column));

  $$TeamDrawPlayersTableFilterComposer get playerId {
    final $$TeamDrawPlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.teamDrawPlayers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamDrawPlayersTableFilterComposer(
              $db: $db,
              $table: $db.teamDrawPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WaitingQueueEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $WaitingQueueEntriesTable> {
  $$WaitingQueueEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contextKey => $composableBuilder(
      column: $table.contextKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get playerName => $composableBuilder(
      column: $table.playerName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get waitingSince => $composableBuilder(
      column: $table.waitingSince,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priorityOrder => $composableBuilder(
      column: $table.priorityOrder,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastSessionId => $composableBuilder(
      column: $table.lastSessionId,
      builder: (column) => ColumnOrderings(column));

  $$TeamDrawPlayersTableOrderingComposer get playerId {
    final $$TeamDrawPlayersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.teamDrawPlayers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamDrawPlayersTableOrderingComposer(
              $db: $db,
              $table: $db.teamDrawPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WaitingQueueEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WaitingQueueEntriesTable> {
  $$WaitingQueueEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contextKey => $composableBuilder(
      column: $table.contextKey, builder: (column) => column);

  GeneratedColumn<String> get playerName => $composableBuilder(
      column: $table.playerName, builder: (column) => column);

  GeneratedColumn<String> get waitingSince => $composableBuilder(
      column: $table.waitingSince, builder: (column) => column);

  GeneratedColumn<int> get priorityOrder => $composableBuilder(
      column: $table.priorityOrder, builder: (column) => column);

  GeneratedColumn<String> get lastSessionId => $composableBuilder(
      column: $table.lastSessionId, builder: (column) => column);

  $$TeamDrawPlayersTableAnnotationComposer get playerId {
    final $$TeamDrawPlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.teamDrawPlayers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamDrawPlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.teamDrawPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WaitingQueueEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WaitingQueueEntriesTable,
    WaitingQueueEntry,
    $$WaitingQueueEntriesTableFilterComposer,
    $$WaitingQueueEntriesTableOrderingComposer,
    $$WaitingQueueEntriesTableAnnotationComposer,
    $$WaitingQueueEntriesTableCreateCompanionBuilder,
    $$WaitingQueueEntriesTableUpdateCompanionBuilder,
    (WaitingQueueEntry, $$WaitingQueueEntriesTableReferences),
    WaitingQueueEntry,
    PrefetchHooks Function({bool playerId})> {
  $$WaitingQueueEntriesTableTableManager(
      _$AppDatabase db, $WaitingQueueEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WaitingQueueEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WaitingQueueEntriesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WaitingQueueEntriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> contextKey = const Value.absent(),
            Value<String> playerId = const Value.absent(),
            Value<String> playerName = const Value.absent(),
            Value<String> waitingSince = const Value.absent(),
            Value<int> priorityOrder = const Value.absent(),
            Value<String?> lastSessionId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WaitingQueueEntriesCompanion(
            id: id,
            contextKey: contextKey,
            playerId: playerId,
            playerName: playerName,
            waitingSince: waitingSince,
            priorityOrder: priorityOrder,
            lastSessionId: lastSessionId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String contextKey,
            required String playerId,
            required String playerName,
            required String waitingSince,
            required int priorityOrder,
            Value<String?> lastSessionId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WaitingQueueEntriesCompanion.insert(
            id: id,
            contextKey: contextKey,
            playerId: playerId,
            playerName: playerName,
            waitingSince: waitingSince,
            priorityOrder: priorityOrder,
            lastSessionId: lastSessionId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WaitingQueueEntriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (playerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.playerId,
                    referencedTable:
                        $$WaitingQueueEntriesTableReferences._playerIdTable(db),
                    referencedColumn: $$WaitingQueueEntriesTableReferences
                        ._playerIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$WaitingQueueEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WaitingQueueEntriesTable,
    WaitingQueueEntry,
    $$WaitingQueueEntriesTableFilterComposer,
    $$WaitingQueueEntriesTableOrderingComposer,
    $$WaitingQueueEntriesTableAnnotationComposer,
    $$WaitingQueueEntriesTableCreateCompanionBuilder,
    $$WaitingQueueEntriesTableUpdateCompanionBuilder,
    (WaitingQueueEntry, $$WaitingQueueEntriesTableReferences),
    WaitingQueueEntry,
    PrefetchHooks Function({bool playerId})>;
typedef $$SavedTeamGroupsTableCreateCompanionBuilder = SavedTeamGroupsCompanion
    Function({
  required String id,
  required String title,
  required String sourceType,
  Value<String?> contextKey,
  Value<String?> notes,
  required String createdAt,
  Value<int> rowid,
});
typedef $$SavedTeamGroupsTableUpdateCompanionBuilder = SavedTeamGroupsCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<String> sourceType,
  Value<String?> contextKey,
  Value<String?> notes,
  Value<String> createdAt,
  Value<int> rowid,
});

final class $$SavedTeamGroupsTableReferences extends BaseReferences<
    _$AppDatabase, $SavedTeamGroupsTable, SavedTeamGroup> {
  $$SavedTeamGroupsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SavedTeamsTable, List<SavedTeam>>
      _savedTeamsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.savedTeams,
              aliasName: $_aliasNameGenerator(
                  db.savedTeamGroups.id, db.savedTeams.groupId));

  $$SavedTeamsTableProcessedTableManager get savedTeamsRefs {
    final manager = $$SavedTeamsTableTableManager($_db, $_db.savedTeams)
        .filter((f) => f.groupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_savedTeamsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SavedGroupWaitingPlayersTable,
      List<SavedGroupWaitingPlayer>> _savedGroupWaitingPlayersRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.savedGroupWaitingPlayers,
          aliasName: $_aliasNameGenerator(
              db.savedTeamGroups.id, db.savedGroupWaitingPlayers.groupId));

  $$SavedGroupWaitingPlayersTableProcessedTableManager
      get savedGroupWaitingPlayersRefs {
    final manager = $$SavedGroupWaitingPlayersTableTableManager(
            $_db, $_db.savedGroupWaitingPlayers)
        .filter((f) => f.groupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_savedGroupWaitingPlayersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SavedTeamGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $SavedTeamGroupsTable> {
  $$SavedTeamGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceType => $composableBuilder(
      column: $table.sourceType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contextKey => $composableBuilder(
      column: $table.contextKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> savedTeamsRefs(
      Expression<bool> Function($$SavedTeamsTableFilterComposer f) f) {
    final $$SavedTeamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.savedTeams,
        getReferencedColumn: (t) => t.groupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedTeamsTableFilterComposer(
              $db: $db,
              $table: $db.savedTeams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> savedGroupWaitingPlayersRefs(
      Expression<bool> Function($$SavedGroupWaitingPlayersTableFilterComposer f)
          f) {
    final $$SavedGroupWaitingPlayersTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.savedGroupWaitingPlayers,
            getReferencedColumn: (t) => t.groupId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SavedGroupWaitingPlayersTableFilterComposer(
                  $db: $db,
                  $table: $db.savedGroupWaitingPlayers,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$SavedTeamGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedTeamGroupsTable> {
  $$SavedTeamGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceType => $composableBuilder(
      column: $table.sourceType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contextKey => $composableBuilder(
      column: $table.contextKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$SavedTeamGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedTeamGroupsTable> {
  $$SavedTeamGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get sourceType => $composableBuilder(
      column: $table.sourceType, builder: (column) => column);

  GeneratedColumn<String> get contextKey => $composableBuilder(
      column: $table.contextKey, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> savedTeamsRefs<T extends Object>(
      Expression<T> Function($$SavedTeamsTableAnnotationComposer a) f) {
    final $$SavedTeamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.savedTeams,
        getReferencedColumn: (t) => t.groupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedTeamsTableAnnotationComposer(
              $db: $db,
              $table: $db.savedTeams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> savedGroupWaitingPlayersRefs<T extends Object>(
      Expression<T> Function(
              $$SavedGroupWaitingPlayersTableAnnotationComposer a)
          f) {
    final $$SavedGroupWaitingPlayersTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.savedGroupWaitingPlayers,
            getReferencedColumn: (t) => t.groupId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SavedGroupWaitingPlayersTableAnnotationComposer(
                  $db: $db,
                  $table: $db.savedGroupWaitingPlayers,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$SavedTeamGroupsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SavedTeamGroupsTable,
    SavedTeamGroup,
    $$SavedTeamGroupsTableFilterComposer,
    $$SavedTeamGroupsTableOrderingComposer,
    $$SavedTeamGroupsTableAnnotationComposer,
    $$SavedTeamGroupsTableCreateCompanionBuilder,
    $$SavedTeamGroupsTableUpdateCompanionBuilder,
    (SavedTeamGroup, $$SavedTeamGroupsTableReferences),
    SavedTeamGroup,
    PrefetchHooks Function(
        {bool savedTeamsRefs, bool savedGroupWaitingPlayersRefs})> {
  $$SavedTeamGroupsTableTableManager(
      _$AppDatabase db, $SavedTeamGroupsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedTeamGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedTeamGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedTeamGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> sourceType = const Value.absent(),
            Value<String?> contextKey = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SavedTeamGroupsCompanion(
            id: id,
            title: title,
            sourceType: sourceType,
            contextKey: contextKey,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String sourceType,
            Value<String?> contextKey = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required String createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SavedTeamGroupsCompanion.insert(
            id: id,
            title: title,
            sourceType: sourceType,
            contextKey: contextKey,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SavedTeamGroupsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {savedTeamsRefs = false, savedGroupWaitingPlayersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (savedTeamsRefs) db.savedTeams,
                if (savedGroupWaitingPlayersRefs) db.savedGroupWaitingPlayers
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (savedTeamsRefs)
                    await $_getPrefetchedData<SavedTeamGroup,
                            $SavedTeamGroupsTable, SavedTeam>(
                        currentTable: table,
                        referencedTable: $$SavedTeamGroupsTableReferences
                            ._savedTeamsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SavedTeamGroupsTableReferences(db, table, p0)
                                .savedTeamsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.groupId == item.id),
                        typedResults: items),
                  if (savedGroupWaitingPlayersRefs)
                    await $_getPrefetchedData<SavedTeamGroup,
                            $SavedTeamGroupsTable, SavedGroupWaitingPlayer>(
                        currentTable: table,
                        referencedTable: $$SavedTeamGroupsTableReferences
                            ._savedGroupWaitingPlayersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SavedTeamGroupsTableReferences(db, table, p0)
                                .savedGroupWaitingPlayersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.groupId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SavedTeamGroupsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SavedTeamGroupsTable,
    SavedTeamGroup,
    $$SavedTeamGroupsTableFilterComposer,
    $$SavedTeamGroupsTableOrderingComposer,
    $$SavedTeamGroupsTableAnnotationComposer,
    $$SavedTeamGroupsTableCreateCompanionBuilder,
    $$SavedTeamGroupsTableUpdateCompanionBuilder,
    (SavedTeamGroup, $$SavedTeamGroupsTableReferences),
    SavedTeamGroup,
    PrefetchHooks Function(
        {bool savedTeamsRefs, bool savedGroupWaitingPlayersRefs})>;
typedef $$SavedTeamsTableCreateCompanionBuilder = SavedTeamsCompanion Function({
  required String id,
  required String groupId,
  required String name,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$SavedTeamsTableUpdateCompanionBuilder = SavedTeamsCompanion Function({
  Value<String> id,
  Value<String> groupId,
  Value<String> name,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$SavedTeamsTableReferences
    extends BaseReferences<_$AppDatabase, $SavedTeamsTable, SavedTeam> {
  $$SavedTeamsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SavedTeamGroupsTable _groupIdTable(_$AppDatabase db) =>
      db.savedTeamGroups.createAlias(
          $_aliasNameGenerator(db.savedTeams.groupId, db.savedTeamGroups.id));

  $$SavedTeamGroupsTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<String>('group_id')!;

    final manager =
        $$SavedTeamGroupsTableTableManager($_db, $_db.savedTeamGroups)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$SavedTeamPlayersTable, List<SavedTeamPlayer>>
      _savedTeamPlayersRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.savedTeamPlayers,
              aliasName: $_aliasNameGenerator(
                  db.savedTeams.id, db.savedTeamPlayers.teamId));

  $$SavedTeamPlayersTableProcessedTableManager get savedTeamPlayersRefs {
    final manager =
        $$SavedTeamPlayersTableTableManager($_db, $_db.savedTeamPlayers)
            .filter((f) => f.teamId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_savedTeamPlayersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SavedTeamsTableFilterComposer
    extends Composer<_$AppDatabase, $SavedTeamsTable> {
  $$SavedTeamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  $$SavedTeamGroupsTableFilterComposer get groupId {
    final $$SavedTeamGroupsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.savedTeamGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedTeamGroupsTableFilterComposer(
              $db: $db,
              $table: $db.savedTeamGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> savedTeamPlayersRefs(
      Expression<bool> Function($$SavedTeamPlayersTableFilterComposer f) f) {
    final $$SavedTeamPlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.savedTeamPlayers,
        getReferencedColumn: (t) => t.teamId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedTeamPlayersTableFilterComposer(
              $db: $db,
              $table: $db.savedTeamPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SavedTeamsTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedTeamsTable> {
  $$SavedTeamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  $$SavedTeamGroupsTableOrderingComposer get groupId {
    final $$SavedTeamGroupsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.savedTeamGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedTeamGroupsTableOrderingComposer(
              $db: $db,
              $table: $db.savedTeamGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SavedTeamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedTeamsTable> {
  $$SavedTeamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$SavedTeamGroupsTableAnnotationComposer get groupId {
    final $$SavedTeamGroupsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.savedTeamGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedTeamGroupsTableAnnotationComposer(
              $db: $db,
              $table: $db.savedTeamGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> savedTeamPlayersRefs<T extends Object>(
      Expression<T> Function($$SavedTeamPlayersTableAnnotationComposer a) f) {
    final $$SavedTeamPlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.savedTeamPlayers,
        getReferencedColumn: (t) => t.teamId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedTeamPlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.savedTeamPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SavedTeamsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SavedTeamsTable,
    SavedTeam,
    $$SavedTeamsTableFilterComposer,
    $$SavedTeamsTableOrderingComposer,
    $$SavedTeamsTableAnnotationComposer,
    $$SavedTeamsTableCreateCompanionBuilder,
    $$SavedTeamsTableUpdateCompanionBuilder,
    (SavedTeam, $$SavedTeamsTableReferences),
    SavedTeam,
    PrefetchHooks Function({bool groupId, bool savedTeamPlayersRefs})> {
  $$SavedTeamsTableTableManager(_$AppDatabase db, $SavedTeamsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedTeamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedTeamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedTeamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> groupId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SavedTeamsCompanion(
            id: id,
            groupId: groupId,
            name: name,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String groupId,
            required String name,
            required int sortOrder,
            Value<int> rowid = const Value.absent(),
          }) =>
              SavedTeamsCompanion.insert(
            id: id,
            groupId: groupId,
            name: name,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SavedTeamsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {groupId = false, savedTeamPlayersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (savedTeamPlayersRefs) db.savedTeamPlayers
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (groupId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.groupId,
                    referencedTable:
                        $$SavedTeamsTableReferences._groupIdTable(db),
                    referencedColumn:
                        $$SavedTeamsTableReferences._groupIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (savedTeamPlayersRefs)
                    await $_getPrefetchedData<SavedTeam, $SavedTeamsTable,
                            SavedTeamPlayer>(
                        currentTable: table,
                        referencedTable: $$SavedTeamsTableReferences
                            ._savedTeamPlayersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SavedTeamsTableReferences(db, table, p0)
                                .savedTeamPlayersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.teamId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SavedTeamsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SavedTeamsTable,
    SavedTeam,
    $$SavedTeamsTableFilterComposer,
    $$SavedTeamsTableOrderingComposer,
    $$SavedTeamsTableAnnotationComposer,
    $$SavedTeamsTableCreateCompanionBuilder,
    $$SavedTeamsTableUpdateCompanionBuilder,
    (SavedTeam, $$SavedTeamsTableReferences),
    SavedTeam,
    PrefetchHooks Function({bool groupId, bool savedTeamPlayersRefs})>;
typedef $$SavedTeamPlayersTableCreateCompanionBuilder
    = SavedTeamPlayersCompanion Function({
  required String id,
  required String teamId,
  required String playerId,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$SavedTeamPlayersTableUpdateCompanionBuilder
    = SavedTeamPlayersCompanion Function({
  Value<String> id,
  Value<String> teamId,
  Value<String> playerId,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$SavedTeamPlayersTableReferences extends BaseReferences<
    _$AppDatabase, $SavedTeamPlayersTable, SavedTeamPlayer> {
  $$SavedTeamPlayersTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SavedTeamsTable _teamIdTable(_$AppDatabase db) =>
      db.savedTeams.createAlias(
          $_aliasNameGenerator(db.savedTeamPlayers.teamId, db.savedTeams.id));

  $$SavedTeamsTableProcessedTableManager get teamId {
    final $_column = $_itemColumn<String>('team_id')!;

    final manager = $$SavedTeamsTableTableManager($_db, $_db.savedTeams)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TeamDrawPlayersTable _playerIdTable(_$AppDatabase db) =>
      db.teamDrawPlayers.createAlias($_aliasNameGenerator(
          db.savedTeamPlayers.playerId, db.teamDrawPlayers.id));

  $$TeamDrawPlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<String>('player_id')!;

    final manager =
        $$TeamDrawPlayersTableTableManager($_db, $_db.teamDrawPlayers)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SavedTeamPlayersTableFilterComposer
    extends Composer<_$AppDatabase, $SavedTeamPlayersTable> {
  $$SavedTeamPlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  $$SavedTeamsTableFilterComposer get teamId {
    final $$SavedTeamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.teamId,
        referencedTable: $db.savedTeams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedTeamsTableFilterComposer(
              $db: $db,
              $table: $db.savedTeams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamDrawPlayersTableFilterComposer get playerId {
    final $$TeamDrawPlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.teamDrawPlayers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamDrawPlayersTableFilterComposer(
              $db: $db,
              $table: $db.teamDrawPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SavedTeamPlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedTeamPlayersTable> {
  $$SavedTeamPlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  $$SavedTeamsTableOrderingComposer get teamId {
    final $$SavedTeamsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.teamId,
        referencedTable: $db.savedTeams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedTeamsTableOrderingComposer(
              $db: $db,
              $table: $db.savedTeams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamDrawPlayersTableOrderingComposer get playerId {
    final $$TeamDrawPlayersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.teamDrawPlayers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamDrawPlayersTableOrderingComposer(
              $db: $db,
              $table: $db.teamDrawPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SavedTeamPlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedTeamPlayersTable> {
  $$SavedTeamPlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$SavedTeamsTableAnnotationComposer get teamId {
    final $$SavedTeamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.teamId,
        referencedTable: $db.savedTeams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedTeamsTableAnnotationComposer(
              $db: $db,
              $table: $db.savedTeams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamDrawPlayersTableAnnotationComposer get playerId {
    final $$TeamDrawPlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.teamDrawPlayers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamDrawPlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.teamDrawPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SavedTeamPlayersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SavedTeamPlayersTable,
    SavedTeamPlayer,
    $$SavedTeamPlayersTableFilterComposer,
    $$SavedTeamPlayersTableOrderingComposer,
    $$SavedTeamPlayersTableAnnotationComposer,
    $$SavedTeamPlayersTableCreateCompanionBuilder,
    $$SavedTeamPlayersTableUpdateCompanionBuilder,
    (SavedTeamPlayer, $$SavedTeamPlayersTableReferences),
    SavedTeamPlayer,
    PrefetchHooks Function({bool teamId, bool playerId})> {
  $$SavedTeamPlayersTableTableManager(
      _$AppDatabase db, $SavedTeamPlayersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedTeamPlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedTeamPlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedTeamPlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> teamId = const Value.absent(),
            Value<String> playerId = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SavedTeamPlayersCompanion(
            id: id,
            teamId: teamId,
            playerId: playerId,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String teamId,
            required String playerId,
            required int sortOrder,
            Value<int> rowid = const Value.absent(),
          }) =>
              SavedTeamPlayersCompanion.insert(
            id: id,
            teamId: teamId,
            playerId: playerId,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SavedTeamPlayersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({teamId = false, playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (teamId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.teamId,
                    referencedTable:
                        $$SavedTeamPlayersTableReferences._teamIdTable(db),
                    referencedColumn:
                        $$SavedTeamPlayersTableReferences._teamIdTable(db).id,
                  ) as T;
                }
                if (playerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.playerId,
                    referencedTable:
                        $$SavedTeamPlayersTableReferences._playerIdTable(db),
                    referencedColumn:
                        $$SavedTeamPlayersTableReferences._playerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SavedTeamPlayersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SavedTeamPlayersTable,
    SavedTeamPlayer,
    $$SavedTeamPlayersTableFilterComposer,
    $$SavedTeamPlayersTableOrderingComposer,
    $$SavedTeamPlayersTableAnnotationComposer,
    $$SavedTeamPlayersTableCreateCompanionBuilder,
    $$SavedTeamPlayersTableUpdateCompanionBuilder,
    (SavedTeamPlayer, $$SavedTeamPlayersTableReferences),
    SavedTeamPlayer,
    PrefetchHooks Function({bool teamId, bool playerId})>;
typedef $$SavedGroupWaitingPlayersTableCreateCompanionBuilder
    = SavedGroupWaitingPlayersCompanion Function({
  required String id,
  required String groupId,
  required String playerId,
  required String playerName,
  required String waitingSince,
  required int priorityOrder,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$SavedGroupWaitingPlayersTableUpdateCompanionBuilder
    = SavedGroupWaitingPlayersCompanion Function({
  Value<String> id,
  Value<String> groupId,
  Value<String> playerId,
  Value<String> playerName,
  Value<String> waitingSince,
  Value<int> priorityOrder,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$SavedGroupWaitingPlayersTableReferences extends BaseReferences<
    _$AppDatabase, $SavedGroupWaitingPlayersTable, SavedGroupWaitingPlayer> {
  $$SavedGroupWaitingPlayersTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SavedTeamGroupsTable _groupIdTable(_$AppDatabase db) =>
      db.savedTeamGroups.createAlias($_aliasNameGenerator(
          db.savedGroupWaitingPlayers.groupId, db.savedTeamGroups.id));

  $$SavedTeamGroupsTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<String>('group_id')!;

    final manager =
        $$SavedTeamGroupsTableTableManager($_db, $_db.savedTeamGroups)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TeamDrawPlayersTable _playerIdTable(_$AppDatabase db) =>
      db.teamDrawPlayers.createAlias($_aliasNameGenerator(
          db.savedGroupWaitingPlayers.playerId, db.teamDrawPlayers.id));

  $$TeamDrawPlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<String>('player_id')!;

    final manager =
        $$TeamDrawPlayersTableTableManager($_db, $_db.teamDrawPlayers)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SavedGroupWaitingPlayersTableFilterComposer
    extends Composer<_$AppDatabase, $SavedGroupWaitingPlayersTable> {
  $$SavedGroupWaitingPlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get playerName => $composableBuilder(
      column: $table.playerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get waitingSince => $composableBuilder(
      column: $table.waitingSince, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priorityOrder => $composableBuilder(
      column: $table.priorityOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  $$SavedTeamGroupsTableFilterComposer get groupId {
    final $$SavedTeamGroupsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.savedTeamGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedTeamGroupsTableFilterComposer(
              $db: $db,
              $table: $db.savedTeamGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamDrawPlayersTableFilterComposer get playerId {
    final $$TeamDrawPlayersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.teamDrawPlayers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamDrawPlayersTableFilterComposer(
              $db: $db,
              $table: $db.teamDrawPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SavedGroupWaitingPlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedGroupWaitingPlayersTable> {
  $$SavedGroupWaitingPlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get playerName => $composableBuilder(
      column: $table.playerName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get waitingSince => $composableBuilder(
      column: $table.waitingSince,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priorityOrder => $composableBuilder(
      column: $table.priorityOrder,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  $$SavedTeamGroupsTableOrderingComposer get groupId {
    final $$SavedTeamGroupsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.savedTeamGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedTeamGroupsTableOrderingComposer(
              $db: $db,
              $table: $db.savedTeamGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamDrawPlayersTableOrderingComposer get playerId {
    final $$TeamDrawPlayersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.teamDrawPlayers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamDrawPlayersTableOrderingComposer(
              $db: $db,
              $table: $db.teamDrawPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SavedGroupWaitingPlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedGroupWaitingPlayersTable> {
  $$SavedGroupWaitingPlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get playerName => $composableBuilder(
      column: $table.playerName, builder: (column) => column);

  GeneratedColumn<String> get waitingSince => $composableBuilder(
      column: $table.waitingSince, builder: (column) => column);

  GeneratedColumn<int> get priorityOrder => $composableBuilder(
      column: $table.priorityOrder, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$SavedTeamGroupsTableAnnotationComposer get groupId {
    final $$SavedTeamGroupsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.savedTeamGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedTeamGroupsTableAnnotationComposer(
              $db: $db,
              $table: $db.savedTeamGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeamDrawPlayersTableAnnotationComposer get playerId {
    final $$TeamDrawPlayersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playerId,
        referencedTable: $db.teamDrawPlayers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeamDrawPlayersTableAnnotationComposer(
              $db: $db,
              $table: $db.teamDrawPlayers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SavedGroupWaitingPlayersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SavedGroupWaitingPlayersTable,
    SavedGroupWaitingPlayer,
    $$SavedGroupWaitingPlayersTableFilterComposer,
    $$SavedGroupWaitingPlayersTableOrderingComposer,
    $$SavedGroupWaitingPlayersTableAnnotationComposer,
    $$SavedGroupWaitingPlayersTableCreateCompanionBuilder,
    $$SavedGroupWaitingPlayersTableUpdateCompanionBuilder,
    (SavedGroupWaitingPlayer, $$SavedGroupWaitingPlayersTableReferences),
    SavedGroupWaitingPlayer,
    PrefetchHooks Function({bool groupId, bool playerId})> {
  $$SavedGroupWaitingPlayersTableTableManager(
      _$AppDatabase db, $SavedGroupWaitingPlayersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedGroupWaitingPlayersTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedGroupWaitingPlayersTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedGroupWaitingPlayersTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> groupId = const Value.absent(),
            Value<String> playerId = const Value.absent(),
            Value<String> playerName = const Value.absent(),
            Value<String> waitingSince = const Value.absent(),
            Value<int> priorityOrder = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SavedGroupWaitingPlayersCompanion(
            id: id,
            groupId: groupId,
            playerId: playerId,
            playerName: playerName,
            waitingSince: waitingSince,
            priorityOrder: priorityOrder,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String groupId,
            required String playerId,
            required String playerName,
            required String waitingSince,
            required int priorityOrder,
            required int sortOrder,
            Value<int> rowid = const Value.absent(),
          }) =>
              SavedGroupWaitingPlayersCompanion.insert(
            id: id,
            groupId: groupId,
            playerId: playerId,
            playerName: playerName,
            waitingSince: waitingSince,
            priorityOrder: priorityOrder,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SavedGroupWaitingPlayersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({groupId = false, playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (groupId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.groupId,
                    referencedTable: $$SavedGroupWaitingPlayersTableReferences
                        ._groupIdTable(db),
                    referencedColumn: $$SavedGroupWaitingPlayersTableReferences
                        ._groupIdTable(db)
                        .id,
                  ) as T;
                }
                if (playerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.playerId,
                    referencedTable: $$SavedGroupWaitingPlayersTableReferences
                        ._playerIdTable(db),
                    referencedColumn: $$SavedGroupWaitingPlayersTableReferences
                        ._playerIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SavedGroupWaitingPlayersTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SavedGroupWaitingPlayersTable,
        SavedGroupWaitingPlayer,
        $$SavedGroupWaitingPlayersTableFilterComposer,
        $$SavedGroupWaitingPlayersTableOrderingComposer,
        $$SavedGroupWaitingPlayersTableAnnotationComposer,
        $$SavedGroupWaitingPlayersTableCreateCompanionBuilder,
        $$SavedGroupWaitingPlayersTableUpdateCompanionBuilder,
        (SavedGroupWaitingPlayer, $$SavedGroupWaitingPlayersTableReferences),
        SavedGroupWaitingPlayer,
        PrefetchHooks Function({bool groupId, bool playerId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$UserSessionsTableTableManager get userSessions =>
      $$UserSessionsTableTableManager(_db, _db.userSessions);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db, _db.teams);
  $$AthletesTableTableManager get athletes =>
      $$AthletesTableTableManager(_db, _db.athletes);
  $$StrategiesTableTableManager get strategies =>
      $$StrategiesTableTableManager(_db, _db.strategies);
  $$StrategyPlayersTableTableManager get strategyPlayers =>
      $$StrategyPlayersTableTableManager(_db, _db.strategyPlayers);
  $$StrategyMovementsTableTableManager get strategyMovements =>
      $$StrategyMovementsTableTableManager(_db, _db.strategyMovements);
  $$StrategySubstitutionsTableTableManager get strategySubstitutions =>
      $$StrategySubstitutionsTableTableManager(_db, _db.strategySubstitutions);
  $$MatchesTableTableManager get matches =>
      $$MatchesTableTableManager(_db, _db.matches);
  $$MatchSetsTableTableManager get matchSets =>
      $$MatchSetsTableTableManager(_db, _db.matchSets);
  $$DrillsTableTableManager get drills =>
      $$DrillsTableTableManager(_db, _db.drills);
  $$DrillPlayersTableTableManager get drillPlayers =>
      $$DrillPlayersTableTableManager(_db, _db.drillPlayers);
  $$DrillStepsTableTableManager get drillSteps =>
      $$DrillStepsTableTableManager(_db, _db.drillSteps);
  $$DrillTipsTableTableManager get drillTips =>
      $$DrillTipsTableTableManager(_db, _db.drillTips);
  $$DrillErrorsTableTableManager get drillErrors =>
      $$DrillErrorsTableTableManager(_db, _db.drillErrors);
  $$DrillVariationsTableTableManager get drillVariations =>
      $$DrillVariationsTableTableManager(_db, _db.drillVariations);
  $$DrillAnimationFramesTableTableManager get drillAnimationFrames =>
      $$DrillAnimationFramesTableTableManager(_db, _db.drillAnimationFrames);
  $$DrillFramePlayersTableTableManager get drillFramePlayers =>
      $$DrillFramePlayersTableTableManager(_db, _db.drillFramePlayers);
  $$DrillFrameMovementsTableTableManager get drillFrameMovements =>
      $$DrillFrameMovementsTableTableManager(_db, _db.drillFrameMovements);
  $$DrillFrameZonesTableTableManager get drillFrameZones =>
      $$DrillFrameZonesTableTableManager(_db, _db.drillFrameZones);
  $$TeamDrawPlayersTableTableManager get teamDrawPlayers =>
      $$TeamDrawPlayersTableTableManager(_db, _db.teamDrawPlayers);
  $$DrawSessionsTableTableManager get drawSessions =>
      $$DrawSessionsTableTableManager(_db, _db.drawSessions);
  $$DrawSessionTeamsTableTableManager get drawSessionTeams =>
      $$DrawSessionTeamsTableTableManager(_db, _db.drawSessionTeams);
  $$DrawSessionTeamPlayersTableTableManager get drawSessionTeamPlayers =>
      $$DrawSessionTeamPlayersTableTableManager(
          _db, _db.drawSessionTeamPlayers);
  $$WaitingQueueEntriesTableTableManager get waitingQueueEntries =>
      $$WaitingQueueEntriesTableTableManager(_db, _db.waitingQueueEntries);
  $$SavedTeamGroupsTableTableManager get savedTeamGroups =>
      $$SavedTeamGroupsTableTableManager(_db, _db.savedTeamGroups);
  $$SavedTeamsTableTableManager get savedTeams =>
      $$SavedTeamsTableTableManager(_db, _db.savedTeams);
  $$SavedTeamPlayersTableTableManager get savedTeamPlayers =>
      $$SavedTeamPlayersTableTableManager(_db, _db.savedTeamPlayers);
  $$SavedGroupWaitingPlayersTableTableManager get savedGroupWaitingPlayers =>
      $$SavedGroupWaitingPlayersTableTableManager(
          _db, _db.savedGroupWaitingPlayers);
}
