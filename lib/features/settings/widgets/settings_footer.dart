import 'package:flutter/material.dart';

class SettingsFooter extends StatelessWidget {
  const SettingsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Text(
        'Version 1.0.0 (Build 2026)',
        style: TextStyle(
          color: colorScheme.onSurface.withValues(alpha: 0.3),
          fontSize: 11,
        ),
      ),
    );
  }
}
