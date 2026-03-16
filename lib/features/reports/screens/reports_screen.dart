import 'package:flutter/material.dart';

import '../../../widgets/module_placeholder_screen.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({
    super.key,
    this.showScaffold = true,
  });

  final bool showScaffold;

  @override
  Widget build(BuildContext context) {
    return ModulePlaceholderScreen(
      title: 'Relatorios',
      description: 'Espaco reservado para dashboards de desempenho, metricas historicas e analises avancadas.',
      showScaffold: showScaffold,
    );
  }
}
