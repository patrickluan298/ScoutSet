import 'package:flutter/material.dart';

import '../../../widgets/module_placeholder_screen.dart';

class ScoreboardScreen extends StatelessWidget {
  const ScoreboardScreen({
    super.key,
    this.showScaffold = true,
  });

  final bool showScaffold;

  @override
  Widget build(BuildContext context) {
    return ModulePlaceholderScreen(
      title: 'Placar',
      description: 'Espaco reservado para o placar de volei com sets, eventos e estatisticas ao vivo.',
      showScaffold: showScaffold,
    );
  }
}
