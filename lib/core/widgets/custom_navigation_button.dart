import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../features/adding/add_transaction_screen.dart';
import '../../features/analytics/analytics_screen.dart';
import '../../features/expenses/presentation/expense_history_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/settings/settings_screen.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key, required this.indx});

  final int indx;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final List<Widget> screens = const [
      HomeScreen(),
      AddExpenseScreen(),
      ExpenseHistory(),
      AnalyticsScreen(),
      SettingsScreen(),
    ];

    return CurvedNavigationBar(
      index: indx,
      color: colorScheme.surfaceContainerHigh.withValues(alpha: 0.9),
      buttonBackgroundColor: colorScheme.secondaryContainer.withValues(
        alpha: 0.8,
      ),
      backgroundColor: colorScheme.surface,
      items: <Widget>[
        Icon(Icons.home, size: 35, color: colorScheme.onSurface),
        Icon(Icons.wallet_outlined, size: 35, color: colorScheme.onSurface),
        Icon(
          Icons.receipt_long_outlined,
          size: 35,
          color: colorScheme.onSurface,
        ),
        Icon(Icons.analytics, size: 35, color: colorScheme.onSurface),
        Icon(Icons.settings, size: 35, color: colorScheme.onSurface),
      ],
      onTap: (index) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            // transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (_, animation, secondaryAnimation) => screens[index],
            transitionsBuilder: (_, animation, secondaryAnimation, child) {
              final slideAnimation =
                  Tween<Offset>(
                    begin: const Offset(0.2, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeOut),
                  );

              final fadeAnimation = Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(animation);

              return FadeTransition(
                opacity: fadeAnimation,
                child: SlideTransition(position: slideAnimation, child: child),
              );
            },
          ),
        );
      },
    );
  }
}
