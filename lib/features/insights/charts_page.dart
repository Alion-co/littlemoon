import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/localization/calendar_provider.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/charts.dart';
import 'package:little_moon/shared/widgets/moon_card.dart';
import 'package:little_moon/shared/widgets/page_header.dart';
import 'package:little_moon/shared/widgets/section_header.dart';

import 'charts/chart_card.dart';
import 'charts/chart_series.dart';
import 'charts/mood_calendar.dart';

/// نمودارها: طول چرخه‌ها، وزن، خواب، دمای بدن و خلق‌وخو در طول زمان.
class ChartsPage extends ConsumerWidget {
  const ChartsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final calendar = ref.watch(appCalendarProvider);
    final cycle = ref.watch(cycleProvider);
    final logs = ref.watch(logsProvider);
    final today = ref.watch(todayProvider);

    final series = ChartSeries(
      calendar: calendar,
      l10n: l10n,
      cycle: cycle,
      logs: logs.values,
      today: today,
    );
    final cyclePoints = series.cyclePoints;
    final weightPoints = series.weightPoints;
    final sleepPoints = series.sleepPoints;
    final temperaturePoints = series.temperaturePoints;

    final primary = context.scheme.primary;
    final secondary = context.scheme.secondary;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            PageHeader(
              title: l10n.charts,
              onBack: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/insights');
                }
              },
            ),
            const SizedBox(height: 8),
            Text(
              l10n.chartsHint,
              style: context.text.bodySmall?.copyWith(color: context.subtitle),
            ),
            const SizedBox(height: 20),

            ChartCard(
              title: l10n.cycleLength,
              subtitle: l10n.chartCycleSubtitle,
              points: cyclePoints,
              chart: () => SimpleLineChart(
                points: cyclePoints,
                color: primary,
                bars: true,
                reference: cycle.avgCycleLength.toDouble(),
                formatValue: (v) => series.n(v.round()),
                formatDate: series.shortDate,
              ),
            ),
            ChartCard(
              title: l10n.weight,
              subtitle: l10n.chartLastDays(ChartSeries.weightDays),
              points: weightPoints,
              chart: () => SimpleLineChart(
                points: weightPoints,
                color: secondary,
                formatValue: series.one,
                formatDate: series.shortDate,
              ),
            ),
            ChartCard(
              title: l10n.sleep,
              subtitle: l10n.chartSleepSubtitle(ChartSeries.sleepDays),
              points: sleepPoints,
              chart: () => SimpleLineChart(
                points: sleepPoints,
                color: primary,
                formatValue: series.one,
                formatDate: series.shortDate,
              ),
            ),
            ChartCard(
              title: l10n.bodyTemperature,
              subtitle: l10n.chartLastDays(ChartSeries.temperatureDays),
              points: temperaturePoints,
              chart: () => SimpleLineChart(
                points: temperaturePoints,
                color: context.moon?.ovulation ?? secondary,
                formatValue: series.one,
                formatDate: series.shortDate,
              ),
            ),

            SectionHeader(
              title: l10n.moodSummary,
              subtitle: l10n.chartLastDays(ChartSeries.moodDays),
            ),
            const SizedBox(height: 12),
            MoonCard(
              child: MoodCalendar(
                logs: logs,
                today: today,
                days: ChartSeries.moodDays,
                calendar: calendar,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
