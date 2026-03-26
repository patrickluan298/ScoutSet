import 'package:flutter/material.dart';

import 'config/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'data/local/database/app_services.dart';
import 'features/drills/services/drills_service.dart';
import 'features/scoreboard/services/scoreboard_service.dart';
import 'features/strategies/services/strategy_service.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppServices.initialize();
  await AuthService.instance.initialize();
  await StrategyService.instance.initialize();
  await ScoreboardService.instance.initialize();
  await DrillsService.instance.initialize();
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
      initialRoute: AppRoutes.initialRoute,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      onUnknownRoute: AppRoutes.onUnknownRoute,
    );
  }
}
