import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/data/local/database/app_services.dart';
import 'package:scoutset/main.dart';
import 'package:scoutset/services/auth_service.dart';

void main() {
  const strongPassword = 'Senha@123';

  setUp(() async {
    await AppServices.useInMemoryDatabaseForTesting();
    await AuthService.instance.reset();
  });

  testWidgets('login vazio não navega para dashboard', (tester) async {
    await tester.pumpWidget(const ScoutSetApp());

    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.pumpAndSettle();

    expect(find.text('Informe seu e-mail.'), findsOneWidget);
    expect(find.text('Informe sua senha.'), findsOneWidget);
    expect(find.text('Dashboard'), findsNothing);
  });

  test('login só autentica quando o usuário existe na base local', () async {
    await AuthService.instance.register(
      name: 'Usuário Teste',
      email: 'usuario@scoutset.app',
      password: strongPassword,
    );

    final user = await AuthService.instance.signIn(
      email: 'usuario@scoutset.app',
      password: strongPassword,
    );

    expect(user.email, 'usuario@scoutset.app');
    expect(AuthService.instance.isAuthenticated, isTrue);
  });

  testWidgets('login com usuário inexistente mostra erro e não navega', (tester) async {
    await tester.pumpWidget(const ScoutSetApp());

    await tester.enterText(find.byType(TextFormField).at(0), 'naoexiste@scoutset.app');
    await tester.enterText(find.byType(TextFormField).at(1), strongPassword);

    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('Usuário não encontrado ou senha incorreta.'), findsOneWidget);
    expect(find.text('Dashboard'), findsNothing);
  });
}
