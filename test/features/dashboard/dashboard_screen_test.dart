import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/core/theme/app_theme.dart';
import 'package:scoutset/features/dashboard/screens/dashboard_screen.dart';
import 'package:scoutset/models/sport_mode.dart';
import 'package:scoutset/services/sport_mode_service.dart';

void main() {
  setUp(() {
    SportModeService.instance.resetForTesting();
    SportModeService.instance.selectMode(SportMode.beach);
  });

  testWidgets('dashboard screen renders with dark theme tokens applied',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: const DashboardScreen(showScaffold: false),
      ),
    );
    await tester.pumpAndSettle();

    final context = tester.element(find.text('Rotina de Praia'));
    expect(Theme.of(context).scaffoldBackgroundColor, const Color(0xFF071325));
    expect(find.text('Rotina de Praia'), findsOneWidget);
    expect(find.text('Modo ativo: Vôlei de Praia'), findsOneWidget);
    expect(find.text('Regras'), findsOneWidget);
    expect(find.text('Placar'), findsOneWidget);
  });
}
