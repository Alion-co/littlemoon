import 'dart:math' as math;

import '../../core/utils/day_utils.dart';
import '../../core/utils/math_utils.dart';
import 'bbt_analyzer.dart';
import 'cycle_forecast.dart';
import 'cycle_models.dart';
import 'cycle_snapshot.dart';
import 'cycle_stats.dart';
import 'day_marks.dart';
import 'luteal_learning.dart';
import 'period_detection.dart';

export 'bbt_analyzer.dart';
export 'cycle_models.dart';
export 'cycle_snapshot.dart';
export 'cycle_snapshot_queries.dart';

/// موتور محاسبه‌ی چرخه — کاملاً خالص (بدون وابستگی به Flutter یا حافظه).
///
/// روش: «روش تقویمی» با میانگین‌گیری از چرخه‌های واقعی ثبت‌شده.
///  • پریود بعدی = شروع آخرین پریود + میانگین طول چرخه‌های اخیر
///  • تخمک‌گذاری = «طول فاز لوتئال» روز قبل از پریود بعدی (پیش‌فرض ۱۴)
///  • بازه‌ی باروری = ۵ روز قبل از تخمک‌گذاری تا ۱ روز بعدش
abstract final class CycleEngine {
  static const minValidCycle = 15;
  static const maxValidCycle = 60;

  /// تا این تعداد روزِ بدون ثبت وسط یک پریود، هنوز همون پریود حساب می‌شه.
  static const maxGapInsidePeriod = 2;

  /// تعداد چرخه‌های اخیر که در میانگین استفاده می‌شن.
  static const historyWindow = 6;

  /// اختلاف کوتاه‌ترین و بلندترین چرخه تا این مقدار «منظم» حساب می‌شه.
  static const regularSpread = 7;

  static const futureCycles = 12;

  /// بازه‌ی پیش‌بینی (± روز) وقتی هنوز دو چرخه‌ی کامل ثبت نشده.
  static const defaultSpread = 3;

  /// بازه‌ی پیش‌بینی هیچ‌وقت از این باریک‌تر یا پهن‌تر نمی‌شه.
  static const minSpread = 1;
  static const maxSpread = 7;

  /// فاز لوتئالِ یادگرفته‌شده باید توی این بازه باشه (هم‌خوان با پروفایل).
  static const minObservedLuteal = 9;
  static const maxObservedLuteal = 18;

  /// حداقل تعداد چرخه‌ی تأییدشده با دما تا فاز لوتئال شخصی به کار بیفته.
  static const minLutealSamples = 2;

  /// بعد از تأیید تخمک‌گذاری با دما، بازه‌ی پیش‌بینی از این پهن‌تر نمی‌شه.
  static const bbtRefinedMaxSpread = 2;

  /// بیشتر از این تعداد روز تأخیر یعنی «تأخیر جدی».
  static const veryLateDays = 7;

  /// میانگین چرخه کمتر از این → «چرخه‌های کوتاه»، بیشتر از [longCycleDays]
  /// → «چرخه‌های بلند» (بازه‌ی رایج ۲۱ تا ۳۵ روز).
  static const shortCycleDays = 21;
  static const longCycleDays = 35;

  static int spreadOf(List<int> lengths) => CycleStats.spreadOf(lengths);

  static PredictionConfidence confidenceOf(List<int> lengths, int spread) =>
      CycleStats.confidenceOf(lengths, spread);

