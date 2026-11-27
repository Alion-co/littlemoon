import '../../core/utils/day_utils.dart';
import '../../core/utils/math_utils.dart';
import 'cycle_engine.dart';

/// پرس‌وجوهای مشتق‌شده از [CycleSnapshot] (بدون state جدید).
extension CycleSnapshotQueries on CycleSnapshot {
  /// تخمک‌گذاری تأییدشده‌ی چرخه‌ی فعلی (اگه با دما دیده شده باشه).
  BbtOvulation? get currentBbtOvulation {
    final start = lastPeriodStart;
    if (start == null) return null;
    return bbtOvulationFor(start);
  }

  /// تخمک‌گذاری تأییدشده برای چرخه‌ای که از [cycleStart] شروع شده.
  BbtOvulation? bbtOvulationFor(DateTime cycleStart) {
    for (final item in bbtOvulations) {
      if (sameDay(item.cycleStart, cycleStart)) return item;
    }
    return null;
  }

  /// زودترین روز محتمل برای شروع پریود بعدی.
  DateTime? get nextPeriodEarliest {
    final next = nextPeriodStart;
    return next == null ? null : addDays(next, -predictionSpread);
  }

  /// دیرترین روز محتمل برای شروع پریود بعدی.
  DateTime? get nextPeriodLatest {
    final next = nextPeriodStart;
    return next == null ? null : addDays(next, predictionSpread);
  }

  /// تعداد روزهای تأخیر پریود (۰ اگه تأخیری نیست).
  int get daysLate {
    final days = daysUntilNextPeriod;
    return (days != null && days < 0) ? -days : 0;
  }

  /// شدت تأخیر: نوسان عادی، تأخیر، یا تأخیر بیشتر از یک هفته.
  LateLevel get lateLevel {
    final days = daysLate;
    if (days == 0) return LateLevel.none;
    if (days <= predictionSpread) return LateLevel.withinRange;
    if (days <= CycleEngine.veryLateDays) return LateLevel.beyondRange;
    return LateLevel.veryLate;
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
