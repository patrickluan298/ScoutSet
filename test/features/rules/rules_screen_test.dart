import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/core/theme/app_theme.dart';
import 'package:scoutset/features/rules/data/rules_catalog_repository.dart';
import 'package:scoutset/features/rules/models/rules_models.dart';
import 'package:scoutset/features/rules/screens/rules_screen.dart';

void main() {
  testWidgets('rules screen renders search results from the local catalog',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 2200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: RulesScreen(
          showScaffold: false,
          repository: _TestRulesCatalogRepository(),
          initialSearchTerm: 'líbero',
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Resultados da busca'), findsNothing);
    expect(find.text('19 O JOGADOR LÍBERO'), findsWidgets);
    expect(find.textContaining('LÍBERO'), findsWidgets);
  });

  testWidgets('rules screen renders lateral menu and expands official sections',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 2200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: RulesScreen(
          showScaffold: false,
          repository: _TestRulesCatalogRepository(),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Sumário lateral'), findsOneWidget);
    expect(find.byKey(const Key('rules-menu-category-system-points')),
        findsOneWidget);
    expect(find.byKey(const Key('rules-menu-category-serve')), findsOneWidget);
    expect(find.byKey(const Key('rules-menu-category-libero')), findsOneWidget);
    expect(
        find.text(
            'Espaço reservado para referência rápida de regras, interpretações e observações do jogo.'),
        findsNothing);

    await tester
        .ensureVisible(find.byKey(const Key('rules-menu-item-chapter-12')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('rules-menu-item-chapter-12')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('12 SERVIÇO'), findsWidgets);
    expect(find.text('12.4'), findsOneWidget);
    expect(find.text('EXECUÇÃO DO SERVIÇO'), findsOneWidget);

    expect(
      find.textContaining(
          '12.4.1 A bola deve ser golpeada com uma das mãos ou qualquer parte do braço'),
      findsNothing,
    );
    await tester.tap(find.text('EXECUÇÃO DO SERVIÇO'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(
      find.textContaining(
          'A bola deve ser golpeada com uma das mãos ou qualquer parte do braço'),
      findsOneWidget,
    );

    await tester
        .ensureVisible(find.byKey(const Key('rules-menu-item-definitions')));
    await tester.tap(find.byKey(const Key('rules-menu-item-definitions')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('PARTE 3: DEFINIÇÕES'), findsWidgets);
  });

  testWidgets('rules screen opens lateral menu from mobile button',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
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
    expect(
        find.byKey(const Key('rules-menu-item-definitions')), findsOneWidget);

    await tester
        .ensureVisible(find.byKey(const Key('rules-menu-item-definitions')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('rules-menu-item-definitions')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Sumário lateral'), findsNothing);
    expect(find.text('PARTE 3: DEFINIÇÕES'), findsWidgets);
  });

  testWidgets('rules sidebar filters menu items while typing', (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 2200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: RulesScreen(
          showScaffold: false,
          repository: _TestRulesCatalogRepository(),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byKey(const Key('rules-menu-category-serve')), findsOneWidget);
    expect(find.byKey(const Key('rules-menu-category-libero')), findsOneWidget);

    await tester.enterText(
        find.byKey(const Key('rules-search-field')), 'líbero');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byKey(const Key('rules-menu-category-libero')), findsOneWidget);
    expect(find.byKey(const Key('rules-menu-item-chapter-19')), findsOneWidget);
    expect(find.byKey(const Key('rules-menu-category-serve')), findsNothing);
    expect(find.byKey(const Key('rules-menu-item-chapter-12')), findsNothing);
  });

  testWidgets('rules screen renders with dark theme tokens applied',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 2200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: RulesScreen(
          showScaffold: false,
          repository: _TestRulesCatalogRepository(),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    final context = tester.element(find.text('Regras Oficiais'));
    expect(Theme.of(context).scaffoldBackgroundColor, const Color(0xFF071325));
    expect(find.text('Regras Oficiais'), findsOneWidget);
    expect(find.text('Sumário lateral'), findsOneWidget);
  });
}

class _TestRulesCatalogRepository extends RulesCatalogRepository {
  @override
  Future<RulesCatalog> load([AssetBundle? bundle]) async {
    final jsonString =
        File(RulesCatalogRepository.assetPath).readAsStringSync();
    return loadFromString(jsonString);
  }
}
