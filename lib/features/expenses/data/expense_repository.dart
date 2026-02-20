import 'package:masareef/features/expenses/domain/expense_model.dart';

abstract class ExpenseRepository {
  Future<List<Expense>> fetchExpenses();

  Future<void> saveExpenses(List<Expense> expenses);
}
