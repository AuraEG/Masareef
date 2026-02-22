import 'package:flutter/material.dart';
import 'core/utils/notification_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'features/expenses/data/shared_preferences_expense_repository.dart';
import 'features/expenses/presentation/cubit/expense_cubit.dart';
import 'features/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeController = ThemeController();
  await themeController.loadThemeMode();

  await NotificationService.instance.init();
  await NotificationService.instance.syncDailyReminderWithPreference();

  runApp(MyApp(themeController: themeController));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.themeController});

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    final expenseRepository = SharedPreferencesExpenseRepository();

    return ThemeScope(
      controller: themeController,
      child: BlocProvider(
        create: (_) => ExpenseCubit(expenseRepository)..loadExpenses(),
        child: AnimatedBuilder(
          animation: themeController,
          builder: (context, _) {
            return ScreenUtilInit(
              designSize: const Size(360, 690),
              builder: (_, child) {
                return MaterialApp(
                  theme: AppTheme.light,
                  darkTheme: AppTheme.dark,
                  themeMode: themeController.themeMode,
                  debugShowCheckedModeBanner: false,
                  home: child,
                );
              },
              child: const SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}
