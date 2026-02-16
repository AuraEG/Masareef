// TODO: wtf...refactor this.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareef/core/constant/app_color.dart';
import 'package:masareef/core/utils/spacing.dart';
import 'package:masareef/core/widgets/custom_navigation_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = true;
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'English';
  String _alternateLanguage = 'العربية';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDark,
      bottomNavigationBar: CustomNavigationBar(indx: 3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(10),
                _buildGeneralSection(),
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

  // General Section
  Widget _buildGeneralSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('GENERAL'),
        verticalSpace(16),
        _buildSettingsCard(
          children: [
            _buildToggleItem(
              icon: Icons.dark_mode_outlined,
              iconColor: AppColor.primaryMedium,
              title: 'Dark Mode',
              value: _isDarkMode,
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
              iconColor: AppColor.primaryMedium,
              title: 'Notifications',
              value: _notificationsEnabled,
              onChanged: _handleNotificationsToggle,
            ),
          ],
        ),
      ],
    );
  }

  // Data Management Section
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

  // Danger Zone Section
  Widget _buildDangerZoneSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('DANGER ZONE', color: AppColor.red),
        verticalSpace(16),
        _buildDangerCard(),
      ],
    );
  }

  // Section label
  Widget _buildSectionLabel(String label, {Color? color}) {
    return Text(
      label,
      style: TextStyle(
        color: color ?? const Color(0xFF00D9A0),
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    );
  }

  // Settings card wrapper
  Widget _buildSettingsCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A3333),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(children: children),
    );
  }

  // Toggle item (Dark Mode, Notifications)
  Widget _buildToggleItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
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
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        _buildCustomSwitch(value, onChanged),
      ],
    );
  }

  // Custom switch
  Widget _buildCustomSwitch(bool value, ValueChanged<bool> onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 50,
        height: 28,
        decoration: BoxDecoration(
          color: value ? const Color(0xFF00D9A0) : const Color(0xFF2A4444),
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.all(2),
        child: AnimatedAlign(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  // Language item
  Widget _buildLanguageItem() {
    return InkWell(
      onTap: _handleLanguagePress,
      borderRadius: BorderRadius.circular(10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColor.primaryMedium.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.language,
              color: AppColor.primaryMedium,
              size: 22,
            ),
          ),
          horizontalSpace(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Language',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                _selectedLanguage,
                style: TextStyle(color: AppColor.grey, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColor.primaryMedium.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _alternateLanguage,
              style: const TextStyle(
                color: Color(0xFF00D9A0),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Export button
  Widget _buildExportButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _handleExportPress,
        icon: const Icon(
          Icons.download_outlined,
          size: 20,
          color: Colors.white,
        ),
        label: const Text(
          'Export CSV Report',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryMedium,
          foregroundColor: const Color(0xFF0A1F1F),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  // Danger card
  Widget _buildDangerCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A3333),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Clearing data will permanently delete all your expenses, budgets, and history. This action cannot be undone.',
            style: TextStyle(color: AppColor.grey, fontSize: 13, height: 1.5),
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
                backgroundColor: AppColor.red,
                foregroundColor: Colors.white,
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

  // Divider
  Widget _buildDivider() {
    return Container(height: 1, color: const Color(0xFF2A4444));
  }

  // Footer
  Widget _buildFooter() {
    return Center(
      child: Column(
        children: [
          Text(
            'Masroofi App',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 12,
            ),
          ),
          verticalSpace(4),
          Text(
            'Version 1.0.0 (Build 2026)',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.3),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // ==================== Event Handlers (Ready for Logic) ====================

  void _handleDarkModeToggle(bool value) {
    setState(() {
      _isDarkMode = value;
    });
    // TODO: Implement theme switching logic
  }

  void _handleNotificationsToggle(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });
    // TODO: Implement notification preferences logic
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

  // Language change dialog
  void _showLanguageChangeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A3333),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColor.primaryMedium.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.language,
                color: Color(0xFF00D9A0),
                size: 22,
              ),
            ),
            horizontalSpace(12),
            const Text(
              'Change Language',
              style: TextStyle(
                color: Colors.white,
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
          style: TextStyle(color: AppColor.grey, fontSize: 14, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(foregroundColor: AppColor.grey),
            child: Text(
              _selectedLanguage == 'English' ? 'Cancel' : 'إلغاء',
              style: TextStyle(fontSize: 14, color: AppColor.green),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Swap languages
                if (_selectedLanguage == 'English') {
                  _selectedLanguage = 'العربية';
                  _alternateLanguage = 'English';
                } else {
                  _selectedLanguage = 'English';
                  _alternateLanguage = 'العربية';
                }
              });
              Navigator.pop(context);
              // TODO: Implement actual language switching logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00D9A0),
              foregroundColor: const Color(0xFF0A1F1F),
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
                color: AppColor.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Export CSV confirmation dialog
  void _showExportConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A3333),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColor.primaryMedium.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.download_outlined,
                color: AppColor.primaryMedium,
                size: 22,
              ),
            ),
            horizontalSpace(12),
            const Text(
              'Export CSV Report',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Text(
          'Do you want to export all your expenses and budgets data to a CSV file? The file will be saved to your device.',
          style: TextStyle(color: AppColor.grey, fontSize: 14, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(foregroundColor: AppColor.grey),
            child: Text(
              'Cancel',
              style: TextStyle(fontSize: 14, color: AppColor.green),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement actual CSV export logic
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('CSV Report exported successfully!'),
                  backgroundColor: AppColor.primaryMedium,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.download_outlined, size: 18),
            label: Text(
              'Export',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryMedium,
              foregroundColor: AppColor.white,
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

  // Clear data dialog
  void _showClearDataDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A3333),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              width: 35.w,
              height: 35.h,
              decoration: BoxDecoration(
                color: AppColor.red.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.warning_outlined,
                color: AppColor.red,
                size: 22,
              ),
            ),
            horizontalSpace(12),
            const Text(
              'Clear All Data?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Text(
          'This action cannot be undone. All your expenses, budgets, and history will be permanently deleted.',
          style: TextStyle(color: AppColor.grey, fontSize: 14, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: AppColor.primaryMedium,
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.green,
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement actual data clearing logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('All data has been cleared'),
                  backgroundColor: AppColor.red,
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
              backgroundColor: AppColor.red,
              foregroundColor: Colors.white,
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
