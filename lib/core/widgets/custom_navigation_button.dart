import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:masareef/core/constant/app_color.dart';
import 'package:masareef/features/adding/add_transaction_screen.dart';
import 'package:masareef/features/analytics/analytics_screen.dart';
import 'package:masareef/features/home/home_screen.dart';
import 'package:masareef/features/settings/settings_screen.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key, required this.indx});
  final int indx;
  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(),
      AddTransactionScreen(),
      AnalyticsScreen(),
      SettingsScreen(),
    ];
    return CurvedNavigationBar(
      index: indx,
      color: AppColor.primaryMedium.withValues(alpha: 0.5), // navigation bar
      buttonBackgroundColor: AppColor.green.withValues(
        alpha: 0.1,
      ), // icon bg when selected

      backgroundColor: AppColor.primaryDark,
      items: <Widget>[
        Icon(Icons.home, size: 35, color: AppColor.white),
        Icon(Icons.wallet_outlined, size: 35, color: AppColor.white),
        Icon(Icons.analytics, size: 35, color: AppColor.white),
        Icon(Icons.settings, size: 35, color: AppColor.white),
      ],
      onTap: (index) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 600),
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
                end: 1.5,
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
