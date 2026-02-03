import 'package:flutter/material.dart';
import 'package:test_doodle/core_ui/components/app_icon_button.dart';
import 'package:test_doodle/core_ui/components/app_text.dart';
import 'package:test_doodle/core_ui/theme/theme_context.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({
    required this.title,
    this.actions,
    this.withLeading = false,
    super.key,
  });

  final String title;
  final bool withLeading;
  final List<Widget>? actions;

  static const titleSize = 28.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: AppText.heading(
        title,
        align: TextAlign.center,
        fontSize: titleSize,
      ),
      actions: actions,
      backgroundColor: ThemeContext.of(context).colors.background,
      elevation: 0,
      leading: withLeading
          ? AppIconButton(
              icon: Icons.arrow_back_ios,
              onTap: () => Navigator.of(context).pop(),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
