import 'package:masareef/features/expenses/data/expense_repository.dart';
import 'package:masareef/features/expenses/domain/expense_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesExpenseRepository implements ExpenseRepository {
  static const String _expensesKey = 'expenses_v1';

  @override
  Future<List<Expense>> fetchExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_expensesKey);
    if (raw == null || raw.isEmpty) {
      return const <Expense>[];
    }

    try {
      final expenses = Expense.decodeList(raw);
      expenses.sort((a, b) => b.date.compareTo(a.date));
      return expenses;
    } catch (_) {
      return const <Expense>[];
    }
  }

  @override
  Future<void> saveExpenses(List<Expense> expenses) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_expensesKey, Expense.encodeList(expenses));
  }
}
