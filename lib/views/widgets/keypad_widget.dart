import 'package:fcalculator/config/app_constants.dart';
import 'package:flutter/material.dart';

import '../../controllers/calculator_controller.dart';
import '../../models/calculator_model.dart';
import 'calculator_button.dart';

/// A widget that represents the calculator keypad layout.
///
/// It uses multiple rows of [CalculatorButton] widgets to create
/// the full calculator keypad with numbers, operations, functions,
/// and memory controls.
class KeypadWidget extends StatelessWidget {
  final CalculatorController controller;

  const KeypadWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double buttonSize = constraints.maxWidth / 4;
        final double keypadHeight = buttonSize * 7;

        return SizedBox(
          height: keypadHeight,
          child: Column(
            children: [
              _buildButtonRow([
                CalculatorButton(
                  label: AppConstants.memoryClear,
                  onTap: controller.memoryClear,
                  type: ButtonType.memory,
                ),
                CalculatorButton(
                  label: AppConstants.memoryRecall,
                  onTap: controller.memoryRecall,
                  type: ButtonType.memory,
                ),
                CalculatorButton(
                  label: AppConstants.memoryAdd,
                  onTap: controller.memoryAdd,
                  type: ButtonType.memory,
                ),
                CalculatorButton(
                  label: AppConstants.backspace,
                  onTap: controller.backspace,
                  type: ButtonType.function,
                ),
              ]),
              _buildButtonRow([
                CalculatorButton(
                  label: AppConstants.clear,
                  onTap: controller.clearEntry,
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.squareRoot,
                  onTap: () => controller.inputOperation(Operation.sqrt),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.power,
                  onTap: () => controller.inputOperation(Operation.power),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.percent,
                  onTap: controller.inputPercent,
                  type: ButtonType.operator,
                ),
              ]),
              _buildButtonRow([
                CalculatorButton(
                  label: AppConstants.allClear,
                  onTap: controller.clearAll,
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.negate,
                  onTap: controller.negate,
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.squared,
                  onTap: () => controller.inputOperation(Operation.squared),
                  type: ButtonType.function,
                ),
                CalculatorButton(
                  label: AppConstants.divide,
                  onTap: () => controller.inputOperation(Operation.divide),
                  type: ButtonType.operator,
                ),
              ]),
              _buildButtonRow([
                CalculatorButton(
                  label: '7',
                  onTap: () => controller.inputDigit('7'),
                ),
                CalculatorButton(
                  label: '8',
                  onTap: () => controller.inputDigit('8'),
                ),
                CalculatorButton(
                  label: '9',
                  onTap: () => controller.inputDigit('9'),
                ),
                CalculatorButton(
                  label: AppConstants.multiply,
                  onTap: () => controller.inputOperation(Operation.multiply),
                  type: ButtonType.operator,
                ),
              ]),
              _buildButtonRow([
                CalculatorButton(
                  label: '4',
                  onTap: () => controller.inputDigit('4'),
                ),
                CalculatorButton(
                  label: '5',
                  onTap: () => controller.inputDigit('5'),
                ),
                CalculatorButton(
                  label: '6',
                  onTap: () => controller.inputDigit('6'),
                ),
                CalculatorButton(
                  label: AppConstants.subtract,
                  onTap: () => controller.inputOperation(Operation.subtract),
                  type: ButtonType.operator,
                ),
              ]),
              _buildButtonRow([
                CalculatorButton(
                  label: '1',
                  onTap: () => controller.inputDigit('1'),
                ),
                CalculatorButton(
                  label: '2',
                  onTap: () => controller.inputDigit('2'),
                ),
                CalculatorButton(
                  label: '3',
                  onTap: () => controller.inputDigit('3'),
                ),
                CalculatorButton(
                  label: AppConstants.add,
                  onTap: () => controller.inputOperation(Operation.add),
                  type: ButtonType.operator,
                ),
              ]),
              _buildButtonRow([
                CalculatorButton(
                  label: AppConstants.decimal,
                  onTap: controller.inputDecimal,
                ),
                CalculatorButton(
                  label: '0',
                  onTap: () => controller.inputDigit('0'),
                ),
                CalculatorButton(
                  flex: 2,
                  label: AppConstants.equals,
                  onTap: controller.calculate,
                  type: ButtonType.equals,
                ),
              ]),
            ],
          ),
        );
      },
    );
  }

  /// Helper method to build a single row of buttons.
  /// Each row is wrapped in an [Expanded] to share equal vertical space.
  Widget _buildButtonRow(List<Widget> buttons) {
    return Expanded(child: Row(children: buttons));
  }
}
