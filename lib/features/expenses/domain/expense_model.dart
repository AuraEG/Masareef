import 'dart:convert';

import 'package:masareef/features/expenses/domain/expense_category.dart';

class Expense {
  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    this.description,
    this.receiptPath,
  });

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;
  final String? description;
  final String? receiptPath;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.key,
      'description': description,
      'receiptPath': receiptPath,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] as String,
      title: map['title'] as String,
      amount: (map['amount'] as num).toDouble(),
      date: DateTime.parse(map['date'] as String),
      category: ExpenseCategoryX.fromKey(map['category'] as String),
      description: map['description'] as String?,
      receiptPath: map['receiptPath'] as String?,
    );
  }

  static String encodeList(List<Expense> expenses) {
    return jsonEncode(expenses.map((expense) => expense.toMap()).toList());
  }

  static List<Expense> decodeList(String source) {
    final data = jsonDecode(source) as List<dynamic>;
    return data
        .map((item) => Expense.fromMap(item as Map<String, dynamic>))
        .toList();
  }
}
