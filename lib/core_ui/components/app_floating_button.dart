import 'package:flutter/material.dart';
import 'package:test_doodle/core_ui/components/app_icon.dart';

class AppFloatingButton extends StatelessWidget {
  const AppFloatingButton({
    required this.heroTag,
    required this.icon,
    required this.onTap,
    this.color,
    super.key,
  });

  final VoidCallback onTap;
  final IconData icon;
  final String heroTag;
  final Color? color;

  static const size = 50.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: FloatingActionButton(
        backgroundColor: color,
        heroTag: heroTag,
        onPressed: onTap,
        elevation: 0.2,
        child: AppIcon(icon: icon),
      ),
    );
  }
}
