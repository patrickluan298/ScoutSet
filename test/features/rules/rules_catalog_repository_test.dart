import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/features/rules/data/rules_catalog_repository.dart';

void main() {
  test(
      'rules catalog preserves official sections from the local PDF extraction',
      () {
    final jsonString =
        File(RulesCatalogRepository.assetPath).readAsStringSync();
    final catalog = const RulesCatalogRepository().loadFromString(jsonString);

    expect(
      catalog.categories.map((category) => category.title),
      containsAll(<String>[
        'Sistema de Pontuação',
        'Estrutura do Jogo',
        'Rodízio e Posições',
        'Toques na Bola',
        'Rede e Invasões',
        'Ataque',
        'Bloqueio',
        'Saque',
        'Líbero',
        'Faltas e Penalidades',
      ]),
    );

    final chapter12 = catalog.chapters
        .firstWhere((chapter) => chapter.officialNumber == '12');
    final section124 = chapter12.sections
        .firstWhere((section) => section.officialNumber == '12.4');
    expect(section124.officialTitle, 'EXECUÇÃO DO SAQUE');
    expect(
      section124.content,
      contains(
          '12.4.1 A bola deve ser golpeada com uma das mãos ou qualquer parte do braço'),
    );

    final chapter19 = catalog.chapters
        .firstWhere((chapter) => chapter.officialNumber == '19');
    final section193 = chapter19.sections
        .firstWhere((section) => section.officialNumber == '19.3');
    expect(section193.officialTitle, 'AÇÕES ENVOLVENDO O LÍBERO');

    final chapter21 = catalog.chapters
        .firstWhere((chapter) => chapter.officialNumber == '21');
    final section213 = chapter21.sections
        .firstWhere((section) => section.officialNumber == '21.3');
    expect(section213.officialTitle, 'ESCALA DE SANÇÕES');

    final chapter1 =
        catalog.chapters.firstWhere((chapter) => chapter.officialNumber == '1');
    final section11 = chapter1.sections
        .firstWhere((section) => section.officialNumber == '1.1');
    expect(
      section11.content,
      contains(
          'A quadra de jogo é um retângulo de 18 x 9 m, cercado por uma zona livre com largura mínima de 3 m em todos os lados.'),
    );
    expect(
      section11.content,
      contains(
          'largura a partir das linhas laterais e 6,5 m de profundidade a partir das linhas de fundo.'),
    );
    expect(section11.content, isNot(contains('largura\n')));
    expect(section11.content, isNot(contains('fundo.\n')));

    expect(catalog.documents.map((document) => document.officialTitle),
        contains('PARTE 3: DEFINIÇÕES'));
  });

  test('beach rules catalog loads official chapters, annexes and media', () {
    final jsonString =
        File(RulesCatalogRepository.beachAssetPath).readAsStringSync();
    final catalog = const RulesCatalogRepository().loadFromString(jsonString);

    expect(
      catalog.categories.map((category) => category.title),
      containsAll(<String>[
        'Fundamentos',
        'Sistema de Pontuação',
        'Posições e Ordem de Saque',
        'Toques na Bola',
        'Saque',
        'Arbitragem',
        'Anexos e Referências',
      ]),
    );
    expect(
      catalog.categories.map((category) => category.title),
      isNot(contains('Líbero')),
    );

    final chapter4 = catalog.chapters.firstWhere(
      (chapter) => chapter.officialNumber == '4',
    );
    final section41 = chapter4.sections.firstWhere(
      (section) => section.officialNumber == '4.1',
    );
    expect(section41.officialTitle, 'COMPOSIÇÃO DA EQUIPE');
    expect(
      section41.content,
      contains('Uma equipe é composta exclusivamente por dois jogadores.'),
    );

    final chapter7 = catalog.chapters.firstWhere(
      (chapter) => chapter.officialNumber == '7',
    );
    final section74 = chapter7.sections.firstWhere(
      (section) => section.officialNumber == '7.4',
    );
    expect(section74.content, contains('Não existem posições predeterminadas'));

    final chapter12 = catalog.chapters.firstWhere(
      (chapter) => chapter.officialNumber == '12',
    );
    final section124 = chapter12.sections.firstWhere(
      (section) => section.officialNumber == '12.4',
    );
    expect(section124.officialTitle, 'EXECUÇÃO DO SAQUE');
    expect(
      section124.content,
      contains(
        'A bola deve ser golpeada com uma das mãos ou qualquer parte do braço',
      ),
    );

    final chapter14 = catalog.chapters.firstWhere(
      (chapter) => chapter.officialNumber == '14',
    );
    final section144 = chapter14.sections.firstWhere(
      (section) => section.officialNumber == '14.4',
    );
    expect(
      section144.content,
      contains('Um contato de bloqueio conta como um toque da equipe.'),
    );

    final chapter17 = catalog.chapters.firstWhere(
      (chapter) => chapter.officialNumber == '17',
    );
    final section171 = chapter17.sections.firstWhere(
      (section) => section.officialNumber == '17.1',
    );
    expect(
      section171.content,
      contains('tempo máximo de recuperação de 5 minutos'),
    );

    final section11 = catalog.chapters
        .firstWhere((chapter) => chapter.officialNumber == '1')
        .sections
        .firstWhere((section) => section.officialNumber == '1.1');
    expect(section11.media?.imageAsset, contains('diagram-48.png'));

    expect(
      catalog.documents.map((document) => document.officialTitle),
      containsAll(<String>[
        'CARACTERÍSTICAS DO JOGO',
        'PARTE 1: FILOSOFIA DAS REGRAS E DA ARBITRAGEM',
        'PARTE 2 - SEÇÃO 3: DIAGRAMAS',
        'PARTE 3: DEFINIÇÕES',
      ]),
    );
  });
}
