import 'package:flutter/material.dart';

import 'dashboard_profile_bottom_navigation.dart';

class AppPageScaffold extends StatelessWidget {
  const AppPageScaffold({
    required this.child,
    super.key,
    this.showScaffold = true,
    this.currentRoute,
    this.backgroundColor,
    this.appBar,
    this.bottomNavigationBar,
  });

  final Widget child;
  final bool showScaffold;
  final String? currentRoute;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final content = SafeArea(child: child);

    if (!showScaffold) {
      return content;
    }

    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: content,
      bottomNavigationBar:
          bottomNavigationBar ??
          (currentRoute == null
              ? null
              : DashboardProfileBottomNavigation(currentRoute: currentRoute!)),
    );
  }
}
