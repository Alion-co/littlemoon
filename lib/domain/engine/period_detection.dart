import '../../core/utils/day_utils.dart';
import 'cycle_engine.dart';

/// تشخیص دوره‌های پریود و چرخه‌ها از روی روزهای خونریزی.
abstract final class PeriodDetection {
  /// روزهای خونریزیِ مرتب‌شده → دوره‌های پریود (فاصله‌ی کوتاه = همون دوره).
  static List<PeriodRange> group(List<DateTime> sorted) {
    final periods = <PeriodRange>[];
    var rangeStart = sorted.first;
    var rangeEnd = sorted.first;
    for (var i = 1; i < sorted.length; i++) {
      final day = sorted[i];
      if (daysBetween(rangeEnd, day) <= CycleEngine.maxGapInsidePeriod + 1) {
        rangeEnd = day;
      } else {
        periods.add(PeriodRange(rangeStart, rangeEnd));
        rangeStart = day;
        rangeEnd = day;
      }
    }
    periods.add(PeriodRange(rangeStart, rangeEnd));
    return periods;
  }

  /// فاصله‌ی شروع هر پریود تا پریود بعدی = یک چرخه‌ی کامل.
  static List<CycleRecord> cyclesOf(
    List<PeriodRange> periods,
    Set<int> unusualStarts,
  ) {
    final cycles = <CycleRecord>[];
    for (var i = 0; i + 1 < periods.length; i++) {
      final length = daysBetween(periods[i].start, periods[i + 1].start);
      cycles.add(
        CycleRecord(
          start: periods[i].start,
          length: length,
          periodLength: periods[i].length,
          valid:
              length >= CycleEngine.minValidCycle &&
              length <= CycleEngine.maxValidCycle,
          excluded: unusualStarts.contains(epochDay(periods[i].start)),
        ),
      );
    }
    return cycles;
  }
}
