import 'package:flutter/material.dart';

import '../config/app_routes.dart';
import '../core/theme/app_theme.dart';

class DashboardProfileBottomNavigation extends StatelessWidget {
  const DashboardProfileBottomNavigation({
    required this.currentRoute,
    super.key,
  });

  final String currentRoute;

  void _navigate(BuildContext context, String route) {
    if (route == currentRoute) {
      return;
    }
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colorsOf(context);

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border(
            top: BorderSide(
              color: colors.subtleBorder.withValues(alpha: 0.55),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.36),
              blurRadius: 22,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _BottomNavItem(
                label: 'Dashboard',
                icon: Icons.dashboard_outlined,
                activeIcon: Icons.dashboard,
                isActive: currentRoute == AppRoutes.dashboard,
                onTap: () => _navigate(context, AppRoutes.dashboard),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _BottomNavItem(
                label: 'Perfil',
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                isActive: currentRoute == AppRoutes.profile,
                onTap: () => _navigate(context, AppRoutes.profile),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatefulWidget {
  const _BottomNavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<_BottomNavItem> createState() => _BottomNavItemState();
}

class _BottomNavItemState extends State<_BottomNavItem> {
  bool _isPressed = false;

  void _setPressed(bool value) {
    if (_isPressed == value) {
      return;
    }
    setState(() => _isPressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colorsOf(context);
    final active = widget.isActive;
    final iconColor = active ? colors.accent : colors.onSurfaceVariant;
    final textColor = active ? colors.accent : colors.onSurfaceVariant;
    final backgroundColor = active
        ? colors.surfaceContainerLow
        : colors.surface.withValues(alpha: 0.001);
    final scale = _isPressed ? 0.97 : 1.0;

    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(18),
          onHighlightChanged: _setPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  active ? widget.activeIcon : widget.icon,
                  color: iconColor,
                  size: 20,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.label.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: textColor,
                        letterSpacing: -0.1,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
