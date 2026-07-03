// light_theme.dart
import 'package:flutter/material.dart';
import 'package:maruthimedical/theme/app_colors.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.lightBackground,
  appBarTheme: AppBarTheme(backgroundColor: AppColors.lightBackground2,foregroundColor: AppColors.lightText,),
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  inputDecorationTheme:InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    hintStyle: TextStyle(
      color: Color.fromARGB(255, 48, 48, 48),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
    ),
    prefixIconColor: Color.fromARGB(255, 48, 48, 48),
    suffixIconColor: Color(0xFF6B7A99) ,
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: AppColors.lightText),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.lightBackground2,
    selectedIconTheme: IconThemeData(color: Colors.blue),
    unselectedItemColor:AppColors.lightText,
    unselectedIconTheme:IconThemeData(color: AppColors.lightText)
  )
); 