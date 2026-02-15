import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareef/core/constant/app_color.dart';
import 'package:masareef/core/utils/spacing.dart';
import '../../models/onboarding_data_model.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingDataModel data;

  const OnboardingContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = (screenWidth * 0.5).clamp(180.0, 260.0);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: imageSize,
              height: imageSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Image.asset(data.image, fit: BoxFit.contain),
            ),
            SizedBox(height: screenHeight * 0.1),
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            verticalSpace(12),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 280.w),
              child: Text(
                data.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColor.primaryGreen,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
