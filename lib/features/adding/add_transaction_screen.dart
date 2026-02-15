import 'package:flutter/material.dart';
import 'package:masareef/core/constant/app_color.dart';
import 'package:masareef/core/widgets/custom_navigation_button.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkGreen,
      appBar: AppBar(backgroundColor: AppColor.primaryDarkGreen),
      body: Center(
        child: Text(
          'Add Transaction Screen',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(indx: 1),
    );
  }
}
