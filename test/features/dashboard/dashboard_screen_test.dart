import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/core/theme/app_theme.dart';
import 'package:scoutset/features/dashboard/screens/dashboard_screen.dart';

void main() {
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

    final context = tester.element(find.text('Vamos começar os treinos?'));
    expect(Theme.of(context).scaffoldBackgroundColor, const Color(0xFF071325));
    expect(find.text('Vamos começar os treinos?'), findsOneWidget);
    expect(find.text('Regras'), findsOneWidget);
    expect(find.text('Placar'), findsOneWidget);
  });
}
