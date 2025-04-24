// view/widgets/calculator_button.dart
import 'package:flutter/material.dart';

import '../../../../config/app_colors.dart';
import '../../../../widgets/animated_press_button.dart';
import '../../config/app_constants.dart';

/// Enum defining types of calculator buttons.
enum ButtonType { number, operator, function, memory, equals }

/// A reusable calculator button widget with animated press effect,
/// styled according to its [ButtonType].
class CalculatorButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final ButtonType type;
  final bool isActive;
  final int flex;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.onTap,
    this.type = ButtonType.number,
    this.isActive = false,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final Color backgroundColor = _getBackgroundColor(colorScheme);
    final Color textColor = _getTextColor(colorScheme);

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.buttonSpacing),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.maxWidth;
            return AnimatedPressButton(
              width: size,
              height: size,
              onPressed: onTap,
              color: backgroundColor,
              elevation: AppConstants.buttonElevation,
              borderRadius: BorderRadius.circular(
                AppConstants.buttonBorderRadius,
              ),
              child: Center(
                child: Text(
                  label,
                  style: textTheme.titleLarge?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Returns the background color based on button type and theme.
  Color _getBackgroundColor(ColorScheme scheme) {
    switch (type) {
      case ButtonType.number:
        return scheme.brightness == Brightness.light
            ? AppColors.lightNumberButton
            : AppColors.darkNumberButton;
      case ButtonType.operator:
        return scheme.secondary;
      case ButtonType.function:
        return scheme.brightness == Brightness.light
            ? AppColors.lightFunctionButton
            : AppColors.darkFunctionButton;
      case ButtonType.memory:
        return isActive
            ? AppColors.memoryActive
            : (scheme.brightness == Brightness.light
                ? AppColors.memoryInactiveLight
                : AppColors.memoryInactiveDark);
      case ButtonType.equals:
        return scheme.tertiary;
    }
  }

  /// Returns the text color based on button type and theme.
  Color _getTextColor(ColorScheme scheme) {
    switch (type) {
      case ButtonType.operator:
      case ButtonType.memory:
      case ButtonType.equals:
      default:
        return scheme.onSurface;
    }
  }
}
