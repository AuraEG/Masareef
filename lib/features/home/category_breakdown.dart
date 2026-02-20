import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareef/core/utils/spacing.dart';
import 'package:masareef/features/expenses/domain/expense_category.dart';

class CategoryBreakdown extends StatelessWidget {
  const CategoryBreakdown({super.key, required this.categoryTotals});

  final Map<ExpenseCategory, double> categoryTotals;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final total = categoryTotals.values.fold(0.0, (sum, value) => sum + value);

    return Container(
      padding: const EdgeInsets.all(16).w,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Spending by Category',
            style: TextStyle(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          ),
          verticalSpace(16),
          if (categoryTotals.isEmpty)
            Text(
              'No expenses yet.',
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            )
          else
            ...categoryTotals.entries.map((entry) {
              final progress = total == 0 ? 0.0 : entry.value / total;
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          entry.key.icon,
                          size: 18,
                          color: colorScheme.secondary,
                        ),
                        horizontalSpace(8),
                        Expanded(
                          child: Text(
                            entry.key.label,
                            style: TextStyle(color: colorScheme.onSurface),
                          ),
                        ),
                        Text(
                          '${(progress * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: LinearProgressIndicator(
                        minHeight: 8.h,
                        value: progress,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colorScheme.secondary,
                        ),
                        backgroundColor: colorScheme.surfaceContainerHighest,
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}