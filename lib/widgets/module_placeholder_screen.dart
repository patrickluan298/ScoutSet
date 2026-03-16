import 'package:flutter/material.dart';

import 'app_card.dart';
import 'section_title.dart';

class ModulePlaceholderScreen extends StatelessWidget {
  const ModulePlaceholderScreen({
    required this.title,
    required this.description,
    super.key,
    this.showScaffold = true,
  });

  final String title;
  final String description;
  final bool showScaffold;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.all(20),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SectionTitle(
              title: title,
              subtitle: description,
            ),
            const SizedBox(height: 16),
            Text(
              'Este modulo ja esta pronto para evolucao com servicos, widgets e modelos dedicados.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );

    if (!showScaffold) {
      return SafeArea(
        child: SingleChildScrollView(child: content),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(child: content),
    );
  }
}
