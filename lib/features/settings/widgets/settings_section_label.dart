import 'package:flutter/material.dart';

class SettingsSectionLabel extends StatelessWidget {
  final String label;
  final Color? color;

  const SettingsSectionLabel(this.label, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      label,
      style: TextStyle(
        color: color ?? colorScheme.secondary,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    );
  }
}
