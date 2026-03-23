import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/services/auth_service.dart';
import 'package:scoutset/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await AuthService.instance.reset();
  });

  test('inicializacao migra usuarios antigos sem derrubar o app', () async {
    await StorageService.instance.save(
      key: 'auth_users',
      value: jsonEncode([
        {
          'id': 'legacy-1',
          'name': 'Usuario Legado',
          'email': 'legado@scoutset.app',
          'password': 'Senha@123',
          'teamId': 'team-1',
        },
      ]),
    );

    await AuthService.instance.initialize();

    final user = await AuthService.instance.signIn(
      email: 'legado@scoutset.app',
      password: 'Senha@123',
    );

    expect(user.email, 'legado@scoutset.app');
    expect(AuthService.instance.isAuthenticated, isTrue);
  });
}
