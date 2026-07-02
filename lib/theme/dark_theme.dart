// dark_theme.dart
import 'package:flutter/material.dart';
import 'package:maruthimedical/theme/app_colors.dart';


ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.darkBackground1,
  cardTheme: CardThemeData(
    color:AppColors.darkBackground2
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: AppColors.darkText),
  ),
);