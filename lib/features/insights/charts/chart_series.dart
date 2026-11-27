import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/core/utils/day_utils.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/charts.dart';

/// نقطه‌های هر نمودار + قالب‌بندی عددها و تاریخ‌ها (رقم فارسی/لاتین).
class ChartSeries {
  /// چند روز اخیر در هر نمودار نشون داده می‌شه.
  static const weightDays = 180;
  static const sleepDays = 30;
  static const temperatureDays = 60;
  static const moodDays = 35;

  /// حداکثر تعداد چرخه‌ی نشون‌داده‌شده.
  static const maxCycles = 12;

  final AppCalendar calendar;
  final AppLocalizations l10n;
  final CycleSnapshot cycle;
  final Iterable<DailyLog> logs;
  final DateTime today;

  const ChartSeries({
    required this.calendar,
    required this.l10n,
    required this.cycle,
    required this.logs,
    required this.today,
  });

  String n(Object v) => calendar.n(v);
  String one(double v) => n(Labels.decimal(v));
  String shortDate(DateTime d) => calendar.dayMonth(d);

  /// ثبت‌های [days] روز اخیر به ترتیب تاریخ.
  List<DailyLog> recent(int days) {
    return [
      for (final log in logs)
        if (daysBetween(log.date, today) >= 0 &&
            daysBetween(log.date, today) < days)
          log,
    ]..sort((a, b) => a.date.compareTo(b.date));
  }

  List<ChartPoint> get cyclePoints {
    final valid = cycle.cycles.where((c) => c.valid).toList();
    final recentCycles = valid.length > maxCycles
        ? valid.sublist(valid.length - maxCycles)
        : valid;
    return [
      for (final c in recentCycles)
        ChartPoint(
          c.start,
          c.length.toDouble(),
          '${shortDate(c.start)} · ${n('${c.length} ${l10n.days}')}',
        ),
    ];
  }

  List<ChartPoint> get weightPoints => [
    for (final log in recent(weightDays))
      if (log.weightKg != null)
        ChartPoint(
          log.date,
          log.weightKg!,
          '${shortDate(log.date)} · ${one(log.weightKg!)} ${l10n.kg}',
        ),
  ];

  List<ChartPoint> get sleepPoints => [
    for (final log in recent(sleepDays))
      if (log.sleepMinutes != null)
        ChartPoint(
          log.date,
          log.sleepMinutes! / 60,
          '${shortDate(log.date)} · '
          '${n(Labels.sleep(l10n, log.sleepMinutes!))}',
        ),
  ];

  List<ChartPoint> get temperaturePoints => [
    for (final log in recent(temperatureDays))
      if (log.temperatureC != null)
        ChartPoint(
          log.date,
          log.temperatureC!,
          '${shortDate(log.date)} · ${one(log.temperatureC!)}°',
        ),
  ];
}
