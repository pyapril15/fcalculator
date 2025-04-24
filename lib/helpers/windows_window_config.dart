// lib/helpers/windows_window_config.dart

import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:window_size/window_size.dart';

void setMinimumWindowSize() {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    WidgetsFlutterBinding.ensureInitialized();

    setWindowMinSize(const Size(450, 800));
  }
}
