import 'package:flutter/material.dart';
import 'package:test_doodle/core_ui/components/app_icon.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({required this.icon, required this.onTap, super.key});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: AppIcon(icon: icon),
    );
  }
}
