import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareef/core/utils/spacing.dart';

class ExportConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ExportConfirmationDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      backgroundColor: colorScheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.download_outlined,
              color: colorScheme.onSecondaryContainer,
              size: 22,
            ),
          ),
          horizontalSpace(12),
          Text(
            'Export CSV Report',
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      content: Text(
        'Do you want to export all your expenses and budgets data to a CSV file? The file will be saved to your device.',
        style: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontSize: 14,
          height: 1.5,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: colorScheme.onSurfaceVariant,
          ),
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          icon: const Icon(Icons.download_outlined, size: 18),
          label: const Text(
            'Export',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.secondary,
            foregroundColor: colorScheme.onSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14).r,
            ),
            elevation: 0,
          ),
        ),
      ],
    );
  }
}
