import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareef/core/constant/app_color.dart';
import 'package:masareef/core/constant/app_images.dart';

class SplashAnimatedLogo extends StatelessWidget {
  final Animation<double> scale;
  final Animation<double> opacity;

  const SplashAnimatedLogo({
    super.key,
    required this.scale,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale.value,
      child: Container(
        width: 200.w,
        height: 200.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.primaryMedium.withValues(alpha: 0.2),
        ),
        child: Opacity(
          opacity: opacity.value,
          child: Image.asset(
            AppImages.logo,
            width: 80.w,
            height: 80.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
