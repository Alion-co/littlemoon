import '../../core/utils/day_utils.dart';
import '../../data/models/daily_log.dart';

/// آمار علائم، خلق‌وخو و درد در بازه‌ی اخیر، برای گزارش پزشک.
class ReportStats {
  final int loggedDays;
  final int painDays;
  final List<MapEntry<String, int>> topSymptoms;
  final List<MapEntry<Mood, int>> topMoods;

  const ReportStats({
    required this.loggedDays,
    required this.painDays,
    required this.topSymptoms,
    required this.topMoods,
  });

  factory ReportStats.from(
    Map<String, DailyLog> logs,
    DateTime today, {
    required int windowDays,
  }) {
    final symptomCounts = <String, int>{};
    final moodCounts = <Mood, int>{};
    var painDays = 0;
    var loggedDays = 0;
    for (final log in logs.values) {
      final age = daysBetween(log.date, today);
      if (age < 0 || age >= windowDays) continue;
      loggedDays++;
      for (final id in log.symptoms) {
        symptomCounts[id] = (symptomCounts[id] ?? 0) + 1;
      }
      final mood = log.mood;
      if (mood != null) moodCounts[mood] = (moodCounts[mood] ?? 0) + 1;
      final pain = log.pain;
      if (pain != null && pain >= 2) painDays++;
    }
    return ReportStats(
      loggedDays: loggedDays,
      painDays: painDays,
      topSymptoms: symptomCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value)),
      topMoods: moodCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value)),
    );
  }
}
