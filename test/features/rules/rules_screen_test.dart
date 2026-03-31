import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/core/theme/app_theme.dart';
import 'package:scoutset/features/rules/data/rules_catalog_repository.dart';
import 'package:scoutset/features/rules/models/rules_models.dart';
import 'package:scoutset/features/rules/screens/rules_screen.dart';

void main() {
  testWidgets('rules screen renders search results from the local catalog', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 2200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.theme,
        home: RulesScreen(
          showScaffold: false,
          repository: _TestRulesCatalogRepository(),
          initialSearchTerm: 'líbero',
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.scrollUntilVisible(
      find.text('Resultados da busca'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pump();

    expect(find.text('Resultados da busca'), findsOneWidget);
    expect(find.byKey(const Key('rules-index-section-19-3')), findsOneWidget);
  });

  testWidgets('rules screen renders lateral menu and expands official sections', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 2200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.theme,
        home: RulesScreen(
          showScaffold: false,
          repository: _TestRulesCatalogRepository(),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Sumário lateral'), findsOneWidget);
    expect(find.byKey(const Key('rules-menu-category-system-points')), findsOneWidget);
    expect(find.byKey(const Key('rules-menu-category-serve')), findsOneWidget);
    expect(find.byKey(const Key('rules-menu-category-libero')), findsOneWidget);
    expect(find.text('Espaço reservado para referência rápida de regras, interpretações e observações do jogo.'), findsNothing);

    await tester.ensureVisible(find.byKey(const Key('rules-menu-item-chapter-12')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('rules-menu-item-chapter-12')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('12 SERVIÇO'), findsWidgets);
    expect(find.text('12.4'), findsOneWidget);
    expect(find.text('EXECUÇÃO DO SERVIÇO'), findsOneWidget);

    expect(
      find.textContaining('12.4.1 A bola deve ser golpeada com uma das mãos ou qualquer parte do braço'),
      findsNothing,
    );
    await tester.tap(find.text('EXECUÇÃO DO SERVIÇO'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(
      find.textContaining('12.4.1 A bola deve ser golpeada com uma das mãos ou qualquer parte do braço'),
      findsOneWidget,
    );

    await tester.ensureVisible(find.byKey(const Key('rules-menu-item-definitions')));
    await tester.tap(find.byKey(const Key('rules-menu-item-definitions')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('PARTE 3: DEFINIÇÕES'), findsWidgets);
  });

  testWidgets('rules screen keeps all study categories accessible in the quick rail', (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.theme,
        home: RulesScreen(
          showScaffold: false,
          repository: _TestRulesCatalogRepository(),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    final quickRail = find.byKey(const Key('rules-quick-category-rail'));

    await tester.dragUntilVisible(
      find.byKey(const Key('rules-quick-category-serve')),
      quickRail,
      const Offset(-180, 0),
    );
    await tester.pump();
    expect(find.byKey(const Key('rules-quick-category-serve')), findsOneWidget);

    await tester.dragUntilVisible(
      find.byKey(const Key('rules-quick-category-libero')),
      quickRail,
      const Offset(-180, 0),
    );
    await tester.pump();
    expect(find.byKey(const Key('rules-quick-category-libero')), findsOneWidget);

    await tester.dragUntilVisible(
      find.byKey(const Key('rules-quick-category-penalties')),
      quickRail,
      const Offset(-180, 0),
    );
    await tester.pump();
    expect(find.byKey(const Key('rules-quick-category-penalties')), findsOneWidget);
  });

  testWidgets('rules screen opens lateral menu from mobile button', (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.theme,
        home: RulesScreen(
          showScaffold: false,
          repository: _TestRulesCatalogRepository(),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byKey(const Key('rules-open-sidebar')), findsOneWidget);

    await tester.ensureVisible(find.byKey(const Key('rules-open-sidebar')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('rules-open-sidebar')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Sumário lateral'), findsOneWidget);
    expect(find.byKey(const Key('rules-menu-item-definitions')), findsOneWidget);

    await tester.ensureVisible(find.byKey(const Key('rules-menu-item-definitions')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('rules-menu-item-definitions')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Sumário lateral'), findsNothing);
    expect(find.text('PARTE 3: DEFINIÇÕES'), findsWidgets);
  });
}

class _TestRulesCatalogRepository extends RulesCatalogRepository {
  @override
  Future<RulesCatalog> load([AssetBundle? bundle]) async {
    final jsonString = File(RulesCatalogRepository.assetPath).readAsStringSync();
    return loadFromString(jsonString);
  }
}
