// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'helpers/windows_window_config.dart';

void main() async {
  setMinimumWindowSize();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const CalculatorApp());
}
