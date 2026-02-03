import 'dart:async';

import 'package:test_doodle/core/models/theme_model.dart';
import 'package:test_doodle/core/services/i_preferences_service.dart';
import 'package:test_doodle/locator.dart';

class ThemeService {
  final _preferenceService = locator<IPreferencesService>();

  final _themeController = StreamController<ThemeModel>.broadcast();
  Stream<ThemeModel> get themeStream => _themeController.stream;

  var _theme = ThemeModel.light;
  ThemeModel get theme => _theme;

  Future<void> initTheme({required ThemeModel systemTheme}) async {
    final themePref = await _preferenceService.getThemeMode();
    if (themePref == null) {
      await _preferenceService.setThemeMode(systemTheme);
      _theme = await _preferenceService.getThemeMode() ?? .light;
      _themeController.add(_theme);
      return;
    }

    _theme = themePref;
    _themeController.add(_theme);
  }

  Future<void> changeTheme(ThemeModel newTheme) async {
    _theme = newTheme;
    await _preferenceService.setThemeMode(_theme);
    _themeController.add(_theme);
  }
}
