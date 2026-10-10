import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/core/utils/jalali.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';

List<DateTime> _range(DateTime start, int length) => [
      for (var i = 0; i < length; i++)
        DateTime.utc(start.year, start.month, start.day + i),
    ];

void main() {
  group('JalaliDate', () {
    test('میلادی به شمسی', () {
      final j = JalaliDate.fromDateTime(DateTime.utc(2026, 10, 10));
      expect([j.year, j.month, j.day], [1405, 7, 18]);
    });

    test('شمسی به میلادی (نوروز و اسفند کبیسه)', () {
      expect(const JalaliDate(1405, 1, 1).toDateTime(), DateTime.utc(2026, 3, 21));
      expect(const JalaliDate(1403, 12, 30).toDateTime(), DateTime.utc(2025, 3, 20));
    });
  });

  group('CycleEngine', () {
    test('بدون داده', () {
      final snapshot = CycleEngine.compute(
        periodDays: const [],
        today: DateTime.utc(2026, 2, 10),
      );
      expect(snapshot.hasData, isFalse);
      expect(snapshot.phase, isNull);
    });

    test('دو پریود با فاصله‌ی ۲۸ روز', () {
      final snapshot = CycleEngine.compute(
        periodDays: [
          ..._range(DateTime.utc(2026, 1, 1), 5),
          ..._range(DateTime.utc(2026, 1, 29), 5),
        ],
        today: DateTime.utc(2026, 2, 10),
      );

      expect(snapshot.periods.length, 2);
      expect(snapshot.avgCycleLength, 28);
      expect(snapshot.avgPeriodLength, 5);
      expect(snapshot.nextPeriodStart, DateTime.utc(2026, 2, 26));
      expect(snapshot.daysUntilNextPeriod, 16);
      expect(snapshot.cycleDay, 13);
      expect(snapshot.phase, CyclePhase.ovulation);
      expect(snapshot.kindOf(DateTime.utc(2026, 1, 30)), DayKind.period);
      expect(snapshot.kindOf(DateTime.utc(2026, 2, 10)), DayKind.fertile);
      expect(snapshot.kindOf(DateTime.utc(2026, 2, 11)), DayKind.ovulation);
      expect(
        snapshot.kindOf(DateTime.utc(2026, 2, 26)),
        DayKind.predictedPeriod,
      );
    });

    test('پریود عقب‌افتاده', () {
      final snapshot = CycleEngine.compute(
        periodDays: _range(DateTime.utc(2026, 1, 1), 5),
        today: DateTime.utc(2026, 2, 5),
      );

      expect(snapshot.daysUntilNextPeriod, -7);
      expect(snapshot.daysLate, 7);
      expect(snapshot.phase, CyclePhase.luteal);
      expect(
        snapshot.kindOf(DateTime.utc(2026, 2, 5)),
        DayKind.predictedPeriod,
      );
    });
  });
}
