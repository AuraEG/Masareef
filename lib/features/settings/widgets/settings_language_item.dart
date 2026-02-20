import 'package:flutter/material.dart';
import 'package:masareef/core/utils/spacing.dart';

class SettingsLanguageItem extends StatelessWidget {
  final String selectedLanguage;
  final String alternateLanguage;
  final VoidCallback onTap;

  const SettingsLanguageItem({
    super.key,
    required this.selectedLanguage,
    required this.alternateLanguage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Row(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Language',
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                selectedLanguage,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              alternateLanguage,
              style: TextStyle(
                color: colorScheme.onSecondaryContainer,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
