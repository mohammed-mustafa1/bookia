import 'package:bookia/core/constants/app_fonts.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: AppFonts.dMSerifDisplay,
    colorScheme: ColorScheme.light(
      onSurface: AppColors.darkColor,
    ),
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: AppFonts.dMSerifDisplay,
    colorScheme: ColorScheme.dark(
      onSurface: AppColors.whiteColor,
    ),
  );
}
