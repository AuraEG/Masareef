import 'package:masareef/features/expenses/domain/expense_model.dart';

enum ExpenseStatus { initial, loading, loaded, failure }

class ExpenseState {
  const ExpenseState({
    this.status = ExpenseStatus.initial,
    this.expenses = const <Expense>[],
    this.errorMessage,
  });

  final ExpenseStatus status;
  final List<Expense> expenses;
  final String? errorMessage;

  ExpenseState copyWith({
    ExpenseStatus? status,
    List<Expense>? expenses,
    String? errorMessage,
  }) {
    return ExpenseState(
      status: status ?? this.status,
      expenses: expenses ?? this.expenses,
      errorMessage: errorMessage,
    );
  }

  double get totalSpent =>
      expenses.fold(0, (sum, expense) => sum + expense.amount);
}
