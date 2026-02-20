import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:masareef/core/utils/spacing.dart';
import 'package:masareef/core/widgets/custom_app_bar.dart';
import 'package:masareef/core/widgets/custom_navigation_button.dart';
import 'package:masareef/features/expenses/domain/expense_category.dart';
import 'package:masareef/features/expenses/domain/expense_metrics.dart';
import 'package:masareef/features/expenses/domain/expense_model.dart';
import 'package:masareef/features/expenses/presentation/cubit/expense_cubit.dart';
import 'package:masareef/features/expenses/presentation/cubit/expense_state.dart';
import 'package:masareef/features/expenses/presentation/widgets/expence_tile.dart';
import 'package:masareef/features/expenses/presentation/widgets/filter_bar.dart';

enum HistoryPeriod { day, week, month }

class ExpenseHistory extends StatefulWidget {
  const ExpenseHistory({super.key});

  @override
  State<ExpenseHistory> createState() => _ExpenseHistoryState();
}

class _ExpenseHistoryState extends State<ExpenseHistory> {
  final TextEditingController _searchController = TextEditingController();
  HistoryPeriod _period = HistoryPeriod.week;
  ExpenseCategory? _categoryFilter;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: BlocBuilder<ExpenseCubit, ExpenseState>(
          builder: (context, state) {
            final filtered = _applyFilters(state.expenses);
            final grouped = _groupByDay(filtered);
            final weekTotal = _thisWeekTotal(state.expenses);

            return ListView(
              padding: const EdgeInsets.all(20).w,
              children: [
                CustomAppBar(title: 'Expenses History'),
                verticalSpace(24),
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search by title or category',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                verticalSpace(12),
                FilterBar(
                  selectedPeriod: _period,
                  selectedCategory: _categoryFilter,
                  onPeriodChanged: (period) {
                    setState(() {
                      _period = period;
                    });
                  },
                  onCategoryChanged: (category) {
                    setState(() {
                      _categoryFilter = category;
                    });
                  },
                ),
                verticalSpace(14),
                if (grouped.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(16).w,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      'No matching expenses found.',
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                  )
                else
                  ...grouped.entries.map((entry) {
                    final dayTotal = entry.value.totalAmount;

                    return Padding(
                      padding: EdgeInsets.only(bottom: 14.h),
                      child: Container(
                        padding: const EdgeInsets.all(14).w,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('EEEE, MMM d').format(entry.key),
                                  style: TextStyle(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  NumberFormat.currency(
                                    symbol: '\$',
                                  ).format(dayTotal),
                                  style: TextStyle(
                                    color: colorScheme.secondary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            verticalSpace(10),
                            ...entry.value.map((expense) {
                              return ExpenseTile(expense: expense);
                            }),
                          ],
                        ),
                      ),
                    );
                  }),
                Container(
                  margin: EdgeInsets.only(top: 8.h, bottom: 20.h),
                  padding: const EdgeInsets.all(16).w,
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'This Week Total',
                        style: TextStyle(
                          color: colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        NumberFormat.currency(symbol: '\$').format(weekTotal),
                        style: TextStyle(
                          color: colorScheme.onSecondaryContainer,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(indx: 2),
    );
  }

  List<Expense> _applyFilters(List<Expense> expenses) {
    final query = _searchController.text.trim().toLowerCase();
    final now = DateTime.now();

    return expenses.where((expense) {
      final matchesQuery =
          query.isEmpty ||
          expense.title.toLowerCase().contains(query) ||
          expense.category.label.toLowerCase().contains(query);

      final matchesCategory =
          _categoryFilter == null || expense.category == _categoryFilter;

      final matchesPeriod = switch (_period) {
        HistoryPeriod.day => _isSameDay(expense.date, now),
        HistoryPeriod.week => _isWithinSameWeek(expense.date, now),
        HistoryPeriod.month =>
          expense.date.year == now.year && expense.date.month == now.month,
      };

      return matchesQuery && matchesCategory && matchesPeriod;
    }).toList();
  }

  Map<DateTime, List<Expense>> _groupByDay(List<Expense> expenses) {
    final grouped = <DateTime, List<Expense>>{};

    for (final expense in expenses) {
      final key = DateTime(
        expense.date.year,
        expense.date.month,
        expense.date.day,
      );
      grouped.putIfAbsent(key, () => <Expense>[]).add(expense);
    }

    final sortedKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));
    final sorted = <DateTime, List<Expense>>{};

    for (final key in sortedKeys) {
      final items = grouped[key]!;
      items.sort((a, b) => b.date.compareTo(a.date));
      sorted[key] = items;
    }

    return sorted;
  }

  double _thisWeekTotal(List<Expense> expenses) {
    final now = DateTime.now();
    return expenses
        .where((expense) => _isWithinSameWeek(expense.date, now))
        .totalAmount;
  }

  bool _isSameDay(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  bool _isWithinSameWeek(DateTime date, DateTime now) {
    final startOfWeek = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7));

    return !date.isBefore(startOfWeek) && date.isBefore(endOfWeek);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}