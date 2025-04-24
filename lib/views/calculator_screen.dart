import 'package:fcalculator/config/app_constants.dart';
import 'package:fcalculator/views/widgets/display_widget.dart';
import 'package:fcalculator/views/widgets/keypad_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/calculator_controller.dart';

/// The main calculator screen.
///
/// This screen contains:
/// - A display area for the current expression and result.
/// - A keypad area for input.
/// It adapts to screen size using `Expanded` widgets for responsiveness,
/// and uses `SafeArea` to avoid system UI interference.
class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CalculatorController controller = Get.find();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorSchema = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Calculator by: - ',
              style: textTheme.titleMedium?.copyWith(
                color: colorSchema.onSurface,
              ),
            ),
            GestureDetector(
              onTap: () async {
                final url = Uri.parse('https://codelabpraveen.web.app');
                if (await canLaunchUrl(url)) {
                  final launched = await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );

                  if (!launched) {
                    await launchUrl(url, mode: LaunchMode.platformDefault);
                  }
                } else {
                  Get.snackbar(
                    'Error',
                    'Could not launch the website',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },

              child: Text(
                'codelabpraveen',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                  color: colorSchema.primary,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isPortrait = constraints.maxHeight > constraints.maxWidth;

            return Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                children: [
                  // Display Widget shows expression and result
                  Expanded(
                    flex: isPortrait ? 2 : 3,
                    child: DisplayWidget(controller: controller),
                  ),

                  const SizedBox(height: 12),

                  // Keypad Widget provides input buttons
                  Expanded(
                    flex: isPortrait ? 5 : 6,
                    child: KeypadWidget(controller: controller),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
