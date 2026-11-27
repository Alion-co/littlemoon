import '../../data/models/app_settings.dart';
import '../engine/cycle_engine.dart';
import '../engine/pattern_finder.dart';

enum ReminderType {
  periodSoon,
  periodToday,
  periodLate,
  fertileSoon,
  fertileToday,
  ovulationToday,
  logToday,

  /// هشدار زودهنگام: «همین حوالی معمولاً سردرد داری»
  patternSoon,
}

class AppReminder {
  final ReminderType type;

  /// تعداد روز مربوط به یادآور (مثلاً «۲ روز تا پریود»).
  final int days;

  /// برای [ReminderType.patternSoon]: الگوهایی که الان وقتشونه.
  final List<PersonalPattern> patterns;

  const AppReminder(
    this.type, [
    this.days = 0,
    this.patterns = const <PersonalPattern>[],
  ]);
}

/// یادآورهای داخل برنامه رو از روی وضعیت چرخه و تنظیمات کاربر می‌سازه.
abstract final class ReminderService {
  static List<AppReminder> build({
    required CycleSnapshot cycle,
    required AppSettings settings,
    required bool loggedToday,
    List<PersonalPattern> patterns = const [],
  }) {
    final reminders = <AppReminder>[];

    if (cycle.hasData) {
      final until = cycle.daysUntilNextPeriod;
      if (settings.periodReminder && until != null && !cycle.isPeriodOngoing) {
        if (until < 0) {
          reminders.add(AppReminder(ReminderType.periodLate, -until));
        } else if (until == 0) {
          reminders.add(const AppReminder(ReminderType.periodToday));
        } else if (until <= settings.periodReminderDays) {
          reminders.add(AppReminder(ReminderType.periodSoon, until));
        }
      }

      final ovulation = cycle.nextOvulation;
      final fertileStart = cycle.fertileStart;
      final today = cycle.today;

      if (settings.ovulationReminder &&
          ovulation != null &&
          ovulation == today) {
        reminders.add(const AppReminder(ReminderType.ovulationToday));
      } else if (settings.fertileReminder && fertileStart != null) {
        final toFertile = fertileStart.difference(today).inDays;
        if (toFertile == 1) {
          reminders.add(const AppReminder(ReminderType.fertileSoon, 1));
        } else if (cycle.isInFertileWindow) {
          reminders.add(const AppReminder(ReminderType.fertileToday));
        }
      }
    }

    // هشدار زودهنگام الگوهای شخصی (مثلاً سردرد قبل از عادت ماهانه)
    if (cycle.hasData && settings.periodReminder && !cycle.isPeriodOngoing) {
      final until = cycle.daysUntilNextPeriod;
      if (until != null && until > 0) {
        final due = <PersonalPattern>[
          for (final pattern in PatternFinder.warnable(patterns))
            if (pattern.day + PatternFinder.warningLeadDays == until) pattern,
        ];
        if (due.isNotEmpty) {
          reminders.add(AppReminder(ReminderType.patternSoon, until, due));
        }
      }
    }

    if (settings.dailyLogReminder && !loggedToday) {
      reminders.add(const AppReminder(ReminderType.logToday));
    }

    return reminders;
  }
}
