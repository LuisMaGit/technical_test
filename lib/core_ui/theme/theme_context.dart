import 'package:flutter/widgets.dart';
import 'package:test_doodle/core_ui/theme/theme_color_scheme.dart';

class ThemeContext extends InheritedWidget {
  const ThemeContext({
    required this.colors,
    required super.child,
    super.key,
  });
  final ThemeColorScheme colors;

  static ThemeContext of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeContext>()!;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}


