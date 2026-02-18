import 'package:flutter/material.dart';
import 'package:masareef/core/widgets/custom_navigation_button.dart';

class ExpenseHistory extends StatelessWidget {
  const ExpenseHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(backgroundColor: colorScheme.surface),
      body: Center(
        child: Text(
          'Expense History Screen',
          style: TextStyle(fontSize: 30, color: colorScheme.onSurface),
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(indx: 2),
    );
  }
}
