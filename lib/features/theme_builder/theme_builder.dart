import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_doodle/core_ui/theme/theme_color_scheme.dart';
import 'package:test_doodle/core_ui/theme/theme_context.dart';
import 'package:test_doodle/features/theme_builder/theme_builder_cubit.dart';

class ThemeBuilder extends StatefulWidget {
  const ThemeBuilder({required this.builder, super.key});

  final Widget Function(BuildContext context, ThemeColorScheme themeColorScheme)
  builder;

  @override
  State<ThemeBuilder> createState() => _ThemeBuilderState();
}

class _ThemeBuilderState extends State<ThemeBuilder> {
  final _themeCubit = ThemeBuilderCubit();

  @override
  Widget build(BuildContext context) {
    final systemBrightness = MediaQuery.of(context).platformBrightness;
    return BlocProvider(
      create: (context) => _themeCubit
        ..initTheme(systemTheme: systemBrightness == .light ? .light : .dark),
      child: BlocBuilder<ThemeBuilderCubit, ThemeBuilderState>(
        builder: (context, state) {
          final colors = getColorSchemeByTheme(
            isLightMode: state.appTheme == .light,
          );
          return ThemeContext(
            colors: colors,
            child: widget.builder(context, colors),
          );
        },
      ),
    );
  }
}
