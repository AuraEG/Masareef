import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareef/core/utils/spacing.dart';

class DailyTrendChart extends StatelessWidget {
  const DailyTrendChart({super.key, required this.values});

  final List<double> values;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final maxValue = values.isEmpty ? 1.0 : values.reduce(max);
    final labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return SizedBox(
      height: 180.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(values.length, (index) {
          final value = values[index];
          final ratio = maxValue == 0 ? 0.05 : value / maxValue;

          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 20.w,
                  height: (ratio * 120.h).clamp(8.h, 120.h),
                  decoration: BoxDecoration(
                    color: colorScheme.secondary.withValues(alpha: 0.2 + ratio),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                verticalSpace(8),
                Text(
                  labels[index],
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}