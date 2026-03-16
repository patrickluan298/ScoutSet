import 'package:flutter/material.dart';

import '../../../widgets/module_placeholder_screen.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ModulePlaceholderScreen(
      title: 'Videos',
      description: 'Espaco reservado para upload, recorte e analise de video com suporte futuro a IA.',
    );
  }
}

