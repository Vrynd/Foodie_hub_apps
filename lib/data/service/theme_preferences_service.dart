import 'package:restaurant_app/data/models/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferencesService {
  final SharedPreferences _preferences;

  ThemePreferencesService(this._preferences);

  static const _keyTheme = "MY_DARK_MODE";

  Future<void> saveThemeValue(Setting setting) async {
    try {
      await _preferences.setBool(_keyTheme, setting.isDarkMode);
    } catch (e) {
      throw Exception("Shared preferences cannot save the setting value.");
    }
  }

  Setting getThemeValue() {
    return Setting(isDarkMode: _preferences.getBool(_keyTheme) ?? false);
  }
}
