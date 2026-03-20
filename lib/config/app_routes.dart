import 'package:flutter/material.dart';

import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/dashboard/screens/app_shell_screen.dart';
import '../features/drills/screens/drills_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/rules/screens/rules_screen.dart';
import '../features/teams/screens/teams_screen.dart';
import '../features/videos/screens/videos_screen.dart';
import '../services/auth_service.dart';

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

  static final AuthService _authService = AuthService.instance;

  static String get initialRoute =>
      _authService.isAuthenticated ? dashboard : login;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final requestedRoute = settings.name ?? initialRoute;
    final routeName = _resolveRoute(requestedRoute);

    return MaterialPageRoute<void>(
      builder: (_) => _builderFor(routeName),
      settings: RouteSettings(name: routeName, arguments: settings.arguments),
    );
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return onGenerateRoute(
      RouteSettings(name: _authService.isAuthenticated ? dashboard : login),
    );
  }

  static String _resolveRoute(String routeName) {
    if (_guestOnlyRoutes.contains(routeName) && _authService.isAuthenticated) {
      return dashboard;
    }

    if (_protectedRoutes.contains(routeName) && !_authService.isAuthenticated) {
      return login;
    }

    return _allRoutes.contains(routeName) ? routeName : initialRoute;
  }

  static Widget _builderFor(String routeName) {
    switch (routeName) {
      case login:
        return const LoginScreen();
      case register:
        return const RegisterScreen();
      case dashboard:
        return const AppShellScreen(initialIndex: 0);
      case scoreboard:
        return const AppShellScreen(initialIndex: 1);
      case strategies:
        return const AppShellScreen(initialIndex: 2);
      case drills:
        return const DrillsScreen();
      case rules:
        return const RulesScreen();
      case videos:
        return const VideosScreen();
      case reports:
        return const AppShellScreen(initialIndex: 3);
      case teams:
        return const TeamsScreen();
      case profile:
        return const ProfileScreen();
      default:
        return const LoginScreen();
    }
  }

  static const Set<String> _guestOnlyRoutes = {
    login,
    register,
  };

  static const Set<String> _protectedRoutes = {
    dashboard,
    scoreboard,
    strategies,
    drills,
    rules,
    videos,
    reports,
    teams,
    profile,
  };

  static const Set<String> _allRoutes = {
    login,
    register,
    dashboard,
    scoreboard,
    strategies,
    drills,
    rules,
    videos,
    reports,
    teams,
    profile,
  };
}
