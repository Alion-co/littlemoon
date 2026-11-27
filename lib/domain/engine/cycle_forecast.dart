import '../../core/utils/day_utils.dart';
import 'cycle_engine.dart';
import 'day_marks.dart';

/// پیش‌بینی پریود و تخمک‌گذاری بعدی (و علامت‌زدن چرخه‌های آینده).
class CycleForecast {
  /// شروع پیش‌بینی‌شده‌ی پریود بعدی (ممکنه در گذشته باشه = تأخیر).
  final DateTime expectedNext;

  /// پیش‌بینی با تخمک‌گذاری تأییدشده‌ی دما اصلاح شده.
  final bool bbtRefined;

  /// منفی یعنی پریود عقب افتاده.
  final int daysUntil;

  /// شروع پریودهای آینده.
  final List<DateTime> upcoming;

  final DateTime nextOvulation;

  const CycleForecast({
    required this.expectedNext,
    required this.bbtRefined,
    required this.daysUntil,
    required this.upcoming,
    required this.nextOvulation,
  });

  /// علاوه بر محاسبه، روزهای پیش‌بینی‌شده و باروری آینده رو توی [marks]
  /// علامت می‌زنه.
  static CycleForecast build({
    required PeriodRange last,
    required DateTime now,
    required int avgCycle,
    required int avgPeriod,
    required int luteal,
    required BbtOvulation? currentBbt,
    required DayMarks marks,
  }) {
    var expectedNext = addDays(last.start, avgCycle);

    // تخمک‌گذاری این چرخه با دما دیده شده → پریود بعدی = تخمک‌گذاری + فاز
    // لوتئال شخصی (دقیق‌تر از میانگین طول چرخه‌های قبلی)
    var bbtRefined = false;
    if (currentBbt != null) {
      final corrected = addDays(currentBbt.ovulationDate, luteal + 1);
      final length = daysBetween(last.start, corrected);
      if (length >= CycleEngine.minValidCycle &&
          length <= CycleEngine.maxValidCycle) {
        expectedNext = corrected;
        bbtRefined = true;
      }
    }
    final daysUntil = daysBetween(now, expectedNext);

    // اگه پریود عقب افتاده باشه، «هر لحظه ممکنه شروع بشه» → از امروز
    final effectiveNext = daysUntil < 0 ? now : expectedNext;

    final upcoming = <DateTime>[];
    for (var k = 0; k < CycleEngine.futureCycles; k++) {
      final start = addDays(effectiveNext, k * avgCycle);
      upcoming.add(start);
      marks.markPredictedPeriod(start, avgPeriod);
      marks.markFertility(start, avgCycle);
    }

    final offset = DayMarks.ovulationOffset(avgCycle, luteal);
    final currentOvulation =
        currentBbt?.ovulationDate ?? addDays(last.start, offset);
    final nextOvulation = currentOvulation.isBefore(now)
        ? addDays(effectiveNext, offset)
        : currentOvulation;

    return CycleForecast(
      expectedNext: expectedNext,
      bbtRefined: bbtRefined,
      daysUntil: daysUntil,
      upcoming: upcoming,
      nextOvulation: nextOvulation,
    );
  }
}
