import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/core/theme/app_theme.dart';
import 'package:scoutset/features/rules/data/rules_catalog_repository.dart';
import 'package:scoutset/features/rules/models/rules_models.dart';
import 'package:scoutset/features/rules/screens/rules_screen.dart';
import 'package:scoutset/models/sport_mode.dart';
import 'package:scoutset/services/sport_mode_service.dart';

void main() {
  setUp(() {
    SportModeService.instance.resetForTesting();
  });

  testWidgets('rules screen renders manual tecnico header and search results',
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

    expect(find.text('Manual Técnico'), findsOneWidget);
    expect(find.text('Resultados da busca'), findsOneWidget);
    expect(find.byType(RulesScreen), findsOneWidget);
  });

  testWidgets(
      'rules screen renders desktop side nav and expands official sections',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1320, 2200));
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

    expect(find.text('Índice de Regras'), findsWidgets);
    expect(find.byKey(const Key('rules-menu-category-system-points')),
        findsOneWidget);
    expect(find.byKey(const Key('rules-menu-category-serve')), findsOneWidget);

    await tester
        .ensureVisible(find.byKey(const Key('rules-menu-item-chapter-12')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('rules-menu-item-chapter-12')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.textContaining('Capítulo 12'), findsWidgets);
    expect(find.text('REGRA 12.4'), findsOneWidget);
    expect(find.text('EXECUÇÃO DO SAQUE'), findsOneWidget);

    expect(
      find.textContaining(
          'A bola deve ser golpeada com uma das mãos ou qualquer parte do braço'),
      findsNothing,
    );

    await tester.tap(find.text('EXECUÇÃO DO SAQUE'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(
      find.textContaining(
          'A bola deve ser golpeada com uma das mãos ou qualquer parte do braço'),
      findsOneWidget,
    );
  });

  testWidgets('rules screen opens document index from mobile button',
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

    expect(find.text('Índice de Regras'), findsWidgets);
    expect(find.byKey(const Key('rules-menu-category-system-points')),
        findsOneWidget);

    await tester.ensureVisible(
        find.byKey(const Key('rules-menu-category-system-points')));
    await tester.pump();
    await tester
        .tap(find.byKey(const Key('rules-menu-category-system-points')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Sistema de Pontuação'), findsWidgets);
  });

  testWidgets('rules side nav filters menu items while typing', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1320, 2200));
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

    await tester.enterText(
        find.byKey(const Key('rules-search-field')), 'líbero');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byKey(const Key('rules-menu-category-libero')), findsOneWidget);
    expect(find.byKey(const Key('rules-menu-item-chapter-19')), findsOneWidget);
    expect(find.byKey(const Key('rules-menu-category-serve')), findsNothing);
    expect(find.byKey(const Key('rules-menu-item-chapter-12')), findsNothing);
  });

  testWidgets('rules screen orders serve and arbitration sections as expected',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1320, 4000));
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

    final serveTop = tester
        .getTopLeft(find.byKey(const Key('rules-menu-category-serve')))
        .dy;
    final attackTop = tester
        .getTopLeft(find.byKey(const Key('rules-menu-category-attack')))
        .dy;

    expect(serveTop, lessThan(attackTop));

    final arbitrationTop = tester
        .getTopLeft(find.byKey(const Key('rules-menu-category-arbitration')))
        .dy;
    final annexesTop = tester
        .getTopLeft(find.byKey(const Key('rules-menu-category-annexes')))
        .dy;

    expect(arbitrationTop, greaterThan(attackTop));
    expect(arbitrationTop, lessThan(annexesTop));
  });

  testWidgets('rules screen groups arbitration chapters in a dedicated section',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1320, 2200));
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

    expect(find.text('Capítulo 22: EQUIPE DE ARBITRAGEM E PROCEDIMENTOS'),
        findsNothing);

    await tester.enterText(
        find.byKey(const Key('rules-search-field')), 'arbitragem');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byKey(const Key('rules-menu-category-arbitration')),
        findsOneWidget);
    expect(find.byKey(const Key('rules-menu-item-chapter-22')), findsOneWidget);
    expect(find.byKey(const Key('rules-menu-item-chapter-30')), findsOneWidget);

    await tester.tap(find.byKey(const Key('rules-menu-category-arbitration')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    await tester.enterText(find.byKey(const Key('rules-search-field')), '');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Arbitragem'), findsWidgets);
    expect(find.text('Capítulo 22: EQUIPE DE ARBITRAGEM E PROCEDIMENTOS'),
        findsOneWidget);
  });

  testWidgets(
      'rules screen keeps chapter headers visible when selecting from filtered search results',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1320, 2200));
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

    await tester.enterText(find.byKey(const Key('rules-search-field')), 'árbitro');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Resultados da busca'), findsOneWidget);
    expect(find.byKey(const Key('rules-menu-item-chapter-23')), findsOneWidget);

    await tester.tap(find.byKey(const Key('rules-menu-item-chapter-23')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Resultados da busca'), findsOneWidget);
    expect(find.textContaining('1º ÁRBITRO'), findsOneWidget);
  });

  testWidgets('rules screen shows accent border and media for expanded panel',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1320, 2200));
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

    await tester.tap(find.text('DIMENSÕES'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Fig 1. Dimensões da quadra'), findsOneWidget);

    final accentFinder = find.byKey(const Key('rules-panel-accent-1.1'));
    expect(accentFinder, findsOneWidget);
    final accent = tester.widget<AnimatedContainer>(accentFinder);
    final decoration = accent.decoration! as BoxDecoration;
    expect(decoration.color, const Color(0xFFF6BF03));
  });

  testWidgets('rules screen renders with dark theme tokens applied',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1320, 2200));
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
    expect(find.text('Manual Técnico'), findsOneWidget);
    expect(find.text('Índice de Regras'), findsOneWidget);
  });

  testWidgets('rules screen renders empty beach placeholder with shared layout',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(900, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const RulesScreen(
          showScaffold: false,
          sportMode: SportMode.beach,
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Manual Técnico'), findsOneWidget);
    expect(find.text('Regras de Praia'), findsOneWidget);
    expect(find.text('Conteúdo em preparação'), findsWidgets);
  });
}

class _TestRulesCatalogRepository extends RulesCatalogRepository {
  @override
  Future<RulesCatalog> load({
    required SportMode sportMode,
    AssetBundle? bundle,
  }) async {
    final jsonString =
        File(RulesCatalogRepository.assetPath).readAsStringSync();
    return loadFromString(jsonString);
  }
}
