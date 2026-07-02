import 'package:flutter/material.dart';
import 'package:maruthimedical/features/home/home_screen.dart';
import 'package:maruthimedical/theme/dark_theme.dart';
import 'package:maruthimedical/theme/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => MyAppState();
}
class MyAppState extends State<MyApp> {
  ThemeData mytheme = lightTheme;

  void changeTheme(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("theme", index);

    setState(() {
      mytheme = index == 0 ? darkTheme : lightTheme;
    });
  }

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  void loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    int storedTheme = prefs.getInt("theme") ?? 1;

    if (!mounted) return;

    setState(() {
      mytheme = storedTheme == 0 ? darkTheme : lightTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mytheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}