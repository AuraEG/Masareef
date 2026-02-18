import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareef/core/theme/theme_controller.dart';
import 'package:masareef/core/utils/spacing.dart';
import 'package:masareef/core/widgets/custom_navigation_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'English';
  String _alternateLanguage = 'العربية';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeController = ThemeScope.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      bottomNavigationBar: const CustomNavigationBar(indx: 4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(10),
                _buildGeneralSection(themeController),
                verticalSpace(30),
                _buildDataManagementSection(),
                verticalSpace(30),
                _buildDangerZoneSection(),
                verticalSpace(20),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGeneralSection(ThemeController themeController) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('GENERAL'),
        verticalSpace(16),
        _buildSettingsCard(
          children: [
            _buildToggleItem(
              icon: Icons.dark_mode_outlined,
              iconColor: colorScheme.secondary,
              title: 'Change Theme',
              value: _isDarkModeEnabled(themeController),
              onChanged: _handleDarkModeToggle,
            ),
            verticalSpace(12),
            _buildDivider(),
            verticalSpace(12),
            _buildLanguageItem(),
            verticalSpace(12),
            _buildDivider(),
            verticalSpace(12),
            _buildToggleItem(
              icon: Icons.notifications_outlined,
              iconColor: colorScheme.secondary,
              title: 'Notifications',
              value: _notificationsEnabled,
              onChanged: _handleNotificationsToggle,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDataManagementSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('DATA MANAGEMENT'),
        verticalSpace(16),
        _buildExportButton(),
      ],
    );
  }

  Widget _buildDangerZoneSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel(
          'DANGER ZONE',
          color: Theme.of(context).colorScheme.error,
        ),
        verticalSpace(16),
        _buildDangerCard(),
      ],
    );
  }

  Widget _buildSectionLabel(String label, {Color? color}) {
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

  Widget _buildSettingsCard({required List<Widget> children}) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(children: children),
    );
  }

  Widget _buildToggleItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 35.w,
          height: 35.h,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        horizontalSpace(12),
        Text(
          title,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        _buildCustomSwitch(value, onChanged),
      ],
    );
  }

  Widget _buildCustomSwitch(bool value, ValueChanged<bool> onChanged) {
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

  Widget _buildLanguageItem() {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: _handleLanguagePress,
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
                _selectedLanguage,
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
              _alternateLanguage,
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

  Widget _buildExportButton() {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _handleExportPress,
        icon: Icon(
          Icons.download_outlined,
          size: 20,
          color: colorScheme.onSecondary,
        ),
        label: Text(
          'Export CSV Report',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSecondary,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.secondary,
          foregroundColor: colorScheme.onSecondary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildDangerCard() {
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
              onPressed: _handleClearDataPress,
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

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: Theme.of(context).colorScheme.outlineVariant,
    );
  }

  Widget _buildFooter() {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        children: [
          Text(
            'Masroofi App',
            style: TextStyle(
              color: colorScheme.onSurface.withValues(alpha: 0.4),
              fontSize: 12,
            ),
          ),
          verticalSpace(4),
          Text(
            'Version 1.0.0 (Build 2026)',
            style: TextStyle(
              color: colorScheme.onSurface.withValues(alpha: 0.3),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  bool _isDarkModeEnabled(ThemeController themeController) {
    return switch (themeController.themeMode) {
      ThemeMode.dark => true,
      ThemeMode.light => false,
      ThemeMode.system =>
        MediaQuery.platformBrightnessOf(context) == Brightness.dark,
    };
  }

  Future<void> _handleDarkModeToggle(bool value) async {
    final themeController = ThemeScope.of(context);
    await themeController.setThemeMode(
      value ? ThemeMode.dark : ThemeMode.light,
    );
  }

  void _handleNotificationsToggle(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });
  }

  void _handleLanguagePress() {
    _showLanguageChangeDialog();
  }

  void _handleExportPress() {
    _showExportConfirmationDialog();
  }

  void _handleClearDataPress() {
    _showClearDataDialog();
  }

  void _showLanguageChangeDialog() {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
          _selectedLanguage == 'English'
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
              _selectedLanguage == 'English' ? 'Cancel' : 'إلغاء',
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (_selectedLanguage == 'English') {
                  _selectedLanguage = 'العربية';
                  _alternateLanguage = 'English';
                } else {
                  _selectedLanguage = 'English';
                  _alternateLanguage = 'العربية';
                }
              });
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
              _selectedLanguage == 'English' ? 'Change' : 'تغيير',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showExportConfirmationDialog() {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('CSV Report exported successfully!'),
                  backgroundColor: colorScheme.secondary,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
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
      ),
    );
  }

  void _showClearDataDialog() {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colorScheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              width: 35.w,
              height: 35.h,
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.warning_outlined,
                color: colorScheme.onErrorContainer,
                size: 22,
              ),
            ),
            horizontalSpace(12),
            Text(
              'Clear All Data?',
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Text(
          'This action cannot be undone. All your expenses, budgets, and history will be permanently deleted.',
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
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('All data has been cleared'),
                  backgroundColor: colorScheme.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.delete_outline, size: 18),
            label: const Text(
              'Clear Data',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
