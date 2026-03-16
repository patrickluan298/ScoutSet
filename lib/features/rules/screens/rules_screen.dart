import 'package:flutter/material.dart';

import '../../../widgets/module_placeholder_screen.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ModulePlaceholderScreen(
      title: 'Regras',
      description: 'Espaco reservado para referencia rapida de regras, interpretacoes e observacoes do jogo.',
    );
  }
}

