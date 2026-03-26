import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/data/local/database/app_services.dart';
import 'package:scoutset/services/auth_service.dart';

void main() {
  setUp(() async {
    await AppServices.useInMemoryDatabaseForTesting();
    await AuthService.instance.reset();
  });

  test('cadastro e login usam sqlite como persistência principal', () async {
    await AuthService.instance.register(
      name: 'Usuário Teste',
      email: 'usuario@scoutset.app',
      password: 'Senha@123',
    );

    final user = await AuthService.instance.signIn(
      email: 'usuario@scoutset.app',
      password: 'Senha@123',
    );

    expect(user.email, 'usuario@scoutset.app');
    expect(AuthService.instance.currentUser?.email, 'usuario@scoutset.app');
    expect(AuthService.instance.isAuthenticated, isTrue);
  });

  test('initialize restaura a sessão ativa salva no sqlite', () async {
    await AuthService.instance.register(
      name: 'Usuário Teste',
      email: 'usuario@scoutset.app',
      password: 'Senha@123',
    );

    await AuthService.instance.signIn(
      email: 'usuario@scoutset.app',
      password: 'Senha@123',
    );

    AuthService.instance.clearCachedStateForTesting();
    await AuthService.instance.initialize();

    expect(AuthService.instance.currentUser?.email, 'usuario@scoutset.app');
    expect(AuthService.instance.isAuthenticated, isTrue);
  });
}
