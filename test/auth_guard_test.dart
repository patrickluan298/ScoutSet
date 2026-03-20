import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/config/app_routes.dart';
import 'package:scoutset/core/theme/app_theme.dart';
import 'package:scoutset/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await AuthService.instance.reset();
  });

  testWidgets('usuario nao autenticado e redirecionado ao login ao acessar rota protegida', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.theme,
        initialRoute: AppRoutes.dashboard,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        onUnknownRoute: AppRoutes.onUnknownRoute,
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Acesso do usuario'), findsOneWidget);
    expect(find.text('Dashboard'), findsNothing);
  });
}
