import 'package:flutter/material.dart';

import 'package:test_doodle/core_ui/components/app_icon.dart';
import 'package:test_doodle/core_ui/components/app_text.dart';
import 'package:test_doodle/core_ui/theme/theme_context.dart';

class AppSegmentedButton extends StatelessWidget {
  const AppSegmentedButton({
    required this.segments,
    required this.icons,
    required this.selectedIdx,
    required this.onSelectionChanged,
    super.key,
  });

  final List<String> segments;
  final List<IconData> icons;
  final int selectedIdx;
  final void Function(String) onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    List<ButtonSegment<String>> segmentsObj() {
      var output = <ButtonSegment<String>>[];
      for (var idx = 0; idx < segments.length; idx++) {
        output.add(
          ButtonSegment<String>(
            value: segments[idx],
            icon: AppIcon(icon: icons[idx]),
            label: AppText.body(segments[idx]),
          ),
        );
      }

      return output;
    }

    return SegmentedButton<String>(
      segments: segmentsObj(),
      selected: {segments[selectedIdx]},
      onSelectionChanged: (selection) => onSelectionChanged(selection.first),
      showSelectedIcon: false,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if(states.contains(MaterialState.selected)) {
              return ThemeContext.of(context).colors.doodlePrimary;
            }
            return ThemeContext.of(context).colors.background;
          },
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: ThemeContext.of(context).colors.textColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
