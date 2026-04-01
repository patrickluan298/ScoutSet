import 'package:flutter/material.dart';

import '../../../config/app_routes.dart';
import '../../../widgets/module_placeholder_screen.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({
    super.key,
    this.showScaffold = true,
  });

  final bool showScaffold;

  @override
  Widget build(BuildContext context) {
    return ModulePlaceholderScreen(
      title: 'Vídeos',
      description: 'Espaço reservado para upload, recorte e análise de vídeo com suporte futuro a IA.',
      currentRoute: AppRoutes.videos,
      showScaffold: showScaffold,
    );
  }
}
