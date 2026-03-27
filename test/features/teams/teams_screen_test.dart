import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/core/theme/app_theme.dart';
import 'package:scoutset/data/local/database/app_services.dart';
import 'package:scoutset/features/teams/screens/teams_screen.dart';
import 'package:scoutset/features/teams/services/team_draw_service.dart';

void main() {
  setUp(() async {
    await AppServices.useInMemoryDatabaseForTesting();
    await TeamDrawService.instance.initialize();
  });

  testWidgets('teams screen shows summary and quick actions', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.theme,
        home: const TeamsScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Formação de Equipes'), findsOneWidget);
    expect(find.text('Sortear Times'), findsOneWidget);
    expect(find.text('Montagem Manual'), findsOneWidget);
  });
}
