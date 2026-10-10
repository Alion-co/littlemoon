import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// یک نوتیفیکیشن برنامه‌ریزی‌شده. [when] به ساعت محلی گوشیه.
class PlannedNotification {
  final int id;
  final DateTime when;
  final String title;
  final String body;

  const PlannedNotification({
    required this.id,
    required this.when,
    required this.title,
    required this.body,
  });
}

/// نوتیفیکیشن‌های محلی گوشی — کاملاً آفلاین، بدون سرور و بدون اینترنت.
///
/// هر بار که وضعیت چرخه یا تنظیمات عوض می‌شه، همه‌ی نوتیفیکیشن‌های
/// قبلی لغو و برنامه‌ی جدید جایگزین می‌شه ([replaceAll]).
class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  static const _channelId = 'cycle_reminders';
  static const _channelName = 'Reminders';
  static const _smallIcon = 'ic_stat_moon';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<bool>? _initializing;
  int _generation = 0;

  /// فعلاً فقط اندروید؛ روی وب کاری انجام نمی‌شه.
  bool get _supported =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  Future<bool> _ensureReady() {
    return _initializing ??= _initialize();
  }

  Future<bool> _initialize() async {
    if (!_supported) return false;
    try {
      // زمان‌ها به‌صورت لحظه‌ی مطلق (UTC) داده می‌شن، پس به منطقه‌ی زمانی
      // گوشی وابسته نیستیم.
      tz_data.initializeTimeZones();
      tz.setLocalLocation(tz.UTC);

      await _plugin.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings(_smallIcon),
        ),
      );
      return true;
    } catch (error) {
      debugPrint('NotificationService init failed: $error');
      return false;
    }
  }

  /// اجازه‌ی نمایش نوتیفیکیشن (اندروید ۱۳ به بالا از کاربر می‌پرسه).
  Future<void> requestPermission() async {
    if (!await _ensureReady()) return;
    try {
      final android = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      await android?.requestNotificationsPermission();
    } catch (error) {
      debugPrint('Notification permission request failed: $error');
    }
  }

  /// همه‌ی نوتیفیکیشن‌های قبلی رو لغو و [items] رو جایگزین می‌کنه.
  Future<void> replaceAll(List<PlannedNotification> items) async {
    final generation = ++_generation;
    if (!await _ensureReady()) return;

    try {
      await _plugin.cancelAll();

      const details = NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
      );

      final now = DateTime.now();
      for (final item in items) {
        // اگه وسط کار برنامه‌ی تازه‌تری رسیده، این یکی رو رها کن
        if (generation != _generation) return;
        if (!item.when.isAfter(now)) continue;

        await _plugin.zonedSchedule(
          id: item.id,
          title: item.title,
          body: item.body,
          scheduledDate: tz.TZDateTime.from(item.when, tz.UTC),
          notificationDetails: details,
          // زمان‌بندی تقریبی کافیه و مجوز «آلارم دقیق» لازم نداره
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        );
      }
    } catch (error) {
      debugPrint('Scheduling notifications failed: $error');
    }
  }
}
