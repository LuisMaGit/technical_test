import 'package:flutter/material.dart';
import 'package:test_doodle/core_ui/components/app_icon.dart';
import 'package:test_doodle/core_ui/components/app_text.dart';
import 'package:test_doodle/core_ui/theme/theme_constants.dart';
import 'package:test_doodle/core_ui/theme/theme_context.dart';

class AppDropDown extends StatelessWidget {
  const AppDropDown({
    required this.label,
    required this.icons,
    required this.onSelectionChanged,
    required this.drops,
    required this.selectedIdx,
    this.disabled = false,
    super.key,
  });

  final String label;
  final List<String> drops;
  final List<IconData> icons;
  final int selectedIdx;
  final bool disabled;
  final void Function(String) onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeContext.of(context).colors;
    List<DropdownMenuItem<String>> items() {
      var output = <DropdownMenuItem<String>>[];
      for (var idx = 0; idx < drops.length; idx++) {
        output.add(
          DropdownMenuItem<String>(
            value: drops[idx],
            child: Row(
              children: [
                AppIcon(icon: icons[idx]),
                const SizedBox(width: kSize1),
                AppText.body(drops[idx]),
              ],
            ),
          ),
        );
      }

      return output;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.body(
          label,
          color: disabled ? colors.disabledTextColor : colors.textColor,
        ),
        DropdownButton(
          underline: const SizedBox.shrink(),
          items: items(),
          value: drops[selectedIdx],
          style: disabled
              ? TextStyle(color: colors.disabledTextColor)
              : TextStyle(color: colors.textColor),
          iconEnabledColor: colors.textColor,
          iconDisabledColor: colors.disabledTextColor,
          onChanged: disabled
              ? null
              : (value) => onSelectionChanged(value as String),
        ),
      ],
    );
  }
}
