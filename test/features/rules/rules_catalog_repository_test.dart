import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:scoutset/features/rules/data/rules_catalog_repository.dart';

void main() {
  test('rules catalog preserves official sections from the local PDF extraction', () {
    final jsonString = File(RulesCatalogRepository.assetPath).readAsStringSync();
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

    final chapter12 = catalog.chapters.firstWhere((chapter) => chapter.officialNumber == '12');
    final section124 = chapter12.sections.firstWhere((section) => section.officialNumber == '12.4');
    expect(section124.officialTitle, 'EXECUÇÃO DO SAQUE');
    expect(
      section124.content,
      contains('12.4.1 A bola deve ser golpeada com uma das mãos ou qualquer parte do braço'),
    );

    final chapter19 = catalog.chapters.firstWhere((chapter) => chapter.officialNumber == '19');
    final section193 = chapter19.sections.firstWhere((section) => section.officialNumber == '19.3');
    expect(section193.officialTitle, 'AÇÕES ENVOLVENDO O LÍBERO');

    final chapter21 = catalog.chapters.firstWhere((chapter) => chapter.officialNumber == '21');
    final section213 = chapter21.sections.firstWhere((section) => section.officialNumber == '21.3');
    expect(section213.officialTitle, 'ESCALA DE SANÇÕES');

    final chapter1 = catalog.chapters.firstWhere((chapter) => chapter.officialNumber == '1');
    final section11 = chapter1.sections.firstWhere((section) => section.officialNumber == '1.1');
    expect(
      section11.content,
      contains('A quadra de jogo é um retângulo de 18 x 9 m, cercado por uma zona livre com largura mínima de 3 m em todos os lados.'),
    );
    expect(
      section11.content,
      contains('largura a partir das linhas laterais e 6,5 m de profundidade a partir das linhas de fundo.'),
    );
    expect(section11.content, isNot(contains('largura\n')));
    expect(section11.content, isNot(contains('fundo.\n')));

    expect(catalog.documents.map((document) => document.officialTitle), contains('PARTE 3: DEFINIÇÕES'));
  });
}
