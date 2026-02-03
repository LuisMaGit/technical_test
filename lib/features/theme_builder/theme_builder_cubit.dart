import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_doodle/core/models/theme_model.dart';
import 'package:test_doodle/core/services/theme_service.dart';
import 'package:test_doodle/locator.dart';

part 'theme_builder_state.dart';

class ThemeBuilderCubit extends Cubit<ThemeBuilderState> {
  ThemeBuilderCubit() : super(const ThemeBuilderState());

  final _themeService = locator<ThemeService>();

  Future<void> initTheme({required ThemeModel systemTheme}) async {
    _themeService.initTheme(systemTheme: systemTheme);
    _themeService.themeStream.listen((theme) {
      if (theme != state.appTheme) {
        emit(state.copyWith(appTheme: theme));
      }
    });
  }
}
