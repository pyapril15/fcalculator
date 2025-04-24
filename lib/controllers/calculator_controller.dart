// controllers/calculator_controller.dart

import 'package:get/get.dart';

import '../../config/app_constants.dart';
import '../models/calculator_model.dart';
import '../services/calculator_service.dart';

class CalculatorController extends GetxController {
  final _state = CalculatorModel().obs;
  final CalculatorService _service = CalculatorService();

  CalculatorModel get state => _state.value;

  // ==========================
  // Public Input Functions
  // ==========================

  void inputDigit(String digit) {
    _handleErrorOrReset(digit);
    final updatedDisplay =
        state.shouldReset || state.display == '0'
            ? digit
            : state.display + digit;

    _updateState(display: updatedDisplay, shouldReset: false);
  }

  void inputDecimal() {
    _handleErrorOrReset('0${AppConstants.decimal}');
    if (state.shouldReset) {
      _updateState(display: '0${AppConstants.decimal}', shouldReset: false);
    } else if (!state.display.contains(AppConstants.decimal)) {
      _updateState(display: state.display + AppConstants.decimal);
    }
  }

  void inputOperation(Operation op) {
    if (state.hasError) return clearAll();

    final symbol = _service.getSymbol(op);

    if (_isFunctionOperation(op)) return _handleFunction(op, symbol);

    if (_readyForCalculation()) calculate();

    _updateState(
      firstOperand: state.display,
      operation: op,
      expression: '${state.display} $symbol',
      shouldReset: true,
    );
  }

  void calculate() {
    if (state.operation == Operation.none || state.hasError) return;

    try {
      final result = _service.calculate(
        state.firstOperand!,
        state.display,
        state.operation,
      );

      final resultStr = _service.formatResult(result.toString());
      final expr = '${state.expression} ${state.display} = $resultStr';

      _updateState(
        display: resultStr,
        expression: expr,
        firstOperand: null,
        operation: Operation.none,
        shouldReset: true,
      );
    } catch (_) {
      _setError(AppConstants.errorInvalidInput);
    }
  }

  void negate() {
    if (state.hasError || state.display == '0') return;

    final isNegative = state.display.startsWith('-');
    final toggled =
        isNegative ? state.display.substring(1) : '-${state.display}';

    _updateState(display: toggled);
  }

  void inputPercent() {
    try {
      final percent = double.parse(state.display) / 100;
      _updateState(display: _service.formatResult(percent.toString()));
    } catch (_) {
      _setError(AppConstants.errorInvalidInput);
    }
  }

  void backspace() {
    if (state.hasError || state.shouldReset || state.display.isEmpty) return;

    final updated =
        state.display.length == 1
            ? '0'
            : state.display.substring(0, state.display.length - 1);

    _updateState(display: updated);
  }

  // ==========================
  // Memory Operations
  // ==========================

  void memoryAdd() {
    if (state.hasError) return;
    try {
      final displayVal = double.parse(state.display);
      final memoryVal = state.memory != null ? double.parse(state.memory!) : 0;
      final total = displayVal + memoryVal;
      _updateState(
        memory: _service.formatResult(total.toString()),
        shouldReset: true,
      );
    } catch (_) {
      _setError(AppConstants.errorInvalidInput);
    }
  }

  void memoryRecall() {
    if (state.memory != null) {
      _updateState(display: state.memory!, shouldReset: true);
    }
  }

  void memoryClear() {
    _updateState(memory: null);
  }

  // ==========================
  // Clear Operations
  // ==========================

  void clearEntry() {
    if (state.hasError) {
      clearAll();
    } else {
      _updateState(display: '0', shouldReset: false);
    }
  }

  void clearAll() {
    _state.value = CalculatorModel();
  }

  // ==========================
  // Internal Helpers
  // ==========================

  void _handleFunction(Operation op, String symbol) {
    try {
      final val = double.parse(state.display);
      double result;
      String expression;

      if (op == Operation.sqrt) {
        if (val < 0) return _setError(AppConstants.errorInvalidInput);
        result = _service.sqrt(val);
        expression = '√(${state.display})';
      } else if (op == Operation.squared) {
        result = _service.squared(val);
        expression = '(${state.display})²';
      } else {
        return;
      }

      _updateState(
        display: _service.formatResult(result.toString()),
        expression: expression,
        firstOperand: null,
        operation: Operation.none,
        shouldReset: true,
      );
    } catch (_) {
      _setError(AppConstants.errorInvalidInput);
    }
  }

  void _handleErrorOrReset(String value) {
    if (state.hasError) {
      _resetDisplay(value);
    }
  }

  bool _readyForCalculation() {
    return state.firstOperand != null &&
        state.operation != Operation.none &&
        !state.shouldReset;
  }

  bool _isFunctionOperation(Operation op) {
    return op == Operation.sqrt || op == Operation.squared;
  }

  void _resetDisplay(String value) {
    _state.value = CalculatorModel(display: value);
  }

  void _setError(String message) {
    _updateState(display: message, hasError: true);
  }

  void _updateState({
    String? display,
    String? expression,
    String? firstOperand,
    Operation? operation,
    String? memory,
    bool? shouldReset,
    bool? hasError,
  }) {
    _state.value = state.copyWith(
      display: display,
      expression: expression,
      firstOperand: firstOperand,
      operation: operation,
      memory: memory,
      shouldReset: shouldReset,
      hasError: hasError,
    );
  }
}
