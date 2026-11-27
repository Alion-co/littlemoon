import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/localization/calendar_provider.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/domain/services/stats_providers.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/moon_card.dart';
import 'package:little_moon/shared/widgets/page_header.dart';
import 'package:little_moon/shared/widgets/section_header.dart';
import 'package:little_moon/shared/widgets/tab_scaffold.dart';

import 'cards/history_card.dart';
import 'cards/learning_card.dart';
import 'cards/predictions_card.dart';
import 'doctor_report_card.dart';
import 'patterns_card.dart';
import 'widgets/charts_link_card.dart';
import 'widgets/overview_stats.dart';
import 'widgets/top_counts_card.dart';

class InsightsPage extends ConsumerWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    final cycle = ref.watch(cycleProvider);
    final calendar = ref.watch(appCalendarProvider);
    final stats = ref.watch(symptomStatsProvider);

    return TabScaffold(
      currentIndex: 1,
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
              style: context.text.bodyMedium?.copyWith(
                color: context.subtitle,
                height: 1.6,
              ),
            ),
          )
        else ...[
          OverviewStats(cycle: cycle),
          const SizedBox(height: 12),
          const ChartsLinkCard(),

          const SizedBox(height: 28),
          SectionHeader(title: l10n.predictions),
          const SizedBox(height: 14),
          PredictionsCard(cycle: cycle, calendar: calendar),

          const SizedBox(height: 12),
          LearningCard(cycle: cycle, calendar: calendar),

          const SizedBox(height: 28),
          SectionHeader(title: l10n.cycleHistory),
          const SizedBox(height: 14),
          HistoryCard(cycle: cycle, calendar: calendar),
        ],

        const SizedBox(height: 28),
        SectionHeader(
          title: l10n.patternsTitle,
          subtitle: l10n.patternsSubtitle,
        ),
        const SizedBox(height: 14),
        const PatternsCard(),

        const SizedBox(height: 28),
        const DoctorReportCard(),

        const SizedBox(height: 28),
        SectionHeader(title: l10n.topSymptoms, subtitle: l10n.last90Days),
        const SizedBox(height: 14),
        TopCountsCard<String>(
          entries: stats.symptoms,
          labelOf: (id) => Labels.symptom(l10n, id),
          emptyText: l10n.noSymptomsLogged,
          color: context.scheme.primary,
          limit: 6,
        ),

        const SizedBox(height: 28),
        SectionHeader(title: l10n.moodSummary, subtitle: l10n.last90Days),
        const SizedBox(height: 14),
        TopCountsCard<Mood>(
          entries: stats.moods,
          labelOf: (mood) => Labels.mood(l10n, mood),
          emptyText: l10n.noMoodLogged,
          color: context.scheme.secondary,
        ),

        const SizedBox(height: 20),
        Text(
          l10n.medicalDisclaimer,
          style: context.text.bodySmall?.copyWith(
            color: context.subtitle,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 110),
      ],
    );
  }
}
