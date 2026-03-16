import 'package:flutter/material.dart';

import 'app_card.dart';

class DashboardTile extends StatelessWidget {
  const DashboardTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: theme.colorScheme.secondary.withOpacity(0.12),
              child: Icon(icon, color: theme.colorScheme.secondary),
            ),
            const Spacer(),
            Text(title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(subtitle, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
