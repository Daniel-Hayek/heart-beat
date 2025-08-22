import 'package:flutter/material.dart';
import './app_colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    scaffoldBackgroundColor: AppColors.backgroundColor, // 👈 global background
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
    ),
  );
}
