import 'package:flutter/material.dart';

class ThemeColorScheme {
  const ThemeColorScheme({
    required this.background,
    required this.textColor,
    required this.expenseColor,
    required this.incomeColor,
    required this.doodlePrimary,
    required this.doodleSecondary,
    required this.disabledTextColor,
  });

  factory ThemeColorScheme.light() {
    return ThemeColorScheme(
      background: const Color(0xFFFFFFFF),
      textColor: const Color(0xFF000000),
      expenseColor: Colors.red[500]!,
      incomeColor: Colors.green[500]!,
      doodlePrimary: const Color(0xFF34B6FF),
      doodleSecondary: const Color(0xFF085C47),
      disabledTextColor: Colors.grey[300]!,
    );
  }

  factory ThemeColorScheme.dark() {
    return ThemeColorScheme(
      background: const Color(0xFF000000),
      textColor: const Color(0xFFFFFFFF),
      expenseColor:  Colors.red[300]!,
      incomeColor: Colors.green[300]!,
      doodlePrimary: const Color(0xFF34B6FF),
      doodleSecondary: const Color(0xFF085C47) ,
      disabledTextColor:  Colors.white70,
    );
  }

  final Color background;
  final Color textColor;
  final Color expenseColor;
  final Color incomeColor;
  final Color doodlePrimary;
  final Color doodleSecondary;
  final Color disabledTextColor;
}

ThemeColorScheme getColorSchemeByTheme({required bool isLightMode}) {
  return isLightMode ? ThemeColorScheme.light() : ThemeColorScheme.dark();
}
