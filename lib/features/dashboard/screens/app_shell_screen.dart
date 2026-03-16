import 'package:flutter/material.dart';

import '../../../config/app_routes.dart';
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

  static const List<String> _titles = [
    'ScoutSet',
    'Placar',
    'Estrategias',
    'Relatorios',
    'Perfil',
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

  void _onDestinationSelected(int index) {
    if (index == _currentIndex) {
      return;
    }

    setState(() => _currentIndex = index);
    Navigator.pushReplacementNamed(context, _routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onDestinationSelected,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_volleyball),
            activeIcon: Icon(Icons.sports_volleyball),
            label: 'Placar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schema),
            activeIcon: Icon(Icons.schema),
            label: 'Estrategias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Relatorios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
