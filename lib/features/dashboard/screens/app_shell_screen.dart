import 'package:flutter/material.dart';

import '../../../config/app_routes.dart';
import '../../../widgets/dashboard_profile_bottom_navigation.dart';
import '../../profile/screens/profile_screen.dart';
import '../../reports/screens/reports_screen.dart';
import '../../scoreboard/screens/scoreboard_screen.dart';
import '../../strategies/screens/strategies_screen.dart';
import 'dashboard_screen.dart';

class AppShellScreen extends StatefulWidget {
  const AppShellScreen({
    required this.initialIndex,
    super.key,
  });

  final int initialIndex;

  @override
  State<AppShellScreen> createState() => _AppShellScreenState();
}

class _AppShellScreenState extends State<AppShellScreen> {
  late int _currentIndex;

  static const List<Widget> _pages = [
    DashboardScreen(showScaffold: false),
    ScoreboardScreen(showScaffold: false),
    StrategiesScreen(showScaffold: false),
    ReportsScreen(showScaffold: false),
    ProfileScreen(showScaffold: false),
  ];

  static const List<String> _routes = [
    AppRoutes.dashboard,
    AppRoutes.scoreboard,
    AppRoutes.strategies,
    AppRoutes.reports,
    AppRoutes.profile,
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = _routes[_currentIndex];

    return Scaffold(
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: DashboardProfileBottomNavigation(currentRoute: currentRoute),
    );
  }
}
