import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../l10n/app_l10n.dart';
import '../models/event.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    tz.initializeTimeZones();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(const InitializationSettings(android: android));
    _initialized = true;
  }

  // Each event type gets its own channel so Android lets users customise sound per channel.
  // Add baby.mp3 / wedding_bells.mp3 to android/app/src/main/res/raw/ to enable custom sounds.
  AndroidNotificationDetails _channelFor(EventType type) {
    return switch (type) {
      EventType.pregnancy => const AndroidNotificationDetails(
          'holatimer_pregnancy',
          'Embarazo / Pregnancy',
          channelDescription: 'Recordatorios de embarazo — Baby sounds',
          importance: Importance.high,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('baby'),
        ),
      EventType.anniversary => const AndroidNotificationDetails(
          'holatimer_anniversary',
          'Aniversario / Anniversary',
          channelDescription: 'Recordatorios de aniversario — Wedding bells',
          importance: Importance.high,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('wedding_bells'),
        ),
      EventType.birthday => const AndroidNotificationDetails(
          'holatimer_birthday',
          'Cumpleaños / Birthday',
          channelDescription: 'Recordatorios de cumpleaños — Happy Birthday',
          importance: Importance.high,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('happy_birthday'),
        ),
      EventType.travel => const AndroidNotificationDetails(
          'holatimer_travel',
          'Viaje / Travel',
          channelDescription: 'Recordatorios de viaje — Plane takeoff',
          importance: Importance.high,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('plane_takeoff'),
        ),
      EventType.custom => const AndroidNotificationDetails(
          'holatimer_custom',
          'Eventos / Events',
          channelDescription: 'Recordatorios personalizados',
          importance: Importance.high,
          priority: Priority.high,
        ),
    };
  }

  Future<AppL10n> _getL10n() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('language') ?? 'es';
    final lang = AppLanguage.values.firstWhere((l) => l.name == code, orElse: () => AppLanguage.es);
    return AppL10n.of(lang);
  }

  Future<void> scheduleEventNotification(Event event) async {
    if (event.id == null || event.notificationTime == null) return;

    final parts = event.notificationTime!.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    await _plugin.cancel(event.id!);

    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    final l = await _getL10n();
    final body = _buildBody(event, l);

    await _plugin.zonedSchedule(
      event.id!,
      event.name,
      body,
      scheduledDate,
      NotificationDetails(android: _channelFor(event.type)),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  String _buildBody(Event event, AppL10n l) {
    final days = event.daysRemaining;
    if (days <= 0) return l.notifToday(event.name);
    if (days == 1) return l.notifTomorrow(event.name);
    return l.notifDays(days, event.name);
  }

  Future<void> cancelNotification(int eventId) => _plugin.cancel(eventId);
  Future<void> cancelAll() => _plugin.cancelAll();
}
