import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/spacing.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key, required this.monthlyTotal});

  final double monthlyTotal;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(18).w,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Spent This Month',
            style: TextStyle(
              color: colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
              fontSize: 14.sp,
            ),
          ),
          verticalSpace(8),
          Text(
            NumberFormat.currency(symbol: '\$').format(monthlyTotal),
            style: TextStyle(
              color: colorScheme.onPrimaryContainer,
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}