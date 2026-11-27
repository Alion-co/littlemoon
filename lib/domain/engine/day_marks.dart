import '../../core/utils/day_utils.dart';
import '../../core/utils/math_utils.dart';

/// مجموعه‌ی روزهای رنگی تقویم: پریود، پیش‌بینی، باروری و تخمک‌گذاری.
class DayMarks {
  final int luteal;
  final Set<int> period;
  final Set<int> predicted = <int>{};
  final Set<int> fertile = <int>{};
  final Set<int> ovulation = <int>{};

  DayMarks({required this.luteal, required this.period});

  /// فاصله‌ی روز تخمک‌گذاری از شروع چرخه (۰ = روز اول).
  static int ovulationOffset(int cycleLength, int luteal) =>
      clampInt(cycleLength - luteal - 1, 4, cycleLength - 2);

  /// تخمک‌گذاری + بازه‌ی باروری (۵ روز قبل تا ۱ روز بعد).
  void markAround(DateTime ovulationDate) {
    ovulation.add(epochDay(ovulationDate));
    for (var i = -5; i <= 1; i++) {
      fertile.add(epochDay(addDays(ovulationDate, i)));
    }
  }

  /// باروری یک چرخه‌ی تخمینی که از [cycleStart] شروع می‌شه.
  void markFertility(DateTime cycleStart, int cycleLength) =>
      markAround(addDays(cycleStart, ovulationOffset(cycleLength, luteal)));

  /// روزهای پریودِ پیش‌بینی‌شده از [start].
  void markPredictedPeriod(DateTime start, int periodLength) {
    for (var i = 0; i < periodLength; i++) {
      predicted.add(epochDay(addDays(start, i)));
    }
  }
}
