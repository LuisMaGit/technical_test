import 'package:test_doodle/core/models/theme_model.dart';

abstract class IPreferencesService {
  Future<ThemeModel?> getThemeMode();
  Future<void> setThemeMode(ThemeModel mode);
}
