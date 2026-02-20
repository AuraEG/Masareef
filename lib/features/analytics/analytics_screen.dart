import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:masareef/core/utils/spacing.dart';
import 'package:masareef/core/widgets/custom_app_bar.dart';
import 'package:masareef/core/widgets/custom_navigation_button.dart';
import 'package:masareef/features/analytics/widgets/category_distribution.dart';
import 'package:masareef/features/analytics/widgets/category_ranking.dart';
import 'package:masareef/features/analytics/widgets/daily_trend_chart.dart';
import 'package:masareef/features/analytics/widgets/section_card.dart';
import 'package:masareef/features/expenses/domain/expense_metrics.dart';
import 'package:masareef/features/expenses/domain/expense_model.dart';
import 'package:masareef/features/expenses/presentation/cubit/expense_cubit.dart';
import 'package:masareef/features/expenses/presentation/cubit/expense_state.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: BlocBuilder<ExpenseCubit, ExpenseState>(
          builder: (context, state) {
            final thisMonth = _expensesOfCurrentMonth(state.expenses);
            final totalMonth = thisMonth.totalAmount;
            final byCategory = thisMonth.amountByCategory();
            final dailyTrend = _lastSevenDaysTotals(state.expenses);
            final ranking = byCategory.entries.toList()
              ..sort((a, b) => b.value.compareTo(a.value));

            return ListView(
              padding: const EdgeInsets.all(20).w,
              children: [
                CustomAppBar(title: 'Analytics'),
                verticalSpace(20),
                Container(
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
                          color: colorScheme.onPrimaryContainer.withValues(
                            alpha: 0.8,
                          ),
                        ),
                      ),
                      verticalSpace(8),
                      Text(
                        NumberFormat.currency(symbol: '\$').format(totalMonth),
                        style: TextStyle(
                          color: colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w800,
                          fontSize: 32.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(16),
                SectionCard(
                  title: 'Spending Distribution',
                  child: CategoryDistribution(
                    categoryTotals: byCategory,
                    total: totalMonth,
                  ),
                ),
                verticalSpace(16),
                SectionCard(
                  title: 'Daily Trend',
                  child: DailyTrendChart(values: dailyTrend),
                ),
                verticalSpace(16),
                SectionCard(
                  title: 'Category Ranking',
                  child: CategoryRanking(entries: ranking),
                ),
                verticalSpace(20),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(indx: 3),
    );
  }

  List<Expense> _expensesOfCurrentMonth(List<Expense> expenses) {
    final now = DateTime.now();
    return expenses
        .where(
          (expense) =>
              expense.date.year == now.year && expense.date.month == now.month,
        )
        .toList();
  }

  List<double> _lastSevenDaysTotals(List<Expense> expenses) {
    final now = DateTime.now();
    return List<double>.generate(7, (index) {
      final date = DateTime(now.year, now.month, now.day - (6 - index));
      return expenses
          .where(
            (expense) =>
                expense.date.year == date.year &&
                expense.date.month == date.month &&
                expense.date.day == date.day,
          )
          .totalAmount;
    });
  }
}