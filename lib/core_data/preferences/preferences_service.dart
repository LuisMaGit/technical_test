import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_doodle/core/models/theme_model.dart';
import 'package:test_doodle/core/services/i_preferences_service.dart';
import 'package:test_doodle/core_data/preferences/preferences_contracts.dart';

class PreferencesService implements IPreferencesService {
  Future<SharedPreferences> get _preferences async =>
      SharedPreferences.getInstance();

  @override
  Future<ThemeModel?> getThemeMode() async {
    final pref = await _preferences;
    final value = pref.getString(PreferencesContracts.theme.source);
    return ThemeModel.fromSource(value);
  }

  @override
  Future<void> setThemeMode(ThemeModel mode) async {
    final pref = await _preferences;
    await pref.setString(PreferencesContracts.theme.source, mode.source);
  }
}
