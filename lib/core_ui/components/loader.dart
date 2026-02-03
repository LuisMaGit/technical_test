import 'package:flutter/material.dart';
import 'package:test_doodle/core_ui/theme/theme_context.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        ThemeContext.of(context).colors.doodlePrimary,
      ),
    );
  }
}