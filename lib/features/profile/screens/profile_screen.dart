import 'package:flutter/material.dart';

import '../../../widgets/module_placeholder_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    this.showScaffold = true,
  });

  final bool showScaffold;

  @override
  Widget build(BuildContext context) {
    return ModulePlaceholderScreen(
      title: 'Perfil',
      description: 'Espaco reservado para conta, preferencias, notificacoes e configuracoes pessoais.',
      showScaffold: showScaffold,
    );
  }
}
