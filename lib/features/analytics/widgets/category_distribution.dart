import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/spacing.dart';
import '../../expenses/domain/expense_category.dart';

class CategoryDistribution extends StatelessWidget {
  const CategoryDistribution({super.key, 
    required this.categoryTotals,
    required this.total,
  });

  final Map<ExpenseCategory, double> categoryTotals;
  final double total;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (categoryTotals.isEmpty) {
      return Text(
        'No data for this month.',
        style: TextStyle(color: colorScheme.onSurfaceVariant),
      );
    }

    return Column(
      children: categoryTotals.entries.map((entry) {
        final percent = total == 0 ? 0.0 : entry.value / total;

        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            children: [
              Icon(entry.key.icon, color: colorScheme.secondary, size: 18),
              horizontalSpace(8),
              Expanded(
                child: Text(
                  entry.key.label,
                  style: TextStyle(color: colorScheme.onSurface),
                ),
              ),
              Text(
                '${(percent * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              horizontalSpace(8),
              SizedBox(
                width: 80.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: LinearProgressIndicator(
                    value: percent,
                    minHeight: 8.h,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme.secondary,
                    ),
                    backgroundColor: colorScheme.surfaceContainerHighest,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}