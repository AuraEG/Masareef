import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import '../constant/app_color.dart';

class AppTheme {
  static ThemeData light = FlexThemeData.light(
    useMaterial3: true,

    // نستخدم Seeded Theming من primary
    keyColors: const FlexKeyColors(useKeyColors: true, keepPrimary: true),

    colors: FlexSchemeColor(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      primaryContainer: AppColors.primaryLight,
    ),

    subThemesData: const FlexSubThemesData(
      defaultRadius: 14,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorIsFilled: true,
      elevatedButtonElevation: 0,
    ),
  );

  static ThemeData dark = FlexThemeData.dark(
    useMaterial3: true,

    keyColors: const FlexKeyColors(useKeyColors: true, keepPrimary: true),

    colors: FlexSchemeColor(
      primary: AppColors.primaryLight,
      secondary: AppColors.secondary,
    ),

    subThemesData: const FlexSubThemesData(
      defaultRadius: 14,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorIsFilled: true,
      elevatedButtonElevation: 0,
    ),
  );
}
