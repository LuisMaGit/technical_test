import 'package:flutter/material.dart';
import 'package:test_doodle/core_ui/theme/theme_context.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({required this.icon, this.size = 24.0, super.key});

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: ThemeContext.of(context).colors.textColor,
      size: size,
    );
  }
}
