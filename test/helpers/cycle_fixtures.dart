import 'package:little_moon/core/utils/day_utils.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';

/// [length] روز پشت‌هم از [start] (UTC).
List<DateTime> dateRange(DateTime start, int length) => [
  for (var i = 0; i < length; i++)
    DateTime.utc(start.year, start.month, start.day + i),
];

/// سه چرخه‌ی ۲۷، ۲۹ و ۲۸ روزه + یک عادت ماهانه‌ی ناقص.
CycleSnapshot sampleCycle() => CycleEngine.compute(
  periodDays: [
    ...dateRange(DateTime.utc(2026, 6, 1), 5),
    ...dateRange(DateTime.utc(2026, 6, 28), 5),
    ...dateRange(DateTime.utc(2026, 7, 27), 4),
    ...dateRange(DateTime.utc(2026, 8, 24), 5),
  ],
  today: DateTime.utc(2026, 9, 5),
);

/// چهار عادت ماهانه با فاصله‌ی ۲۸ روز؛ در هر چرخه ۲ روز قبل از عادت
/// سردرد و روز اول دل‌درد ثبت شده.
({CycleSnapshot cycle, List<DailyLog> logs}) samplePatternData() {
  final starts = [
    DateTime.utc(2026, 5, 4),
    DateTime.utc(2026, 6, 1),
    DateTime.utc(2026, 6, 29),
    DateTime.utc(2026, 7, 27),
  ];
  final logs = <DailyLog>[];
  for (final start in starts) {
    for (var i = 0; i < 5; i++) {
      logs.add(
        DailyLog(
          date: addDays(start, i),
          flow: FlowLevel.medium,
          symptoms: i == 0 ? const {'cramps'} : const {},
        ),
      );
    }
    logs.add(
      DailyLog(
        date: addDays(start, -2),
        symptoms: const {'headache'},
        mood: Mood.irritable,
      ),
    );
  }
  final today = DateTime.utc(2026, 8, 10);
  final cycle = CycleEngine.compute(
    periodDays: [
      for (final log in logs)
        if (log.isPeriodDay) log.date,
    ],
    today: today,
  );
  return (cycle: cycle, logs: logs);
}
