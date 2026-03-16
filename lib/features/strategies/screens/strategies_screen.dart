import 'package:flutter/material.dart';

import '../../../widgets/module_placeholder_screen.dart';

class StrategiesScreen extends StatelessWidget {
  const StrategiesScreen({
    super.key,
    this.showScaffold = true,
  });

  final bool showScaffold;

  @override
  Widget build(BuildContext context) {
    return ModulePlaceholderScreen(
      title: 'Estrategias',
      description: 'Espaco reservado para simulador tatico, cenarios de jogo e planejamento de estrategias.',
      showScaffold: showScaffold,
    );
  }
}
