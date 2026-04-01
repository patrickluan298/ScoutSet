import 'package:flutter/material.dart';

import 'app_card.dart';
import 'app_page_scaffold.dart';
import 'section_title.dart';

class ModulePlaceholderScreen extends StatelessWidget {
  const ModulePlaceholderScreen({
    required this.title,
    required this.description,
    required this.currentRoute,
    super.key,
    this.showScaffold = true,
  });

  final String title;
  final String description;
  final String currentRoute;
  final bool showScaffold;

  @override
  Widget build(BuildContext context) {
    return AppPageScaffold(
      showScaffold: showScaffold,
      currentRoute: currentRoute,
      child: SingleChildScrollView(
        child: Padding(
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
                  'Este módulo já está pronto para evolução com serviços, widgets e modelos dedicados.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
