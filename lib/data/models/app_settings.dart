import '../../core/utils/app_calendar.dart';
import '../../core/utils/math_utils.dart';

/// تنظیمات یادآورها و تقویم.
class AppSettings {
  final CalendarType calendarType;
  final bool periodReminder;

  /// چند روز قبل از پریود یادآوری بشه.
  final int periodReminderDays;
  final bool fertileReminder;
  final bool ovulationReminder;
  final bool dailyLogReminder;

  const AppSettings({
    this.calendarType = CalendarType.jalali,
    this.periodReminder = true,
    this.periodReminderDays = 2,
    this.fertileReminder = true,
    this.ovulationReminder = true,
    this.dailyLogReminder = true,
  });

  AppSettings copyWith({
    CalendarType? calendarType,
    bool? periodReminder,
    int? periodReminderDays,
    bool? fertileReminder,
    bool? ovulationReminder,
    bool? dailyLogReminder,
  }) {
    return AppSettings(
      calendarType: calendarType ?? this.calendarType,
      periodReminder: periodReminder ?? this.periodReminder,
      periodReminderDays: periodReminderDays ?? this.periodReminderDays,
      fertileReminder: fertileReminder ?? this.fertileReminder,
      ovulationReminder: ovulationReminder ?? this.ovulationReminder,
      dailyLogReminder: dailyLogReminder ?? this.dailyLogReminder,
    );
  }

  Map<String, dynamic> toJson() => {
        'calendarType': calendarType.name,
        'periodReminder': periodReminder,
        'periodReminderDays': periodReminderDays,
        'fertileReminder': fertileReminder,
        'ovulationReminder': ovulationReminder,
        'dailyLogReminder': dailyLogReminder,
      };

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    final days = json['periodReminderDays'];
    return AppSettings(
      calendarType: json['calendarType'] == CalendarType.gregorian.name
          ? CalendarType.gregorian
          : CalendarType.jalali,
      periodReminder: json['periodReminder'] != false,
      periodReminderDays: days is num ? clampInt(days.toInt(), 1, 7) : 2,
      fertileReminder: json['fertileReminder'] != false,
      ovulationReminder: json['ovulationReminder'] != false,
      dailyLogReminder: json['dailyLogReminder'] != false,
    );
  }
}
