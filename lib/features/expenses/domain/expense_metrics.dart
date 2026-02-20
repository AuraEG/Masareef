import 'package:masareef/features/expenses/domain/expense_category.dart';
import 'package:masareef/features/expenses/domain/expense_model.dart';

extension ExpenseListMetrics on Iterable<Expense> {
  double get totalAmount => fold(0, (sum, expense) => sum + expense.amount);

  Map<ExpenseCategory, double> amountByCategory() {
    final grouped = <ExpenseCategory, double>{
      for (final category in ExpenseCategory.values) category: 0,
    };

    for (final expense in this) {
      grouped.update(expense.category, (value) => value + expense.amount);
    }
    grouped.removeWhere((_, value) => value <= 0);
    return grouped;
  }
}
