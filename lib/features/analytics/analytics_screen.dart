import 'package:flutter/material.dart';
import 'package:masareef/core/constant/app_color.dart';
import 'package:masareef/core/widgets/custom_navigation_button.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDark,
      appBar: AppBar(backgroundColor: AppColor.primaryDark),
      body: Center(
        child: Text(
          'analysis screen',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(indx: 2),
    );
  }
}
