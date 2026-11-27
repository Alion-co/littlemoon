import 'package:little_moon/data/models/daily_log.dart';

/// آنچه موتور چرخه واقعاً از ثبت‌ها لازم داره: روزهای پریود و دماها.
///
/// دو نمونه با همین اطلاعات `==` هستن؛ برای همین با `select(...)` وقتی
/// فقط آب، وزن، یادداشت، خلق‌وخو و ... عوض می‌شه، چرخه از نو محاسبه نمی‌شه.
class CycleInputs {
  final List<DateTime> periodDays;
  final List<MapEntry<DateTime, double>> temperatures;

  const CycleInputs({this.periodDays = const [], this.temperatures = const []});

  factory CycleInputs.from(Map<String, DailyLog> logs) {
    final periodDays = <DateTime>[];
    final temperatures = <MapEntry<DateTime, double>>[];
    for (final log in logs.values) {
      if (log.isPeriodDay) periodDays.add(log.date);
      final temperature = log.temperatureC;
      if (temperature != null) {
        temperatures.add(MapEntry(log.date, temperature));
      }
    }
    return CycleInputs(periodDays: periodDays, temperatures: temperatures);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CycleInputs) return false;
    if (periodDays.length != other.periodDays.length ||
        temperatures.length != other.temperatures.length) {
      return false;
    }
    for (var i = 0; i < periodDays.length; i++) {
      if (periodDays[i] != other.periodDays[i]) return false;
    }
    for (var i = 0; i < temperatures.length; i++) {
      final a = temperatures[i];
      final b = other.temperatures[i];
      if (a.key != b.key || a.value != b.value) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hash(periodDays.length, temperatures.length);
}

/// آنچه `PatternFinder` از ثبت‌ها می‌خونه: روز، علائم، خلق‌وخو و درد
/// (متوسط به بالا). ثبت‌هایی که هیچ‌کدوم رو ندارن حذف می‌شن.
class PatternInputs {
  final List<DailyLog> logs;

  const PatternInputs([this.logs = const []]);

  factory PatternInputs.from(Map<String, DailyLog> logs) => PatternInputs([
    for (final log in logs.values)
      if (_isRelevant(log)) log,
  ]);

  static bool _isRelevant(DailyLog log) =>
      log.symptoms.isNotEmpty || log.mood != null || _highPain(log);

  static bool _highPain(DailyLog log) => (log.pain ?? 0) >= 2;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PatternInputs || logs.length != other.logs.length) {
      return false;
    }
    for (var i = 0; i < logs.length; i++) {
      final a = logs[i];
      final b = other.logs[i];
      if (a.date != b.date ||
          a.mood != b.mood ||
          _highPain(a) != _highPain(b) ||
          a.symptoms.length != b.symptoms.length ||
          !a.symptoms.containsAll(b.symptoms)) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode => logs.length.hashCode;
}