  static CycleSnapshot compute({
    required Iterable<DateTime> periodDays,
    required DateTime today,
    int defaultCycleLength = 28,
    int defaultPeriodLength = 5,
    int lutealLength = 14,
    Iterable<MapEntry<DateTime, double>> temperatures = const [],
    Iterable<DateTime> unusualCycleStarts = const [],
  }) {
    final now = dayOnly(today);
    final profileLuteal = clampInt(lutealLength, 9, 18);

    final sorted = <DateTime>[];
    for (final day in periodDays.map(dayOnly).toSet()) {
      if (!day.isAfter(now)) sorted.add(day);
    }
    sorted.sort();

    if (sorted.isEmpty) {
      return CycleSnapshot.empty(
        today: now,
        cycleLength: clampInt(defaultCycleLength, minValidCycle, maxValidCycle),
        periodLength: clampInt(defaultPeriodLength, 1, 10),
        lutealLength: profileLuteal,
      );
    }

    // ۱–۲) دوره‌های پریود و چرخه‌ها (چرخه‌ی «غیرعادی» از میانگین کنار می‌ره)
    final periods = PeriodDetection.group(sorted);
    final cycles = PeriodDetection.cyclesOf(periods, <int>{
      for (final d in unusualCycleStarts) epochDay(d),
    });
    final recent = CycleStats.lastN(<int>[
      for (final cycle in cycles)
        if (cycle.counted) cycle.length,
    ], historyWindow);
    final avgCycle = clampInt(
      CycleStats.blend(recent, defaultCycleLength),
      minValidCycle,
      maxValidCycle,
    );

    // ۳) طول پریود (پریودی که هنوز ادامه داره حساب نمی‌شه)
    final last = periods.last;
    final lastOngoing = daysBetween(last.end, now) <= 1;
    final completedPeriodLengths = <int>[
      for (var i = 0; i < periods.length; i++)
        if (i < periods.length - 1 || !lastOngoing) periods[i].length,
    ];
    final avgPeriod = clampInt(
      CycleStats.blend(
        CycleStats.lastN(completedPeriodLengths, historyWindow),
        defaultPeriodLength,
      ),
      1,
      10,
    );

    // ۴) تأیید تخمک‌گذاری با دما + فاز لوتئال شخصی
    final readings = BbtAnalyzer.normalize(temperatures);
    final learning = LutealLearning.learn(
      periods: periods,
      cycles: cycles,
      readings: readings,
      now: now,
      profileLuteal: profileLuteal,
    );
    final currentBbt = learning.ovulationFor(last.start);

    // ۵) نشانه‌گذاری روزها (چرخه‌های گذشته)
    final marks = DayMarks(
      luteal: learning.luteal,
      period: <int>{for (final day in sorted) epochDay(day)},
    );
    for (final cycle in cycles) {
      if (!cycle.valid) continue;
      final confirmed = learning.ovulationFor(cycle.start);
      if (confirmed != null) {
        marks.markAround(confirmed.ovulationDate);
      } else {
        marks.markFertility(cycle.start, cycle.length);
      }
    }
    if (currentBbt != null) {
      marks.markAround(currentBbt.ovulationDate);
    } else {
      marks.markFertility(last.start, avgCycle);
    }

    // ۶) پیش‌بینی چرخه‌های آینده
    final forecast = CycleForecast.build(
      last: last,
      now: now,
      avgCycle: avgCycle,
      avgPeriod: avgPeriod,
      luteal: learning.luteal,
      currentBbt: currentBbt,
      marks: marks,
    );

    // ۷) وضعیت امروز
    final cycleDay = daysBetween(last.start, now) + 1;
    final ovulationDay = currentBbt != null
        ? daysBetween(last.start, currentBbt.ovulationDate) + 1
        : DayMarks.ovulationOffset(avgCycle, learning.luteal) + 1;
    final isPeriodToday = marks.period.contains(epochDay(now));
    final bleedingNow = isPeriodToday || (lastOngoing && cycleDay <= avgPeriod);

    // ۸) نظم چرخه، بازه‌ی پیش‌بینی و اطمینان
    int? minCycle;
    int? maxCycle;
    for (final length in recent) {
      if (minCycle == null || length < minCycle) minCycle = length;
      if (maxCycle == null || length > maxCycle) maxCycle = length;
    }
    final regularity = CycleStats.regularityOf(
      minCycle,
      maxCycle,
      recent.length,
    );

    // وقتی تخمک‌گذاری تأیید شده، بازه‌ی عدم‌قطعیت فقط به تغییرات فاز لوتئال
    // (معمولاً ±۲ روز) برمی‌گرده
    var spread = CycleStats.spreadOf(recent);
    var confidence = CycleStats.confidenceOf(recent, spread);
    if (forecast.bbtRefined) {
      spread = math.min(spread, bbtRefinedMaxSpread);
      if (confidence == PredictionConfidence.low) {
        confidence = PredictionConfidence.medium;
      }
    }

    final nextOvulation = forecast.nextOvulation;
    return CycleSnapshot(
      today: now,
      hasData: true,
      periods: periods,
      cycles: cycles,
      recentCycleLengths: recent,
      avgCycleLength: avgCycle,
      avgPeriodLength: avgPeriod,
      lutealLength: learning.luteal,
      lutealSource: learning.learned
          ? LutealSource.learned
          : LutealSource.profile,
      lutealSamples: learning.samples,
      bbtOvulations: learning.ovulations,
      bbtRefined: forecast.bbtRefined,
      bbtReadingsThisCycle: BbtAnalyzer.countReadings(
        readings,
        last.start,
        addDays(now, 1),
      ),
      unusualCycleCount: cycles.where((c) => c.excluded).length,
      minCycleLength: minCycle,
      maxCycleLength: maxCycle,
      regularity: regularity,
      lastPeriodStart: last.start,
      nextPeriodStart: forecast.expectedNext,
      predictionSpread: spread,
      confidence: confidence,
      concerns: CycleStats.concernsOf(
        cycles: cycles,
        recent: recent,
        avgCycle: avgCycle,
        regularity: regularity,
        cycleDay: cycleDay,
      ),
      daysUntilNextPeriod: forecast.daysUntil,
      cycleDay: cycleDay,
      phase: CyclePhaseResolver.resolve(
        bleedingNow: bleedingNow,
        cycleDay: cycleDay,
        ovulationDay: ovulationDay,
      ),
      isPeriodToday: isPeriodToday,
      isPeriodOngoing: bleedingNow,
      nextOvulation: nextOvulation,
      fertileStart: addDays(nextOvulation, -5),
      fertileEnd: addDays(nextOvulation, 1),
      upcomingPeriods: forecast.upcoming,
      periodDaySet: marks.period,
      predictedDaySet: marks.predicted,
      fertileDaySet: marks.fertile,
      ovulationDaySet: marks.ovulation,
    );
  }
}
