import '../../core/utils/day_utils.dart';
import '../../core/utils/math_utils.dart';

enum CyclePhase { menstrual, follicular, ovulation, luteal }

enum DayKind { none, period, predictedPeriod, fertile, ovulation }

enum CycleRegularity { unknown, regular, irregular }

/// یک دوره‌ی پریود ثبت‌شده (از اولین تا آخرین روز خونریزی).
class PeriodRange {
  final DateTime start;
  final DateTime end;

  const PeriodRange(this.start, this.end);

  int get length => daysBetween(start, end) + 1;
}

/// یک چرخه‌ی کامل: از شروع یک پریود تا شروع پریود بعدی.
class CycleRecord {
  final DateTime start;
  final int length;
  final int periodLength;

  /// چرخه‌های خیلی کوتاه/بلند (معمولاً به‌خاطر ثبت‌نشدن یک پریود)
  /// در میانگین‌گیری حساب نمی‌شن.
  final bool valid;

  const CycleRecord({
    required this.start,
    required this.length,
    required this.periodLength,
    required this.valid,
  });
}

/// وضعیت محاسبه‌شده‌ی چرخه در یک روز مشخص.
class CycleSnapshot {
  final DateTime today;
  final bool hasData;

  final List<PeriodRange> periods;
  final List<CycleRecord> cycles;

  /// طول چرخه‌های معتبرِ اخیر که مبنای میانگین بودن (حداکثر ۶ تا).
  final List<int> recentCycleLengths;

  final int avgCycleLength;
  final int avgPeriodLength;
  final int lutealLength;
  final int? minCycleLength;
  final int? maxCycleLength;
  final CycleRegularity regularity;

  final DateTime? lastPeriodStart;

  /// شروع پیش‌بینی‌شده‌ی پریود بعدی (ممکنه در گذشته باشه = تأخیر).
  final DateTime? nextPeriodStart;

  /// منفی یعنی پریود عقب افتاده.
  final int? daysUntilNextPeriod;

  final int? cycleDay;
  final CyclePhase? phase;
  final bool isPeriodToday;
  final bool isPeriodOngoing;

  final DateTime? nextOvulation;
  final DateTime? fertileStart;
  final DateTime? fertileEnd;

  /// شروع پریودهای پیش‌بینی‌شده‌ی آینده.
  final List<DateTime> upcomingPeriods;

  final Set<int> periodDaySet;
  final Set<int> predictedDaySet;
  final Set<int> fertileDaySet;
  final Set<int> ovulationDaySet;

  const CycleSnapshot({
    required this.today,
    required this.hasData,
    required this.periods,
    required this.cycles,
    required this.recentCycleLengths,
    required this.avgCycleLength,
    required this.avgPeriodLength,
    required this.lutealLength,
    required this.minCycleLength,
    required this.maxCycleLength,
    required this.regularity,
    required this.lastPeriodStart,
    required this.nextPeriodStart,
    required this.daysUntilNextPeriod,
    required this.cycleDay,
    required this.phase,
    required this.isPeriodToday,
    required this.isPeriodOngoing,
    required this.nextOvulation,
    required this.fertileStart,
    required this.fertileEnd,
    required this.upcomingPeriods,
    required this.periodDaySet,
    required this.predictedDaySet,
    required this.fertileDaySet,
    required this.ovulationDaySet,
  });

  factory CycleSnapshot.empty({
    required DateTime today,
    int cycleLength = 28,
    int periodLength = 5,
    int lutealLength = 14,
  }) {
    return CycleSnapshot(
      today: dayOnly(today),
      hasData: false,
      periods: const [],
      cycles: const [],
      recentCycleLengths: const [],
      avgCycleLength: cycleLength,
      avgPeriodLength: periodLength,
      lutealLength: lutealLength,
      minCycleLength: null,
      maxCycleLength: null,
      regularity: CycleRegularity.unknown,
      lastPeriodStart: null,
      nextPeriodStart: null,
      daysUntilNextPeriod: null,
      cycleDay: null,
      phase: null,
      isPeriodToday: false,
      isPeriodOngoing: false,
      nextOvulation: null,
      fertileStart: null,
      fertileEnd: null,
      upcomingPeriods: const [],
      periodDaySet: const <int>{},
      predictedDaySet: const <int>{},
      fertileDaySet: const <int>{},
      ovulationDaySet: const <int>{},
    );
  }

