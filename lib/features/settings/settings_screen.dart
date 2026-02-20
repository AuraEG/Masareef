import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/theme_controller.dart';
import '../../core/utils/spacing.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_navigation_button.dart';
import '../expenses/presentation/cubit/expense_cubit.dart';
import 'widgets/clear_data_dialog.dart';
import 'widgets/danger_zone_card.dart';
import 'widgets/export_confirmation_dialog.dart';
import 'widgets/export_csv_button.dart';
import 'widgets/language_change_dialog.dart';
import 'widgets/settings_card.dart';
import 'widgets/settings_divider.dart';
import 'widgets/settings_footer.dart';
import 'widgets/settings_language_item.dart';
import 'widgets/settings_section_label.dart';
import 'widgets/settings_toggle_item.dart';

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
                CustomAppBar(title: 'Settings'),
                verticalSpace(16),
                _buildGeneralSection(themeController),
                verticalSpace(30),
                _buildDataManagementSection(),
                verticalSpace(30),
                _buildDangerZoneSection(),
                verticalSpace(20),
                const SettingsFooter(),
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
        const SettingsSectionLabel('GENERAL'),
        verticalSpace(16),
        SettingsCard(
          children: [
            SettingsToggleItem(
              icon: Icons.dark_mode_outlined,
              iconColor: colorScheme.secondary,
              title: 'Change Theme',
              value: _isDarkModeEnabled(themeController),
              onChanged: _handleDarkModeToggle,
            ),
            verticalSpace(12),
            const SettingsDivider(),
            verticalSpace(12),
            SettingsLanguageItem(
              selectedLanguage: _selectedLanguage,
              alternateLanguage: _alternateLanguage,
              onTap: _showLanguageChangeDialog,
            ),
            verticalSpace(12),
            const SettingsDivider(),
            verticalSpace(12),
            SettingsToggleItem(
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
        const SettingsSectionLabel('DATA MANAGEMENT'),
        verticalSpace(16),
        ExportCsvButton(onPressed: _showExportConfirmationDialog),
      ],
    );
  }

  Widget _buildDangerZoneSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionLabel(
          'DANGER ZONE',
          color: Theme.of(context).colorScheme.error,
        ),
        verticalSpace(16),
        DangerZoneCard(onClearDataPressed: _showClearDataDialog),
      ],
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
    setState(() => _notificationsEnabled = value);
  }

  void _showLanguageChangeDialog() {
    showDialog(
      context: context,
      builder: (_) => LanguageChangeDialog(
        selectedLanguage: _selectedLanguage,
        onConfirm: () {
          setState(() {
            if (_selectedLanguage == 'English') {
              _selectedLanguage = 'العربية';
              _alternateLanguage = 'English';
            } else {
              _selectedLanguage = 'English';
              _alternateLanguage = 'العربية';
            }
          });
        },
      ),
    );
  }

  void _showExportConfirmationDialog() {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (_) => ExportConfirmationDialog(
        onConfirm: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('CSV Report exported coming soon!'),
              backgroundColor: colorScheme.secondary,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showClearDataDialog() {
    final colorScheme = Theme.of(context).colorScheme;
    final expenseCubit = context.read<ExpenseCubit>();
    final messenger = ScaffoldMessenger.of(context);

    showDialog(
      context: context,
      builder: (_) => ClearDataDialog(
        onConfirm: () async {
          try {
            await expenseCubit.clearAll();
            if (!mounted) return;
            messenger.showSnackBar(
              SnackBar(
                content: const Text('All data has been cleared'),
                backgroundColor: colorScheme.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          } catch (_) {
            if (!mounted) return;
            messenger.showSnackBar(
              SnackBar(
                content: const Text('Failed to clear data'),
                backgroundColor: colorScheme.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
