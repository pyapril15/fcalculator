// models/calculator_model.dart

/// Enum representing supported calculator operations.
enum Operation { none, add, subtract, multiply, divide, sqrt, squared, power }

/// Model representing the state of the calculator.
class CalculatorModel {
  final String display;
  final String? expression;
  final String? firstOperand;
  final Operation operation;
  final String? memory;
  final bool hasError;
  final bool shouldReset;

  CalculatorModel({
    this.display = '0',
    this.expression,
    this.firstOperand,
    this.operation = Operation.none,
    this.memory,
    this.hasError = false,
    this.shouldReset = false,
  });

  /// Creates a new instance of [CalculatorModel] with optional overrides.
  CalculatorModel copyWith({
    String? display,
    String? expression,
    String? firstOperand,
    Operation? operation,
    String? memory,
    bool? hasError,
    bool? shouldReset,
  }) {
    return CalculatorModel(
      display: display ?? this.display,
      expression: expression ?? this.expression,
      firstOperand: firstOperand ?? this.firstOperand,
      operation: operation ?? this.operation,
      memory: memory ?? this.memory,
      hasError: hasError ?? this.hasError,
      shouldReset: shouldReset ?? this.shouldReset,
    );
  }
}
