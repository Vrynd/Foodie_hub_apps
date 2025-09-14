import 'package:flutter/material.dart';
import 'package:restaurant_app/data/service/local_notification_service.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  LocalNotificationProvider(this.flutterNotificationService);

  final int _notificationId = 1;
  bool _permission = false;
  bool? get permission => _permission;

  Future<void> requestPermission() async {
    _permission = await flutterNotificationService.requestPermissions() ?? false;
    notifyListeners();
  }

  void scheduleDailyElevenAMNotification() {
    flutterNotificationService.scheduleDailyElevenAMNotification(
      id: _notificationId,
    );
  }

  Future<void> cancelNotification() async {
    await flutterNotificationService.cancelNotification(_notificationId);
  }
}
