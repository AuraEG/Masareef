import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareef/core/utils/spacing.dart';
import 'package:masareef/core/widgets/custom_navigation_button.dart';
import 'package:masareef/features/expenses/domain/expense_metrics.dart';
import 'package:masareef/features/expenses/presentation/cubit/expense_cubit.dart';
import 'package:masareef/features/expenses/presentation/cubit/expense_state.dart';
import 'package:masareef/features/home/category_breakdown.dart';
import 'package:masareef/features/home/widgets/home_app_bar.dart';
import 'package:masareef/features/home/widgets/recent_expences.dart';
import 'package:masareef/features/home/widgets/summary_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: BlocBuilder<ExpenseCubit, ExpenseState>(
          builder: (context, state) {
            final expenses = state.expenses;
            final monthlyExpenses = expenses
                .where(
                  (expense) =>
                      expense.date.year == DateTime.now().year &&
                      expense.date.month == DateTime.now().month,
                )
                .toList();
            final monthlyTotal = monthlyExpenses.totalAmount;
            final categoryTotals = expenses.amountByCategory();
            final recent = expenses.take(5).toList();

            return RefreshIndicator(
              onRefresh: () => context.read<ExpenseCubit>().loadExpenses(),
              child: ListView(
                padding: const EdgeInsets.all(20).w,
                children: [
                  const HomeAppBar(),
                  verticalSpace(24),
                  SummaryCard(monthlyTotal: monthlyTotal),
                  verticalSpace(20),
                  CategoryBreakdown(categoryTotals: categoryTotals),
                  verticalSpace(20),
                  RecentExpenses(expenses: recent),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(indx: 0),
    );
  }
}