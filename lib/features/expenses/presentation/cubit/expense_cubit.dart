import 'dart:math';

import 'package:bloc/bloc.dart';
import '../../data/expense_repository.dart';
import '../../domain/expense_category.dart';
import '../../domain/expense_model.dart';
import 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  ExpenseCubit(this._repository) : super(const ExpenseState());

  final ExpenseRepository _repository;

  Future<void> loadExpenses() async {
    emit(state.copyWith(status: ExpenseStatus.loading));
    try {
      final expenses = await _repository.fetchExpenses();
      emit(state.copyWith(status: ExpenseStatus.loaded, expenses: expenses));
    } catch (_) {
      emit(
        state.copyWith(
          status: ExpenseStatus.failure,
          errorMessage: 'Failed to load expenses',
        ),
      );
    }
  }

  Future<void> addExpense({
    required String title,
    required double amount,
    required DateTime date,
    required ExpenseCategory category,
    String? description,
    String? receiptPath,
  }) async {
    final expense = Expense(
      id: _createId(),
      title: title.trim(),
      amount: amount,
      date: date,
      category: category,
      description: _normalizeNullable(description),
      receiptPath: _normalizeNullable(receiptPath),
    );

    final updated = <Expense>[expense, ...state.expenses]
      ..sort((a, b) => b.date.compareTo(a.date));

    emit(state.copyWith(status: ExpenseStatus.loaded, expenses: updated));
    await _repository.saveExpenses(updated);
  }

  Future<void> deleteExpense(String id) async {
    final updated = state.expenses.where((expense) => expense.id != id).toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    emit(state.copyWith(status: ExpenseStatus.loaded, expenses: updated));
    await _repository.saveExpenses(updated);
  }

  Future<void> clearAll() async {
    emit(state.copyWith(status: ExpenseStatus.loaded, expenses: const []));
    await _repository.saveExpenses(const []);
  }

  String _createId() {
    final random = Random();
    return '${DateTime.now().microsecondsSinceEpoch}_${random.nextInt(100000)}';
  }

  String? _normalizeNullable(String? value) {
    if (value == null) {
      return null;
    }
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}
