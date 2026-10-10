import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/localization/calendar_provider.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/themes/moon_colors.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/core/utils/day_utils.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/moon_card.dart';
import 'package:little_moon/shared/widgets/page_header.dart';
import 'package:little_moon/shared/widgets/section_header.dart';
import 'package:little_moon/shared/widgets/tab_scaffold.dart';

/// بازه‌ای که آمار علائم و خلق‌وخو روی اون حساب می‌شه.
const _statsWindowDays = 90;

class InsightsPage extends ConsumerWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>();
    final l10n = AppLocalizations.of(context)!;
    final subtitleColor = moon?.subtitle ?? theme.colorScheme.onSurfaceVariant;

    final cycle = ref.watch(cycleProvider);
    final calendar = ref.watch(appCalendarProvider);
    final logs = ref.watch(logsProvider);
    final today = ref.watch(todayProvider);

    // شمارش علائم و خلق‌وخو در ۹۰ روز اخیر
    final symptomCounts = <String, int>{};
    final moodCounts = <Mood, int>{};
    for (final log in logs.values) {
      final age = daysBetween(log.date, today);
      if (age < 0 || age > _statsWindowDays) continue;
      for (final id in log.symptoms) {
        symptomCounts[id] = (symptomCounts[id] ?? 0) + 1;
      }
      final mood = log.mood;
      if (mood != null) moodCounts[mood] = (moodCounts[mood] ?? 0) + 1;
    }
    final topSymptoms = symptomCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topMoods = moodCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return TabScaffold(
      currentIndex: 2,
      children: [
        const SizedBox(height: 12),
        PageHeader(
          title: l10n.insightsTitle,
          onBack: () => context.go('/home'),
        ),
        const SizedBox(height: 16),

        if (!cycle.hasData)
          MoonCard(
            child: Text(
              l10n.insightsEmpty,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: subtitleColor,
                height: 1.6,
              ),
            ),
          )
        else ...[
          // ---------- آمار کلی ----------
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  icon: Icons.circle_outlined,
                  title: l10n.averageCycle,
                  value: context.n('${cycle.avgCycleLength} ${l10n.days}'),
                  color: moon?.tintA ?? const Color(0xFFFCEEF4),
                  iconColor: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatTile(
                  icon: Icons.water_drop_outlined,
                  title: l10n.averagePeriod,
                  value: context.n('${cycle.avgPeriodLength} ${l10n.days}'),
                  color: moon?.tintB ?? const Color(0xFFF3EEF9),
                  iconColor: theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  icon: Icons.waves_rounded,
                  title: l10n.regularity,
                  value: Labels.regularity(l10n, cycle.regularity),
                  color: moon?.tintB ?? const Color(0xFFF3EEF9),
                  iconColor: theme.colorScheme.secondary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatTile(
                  icon: Icons.timeline_rounded,
                  title: l10n.cyclesTracked,
                  value: context.n(cycle.cycles.length),
                  color: moon?.tintA ?? const Color(0xFFFCEEF4),
                  iconColor: theme.colorScheme.primary,
                ),
              ),
            ],
          ),

          // ---------- پیش‌بینی ----------
          const SizedBox(height: 28),
          SectionHeader(title: l10n.predictions),
          const SizedBox(height: 14),
          _PredictionsCard(cycle: cycle, calendar: calendar),

          // ---------- تاریخچه‌ی چرخه‌ها ----------
          const SizedBox(height: 28),
          SectionHeader(title: l10n.cycleHistory),
          const SizedBox(height: 14),
          _HistoryCard(cycle: cycle, calendar: calendar),
        ],

        // ---------- علائم پرتکرار ----------
        const SizedBox(height: 28),
        SectionHeader(
          title: l10n.topSymptoms,
          subtitle: l10n.last90Days,
        ),
        const SizedBox(height: 14),
        MoonCard(
          child: topSymptoms.isEmpty
              ? Text(
                  l10n.noSymptomsLogged,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: subtitleColor,
                  ),
                )
              : Column(
                  children: [
                    for (final entry in topSymptoms.take(6))
                      _CountBar(
                        label: Labels.symptom(l10n, entry.key),
                        count: entry.value,
                        maxCount: topSymptoms.first.value,
                        color: theme.colorScheme.primary,
                      ),
                  ],
                ),
        ),

        // ---------- خلق‌وخو ----------
        const SizedBox(height: 28),
        SectionHeader(title: l10n.moodSummary, subtitle: l10n.last90Days),
        const SizedBox(height: 14),
        MoonCard(
          child: topMoods.isEmpty
              ? Text(
                  l10n.noMoodLogged,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: subtitleColor,
                  ),
                )
              : Column(
                  children: [
                    for (final entry in topMoods)
                      _CountBar(
                        label: Labels.mood(l10n, entry.key),
                        count: entry.value,
                        maxCount: topMoods.first.value,
                        color: theme.colorScheme.secondary,
                      ),
                  ],
                ),
        ),

        const SizedBox(height: 20),
        Text(
          l10n.medicalDisclaimer,
          style: theme.textTheme.bodySmall?.copyWith(
            color: subtitleColor,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 110),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final Color iconColor;

  const _StatTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: iconColor.withValues(alpha: 0.85)),
          const SizedBox(height: 14),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: moon?.subtitle ?? theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _PredictionsCard extends StatelessWidget {
  final CycleSnapshot cycle;
  final AppCalendar calendar;

  const _PredictionsCard({required this.cycle, required this.calendar});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>();
    final l10n = AppLocalizations.of(context)!;
    final subtitleColor = moon?.subtitle ?? theme.colorScheme.onSurfaceVariant;

    final ovulation = cycle.nextOvulation;
    final fertileStart = cycle.fertileStart;
    final fertileEnd = cycle.fertileEnd;
    final upcoming = cycle.upcomingPeriods.take(3).toList();

    Widget row(IconData icon, Color color, String title, String value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 18, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: subtitleColor,
                ),
              ),
            ),
            Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    }

    String periodValue(int index) {
      final date = upcoming[index];
      if (index == 0 && cycle.daysLate > 0) {
        return context.n(Labels.latePeriod(l10n, cycle.daysLate));
      }
      return calendar.dayMonth(date);
    }

    return MoonCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          for (var i = 0; i < upcoming.length; i++)
            row(
              Icons.water_drop_outlined,
              theme.colorScheme.primary,
              i == 0 ? l10n.nextPeriod : l10n.followingPeriod,
              periodValue(i),
            ),
          if (fertileStart != null && fertileEnd != null)
            row(
              Icons.spa_outlined,
              theme.colorScheme.secondary,
              l10n.fertileWindow,
              '${calendar.dayMonth(fertileStart)} – '
              '${calendar.dayMonth(fertileEnd)}',
            ),
          if (ovulation != null)
            row(
              Icons.egg_outlined,
              moon?.ovulation ?? const Color(0xFF7B4DB3),
              l10n.ovulationDay,
              calendar.dayMonth(ovulation),
            ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final CycleSnapshot cycle;
  final AppCalendar calendar;

  const _HistoryCard({required this.cycle, required this.calendar});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>();
    final l10n = AppLocalizations.of(context)!;
    final subtitleColor = moon?.subtitle ?? theme.colorScheme.onSurfaceVariant;

    final all = cycle.cycles;
    final recent = all.length > 8 ? all.sublist(all.length - 8) : all;

    if (recent.isEmpty) {
      return MoonCard(
        child: Text(
          l10n.historyEmpty,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: subtitleColor,
            height: 1.6,
          ),
        ),
      );
    }

    var longest = 1;
    for (final record in recent) {
      if (record.length > longest) longest = record.length;
    }

    return MoonCard(
      child: Column(
        children: [
          for (final record in recent.reversed)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                children: [
                  SizedBox(
                    width: 86,
                    child: Text(
                      calendar.dayMonth(record.start),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: subtitleColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: FractionallySizedBox(
                        widthFactor: record.length / longest,
                        child: Container(
                          height: 12,
                          decoration: BoxDecoration(
                            color: record.valid
                                ? theme.colorScheme.primary
                                    .withValues(alpha: 0.75)
                                : theme.dividerColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 64,
                    child: Text(
                      context.n('${record.length} ${l10n.days}'),
                      textAlign: TextAlign.end,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _CountBar extends StatelessWidget {
  final String label;
  final int count;
  final int maxCount;
  final Color color;

  const _CountBar({
    required this.label,
    required this.count,
    required this.maxCount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final factor = maxCount <= 0 ? 0.0 : count / maxCount;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: FractionallySizedBox(
                widthFactor: factor,
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 34,
            child: Text(
              context.n(count),
              textAlign: TextAlign.end,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
