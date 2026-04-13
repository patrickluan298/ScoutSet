import 'package:flutter/material.dart';

import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/dashboard/screens/app_shell_screen.dart';
import '../features/drills/screens/drill_detail_screen.dart';
import '../features/drills/screens/drills_screen.dart';
import '../features/mode_selection/screens/mode_selection_screen.dart';
import '../features/rules/screens/rules_screen.dart';
import '../features/teams/screens/teams_screen.dart';
import '../features/videos/screens/videos_screen.dart';
import '../services/auth_service.dart';
import '../services/sport_mode_service.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String modeSelection = '/mode-selection';
  static const String dashboard = '/dashboard';
  static const String scoreboard = '/scoreboard';
  static const String strategies = '/strategies';
  static const String drills = '/drills';
  static const String drillDetail = '/drills/detail';
  static const String rules = '/rules';
  static const String videos = '/videos';
  static const String reports = '/reports';
  static const String teams = '/teams';
  static const String profile = '/profile';

  static final AuthService _authService = AuthService.instance;
  static final SportModeService _sportModeService = SportModeService.instance;

  static String get initialRoute =>
      _authService.isAuthenticated ? modeSelection : login;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final requestedRoute = settings.name ?? initialRoute;
    final routeName = _resolveRoute(requestedRoute);

    return MaterialPageRoute<void>(
      builder: (_) => _builderFor(routeName, settings.arguments),
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
      return modeSelection;
    }

    if (_protectedRoutes.contains(routeName) && !_authService.isAuthenticated) {
      return login;
    }

    if (routeName != modeSelection &&
        _modeRequiredRoutes.contains(routeName) &&
        _authService.isAuthenticated &&
        !_sportModeService.hasSelection) {
      return modeSelection;
    }

    return _allRoutes.contains(routeName) ? routeName : initialRoute;
  }

  static Widget _builderFor(String routeName, Object? arguments) {
    switch (routeName) {
      case login:
        return const LoginScreen();
      case register:
        return const RegisterScreen();
      case modeSelection:
        return const ModeSelectionScreen();
      case dashboard:
        return const AppShellScreen(initialIndex: 0);
      case scoreboard:
        return const AppShellScreen(initialIndex: 1);
      case strategies:
        return const AppShellScreen(initialIndex: 2);
      case drills:
        return const DrillsScreen();
      case drillDetail:
        return DrillDetailScreen(drillId: arguments as String? ?? 'reception-triangle');
      case rules:
        return const RulesScreen();
      case videos:
        return const VideosScreen();
      case reports:
        return const AppShellScreen(initialIndex: 3);
      case teams:
        return const TeamsScreen();
      case profile:
        return const AppShellScreen(initialIndex: 4);
      default:
        return const LoginScreen();
    }
  }

  static const Set<String> _guestOnlyRoutes = {
    login,
    register,
  };

  static const Set<String> _protectedRoutes = {
    modeSelection,
    dashboard,
    scoreboard,
    strategies,
    drills,
    drillDetail,
    rules,
    videos,
    reports,
    teams,
    profile,
  };

  static const Set<String> _modeRequiredRoutes = {
    dashboard,
    scoreboard,
    strategies,
    drills,
    drillDetail,
    rules,
    videos,
    reports,
    teams,
    profile,
  };

  static const Set<String> _allRoutes = {
    login,
    register,
    modeSelection,
    dashboard,
    scoreboard,
    strategies,
    drills,
    drillDetail,
    rules,
    videos,
    reports,
    teams,
    profile,
  };
}
