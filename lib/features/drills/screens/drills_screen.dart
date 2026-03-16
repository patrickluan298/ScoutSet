import 'package:flutter/material.dart';

import '../../../widgets/module_placeholder_screen.dart';

class DrillsScreen extends StatelessWidget {
  const DrillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ModulePlaceholderScreen(
      title: 'Drills',
      description: 'Espaco reservado para catalogo de treinos, ciclos de pratica e evolucao tecnica.',
    );
  }
}

