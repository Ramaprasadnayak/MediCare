import 'package:flutter/material.dart';
import 'package:maruthimedical/providers/theme_providers.dart';
import 'package:provider/provider.dart';
import 'theme/light_theme.dart';
import 'theme/dark_theme.dart';
import 'features/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider =Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      home: const HomeScreen(),
    );
  }
}