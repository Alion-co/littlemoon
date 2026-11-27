import 'package:little_moon/core/utils/day_utils.dart';
import 'package:little_moon/data/models/daily_log.dart';

/// شمارش علائم و خلق‌وخو در یک بازه‌ی اخیر.
/// خالص (بدون Flutter)؛ از طریق `symptomStatsProvider` به UI می‌رسه.
class SymptomStats {
  /// بازه‌ای که آمار علائم و خلق‌وخو روی اون حساب می‌شه.
  static const windowDays = 90;

  /// علائم از بیشترین به کمترین تکرار.
  final List<MapEntry<String, int>> symptoms;

  /// خلق‌وخوها از بیشترین به کمترین تکرار.
  final List<MapEntry<Mood, int>> moods;

  const SymptomStats({this.symptoms = const [], this.moods = const []});

  /// شناسه‌ی پرتکرارترین علائم (حداکثر [count] تا).
  List<String> topSymptomIds(int count) => [
    for (final entry in symptoms.take(count)) entry.key,
  ];

  factory SymptomStats.from(Iterable<DailyLog> logs, DateTime today) {
    final symptomCounts = <String, int>{};
    final moodCounts = <Mood, int>{};
    for (final log in logs) {
      final age = daysBetween(log.date, today);
      if (age < 0 || age >= windowDays) continue;
      for (final id in log.symptoms) {
        symptomCounts[id] = (symptomCounts[id] ?? 0) + 1;
      }
      final mood = log.mood;
      if (mood != null) moodCounts[mood] = (moodCounts[mood] ?? 0) + 1;
    }
    return SymptomStats(
      symptoms: symptomCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value)),
      moods: moodCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value)),
    );
  }
}
