import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareef/core/theme/app_theme.dart';
import 'package:masareef/core/theme/theme_controller.dart';
import 'package:masareef/features/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeController = ThemeController();
  await themeController.loadThemeMode();

  runApp(MyApp(themeController: themeController));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.themeController});

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      controller: themeController,
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
    );
  }
}
