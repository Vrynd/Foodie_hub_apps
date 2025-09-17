import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/setting.dart';
import 'package:restaurant_app/data/service/theme_preferences_service.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemePreferencesService _service;

  ThemeProvider(this._service) {
    getSettingValue();
  }

  String _message = "";
  String get message => _message;

  Setting? _setting;
  Setting? get setting => _setting;

  bool get isDarkMode => _setting?.isDarkMode ?? false;

  Future<void> saveSettingValue(Setting value) async {
    try {
      await _service.saveThemeValue(value);
      _setting = value;
      _message = "Theme preference saved";
    } catch (e) {
      _message = "Failed to save theme preference";
    }
    notifyListeners();
  }

  void getSettingValue() {
    try {
      _setting = _service.getThemeValue();
      _message = "Theme preference retrieved";
    } catch (e) {
      _message = "Failed to get theme preference";
    }
    notifyListeners();
  }
}
