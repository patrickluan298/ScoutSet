import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    required this.title,
    super.key,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.titleLarge),
        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(subtitle!, style: theme.textTheme.bodyMedium),
        ],
      ],
    );
  }
}

