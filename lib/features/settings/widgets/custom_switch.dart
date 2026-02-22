import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 50,
        height: 28,
        decoration: BoxDecoration(
          color: value ? colorScheme.secondary : colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.all(2),
        child: AnimatedAlign(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: colorScheme.onSecondary,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
