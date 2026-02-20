import 'package:flutter/material.dart';

enum ExpenseCategory {
  food,
  transport,
  rent,
  shopping,
  health,
  travel,
  entertainment,
  utilities,
  others,
}

extension ExpenseCategoryX on ExpenseCategory {
  String get label => switch (this) {
    ExpenseCategory.food => 'Food',
    ExpenseCategory.transport => 'Transport',
    ExpenseCategory.rent => 'Rent',
    ExpenseCategory.shopping => 'Shopping',
    ExpenseCategory.health => 'Health',
    ExpenseCategory.travel => 'Travel',
    ExpenseCategory.entertainment => 'Entertainment',
    ExpenseCategory.utilities => 'Utilities',
    ExpenseCategory.others => 'Others',
  };

  IconData get icon => switch (this) {
    ExpenseCategory.food => Icons.restaurant,
    ExpenseCategory.transport => Icons.directions_car,
    ExpenseCategory.rent => Icons.home_work,
    ExpenseCategory.shopping => Icons.shopping_bag,
    ExpenseCategory.health => Icons.health_and_safety,
    ExpenseCategory.travel => Icons.flight,
    ExpenseCategory.entertainment => Icons.movie,
    ExpenseCategory.utilities => Icons.electric_bolt,
    ExpenseCategory.others => Icons.more_horiz,
  };

  String get key => name;

  static ExpenseCategory fromKey(String value) {
    return ExpenseCategory.values.firstWhere(
      (category) => category.name == value,
      orElse: () => ExpenseCategory.others,
    );
  }
}
