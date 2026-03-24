import 'package:flutter/material.dart';

import '../../../widgets/module_placeholder_screen.dart';

class TeamsScreen extends StatelessWidget {
  const TeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ModulePlaceholderScreen(
      title: 'Equipes',
      description: 'Espaço reservado para cadastro de equipes, atletas, papéis e composições de elenco.',
    );
  }
}

