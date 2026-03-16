import 'package:flutter/material.dart';

import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/dashboard/screens/app_shell_screen.dart';
import '../features/drills/screens/drills_screen.dart';
import '../features/rules/screens/rules_screen.dart';
import '../features/teams/screens/teams_screen.dart';
import '../features/videos/screens/videos_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
  static const String scoreboard = '/scoreboard';
  static const String strategies = '/strategies';
  static const String drills = '/drills';
  static const String rules = '/rules';
  static const String videos = '/videos';
  static const String reports = '/reports';
  static const String teams = '/teams';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> get routes => {
        login: (_) => const LoginScreen(),
        register: (_) => const RegisterScreen(),
        dashboard: (_) => const AppShellScreen(initialIndex: 0),
        scoreboard: (_) => const AppShellScreen(initialIndex: 1),
        strategies: (_) => const AppShellScreen(initialIndex: 2),
        drills: (_) => const DrillsScreen(),
        rules: (_) => const RulesScreen(),
        videos: (_) => const VideosScreen(),
        reports: (_) => const AppShellScreen(initialIndex: 3),
        teams: (_) => const TeamsScreen(),
        profile: (_) => const AppShellScreen(initialIndex: 4),
      };
}
