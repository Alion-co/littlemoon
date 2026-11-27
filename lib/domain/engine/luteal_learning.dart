import '../../core/utils/day_utils.dart';
import '../../core/utils/math_utils.dart';
import 'cycle_engine.dart';
import 'cycle_stats.dart';

/// نتیجه‌ی تأیید تخمک‌گذاری با دمای پایه و یادگیری فاز لوتئال.
class LutealLearning {
  /// تخمک‌گذاری‌های تأییدشده با دما در همه‌ی چرخه‌ها.
  final List<BbtOvulation> ovulations;

  /// فاز لوتئال‌های مشاهده‌شده (قدیمی ← جدید).
  final List<int> samples;

  /// طول فاز لوتئالی که پیش‌بینی بر اساسش انجام می‌شه.
  final int luteal;

  /// [luteal] از چرخه‌های خودِ کاربر یاد گرفته شده.
  final bool learned;

  const LutealLearning({
    required this.ovulations,
    required this.samples,
    required this.luteal,
    required this.learned,
  });

  /// تخمک‌گذاری تأییدشده برای چرخه‌ای که از [cycleStart] شروع شده.
  BbtOvulation? ovulationFor(DateTime cycleStart) {
    BbtOvulation? found;
    for (final item in ovulations) {
      if (sameDay(item.cycleStart, cycleStart)) found = item;
    }
    return found;
  }

  /// روی هر چرخه‌ی کامل (و چرخه‌ی جاری) تخمک‌گذاری دمایی رو پیدا می‌کنه و
  /// اگه ≥ [CycleEngine.minLutealSamples] نمونه باشه، فاز لوتئال شخصی می‌سازه.
  static LutealLearning learn({
    required List<PeriodRange> periods,
    required List<CycleRecord> cycles,
    required Map<int, int> readings,
    required DateTime now,
    required int profileLuteal,
  }) {
    final ovulations = <BbtOvulation>[];
    final samples = <int>[];
    if (readings.isNotEmpty) {
      for (var i = 0; i < periods.length; i++) {
        final isLastPeriod = i == periods.length - 1;
        if (!isLastPeriod && !cycles[i].valid) continue;
        final endExclusive = isLastPeriod
            ? addDays(now, 1)
            : periods[i + 1].start;
        final found = BbtAnalyzer.detect(
          start: periods[i].start,
          endExclusive: endExclusive,
          readings: readings,
        );
        if (found == null) continue;
        ovulations.add(found);

        // فاز لوتئال = روزهای بین تخمک‌گذاری و پریود بعدی
        // (چرخه‌ی غیرعادی و مقدار غیرمنطقی یاد گرفته نمی‌شه)
        if (!isLastPeriod && cycles[i].counted) {
          final observed =
              daysBetween(found.ovulationDate, periods[i + 1].start) - 1;
          if (observed >= CycleEngine.minObservedLuteal &&
              observed <= CycleEngine.maxObservedLuteal) {
            samples.add(observed);
          }
        }
      }
    }

    final learned = samples.length >= CycleEngine.minLutealSamples;
    final luteal = learned
        ? clampInt(
            CycleStats.blend(
              CycleStats.lastN(samples, CycleEngine.historyWindow),
              profileLuteal,
            ),
            CycleEngine.minObservedLuteal,
            CycleEngine.maxObservedLuteal,
          )
        : profileLuteal;
    return LutealLearning(
      ovulations: List<BbtOvulation>.unmodifiable(ovulations),
      samples: List<int>.unmodifiable(samples),
      luteal: luteal,
      learned: learned,
    );
  }
}
