import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/calculator_binding.dart';
import 'config/app_theme.dart';
import 'views/calculator_screen.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialBinding: CalculatorBinding(),
      home: const CalculatorScreen(),
    );
  }
}
