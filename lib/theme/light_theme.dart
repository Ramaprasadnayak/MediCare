// light_theme.dart
import 'package:flutter/material.dart';
import 'package:maruthimedical/theme/app_colors.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.lightBackground,
  cardTheme: CardThemeData(
    color:AppColors.lightBackground2
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: AppColors.lightText),
  ),
);