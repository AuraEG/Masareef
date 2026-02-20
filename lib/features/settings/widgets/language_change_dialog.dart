import 'package:flutter/material.dart';
import 'package:masareef/core/utils/spacing.dart';

class LanguageChangeDialog extends StatelessWidget {
  final String selectedLanguage;
  final VoidCallback onConfirm;

  const LanguageChangeDialog({
    super.key,
    required this.selectedLanguage,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isEnglish = selectedLanguage == 'English';

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
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.language,
              color: colorScheme.onSecondaryContainer,
              size: 22,
            ),
          ),
          horizontalSpace(12),
          Text(
            'Change Language',
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      content: Text(
        isEnglish
            ? 'Do you want to change the language to Arabic?'
            : 'هل تريد تغيير اللغة إلى الإنجليزية؟',
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
            isEnglish ? 'Cancel' : 'إلغاء',
            style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.secondary,
            foregroundColor: colorScheme.onSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: Text(
            isEnglish ? 'Change' : 'تغيير',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
