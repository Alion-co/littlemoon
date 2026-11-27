import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/core/utils/day_utils.dart';
import 'package:little_moon/data/models/app_settings.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/domain/engine/pattern_finder.dart';
import 'package:little_moon/domain/services/reminder_service.dart';

final _start = DateTime.utc(2026, 1, 1);
final _starts = [for (var i = 0; i < 5; i++) addDays(_start, 28 * i)];

/// چرخه‌ی منظم ۲۸ روزه؛ [until] روز تا عادت ماهانه‌ی بعدی مونده.
CycleSnapshot _cycleWithDaysUntil(int until) {
  return CycleEngine.compute(
    periodDays: [
      for (final start in _starts)
        for (var i = 0; i < 5; i++) addDays(start, i),
    ],
    today: addDays(_starts.last, 28 - until),
  );
}

const _headacheTwoDaysBefore = PersonalPattern(
  subject: PatternSubject.symptom,
  id: SymptomIds.headache,
  timing: PatternTiming.beforePeriod,
  day: 2,
  count: 4,
  cycles: 4,
);

Iterable<AppReminder> _patternReminders(List<AppReminder> all) =>
    all.where((r) => r.type == ReminderType.patternSoon);

void main() {
  group('هشدار زودهنگام الگوها', () {
    test('یک روز زودتر از زمان معمول الگو یادآوری میاد', () {
      // سردرد معمولاً ۲ روز قبل از عادت ماهانه → هشدار ۳ روز قبل
      final reminders = ReminderService.build(
        cycle: _cycleWithDaysUntil(3),
        settings: const AppSettings(),
        loggedToday: true,
        patterns: const [_headacheTwoDaysBefore],
      );
      final found = _patternReminders(reminders).toList();
      expect(found.length, 1);
      expect(found.single.days, 3);
      expect(found.single.patterns.single.id, SymptomIds.headache);
    });

    test('روز دیگه‌ای یادآوری نمیاد', () {
      for (final until in [1, 2, 4, 10]) {
        final reminders = ReminderService.build(
          cycle: _cycleWithDaysUntil(until),
          settings: const AppSettings(),
          loggedToday: true,
          patterns: const [_headacheTwoDaysBefore],
        );
        expect(_patternReminders(reminders), isEmpty, reason: 'until=$until');
      }
    });

    test('بدون الگو یادآوری نمیاد', () {
      final reminders = ReminderService.build(
        cycle: _cycleWithDaysUntil(3),
        settings: const AppSettings(),
        loggedToday: true,
      );
      expect(_patternReminders(reminders), isEmpty);
    });

    test('اگه یادآور عادت ماهانه خاموشه، هشدار الگو هم نمیاد', () {
      final reminders = ReminderService.build(
        cycle: _cycleWithDaysUntil(3),
        settings: const AppSettings(periodReminder: false),
        loggedToday: true,
        patterns: const [_headacheTwoDaysBefore],
      );
      expect(_patternReminders(reminders), isEmpty);
    });

    test('الگوی ضعیف (کمتر از ۳ چرخه) هشدار نمی‌ده', () {
      const weak = PersonalPattern(
        subject: PatternSubject.symptom,
        id: SymptomIds.headache,
        timing: PatternTiming.beforePeriod,
        day: 2,
        count: 3,
        cycles: 2,
      );
      final reminders = ReminderService.build(
        cycle: _cycleWithDaysUntil(3),
        settings: const AppSettings(),
        loggedToday: true,
        patterns: const [weak],
      );
      expect(_patternReminders(reminders), isEmpty);
    });
  });
}
