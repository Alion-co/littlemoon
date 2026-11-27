import '../../core/utils/app_calendar.dart';
import '../../core/utils/math_utils.dart';

/// تنظیمات یادآورها و تقویم.
class AppSettings {
  final CalendarType calendarType;
  final bool periodReminder;

  /// چند روز قبل از عادت ماهانه یادآوری بشه.
  final int periodReminderDays;
  final bool fertileReminder;
  final bool ovulationReminder;
  final bool dailyLogReminder;

  /// اگه عادت ماهانه چند روز عقب بیفته، یک یادآور ملایم بیاد.
  final bool lateReminder;

  /// متن نوتیفیکیشن‌ها و ویجت خنثی بشه و چیزی از چرخه لو نده.
  final bool discreetNotifications;

  /// یادآور روزانه‌ی قرص در ساعت [pillHour]:[pillMinute].
  final bool pillReminder;
  final int pillHour;
  final int pillMinute;

  const AppSettings({
    this.calendarType = CalendarType.jalali,
    this.periodReminder = true,
    this.periodReminderDays = 2,
    this.fertileReminder = true,
    this.ovulationReminder = true,
    this.dailyLogReminder = true,
    this.lateReminder = true,
    this.discreetNotifications = false,
    this.pillReminder = false,
    this.pillHour = 22,
    this.pillMinute = 0,
  });

  AppSettings copyWith({
    CalendarType? calendarType,
    bool? periodReminder,
    int? periodReminderDays,
    bool? fertileReminder,
    bool? ovulationReminder,
    bool? dailyLogReminder,
    bool? lateReminder,
    bool? discreetNotifications,
    bool? pillReminder,
    int? pillHour,
    int? pillMinute,
  }) {
    return AppSettings(
      calendarType: calendarType ?? this.calendarType,
      periodReminder: periodReminder ?? this.periodReminder,
      periodReminderDays: periodReminderDays ?? this.periodReminderDays,
      fertileReminder: fertileReminder ?? this.fertileReminder,
      ovulationReminder: ovulationReminder ?? this.ovulationReminder,
      dailyLogReminder: dailyLogReminder ?? this.dailyLogReminder,
      lateReminder: lateReminder ?? this.lateReminder,
      discreetNotifications:
          discreetNotifications ?? this.discreetNotifications,
      pillReminder: pillReminder ?? this.pillReminder,
      pillHour: pillHour ?? this.pillHour,
      pillMinute: pillMinute ?? this.pillMinute,
    );
  }

  Map<String, dynamic> toJson() => {
    'calendarType': calendarType.name,
    'periodReminder': periodReminder,
    'periodReminderDays': periodReminderDays,
    'fertileReminder': fertileReminder,
    'ovulationReminder': ovulationReminder,
    'dailyLogReminder': dailyLogReminder,
    'lateReminder': lateReminder,
    'discreetNotifications': discreetNotifications,
    'pillReminder': pillReminder,
    'pillHour': pillHour,
    'pillMinute': pillMinute,
  };

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    int readInt(String key, int fallback, int min, int max) {
      final value = json[key];
      return value is num ? clampInt(value.toInt(), min, max) : fallback;
    }

    return AppSettings(
      calendarType: json['calendarType'] == CalendarType.gregorian.name
          ? CalendarType.gregorian
          : CalendarType.jalali,
      periodReminder: json['periodReminder'] != false,
      periodReminderDays: readInt('periodReminderDays', 2, 1, 7),
      fertileReminder: json['fertileReminder'] != false,
      ovulationReminder: json['ovulationReminder'] != false,
      dailyLogReminder: json['dailyLogReminder'] != false,
      lateReminder: json['lateReminder'] != false,
      // تنظیم‌های تازه‌ی نسخه‌ی ۱.۱: پشتیبان‌های قدیمی این کلیدها رو ندارن
      discreetNotifications: json['discreetNotifications'] == true,
      pillReminder: json['pillReminder'] == true,
      pillHour: readInt('pillHour', 22, 0, 23),
      pillMinute: readInt('pillMinute', 0, 0, 59),
    );
  }
}
