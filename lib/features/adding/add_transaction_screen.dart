import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../core/utils/spacing.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_navigation_button.dart';
import '../expenses/domain/expense_category.dart';
import '../expenses/presentation/cubit/expense_cubit.dart';
import '../home/home_screen.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ExpenseCategory _selectedCategory = ExpenseCategory.food;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final amount = double.tryParse(_amountController.text) ?? 0;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 16).w,
              child: CustomAppBar(title: 'Add Expense'),
            ),
            verticalSpace(8),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(20).w,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18).w,
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Amount',
                            style: TextStyle(
                              color: colorScheme.onPrimaryContainer.withValues(
                                alpha: 0.75,
                              ),
                            ),
                          ),
                          verticalSpace(8),
                          Text(
                            NumberFormat.currency(symbol: '\$').format(amount),
                            style: TextStyle(
                              color: colorScheme.onPrimaryContainer,
                              fontSize: 34.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(16),
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(12),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}'),
                        ),
                      ],
                      decoration: const InputDecoration(labelText: 'Amount'),
                      onChanged: (_) => setState(() {}),
                      validator: (value) {
                        final parsed = double.tryParse(value ?? '');
                        if (parsed == null || parsed <= 0) {
                          return 'Enter a valid amount';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(18),
                    Text(
                      'Category',
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ),
                    verticalSpace(8),
                    Wrap(
                      spacing: 10.w,
                      runSpacing: 10.h,
                      children: ExpenseCategory.values.map((category) {
                        final selected = _selectedCategory == category;
                        return ChoiceChip(
                          selected: selected,
                          label: Text(category.label),
                          avatar: Icon(
                            category.icon,
                            size: 18,
                            color: selected
                                ? colorScheme.onSecondary
                                : colorScheme.onSurfaceVariant,
                          ),
                          onSelected: (_) {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                        );
                      }).toList(),
                    ),
                    verticalSpace(18),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.calendar_today,
                        color: colorScheme.secondary,
                      ),
                      title: const Text('Date'),
                      subtitle: Text(
                        DateFormat('EEEE, MMM d, y').format(_selectedDate),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      onTap: _pickDate,
                    ),
                    verticalSpace(8),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Description (optional)',
                      ),
                    ),
                    verticalSpace(14),
                    OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Receipt attachment coming soon'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.attach_file),
                      label: const Text('Attach Receipt'),
                    ),
                    verticalSpace(24),
                    ElevatedButton.icon(
                      onPressed: _saveExpense,
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('Save Expense'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 54.h),
                      ),
                    ),
                    verticalSpace(20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(indx: 1),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _saveExpense() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await context.read<ExpenseCubit>().addExpense(
      title: _titleController.text,
      amount: double.parse(_amountController.text),
      date: _selectedDate,
      category: _selectedCategory,
      description: _descriptionController.text,
    );

    if (!mounted) {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
