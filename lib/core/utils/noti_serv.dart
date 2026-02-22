import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiServ {
  final notificationPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  Future<void> initNotification() async {
    if (_isInitialized) return;

    const initSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initSettings = InitializationSettings(android: initSettingsAndroid);

    await notificationPlugin.initialize(settings: initSettings);

    _isInitialized = true;
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    await notificationPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: notificationDetails(), // 👈 مهم جدًا
    );
  }
}
