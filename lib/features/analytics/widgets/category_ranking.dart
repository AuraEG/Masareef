import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/spacing.dart';
import '../../expenses/domain/expense_category.dart';

class CategoryRanking extends StatelessWidget {
  const CategoryRanking({super.key, required this.entries});

  final List<MapEntry<ExpenseCategory, double>> entries;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (entries.isEmpty) {
      return Text(
        'No categories to rank yet.',
        style: TextStyle(color: colorScheme.onSurfaceVariant),
      );
    }

    return Column(
      children: entries.map((entry) {
        return Container(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: const EdgeInsets.all(12).w,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: colorScheme.secondaryContainer,
                child: Icon(
                  entry.key.icon,
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
              horizontalSpace(10),
              Expanded(
                child: Text(
                  entry.key.label,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                NumberFormat.currency(symbol: '\$').format(entry.value),
                style: TextStyle(
                  color: colorScheme.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
