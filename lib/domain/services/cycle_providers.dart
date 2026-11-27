import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/day_utils.dart';
import '../../data/models/daily_log.dart';
import '../../data/repositories/cycle_tags_repository.dart';
import '../../data/repositories/log_repository.dart';
import '../../data/repositories/profile_repository.dart';
import '../../data/repositories/settings_repository.dart';
import '../engine/cycle_engine.dart';
import '../engine/cycle_inputs.dart';
import '../engine/pattern_finder.dart';
import 'reminder_service.dart';

/// «امروز» — وقتی برنامه دوباره باز می‌شه invalidate می‌شه تا بعد از
/// نیمه‌شب تاریخ درست بمونه.
final todayProvider = Provider<DateTime>((ref) => dayOnly(DateTime.now()));

/// روزهای پریود و دماهای ثبت‌شده. با هر تغییر در ثبت‌ها دوباره ساخته می‌شه،
/// ولی فقط وقتی مقدارش واقعاً عوض شده باشه به بقیه خبر می‌ده.
final cycleInputsProvider = Provider<CycleInputs>(
  (ref) => ref.watch(logsProvider.select(CycleInputs.from)),
);

/// وضعیت چرخه؛ فقط با تغییر روزهای پریود، دماها، چرخه‌های غیرعادی و
/// طول‌های پروفایل دوباره محاسبه می‌شه (نه با آب، وزن، یادداشت، ...).
final cycleProvider = Provider<CycleSnapshot>((ref) {
  final inputs = ref.watch(cycleInputsProvider);
  final lengths = ref.watch(
    profileProvider.select(
      (p) => (
        cycle: p.cycleLength,
        period: p.periodLength,
        luteal: p.lutealLength,
      ),
    ),
  );
  final today = ref.watch(todayProvider);
  final unusual = ref.watch(unusualCyclesProvider);

  return CycleEngine.compute(
    periodDays: inputs.periodDays,
    today: today,
    defaultCycleLength: lengths.cycle,
    defaultPeriodLength: lengths.period,
    lutealLength: lengths.luteal,
    // دمای ثبت‌شده در صفحه‌ی سلامت: جهش دما تخمک‌گذاری رو تأیید می‌کنه
    temperatures: inputs.temperatures,
    // چرخه‌هایی که کاربر «غیرعادی» علامت زده از میانگین کنار می‌رن
    unusualCycleStarts: [
      for (final key in unusual)
        if (parseDayKey(key) != null) parseDayKey(key)!,
    ],
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
    loggedToday: ref.watch(todayLogProvider.select((log) => log != null)),
    patterns: ref.watch(patternsProvider),
  );
});

/// ثبت‌های مربوط به الگوها (علائم، خلق‌وخو، درد)؛ آب و وزن و ... رو نمی‌بینه.
final patternInputsProvider = Provider<PatternInputs>(
  (ref) => ref.watch(logsProvider.select(PatternInputs.from)),
);

/// الگوهای تکراری در ثبت‌های کاربر (مثلاً سردرد قبل از عادت ماهانه).
final patternsProvider = Provider<List<PersonalPattern>>((ref) {
  return PatternFinder.find(
    cycle: ref.watch(cycleProvider),
    logs: ref.watch(patternInputsProvider).logs,
    today: ref.watch(todayProvider),
  );
});
