import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/setting.dart';
import 'package:restaurant_app/data/service/schedule_preferences_service.dart';
import 'package:restaurant_app/provider/local_notification_provider.dart';

class ScheduleProvider extends ChangeNotifier {
  final SchedulePreferencesService _service;
  final LocalNotificationProvider _provider;

  ScheduleProvider(this._service, this._provider) {
    getSettingValue();
  }

  String _message = "";
  String get message => _message;

  Setting? _setting;
  Setting? get setting => _setting;

  bool get isEnabled => _setting?.isEnabled ?? false;

  Future<void> saveSettingValue(Setting value) async {
    try {
      await _service.saveReminderValue(value);
      _setting = value;
      _message = "Daily reminder preference saved";

      if (value.isEnabled) {
        _provider.scheduleDailyElevenAMNotification();
      } else {
        await _provider.cancelNotification();
      }
    } catch (e) {
      _message = "Failed to save daily reminder preference";
    }
    notifyListeners();
  }

  void getSettingValue() {
    try {
      _setting = _service.getReminderValue();
      _message = "Daily reminder preference retrieved";
    } catch (e) {
      _message = "Failed to get daily reminder preference";
    }
    notifyListeners();
  }
}
