import 'package:flutter/material.dart';

import '../../../core/utils/spacing.dart';

class DangerZoneCard extends StatelessWidget {
  final VoidCallback onClearDataPressed;

  const DangerZoneCard({super.key, required this.onClearDataPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Clearing data will permanently delete all your expenses, budgets, and history. This action cannot be undone.',
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          verticalSpace(16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onClearDataPressed,
              icon: const Icon(Icons.delete_outline, size: 20),
              label: const Text(
                'Clear All Data',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onError,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
