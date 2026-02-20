import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:masareef/core/utils/spacing.dart';
import 'package:masareef/features/expenses/domain/expense_category.dart';
import 'package:masareef/features/expenses/domain/expense_model.dart';

class RecentExpenses extends StatelessWidget {
  const RecentExpenses({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('MMM d, hh:mm a');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Expenses',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          ),
        ),
        verticalSpace(12),
        if (expenses.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16).w,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              'Add your first expense to see activity.',
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
          )
        else
          ...expenses.map((expense) {
            return Container(
              margin: EdgeInsets.only(bottom: 10.h),
              padding: const EdgeInsets.all(14).w,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: colorScheme.secondaryContainer,
                    child: Icon(
                      expense.category.icon,
                      color: colorScheme.onSecondaryContainer,
                    ),
                  ),
                  horizontalSpace(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expense.title,
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${expense.category.label} - ${dateFormat.format(expense.date)}',
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '-${NumberFormat.currency(symbol: '\$').format(expense.amount)}',
                    style: TextStyle(
                      color: colorScheme.error,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          }),
      ],
    );
  }
}
