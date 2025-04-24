// config/app_constants.dart
class AppConstants {
  // Responsive breakpoints
  static const double mobileBreakpoint = 600;

  // App default
  static const double defaultPadding = 8;
  static const double defaultBorderRadius = 8;
  static const double defaultElevation = 4;

  // Display config
  static const double displayPadding = defaultPadding * 3;
  static const double displayBorderRadius = defaultBorderRadius * 3;
  static const double buttonHeight = 44;
  static const double buttonElevation = defaultElevation / 2;

  // Button config
  static const double buttonSpacing = 4;
  static const double buttonBorderRadius = defaultBorderRadius * 2.5;

  // Calculator constants
  static const int maxDecimalPlaces = 8;

  // Basic operations
  static const String add = '\u002B'; // +
  static const String subtract = '\u2212'; // −
  static const String multiply = '\u00D7'; // ×
  static const String divide = '\u00F7'; // ÷

  // Advanced math
  static const String percent = '\u0025'; // %
  static const String squareRoot = '\u221A'; // √
  static const String power = '^'; // ^
  static const String squared = 'x\u00B2'; // x²

  // Result and equals
  static const String equals = '\u003D'; // =

  // Modifiers
  static const String negate = '\u00B1'; // ±
  static const String decimal = '.'; // .
  static const String plusMinusCombo = '+/\u2212'; // +/−

  // Clear operations
  static const String clear = 'C';
  static const String allClear = 'AC';

  // Utility
  static const String backspace = '\u232B';

  // Custom extensions
  static const String exponent = '^';

  // Memory operations
  static const String memoryClear = 'MC';
  static const String memoryRecall = 'MR';
  static const String memoryAdd = 'M+';

  // Error messages
  static const String errorDivideByZero = 'Cannot divide by zero';
  static const String errorInvalidInput = 'Invalid input';
}
