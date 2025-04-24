// services/calculator_service.dart

import 'dart:math' as math;

import '../../config/app_constants.dart';
import '../models/calculator_model.dart';

class CalculatorService {
  /// Returns the symbol corresponding to the given [Operation].
  String getSymbol(Operation operation) {
    switch (operation) {
      case Operation.add:
        return AppConstants.add;
      case Operation.subtract:
        return AppConstants.subtract;
      case Operation.multiply:
        return AppConstants.multiply;
      case Operation.divide:
        return AppConstants.divide;
      case Operation.sqrt:
        return AppConstants.squareRoot;
      case Operation.squared:
        return AppConstants.squared;
      case Operation.power:
        return AppConstants.power;
      default:
        return '';
    }
  }

  /// Formats a numeric [value] string into a clean display format.
  /// Removes trailing zeros and unnecessary decimal point.
  String formatResult(String value) {
    final number = double.tryParse(value);
    if (number == null) return value;

    if (number == number.truncateToDouble()) {
      return number.toInt().toString();
    }

    String formatted = number.toStringAsFixed(AppConstants.maxDecimalPlaces);
    while (formatted.contains('.') && formatted.endsWith('0')) {
      formatted = formatted.substring(0, formatted.length - 1);
    }

    return formatted.endsWith('.')
        ? formatted.substring(0, formatted.length - 1)
        : formatted;
  }

  /// Applies square root to a given [value].
  double sqrt(double value) => math.sqrt(value);

  /// Applies square to a given [value].
  double squared(double value) => value * value;

  /// Applies exponentiation with [base] raised to the power of [exponent].
  double power(double base, double exponent) =>
      math.pow(base, exponent).toDouble();

  /// Performs calculation based on the given operands and operation.
  double calculate(String firstOperand, String secondOperand, Operation op) {
    final first = double.parse(firstOperand);
    final second = double.parse(secondOperand);

    switch (op) {
      case Operation.add:
        return first + second;
      case Operation.subtract:
        return first - second;
      case Operation.multiply:
        return first * second;
      case Operation.divide:
        if (second == 0) throw Exception(AppConstants.errorDivideByZero);
        return first / second;
      case Operation.power:
        return power(first, second);
      default:
        throw Exception(AppConstants.errorInvalidInput);
    }
  }
}
