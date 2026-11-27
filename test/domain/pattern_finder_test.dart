import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/core/utils/day_utils.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/domain/engine/pattern_finder.dart';

final _start = DateTime.utc(2026, 1, 1);

/// شروع ۵ پریود با فاصله‌ی ۲۸ روز.
final _starts = [for (var i = 0; i < 5; i++) addDays(_start, 28 * i)];
final _today = addDays(_starts.last, 10);

CycleSnapshot _cycle() => CycleEngine.compute(
  periodDays: [
    for (final start in _starts)
      for (var i = 0; i < 5; i++) addDays(start, i),
  ],
  today: _today,
);

DailyLog _log(DateTime date, String symptom) =>
    DailyLog(date: date, symptoms: {symptom});

void main() {
  group('PatternFinder.find', () {
    test('سردرد ۲ روز قبل از ۴ عادت ماهانه → یک الگو', () {
      final logs = [
        for (var k = 1; k <= 4; k++)
          _log(addDays(_starts[k], -2), SymptomIds.headache),
      ];
      final patterns = PatternFinder.find(
        cycle: _cycle(),
        logs: logs,
        today: _today,
      );

      expect(patterns.length, 1);
      final pattern = patterns.single;
      expect(pattern.subject, PatternSubject.symptom);
      expect(pattern.id, SymptomIds.headache);
      expect(pattern.timing, PatternTiming.beforePeriod);
      expect(pattern.day, 2);
      expect(pattern.count, 4);
      expect(pattern.cycles, 4);
    });

    test('فقط ۲ بار ثبت شده → هنوز الگو نیست', () {
      final logs = [
        for (var k = 1; k <= 2; k++)
          _log(addDays(_starts[k], -2), SymptomIds.headache),
      ];
      expect(
        PatternFinder.find(cycle: _cycle(), logs: logs, today: _today),
        isEmpty,
      );
    });

    test('اگه بیشتر وقت‌ها وسط چرخه ثبت شده، الگو نیست', () {
      final logs = [
        // ۳ بار قبل از عادت ماهانه…
        for (var k = 1; k <= 3; k++)
          _log(addDays(_starts[k], -2), SymptomIds.bloating),
        // …ولی ۴ بار هم وسط چرخه
        for (var k = 0; k < 4; k++)
          _log(addDays(_starts[k], 10), SymptomIds.bloating),
      ];
      expect(
        PatternFinder.find(cycle: _cycle(), logs: logs, today: _today),
        isEmpty,
      );
    });

    test('با کمتر از ۲ عادت ماهانه ثبت‌شده چیزی برنمی‌گرده', () {
      final cycle = CycleEngine.compute(
        periodDays: [for (var i = 0; i < 5; i++) addDays(_start, i)],
        today: addDays(_start, 10),
      );
      expect(
        PatternFinder.find(cycle: cycle, logs: const [], today: _today),
        isEmpty,
      );
    });
  });

  group('PatternFinder.warnable', () {
    PersonalPattern pattern({
      PatternTiming timing = PatternTiming.beforePeriod,
      int day = 2,
      int cycles = 3,
    }) {
      return PersonalPattern(
        subject: PatternSubject.symptom,
        id: SymptomIds.headache,
        timing: timing,
        day: day,
        count: cycles,
        cycles: cycles,
      );
    }

    test('الگوی قوی «قبل از عادت» انتخاب می‌شه', () {
      expect(PatternFinder.warnable([pattern()]).length, 1);
    });

    test('الگویی که فقط در ۲ چرخه دیده شده کافی نیست', () {
      expect(PatternFinder.warnable([pattern(cycles: 2)]), isEmpty);
    });

    test('الگوی «روزهای عادت» هشدار زودهنگام نداره', () {
      expect(
        PatternFinder.warnable([pattern(timing: PatternTiming.duringPeriod)]),
        isEmpty,
      );
    });
  });
}
