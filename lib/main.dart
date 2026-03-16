import 'package:flutter/material.dart';

import 'config/app_routes.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const ScoutSetApp());
}

class ScoutSetApp extends StatelessWidget {
  const ScoutSetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScoutSet',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}

