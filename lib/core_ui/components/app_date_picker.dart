import 'package:flutter/material.dart';
import 'package:test_doodle/core_ui/components/app_icon.dart';
import 'package:test_doodle/core_ui/components/app_text.dart';
import 'package:test_doodle/core_ui/theme/theme_constants.dart';
import 'package:test_doodle/core_ui/theme/theme_context.dart';

Future<DateTime?> showAppDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) {
  return showDatePicker(
    context: context,
    firstDate: firstDate,
    lastDate: lastDate,
  );
}

class AppDatePicker extends StatelessWidget {
  const AppDatePicker({
    required this.firstDate,
    required this.initialDate,
    required this.lastDate,
    required this.label,
    required this.onSelect,
    required this.disabled,
    super.key,
  });
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final String label;
  final void Function(DateTime date) onSelect;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeContext.of(context).colors;
    return Column(
      crossAxisAlignment: .start,
      children: [
        AppText.body(
          label,
          color: disabled ? colors.disabledTextColor : colors.textColor,
        ),
        Material(
          child: InkWell(
            onTap: disabled
                ? null
                : () async {
                    final selectedDate = await showAppDatePicker(
                      context: context,
                      initialDate: initialDate,
                      firstDate: firstDate,
                      lastDate: lastDate,
                    );
                    if (selectedDate != null) {
                      onSelect(selectedDate);
                    }
                  },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: kSize1),
              child: Row(
                children: [
                  AppIcon(icon: Icons.calendar_today),
                  const SizedBox(width: kSize2),
                  AppText.body(
                    '${initialDate.year}/${initialDate.month}/${initialDate.day}',
                    color: disabled ? colors.disabledTextColor : colors.textColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
