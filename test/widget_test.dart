import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/main.dart';
import 'package:scoutset/services/auth_service.dart';
import 'package:scoutset/widgets/scoutset_logo.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const strongPassword = 'Senha@123';

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await AuthService.instance.reset();
  });

  testWidgets('login vazio nao navega para dashboard', (tester) async {
    await tester.pumpWidget(const ScoutSetApp());

    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.pumpAndSettle();

    expect(find.text('Informe seu e-mail.'), findsOneWidget);
    expect(find.text('Informe sua senha.'), findsOneWidget);
    expect(find.text('Dashboard'), findsNothing);
  });

  testWidgets('login so navega para dashboard quando o usuario existe na base local', (tester) async {
    await AuthService.instance.register(
      name: 'Usuario Teste',
      email: 'usuario@scoutset.app',
      password: strongPassword,
    );

    await tester.pumpWidget(const ScoutSetApp());

    expect(find.byType(ScoutSetLogo), findsOneWidget);
    expect(find.text('usuario@exemplo.com'), findsOneWidget);
    expect(find.text('Digite sua senha'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'usuario@scoutset.app');
    await tester.enterText(find.byType(TextFormField).at(1), strongPassword);

    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsWidgets);
    expect(find.text('Placar'), findsWidgets);
  });

  testWidgets('login com usuario inexistente mostra erro e nao navega', (tester) async {
    await tester.pumpWidget(const ScoutSetApp());

    await tester.enterText(find.byType(TextFormField).at(0), 'naoexiste@scoutset.app');
    await tester.enterText(find.byType(TextFormField).at(1), strongPassword);

    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('Usuario nao encontrado ou senha incorreta.'), findsOneWidget);
    expect(find.text('Dashboard'), findsNothing);
  });
}
