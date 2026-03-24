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
      title: 'Relatórios',
      description: 'Espaço reservado para dashboards de desempenho, métricas históricas e análises avançadas.',
      showScaffold: showScaffold,
    );
  }
}
