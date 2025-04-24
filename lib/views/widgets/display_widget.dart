import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_constants.dart';
import '../../controllers/calculator_controller.dart';

/// A widget that displays the calculator's current expression and result.
///
/// This widget reacts to changes in the [CalculatorController]'s state
/// and applies app-wide color and font themes for consistency.
class DisplayWidget extends StatelessWidget {
  /// The controller that manages the calculator's state.
  final CalculatorController controller;

  const DisplayWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorSchema = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = context.isDarkMode;

    return Obx(() {
      final state = controller.state;
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppConstants.displayPadding),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.displayBorderRadius),
          color: colorSchema.surface,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Expression display
            if (state.expression?.isNotEmpty ?? false)
              Text(
                state.expression!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.headlineSmall?.copyWith(
                  color:
                      isDark
                          ? AppColors.darkSecondaryText
                          : AppColors.lightSecondaryText,
                ),
              ),
            const SizedBox(height: 8),

            // Result display
            Text(
              state.display,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.displayLarge?.copyWith(
                color:
                    state.hasError ? colorSchema.error : colorSchema.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    });
  }
}
