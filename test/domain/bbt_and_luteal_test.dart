import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';

DateTime d(int y, int m, int day) => DateTime.utc(y, m, day);

/// دمای یک چرخه: پایین تا روز [ovDay] (۱ = روز اول)، بعدش بالا.
List<MapEntry<DateTime, double>> temps(DateTime start, int ovDay, int upTo) {
  final result = <MapEntry<DateTime, double>>[];
  for (var i = 0; i < upTo; i++) {
    final low = 36.2 + (i % 3) * 0.05;
    result.add(
      MapEntry(start.add(Duration(days: i)), i + 1 <= ovDay ? low : 36.7),
    );
  }
  return result;
}

/// روزهای پریود (۵ روز) برای شروع‌های داده‌شده.
List<DateTime> periodDays(List<DateTime> starts) => [
  for (final s in starts)
    for (var i = 0; i < 5; i++) s.add(Duration(days: i)),
];

void main() {
  group('BbtAnalyzer', () {
    test('جهش سه‌روزه رو پیدا می‌کنه و روز تخمک‌گذاری آخرین روز پایینه', () {
      final start = d(2026, 1, 1);
      final r = BbtAnalyzer.normalize(temps(start, 14, 20));
      final found = BbtAnalyzer.detect(
        start: start,
        endExclusive: d(2026, 1, 21),
        readings: r,
      );
      expect(found, isNotNull);
      expect(found!.cycleDay, 14);
      expect(found.shiftStart, d(2026, 1, 15));
    });

    test('بدون جهش چیزی تأیید نمی‌شه', () {
      final start = d(2026, 1, 1);
      final r = BbtAnalyzer.normalize(temps(start, 99, 25));
      expect(
        BbtAnalyzer.detect(
          start: start,
          endExclusive: d(2026, 1, 26),
          readings: r,
        ),
        isNull,
      );
    });

    test('تب و دمای نامعتبر نادیده گرفته می‌شه', () {
      final r = BbtAnalyzer.normalize([
        MapEntry(d(2026, 1, 1), 39.5),
        MapEntry(d(2026, 1, 2), 30.0),
        MapEntry(d(2026, 1, 3), 36.4),
      ]);
      expect(r.length, 1);
    });

    test('با کمتر از ۶ اندازه‌گیری پایه تأیید نمی‌شه', () {
      final start = d(2026, 1, 1);
      final data = temps(start, 14, 18).where((e) => e.key.day >= 10).toList();
      final r = BbtAnalyzer.normalize(data);
      expect(
        BbtAnalyzer.detect(
          start: start,
          endExclusive: d(2026, 1, 19),
          readings: r,
        ),
        isNull,
      );
    });
  });

  group('فاز لوتئال شخصی (A2)', () {
    // سه چرخه‌ی ۲۸ روزه با تخمک‌گذاری روز ۱۸ → لوتئال = ۲۸ − ۱۸ = ۱۰
    final starts = [
      d(2026, 1, 1),
      d(2026, 1, 29),
      d(2026, 2, 26),
      d(2026, 3, 26),
    ];
    final allTemps = [for (var i = 0; i < 3; i++) ...temps(starts[i], 18, 28)];

    test('بدون دما همون عدد پروفایل می‌مونه', () {
      final s = CycleEngine.compute(
        periodDays: periodDays(starts),
        today: d(2026, 4, 5),
      );
      expect(s.lutealLength, 14);
      expect(s.lutealSource, LutealSource.profile);
    });

    test('از چرخه‌های تأییدشده یاد می‌گیره', () {
      final s = CycleEngine.compute(
        periodDays: periodDays(starts),
        today: d(2026, 4, 5),
        temperatures: allTemps,
      );
      expect(s.lutealSamples, [10, 10, 10]);
      expect(s.lutealSource, LutealSource.learned);
      expect(s.lutealLength, 10);
    });

    test('یک نمونه کافی نیست', () {
      final s = CycleEngine.compute(
        periodDays: periodDays(starts),
        today: d(2026, 4, 5),
        temperatures: temps(starts[0], 18, 28),
      );
      expect(s.lutealSource, LutealSource.profile);
    });
  });

  group('اصلاح پیش‌بینی با BBT (A1)', () {
    test('تخمک‌گذاری تأییدشده‌ی چرخه‌ی فعلی پریود بعدی رو اصلاح می‌کنه', () {
      final starts = [d(2026, 1, 1), d(2026, 1, 29), d(2026, 2, 26)];
      // چرخه‌ی فعلی: تخمک‌گذاری روز ۱۹ (دیرتر از معمول)
      final s = CycleEngine.compute(
        periodDays: periodDays(starts),
        today: d(2026, 3, 20),
        lutealLength: 14,
        temperatures: temps(starts[2], 19, 23),
      );
      expect(s.bbtRefined, isTrue);
      // تخمک‌گذاری = ۱۹ روز بعد از ۲۶ فوریه → ۱۶ مارس (روز ۱۹ = +۱۸)
      expect(s.currentBbtOvulation!.ovulationDate, d(2026, 3, 16));
      // پریود بعدی = تخمک‌گذاری + لوتئال + ۱
      expect(s.nextPeriodStart, d(2026, 3, 31));
      expect(s.predictionSpread <= 2, isTrue);
    });
  });

  group('چرخه‌ی غیرعادی (A3)', () {
    // ۲۸، ۲۸، ۴۵ (بیماری)، ۲۸
    final starts = [
      d(2026, 1, 1),
      d(2026, 1, 29),
      d(2026, 2, 26),
      d(2026, 4, 12),
      d(2026, 5, 10),
    ];

    test('بدون برچسب، چرخه‌ی ۴۵ روزه میانگین رو بالا می‌بره', () {
      final s = CycleEngine.compute(
        periodDays: periodDays(starts),
        today: d(2026, 5, 15),
      );
      expect(s.avgCycleLength > 28, isTrue);
    });

    test('با برچسب، از میانگین کنار می‌ره', () {
      final s = CycleEngine.compute(
        periodDays: periodDays(starts),
        today: d(2026, 5, 15),
        unusualCycleStarts: [d(2026, 2, 26)],
      );
      expect(s.avgCycleLength, 28);
      expect(s.unusualCycleCount, 1);
      expect(s.cycles.where((c) => c.excluded).length, 1);
      expect(s.regularity, CycleRegularity.regular);
    });
  });
}
