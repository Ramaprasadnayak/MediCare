import 'package:flutter/material.dart';
import 'package:maruthimedical/theme/theme_providers.dart';
import 'package:provider/provider.dart';
import 'app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}