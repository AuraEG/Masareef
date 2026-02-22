import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_10y.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  static const int _dailyReminderId = 1;
  static const String _notificationsEnabledKey = 'daily_reminder_enabled';

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings = InitializationSettings(android: androidSettings);

    await _notifications.initialize(settings: settings);
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

    await _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  Future<bool> isDailyReminderEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationsEnabledKey) ?? true;
  }

  Future<void> setDailyReminderEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsEnabledKey, enabled);

    if (enabled) {
      await scheduleDailyReminder();
      return;
    }
    await cancelDailyReminder();
  }

  Future<void> syncDailyReminderWithPreference() async {
    final enabled = await isDailyReminderEnabled();
    if (enabled) {
      await scheduleDailyReminder();
      return;
    }
    await cancelDailyReminder();
  }

  Future<void> cancelDailyReminder() async {
    await _notifications.cancel(id: _dailyReminderId);
  }

  Future<void> scheduleDailyReminder({int hour = 22, int minute = 0}) async {
    const androidDetails = AndroidNotificationDetails(
      'daily_channel',
      'Daily Reminder',
      channelDescription: 'Daily expense logging reminders',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
      macOS: iosDetails,
    );
    final scheduledDate = _nextInstanceOfTime(hour: hour, minute: minute);

    await _notifications.zonedSchedule(
      id: _dailyReminderId,
      title: 'سجل مصاريفك 💰',
      body: 'الساعة 10:00 مساءً.. افتح التطبيق وسجّل مصاريفك اليوم.',
      scheduledDate: scheduledDate,
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfTime({required int hour, required int minute}) {
    final now = DateTime.now();
    var target = DateTime(now.year, now.month, now.day, now.hour, now.minute);
    if (!target.isAfter(now)) {
      target = target.add(const Duration(days: 1));
    }
    return tz.TZDateTime.from(target, tz.local);
  }
}
