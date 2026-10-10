import '../../data/models/app_settings.dart';
import '../engine/cycle_engine.dart';

enum ReminderType {
  periodSoon,
  periodToday,
  periodLate,
  fertileSoon,
  fertileToday,
  ovulationToday,
  logToday,
}

class AppReminder {
  final ReminderType type;

  /// تعداد روز مربوط به یادآور (مثلاً «۲ روز تا پریود»).
  final int days;

  const AppReminder(this.type, [this.days = 0]);
}

/// یادآورهای داخل برنامه رو از روی وضعیت چرخه و تنظیمات کاربر می‌سازه.
abstract final class ReminderService {
  static List<AppReminder> build({
    required CycleSnapshot cycle,
    required AppSettings settings,
    required bool loggedToday,
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

    if (settings.dailyLogReminder && !loggedToday) {
      reminders.add(const AppReminder(ReminderType.logToday));
    }

    return reminders;
  }
}
