import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/expense_category.dart';
import '../expense_history_screen.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key, 
    required this.selectedPeriod,
    required this.selectedCategory,
    required this.onPeriodChanged,
    required this.onCategoryChanged,
  });

  final HistoryPeriod selectedPeriod;
  final ExpenseCategory? selectedCategory;
  final ValueChanged<HistoryPeriod> onPeriodChanged;
  final ValueChanged<ExpenseCategory?> onCategoryChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        ...HistoryPeriod.values.map((period) {
          return ChoiceChip(
            selected: selectedPeriod == period,
            label: Text(period.name.toUpperCase()),
            onSelected: (_) => onPeriodChanged(period),
          );
        }),
        PopupMenuButton<ExpenseCategory?>(
          onSelected: onCategoryChanged,
          itemBuilder: (context) {
            return [
              const PopupMenuItem<ExpenseCategory?>(
                value: null,
                child: Text('All Categories'),
              ),
              ...ExpenseCategory.values.map(
                (category) => PopupMenuItem<ExpenseCategory?>(
                  value: category,
                  child: Text(category.label),
                ),
              ),
            ];
          },
          child: Chip(
            avatar: const Icon(Icons.filter_alt_outlined, size: 18),
            label: Text(selectedCategory?.label ?? 'Category'),
          ),
        ),
      ],
    );
  }
}