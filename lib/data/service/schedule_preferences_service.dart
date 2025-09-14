import 'package:restaurant_app/data/models/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchedulePreferencesService {
  final SharedPreferences _preferences;

  SchedulePreferencesService(this._preferences);

  static const _keyReminder = "MY_DAILY_REMINDER";

  Future<void> saveReminderValue(Setting setting) async {
    try {
      await _preferences.setBool(_keyReminder, setting.isEnabled);
    } catch (e) {
      throw Exception("Failed to save daily reminder preference.");
    }
  }

  Setting getReminderValue() {
    return Setting(
      isEnabled: _preferences.getBool(_keyReminder) ?? false,
      isDarkMode: false,
    );
  }
}
