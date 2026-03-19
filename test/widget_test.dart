import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/main.dart';
import 'package:scoutset/widgets/scoutset_logo.dart';

void main() {
  testWidgets('login navega para dashboard', (tester) async {
    await tester.pumpWidget(const ScoutSetApp());

    expect(find.byType(ScoutSetLogo), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Entrar'), findsOneWidget);

    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsWidgets);
    expect(find.text('Placar'), findsWidgets);
  });
}
