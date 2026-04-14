import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/config/app_routes.dart';
import 'package:scoutset/core/theme/app_theme.dart';
import 'package:scoutset/data/local/database/app_services.dart';
import 'package:scoutset/services/auth_service.dart';
import 'package:scoutset/services/sport_mode_service.dart';

void main() {
  setUp(() async {
    await AppServices.useInMemoryDatabaseForTesting();
    await AuthService.instance.reset();
    SportModeService.instance.resetForTesting();
  });

  testWidgets('usuário não autenticado é redirecionado ao login ao acessar rota protegida', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.theme,
        initialRoute: AppRoutes.dashboard,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        onUnknownRoute: AppRoutes.onUnknownRoute,
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Dashboard'), findsNothing);
  });

  testWidgets('usuário autenticado entra no seletor de modalidade', (tester) async {
    await AuthService.instance.register(
      name: 'Usuário',
      email: 'usuario@scoutset.app',
      password: 'Senha@123',
    );
    await AuthService.instance.signIn(
      email: 'usuario@scoutset.app',
      password: 'Senha@123',
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.theme,
        initialRoute: AppRoutes.modeSelection,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        onUnknownRoute: AppRoutes.onUnknownRoute,
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Escolha a Modalidade'), findsOneWidget);
    expect(find.text('Vôlei de Quadra'), findsOneWidget);
    expect(find.text('Vôlei de Praia'), findsOneWidget);
  });
}
