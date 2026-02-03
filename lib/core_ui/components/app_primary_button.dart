import 'package:flutter/material.dart';
import 'package:test_doodle/core_ui/components/app_text.dart';
import 'package:test_doodle/core_ui/theme/theme_context.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    required this.disabled,
    required this.onTap,
    required this.title,
    super.key,
  });

  final String title;
  final VoidCallback onTap;
  final bool disabled;

  static const kBorder = 8.0;
  static const height = 60.0;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeContext.of(context).colors;
    return SizedBox(
      height: height,
      child: FilledButton(
        onPressed: disabled ? null : onTap,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorder),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return colors.doodlePrimary.withOpacity(0.5);
              }
              return colors.doodlePrimary;
            },
          ),
        ),
        child: AppText.body(title),
      ),
    );
  }
}
