import 'package:bookia/core/constants/app_fonts.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: AppFonts.dMSerifDisplay,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(8)),
    ),
    colorScheme: ColorScheme.light(
      onSurface: AppColors.darkColor,
    ),
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: AppColors.whiteColor),
    ),
  );
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      fontFamily: AppFonts.dMSerifDisplay,
      colorScheme: ColorScheme.dark(
        onSurface: AppColors.whiteColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(8)),
      ),
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.whiteColor),
      ));
}
