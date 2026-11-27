import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/core/utils/day_utils.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';

import '../helpers/cycle_fixtures.dart';

final _start = DateTime.utc(2026, 1, 1);

/// روزهای پریود برای چرخه‌هایی با طول‌های داده‌شده؛ هر پریود ۵ روز.
/// `[28, 28]` یعنی ۳ پریود با فاصله‌ی ۲۸ روز.
List<DateTime> _periodDays(List<int> cycleLengths) {
  final starts = <DateTime>[_start];
  for (final length in cycleLengths) {
    starts.add(addDays(starts.last, length));
  }
  return [
    for (final start in starts)
      for (var i = 0; i < 5; i++) addDays(start, i),
  ];
}

DateTime _lastStart(List<int> cycleLengths) =>
    addDays(_start, cycleLengths.fold<int>(0, (a, b) => a + b));

/// «امروز» = [daysAfterLastStart] روز بعد از شروع آخرین پریود.
CycleSnapshot _compute(List<int> cycleLengths, {int daysAfterLastStart = 10}) {
  return CycleEngine.compute(
    periodDays: _periodDays(cycleLengths),
    today: addDays(_lastStart(cycleLengths), daysAfterLastStart),
  );
}

void main() {
  group('داده‌ی خالی', () {
    test('بدون ثبت، مقدارهای پیش‌فرض برمی‌گرده', () {
      final snapshot = CycleEngine.compute(
        periodDays: const [],
        today: DateTime.utc(2026, 3, 1),
      );
      expect(snapshot.hasData, isFalse);
      expect(snapshot.avgCycleLength, 28);
      expect(snapshot.avgPeriodLength, 5);
      expect(snapshot.nextPeriodStart, isNull);
      expect(snapshot.confidence, PredictionConfidence.low);
      expect(snapshot.concerns, isEmpty);
      expect(snapshot.lateLevel, LateLevel.none);
    });
  });

  group('چرخه‌ی منظم ۲۸ روزه', () {
    final lengths = [28, 28, 28, 28];
    final snapshot = _compute(lengths);

    test('میانگین، نظم و پیش‌بینی', () {
      expect(snapshot.hasData, isTrue);
      expect(snapshot.avgCycleLength, 28);
      expect(snapshot.regularity, CycleRegularity.regular);
      expect(snapshot.nextPeriodStart, addDays(_lastStart(lengths), 28));
      expect(snapshot.daysUntilNextPeriod, 18);
      expect(snapshot.cycleDay, 11);
      expect(snapshot.phase, CyclePhase.follicular);
    });

    test('تخمک‌گذاری و بازه‌ی باروری', () {
      final last = _lastStart(lengths);
      expect(snapshot.nextOvulation, addDays(last, 13));
      expect(snapshot.fertileStart, addDays(last, 8));
      expect(snapshot.fertileEnd, addDays(last, 14));
    });

    test('بازه‌ی پیش‌بینی باریک و اطمینان زیاده، بدون نگرانی', () {
      expect(snapshot.predictionSpread, 1);
      expect(snapshot.confidence, PredictionConfidence.high);
      expect(snapshot.concerns, isEmpty);
      expect(snapshot.lateLevel, LateLevel.none);
    });

    test('نوع روزها در تقویم', () {
      expect(snapshot.kindOf(_start), DayKind.period);
      expect(
        snapshot.kindOf(snapshot.nextPeriodStart!),
        DayKind.predictedPeriod,
      );
    });
  });

  group('میانگین وزن‌دار', () {
    test('چرخه‌های اخیر وزن بیشتری دارن (روند رو به بلندتر شدن)', () {
      // (۲۶×۱ + ۲۸×۲ + ۳۰×۳) / ۶ = ۲۸٫۶۷ → ۲۹ (میانگین ساده ۲۸ می‌شد)
      final snapshot = _compute([26, 28, 30]);
      expect(snapshot.avgCycleLength, 29);
    });

    test('روند رو به کوتاه‌تر شدن', () {
      // (۳۰×۱ + ۲۸×۲ + ۲۶×۳) / ۶ = ۲۷٫۳۳ → ۲۷
      final snapshot = _compute([30, 28, 26]);
      expect(snapshot.avgCycleLength, 27);
    });

    test('با کمتر از ۳ چرخه با مقدار پیش‌فرض ترکیب می‌شه', () {
      // (۳۴ + ۳۴ + ۲۸) / ۳ = ۳۲
      final snapshot = _compute([34, 34]);
      expect(snapshot.avgCycleLength, 32);
    });

    test('چرخه‌ی خیلی کوتاه (احتمالاً ثبت اشتباه) تو میانگین نمی‌ره', () {
      final snapshot = _compute([28, 10, 28]);
      expect(snapshot.cycles.map((c) => c.valid).toList(), [true, false, true]);
      expect(snapshot.avgCycleLength, 28);
    });
  });

  group('پراکندگی و اطمینان', () {
    test('با کمتر از ۲ چرخه، بازه‌ی پیش‌فرض', () {
      expect(CycleEngine.spreadOf(const [28]), CycleEngine.defaultSpread);
      expect(CycleEngine.spreadOf(const []), CycleEngine.defaultSpread);
    });

    test('چرخه‌های یکسان → کمترین بازه', () {
      expect(
        CycleEngine.spreadOf(const [28, 28, 28, 28]),
        CycleEngine.minSpread,
      );
    });

    test('چرخه‌های خیلی نامنظم → بیشترین بازه', () {
      expect(
        CycleEngine.spreadOf(const [20, 36, 24, 40, 22, 38]),
        CycleEngine.maxSpread,
      );
    });

    test('اطمینان', () {
      expect(
        CycleEngine.confidenceOf(const [28, 28], 1),
        PredictionConfidence.low,
      );
      expect(
        CycleEngine.confidenceOf(const [28, 28, 28], 1),
        PredictionConfidence.medium,
      );
      expect(
        CycleEngine.confidenceOf(const [28, 28, 28, 28], 1),
        PredictionConfidence.high,
      );
      expect(
        CycleEngine.confidenceOf(const [28, 29, 27, 28], 3),
        PredictionConfidence.medium,
      );
      expect(
        CycleEngine.confidenceOf(const [20, 36, 24, 40], 6),
        PredictionConfidence.low,
      );
    });
  });

  group('تأخیر', () {
    // چرخه‌ی منظم ۲۸ روزه (بازه‌ی پیش‌بینی ±۱)؛ «امروز» = روز ۲۸ + k
    LateLevel levelAfter(int extraDays) => _compute([
      28,
      28,
      28,
      28,
    ], daysAfterLastStart: 28 + extraDays).lateLevel;

    test('سروقت → بدون تأخیر', () {
      expect(levelAfter(0), LateLevel.none);
    });

    test('۱ روز تأخیر هنوز داخل نوسان معموله', () {
      expect(levelAfter(1), LateLevel.withinRange);
    });

    test('بیشتر از بازه ولی تا یک هفته', () {
      expect(levelAfter(3), LateLevel.beyondRange);
      expect(levelAfter(7), LateLevel.beyondRange);
    });

    test('بیشتر از یک هفته', () {
      expect(levelAfter(8), LateLevel.veryLate);
    });

    test('تعداد روزهای تأخیر درست حساب می‌شه', () {
      final snapshot = _compute([28, 28, 28, 28], daysAfterLastStart: 28 + 5);
      expect(snapshot.daysLate, 5);
    });
  });

  group('نگرانی‌ها', () {
    test('چرخه‌های کوتاه‌تر از ۲۱ روز', () {
      expect(_compute([19, 19, 19, 19]).concerns, [CycleConcern.shortCycles]);
    });

    test('چرخه‌های بلندتر از ۳۵ روز', () {
      expect(_compute([40, 40, 40, 40]).concerns, [CycleConcern.longCycles]);
    });

    test('اختلاف زیاد بین چرخه‌ها', () {
      final snapshot = _compute([24, 34, 26, 36]);
      expect(snapshot.regularity, CycleRegularity.irregular);
      expect(snapshot.concerns, [CycleConcern.highVariation]);
    });

    test('چرخه‌ی بیش از ۶۰ روز → احتمالاً یک پریود ثبت نشده', () {
      expect(_compute([28, 28, 75]).concerns, [CycleConcern.possibleMissedLog]);
    });

    test('چند ماه بدون ثبت → احتمالاً ثبت جا افتاده', () {
      final snapshot = _compute([28, 28, 28, 28], daysAfterLastStart: 70);
      expect(snapshot.concerns, contains(CycleConcern.possibleMissedLog));
      expect(snapshot.lateLevel, LateLevel.veryLate);
    });
  });

  group('گروه‌بندی روزهای خونریزی', () {
    test('یک روز ثبت‌نشده وسط پریود، پریود رو دو تکه نمی‌کنه', () {
      final snapshot = CycleEngine.compute(
        periodDays: [
          DateTime.utc(2026, 1, 1),
          DateTime.utc(2026, 1, 2),
          // ۳ ژانویه ثبت نشده
          DateTime.utc(2026, 1, 4),
          DateTime.utc(2026, 1, 5),
        ],
        today: DateTime.utc(2026, 1, 10),
      );
      expect(snapshot.periods.length, 1);
      expect(snapshot.periods.first.length, 5);
    });

    test('روزهای آینده نادیده گرفته می‌شن', () {
      final snapshot = CycleEngine.compute(
        periodDays: [DateTime.utc(2026, 2, 1)],
        today: DateTime.utc(2026, 1, 10),
      );
      expect(snapshot.hasData, isFalse);
    });
  });

  group('حداقل داده (دو پریود و پریود عقب‌افتاده)', () {
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
          ...dateRange(DateTime.utc(2026, 1, 1), 5),
          ...dateRange(DateTime.utc(2026, 1, 29), 5),
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
        periodDays: dateRange(DateTime.utc(2026, 1, 1), 5),
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
