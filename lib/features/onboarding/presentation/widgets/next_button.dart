import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLastPage;

  const NextButton({
    super.key,
    required this.onPressed,
    this.isLastPage = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.secondaryContainer.withValues(
            alpha: 0.8,
          ),
          foregroundColor: colorScheme.onSecondaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36.r),
          ),
          elevation: 0,
        ),
        child: Text(
          isLastPage ? 'Get Started' : 'Next',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSecondaryContainer,
          ),
        ),
      ),
    );
  }
}
