import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/day_utils.dart';
import '../../data/models/daily_log.dart';
import '../../data/repositories/log_repository.dart';
import '../../data/repositories/profile_repository.dart';
import '../../data/repositories/settings_repository.dart';
import '../engine/cycle_engine.dart';
import 'reminder_service.dart';

/// «امروز» — وقتی برنامه دوباره باز می‌شه invalidate می‌شه تا بعد از
/// نیمه‌شب تاریخ درست بمونه.
final todayProvider = Provider<DateTime>((ref) => dayOnly(DateTime.now()));

/// وضعیت چرخه؛ با هر تغییر در ثبت‌ها یا پروفایل دوباره محاسبه می‌شه.
final cycleProvider = Provider<CycleSnapshot>((ref) {
  final logs = ref.watch(logsProvider);
  final profile = ref.watch(profileProvider);
  final today = ref.watch(todayProvider);

  return CycleEngine.compute(
    periodDays: [
      for (final log in logs.values)
        if (log.isPeriodDay) log.date,
    ],
    today: today,
    defaultCycleLength: profile.cycleLength,
    defaultPeriodLength: profile.periodLength,
    lutealLength: profile.lutealLength,
  );
});

final todayLogProvider = Provider<DailyLog?>((ref) {
  final logs = ref.watch(logsProvider);
  return logs[dayKey(ref.watch(todayProvider))];
});

final remindersProvider = Provider<List<AppReminder>>((ref) {
  return ReminderService.build(
    cycle: ref.watch(cycleProvider),
    settings: ref.watch(settingsProvider),
    loggedToday: ref.watch(todayLogProvider) != null,
  );
});