  /// تعداد روزهای تأخیر پریود (۰ اگه تأخیری نیست).
  int get daysLate {
    final days = daysUntilNextPeriod;
    return (days != null && days < 0) ? -days : 0;
  }

  /// پیشرفت چرخه‌ی فعلی بین ۰ و ۱.
  double get progress {
    final day = cycleDay;
    if (day == null || avgCycleLength <= 0) return 0;
    return clampDouble(day / avgCycleLength, 0, 1);
  }

  bool get isInFertileWindow {
    final key = epochDay(today);
    return !periodDaySet.contains(key) &&
        (fertileDaySet.contains(key) || ovulationDaySet.contains(key));
  }

  /// نوع یک روز برای نمایش در تقویم.
  DayKind kindOf(DateTime date) {
    final key = epochDay(date);
    if (periodDaySet.contains(key)) return DayKind.period;
    if (predictedDaySet.contains(key)) return DayKind.predictedPeriod;
    if (ovulationDaySet.contains(key)) return DayKind.ovulation;
    if (fertileDaySet.contains(key)) return DayKind.fertile;
    return DayKind.none;
  }

  /// شماره‌ی روز چرخه برای یک تاریخ دلخواه (اگه قابل محاسبه باشه).
  int? cycleDayOf(DateTime date) {
    final day = dayOnly(date);
    PeriodRange? owner;
    for (final period in periods) {
      if (!period.start.isAfter(day)) owner = period;
    }
    if (owner == null) return null;

    final isLast = identical(owner, periods.last);
    if (isLast && upcomingPeriods.isNotEmpty) {
      final next = upcomingPeriods.first;
      if (!day.isBefore(next) && day.isAfter(today)) {
        // روز آینده‌ای که در چرخه‌های پیش‌بینی‌شده‌ی بعدی می‌افته
        return daysBetween(next, day) % avgCycleLength + 1;
      }
    }
    return daysBetween(owner.start, day) + 1;
  }
}

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

  static const _futureCycles = 12;

  static CycleSnapshot compute({
    required Iterable<DateTime> periodDays,
    required DateTime today,
    int defaultCycleLength = 28,
    int defaultPeriodLength = 5,
    int lutealLength = 14,
  }) {
    final now = dayOnly(today);
    final luteal = clampInt(lutealLength, 9, 18);

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
        lutealLength: luteal,
      );
    }

    // ۱) گروه‌بندی روزهای خونریزی به دوره‌های پریود
    final periods = <PeriodRange>[];
    var rangeStart = sorted.first;
    var rangeEnd = sorted.first;
    for (var i = 1; i < sorted.length; i++) {
      final day = sorted[i];
      if (daysBetween(rangeEnd, day) <= maxGapInsidePeriod + 1) {
        rangeEnd = day;
      } else {
        periods.add(PeriodRange(rangeStart, rangeEnd));
        rangeStart = day;
        rangeEnd = day;
      }
    }
    periods.add(PeriodRange(rangeStart, rangeEnd));

    // ۲) طول چرخه‌ها
    final cycles = <CycleRecord>[];
    for (var i = 0; i + 1 < periods.length; i++) {
      final length = daysBetween(periods[i].start, periods[i + 1].start);
      cycles.add(
        CycleRecord(
          start: periods[i].start,
          length: length,
          periodLength: periods[i].length,
          valid: length >= minValidCycle && length <= maxValidCycle,
        ),
      );
    }

    final validLengths = <int>[
      for (final cycle in cycles)
        if (cycle.valid) cycle.length,
    ];
    final recent = _lastN(validLengths, historyWindow);
    final avgCycle = clampInt(
      _blend(recent, defaultCycleLength),
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
      _blend(_lastN(completedPeriodLengths, historyWindow), defaultPeriodLength),
      1,
      10,
    );

    // فاصله‌ی روز تخمک‌گذاری از شروع چرخه (۰ = روز اول)
    int ovulationOffset(int cycleLength) =>
        clampInt(cycleLength - luteal - 1, 4, cycleLength - 2);

    // ۴) نشانه‌گذاری روزها
    final periodSet = <int>{for (final day in sorted) epochDay(day)};
    final predictedSet = <int>{};
    final fertileSet = <int>{};
    final ovulationSet = <int>{};

    void markFertility(DateTime cycleStart, int cycleLength) {
      final ovulation = addDays(cycleStart, ovulationOffset(cycleLength));
      ovulationSet.add(epochDay(ovulation));
      for (var i = -5; i <= 1; i++) {
        fertileSet.add(epochDay(addDays(ovulation, i)));
      }
    }

    for (final cycle in cycles) {
      if (cycle.valid) markFertility(cycle.start, cycle.length);
    }
    markFertility(last.start, avgCycle);

    // ۵) پیش‌بینی
    final expectedNext = addDays(last.start, avgCycle);
    final daysUntil = daysBetween(now, expectedNext);

    // اگه پریود عقب افتاده باشه، «هر لحظه ممکنه شروع بشه» → از امروز
    final effectiveNext = daysUntil < 0 ? now : expectedNext;

    final upcoming = <DateTime>[];
    for (var k = 0; k < _futureCycles; k++) {
      final start = addDays(effectiveNext, k * avgCycle);
      upcoming.add(start);
      for (var i = 0; i < avgPeriod; i++) {
        predictedSet.add(epochDay(addDays(start, i)));
      }
      markFertility(start, avgCycle);
    }

    final currentOvulation = addDays(last.start, ovulationOffset(avgCycle));
    final nextOvulation = currentOvulation.isBefore(now)
        ? addDays(effectiveNext, ovulationOffset(avgCycle))
        : currentOvulation;

    // ۶) وضعیت امروز
    final cycleDay = daysBetween(last.start, now) + 1;
    final ovulationDay = ovulationOffset(avgCycle) + 1;
    final isPeriodToday = periodSet.contains(epochDay(now));
    final bleedingNow =
        isPeriodToday || (lastOngoing && cycleDay <= avgPeriod);

    CyclePhase phase;
    if (bleedingNow) {
      phase = CyclePhase.menstrual;
    } else if (cycleDay < ovulationDay - 1) {
      phase = CyclePhase.follicular;
    } else if (cycleDay <= ovulationDay + 1) {
      phase = CyclePhase.ovulation;
    } else {
      phase = CyclePhase.luteal;
    }

    // ۷) نظم چرخه
    int? minCycle;
    int? maxCycle;
    for (final length in recent) {
      if (minCycle == null || length < minCycle) minCycle = length;
      if (maxCycle == null || length > maxCycle) maxCycle = length;
    }
    var regularity = CycleRegularity.unknown;
    if (recent.length >= 2 && minCycle != null && maxCycle != null) {
      regularity = (maxCycle - minCycle) <= regularSpread
          ? CycleRegularity.regular
          : CycleRegularity.irregular;
    }

    return CycleSnapshot(
      today: now,
      hasData: true,
      periods: periods,
      cycles: cycles,
      recentCycleLengths: recent,
      avgCycleLength: avgCycle,
      avgPeriodLength: avgPeriod,
      lutealLength: luteal,
      minCycleLength: minCycle,
      maxCycleLength: maxCycle,
      regularity: regularity,
      lastPeriodStart: last.start,
      nextPeriodStart: expectedNext,
      daysUntilNextPeriod: daysUntil,
      cycleDay: cycleDay,
      phase: phase,
      isPeriodToday: isPeriodToday,
      isPeriodOngoing: bleedingNow,
      nextOvulation: nextOvulation,
      fertileStart: addDays(nextOvulation, -5),
      fertileEnd: addDays(nextOvulation, 1),
      upcomingPeriods: upcoming,
      periodDaySet: periodSet,
      predictedDaySet: predictedSet,
      fertileDaySet: fertileSet,
      ovulationDaySet: ovulationSet,
    );
  }

  static List<int> _lastN(List<int> values, int count) =>
      values.length > count ? values.sublist(values.length - count) : values;

  /// میانگین مقادیر واقعی؛ تا وقتی کمتر از ۳ نمونه داریم، با مقدار
  /// پیش‌فرضِ کاربر ترکیب می‌شه تا یک چرخه‌ی غیرعادی پیش‌بینی رو خراب نکنه.
  static int _blend(List<int> values, int fallback) {
    if (values.isEmpty) return fallback;
    var sum = 0;
    for (final value in values) {
      sum += value;
    }
    if (values.length >= 3) return (sum / values.length).round();
    return ((sum + fallback * (3 - values.length)) / 3).round();
  }
}
