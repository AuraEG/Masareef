import 'package:flutter/material.dart';
import 'package:masareef/core/constant/app_color.dart';
import 'package:masareef/core/widgets/custom_navigation_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkGreen,
      appBar: AppBar(backgroundColor: AppColor.primaryDarkGreen),
      body: Center(
        child: Text(
          'setting screen',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(indx: 3),
    );
  }
}
