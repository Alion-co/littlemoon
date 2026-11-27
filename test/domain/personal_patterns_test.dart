import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/domain/engine/pattern_finder.dart';

import '../helpers/cycle_fixtures.dart';

void main() {
  group('الگوهای شخصی', () {
    test('سردرد ۲ روز قبل و دل‌درد روز اول', () {
      final sample = samplePatternData();
      final patterns = PatternFinder.find(
        cycle: sample.cycle,
        logs: sample.logs,
        today: DateTime.utc(2026, 8, 10),
      );

      final headache = patterns.firstWhere((p) => p.id == 'headache');
      expect(headache.timing, PatternTiming.beforePeriod);
      expect(headache.day, 2);
      expect(headache.cycles, greaterThanOrEqualTo(2));

      final cramps = patterns.firstWhere((p) => p.id == 'cramps');
      expect(cramps.timing, PatternTiming.duringPeriod);
      expect(cramps.day, 1);

      final mood = patterns.firstWhere((p) => p.subject == PatternSubject.mood);
      expect(mood.mood, Mood.irritable);
    });

    test('یک بار اتفاق الگو حساب نمی‌شه', () {
      final sample = samplePatternData();
      final logs = [
        ...sample.logs,
        DailyLog(date: DateTime.utc(2026, 7, 10), symptoms: const {'acne'}),
      ];
      final patterns = PatternFinder.find(
        cycle: sample.cycle,
        logs: logs,
        today: DateTime.utc(2026, 8, 10),
      );
      expect(patterns.where((p) => p.id == 'acne'), isEmpty);
    });

    test('بدون دو عادت ماهانه الگویی نیست', () {
      expect(
        PatternFinder.find(
          cycle: CycleSnapshot.empty(today: DateTime.utc(2026, 8, 10)),
          logs: const [],
          today: DateTime.utc(2026, 8, 10),
        ),
        isEmpty,
      );
    });
  });
}
