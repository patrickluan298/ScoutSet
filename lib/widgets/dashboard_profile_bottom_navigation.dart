import 'package:flutter/material.dart';

import '../config/app_routes.dart';

class DashboardProfileBottomNavigation extends StatelessWidget {
  const DashboardProfileBottomNavigation({
    required this.currentRoute,
    super.key,
  });

  final String currentRoute;

  int get _currentIndex => currentRoute == AppRoutes.profile ? 1 : 0;

  void _onTap(BuildContext context, int index) {
    final targetRoute = index == 0 ? AppRoutes.dashboard : AppRoutes.profile;
    if (targetRoute == currentRoute) {
      return;
    }
    Navigator.pushReplacementNamed(context, targetRoute);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) => _onTap(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          activeIcon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    );
  }
}
