import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/main.dart';

void main() {
  testWidgets('login navega para dashboard', (tester) async {
    await tester.pumpWidget(const ScoutSetApp());

    expect(find.text('ScoutSet'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Entrar'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Placar'), findsWidgets);
  });
}
