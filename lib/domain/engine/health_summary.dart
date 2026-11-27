import 'package:little_moon/core/utils/day_utils.dart';
import 'package:little_moon/data/models/daily_log.dart';

/// خلاصه‌ی سلامت از روی ثبت‌ها: آخرین وزن و دما + میانگین خواب ۷ روز اخیر.
/// خالص (بدون Flutter)؛ از طریق `healthSummaryProvider` به UI می‌رسه.
class HealthSummary {
  /// تعداد روزهای اخیر برای میانگین خواب.
  static const sleepWindowDays = 7;

  final DailyLog? lastWeight;
  final DailyLog? lastTemperature;
  final int sleepSum;
  final int sleepCount;

  const HealthSummary({
    this.lastWeight,
    this.lastTemperature,
    this.sleepSum = 0,
    this.sleepCount = 0,
  });

  double? get weightKg => lastWeight?.weightKg;
  DateTime? get weightDate => lastWeight?.date;
  double? get temperatureC => lastTemperature?.temperatureC;
  DateTime? get temperatureDate => lastTemperature?.date;

  /// میانگین خواب به دقیقه (`null` = داده‌ای نیست)، گرد به نزدیک‌ترین ۵ دقیقه.
  int? get averageSleepMinutes =>
      sleepCount == 0 ? null : ((sleepSum / sleepCount) / 5).round() * 5;

  factory HealthSummary.from(Iterable<DailyLog> logs, DateTime today) {
    DailyLog? lastWeight;
    DailyLog? lastTemperature;
    var sleepSum = 0;
    var sleepCount = 0;
    for (final log in logs) {
      if (log.weightKg != null &&
          (lastWeight == null || log.date.isAfter(lastWeight.date))) {
        lastWeight = log;
      }
      if (log.temperatureC != null &&
          (lastTemperature == null || log.date.isAfter(lastTemperature.date))) {
        lastTemperature = log;
      }
      final sleep = log.sleepMinutes;
      final age = daysBetween(log.date, today);
      if (sleep != null && age >= 0 && age < sleepWindowDays) {
        sleepSum += sleep;
        sleepCount++;
      }
    }
    return HealthSummary(
      lastWeight: lastWeight,
      lastTemperature: lastTemperature,
      sleepSum: sleepSum,
      sleepCount: sleepCount,
    );
  }
}
