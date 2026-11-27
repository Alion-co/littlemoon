import 'package:pdf/widgets.dart' as pw;

import '../../core/localization/labels.dart';
import '../../core/utils/app_calendar.dart';
import '../../l10n/generated/app_localizations.dart';
import '../engine/cycle_engine.dart';
import 'doctor_report_kit.dart';

/// بخش‌های دیتامحور گزارش پزشک: خلاصه‌ی چرخه و جدول چرخه‌ها.
abstract final class ReportSections {
  /// ردیف‌های «خلاصه»؛ اگه داده‌ای نیست فقط یک پیام خالی.
  static List<pw.Widget> summaryRows({
    required ReportKit kit,
    required AppLocalizations l10n,
    required AppCalendar calendar,
    required CycleSnapshot cycle,
  }) {
    final n = calendar.n;
    final text = kit.text;
    final keyValue = kit.keyValue;
    final days = l10n.days;
    String daysText(int value) => n('$value $days');

    final summary = <pw.Widget>[];
    if (!cycle.hasData) {
      summary.add(text(l10n.insightsEmpty, color: ReportKit.muted));
    } else {
      summary
        ..add(keyValue(l10n.averageCycle, daysText(cycle.avgCycleLength)))
        ..add(keyValue(l10n.averagePeriod, daysText(cycle.avgPeriodLength)));
      final minCycle = cycle.minCycleLength;
      final maxCycle = cycle.maxCycleLength;
      if (minCycle != null && maxCycle != null) {
        summary.add(
          keyValue(
            l10n.reportCycleRange,
            n(l10n.reportMinMax(minCycle, maxCycle)),
          ),
        );
      }
      summary
        ..add(
          keyValue(l10n.regularity, Labels.regularity(l10n, cycle.regularity)),
        )
        ..add(keyValue(l10n.cyclesTracked, n(cycle.cycles.length)));

      final lastStart = cycle.lastPeriodStart;
      if (lastStart != null) {
        summary.add(
          keyValue(l10n.reportLastPeriod, calendar.dayMonthYear(lastStart)),
        );
      }

      final earliest = cycle.nextPeriodEarliest;
      final latest = cycle.nextPeriodLatest;
      if (cycle.daysLate > 0) {
        summary.add(
          keyValue(l10n.nextPeriod, n(Labels.latePeriod(l10n, cycle.daysLate))),
        );
      } else if (earliest != null && latest != null) {
        summary.add(
          keyValue(
            l10n.nextPeriod,
            Labels.dateRange(l10n, calendar, earliest, latest),
          ),
        );
      }
    }

    return summary;
  }

  /// ردیف‌های جدول چرخه‌ها: جدیدترین بالا.
  static List<List<String>> cycleRows({
    required AppLocalizations l10n,
    required AppCalendar calendar,
    required CycleSnapshot cycle,
    required int maxRows,
  }) {
    final n = calendar.n;
    final rows = <List<String>>[];
    if (cycle.hasData) {
      final last = cycle.periods.last;
      rows.add([
        calendar.dayMonthYear(last.start),
        l10n.reportInProgress,
        n(last.length),
      ]);
      final records = cycle.cycles.reversed.take(maxRows - 1);
      for (final record in records) {
        rows.add([
          calendar.dayMonthYear(record.start),
          record.counted ? n(record.length) : n('${record.length}*'),
          n(record.periodLength),
        ]);
      }
    }
    return rows;
  }
}
