import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/core/theme/app_theme.dart';
import 'package:scoutset/core/theme/theme_controller.dart';
import 'package:scoutset/data/local/database/app_services.dart';
import 'package:scoutset/features/profile/screens/profile_screen.dart';
import 'package:scoutset/main.dart';
import 'package:scoutset/services/auth_service.dart';
import 'package:scoutset/services/sport_mode_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const strongPassword = 'Senha@123';

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await AppServices.useInMemoryDatabaseForTesting();
    await AuthService.instance.reset();
    SportModeService.instance.resetForTesting();
    await ThemeController.instance.initialize();
    await ThemeController.instance.resetForTesting(
      preferences: await SharedPreferences.getInstance(),
    );
  });

  testWidgets('login vazio não navega para seletor de modalidade', (tester) async {
    await tester.pumpWidget(const ScoutSetApp());

    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.pumpAndSettle();

    expect(find.text('Informe seu e-mail.'), findsOneWidget);
    expect(find.text('Informe sua senha.'), findsOneWidget);
    expect(find.text('Escolha a modalidade'), findsNothing);
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

  testWidgets('login com usuário inexistente mostra erro e não navega',
      (tester) async {
    await tester.pumpWidget(const ScoutSetApp());

    await tester.enterText(
        find.byType(TextFormField).at(0), 'naoexiste@scoutset.app');
    await tester.enterText(find.byType(TextFormField).at(1), strongPassword);

    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('Usuário não encontrado ou senha incorreta.'),
        findsOneWidget);
    expect(find.text('Escolha a modalidade'), findsNothing);
  });

  testWidgets('login com usuário válido navega para o seletor de modalidade',
      (tester) async {
    await AuthService.instance.register(
      name: 'Usuário Teste',
      email: 'usuario@scoutset.app',
      password: strongPassword,
    );

    await tester.pumpWidget(const ScoutSetApp());
    await tester.enterText(find.byType(TextFormField).at(0), 'usuario@scoutset.app');
    await tester.enterText(find.byType(TextFormField).at(1), strongPassword);

    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('Escolha a modalidade'), findsOneWidget);
    expect(find.text('Vôlei de Quadra'), findsOneWidget);
  });

  testWidgets('app inicia com tema salvo em modo escuro', (tester) async {
    SharedPreferences.setMockInitialValues({'theme_mode': 'dark'});
    final preferences = await SharedPreferences.getInstance();
    await ThemeController.instance.resetForTesting(preferences: preferences);

    await tester.pumpWidget(const ScoutSetApp());
    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.themeMode, ThemeMode.dark);
  });

  testWidgets('perfil alterna tema global e persiste a escolha',
      (tester) async {
    final preferences = await SharedPreferences.getInstance();
    await ThemeController.instance.resetForTesting(preferences: preferences);

    await tester.pumpWidget(
      AnimatedBuilder(
        animation: ThemeController.instance,
        builder: (context, _) {
          return MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeController.instance.themeMode,
            home: const ProfileScreen(showScaffold: false),
          );
        },
      ),
    );
    await tester.pumpAndSettle();

    expect(ThemeController.instance.themeMode, ThemeMode.light);
    expect(find.text('Tema'), findsOneWidget);
    expect(find.text('Claro'), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(ThemeController.instance.themeMode, ThemeMode.dark);
    expect(preferences.getString('theme_mode'), 'dark');
    expect(find.text('Escuro'), findsOneWidget);

    await ThemeController.instance.resetForTesting(preferences: preferences);
    expect(ThemeController.instance.themeMode, ThemeMode.dark);
  });
}
