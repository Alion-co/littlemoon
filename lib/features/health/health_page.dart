import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/localization/calendar_provider.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/domain/services/stats_providers.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/page_header.dart';
import 'package:little_moon/shared/widgets/section_header.dart';
import 'package:little_moon/shared/widgets/tab_scaffold.dart';

import 'phase_content.dart';
import 'widgets/body_measures_row.dart';
import 'widgets/health_summary_card.dart';
import 'widgets/phase_card.dart';
import 'widgets/tips_card.dart';
import 'widgets/water_card.dart';

class HealthPage extends ConsumerWidget {
  const HealthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    final cycle = ref.watch(cycleProvider);
    final calendar = ref.watch(appCalendarProvider);
    final today = ref.watch(todayProvider);
    final todayLog = ref.watch(todayLogProvider) ?? DailyLog(date: today);
    final summary = ref.watch(healthSummaryProvider);

    return TabScaffold(
      currentIndex: 3,
      children: [
        const SizedBox(height: 12),
        PageHeader(title: l10n.health, onBack: () => context.go('/home')),
        const SizedBox(height: 16),
        PhaseCard(phase: cycle.phase),

        const SizedBox(height: 28),
        SectionHeader(title: l10n.tipsForYou),
        const SizedBox(height: 14),
        TipsCard(tips: PhaseContent.tips(l10n, cycle.phase)),

        const SizedBox(height: 28),
        SectionHeader(title: l10n.todayTracking),
        const SizedBox(height: 14),
        WaterCard(todayLog: todayLog),
        const SizedBox(height: 12),
        BodyMeasuresRow(
          summary: summary,
          todayLog: todayLog,
          calendar: calendar,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.bbtTip,
          style: context.text.bodySmall?.copyWith(
            color: context.subtitle,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 12),
        HealthSummaryCard(
          cycle: cycle,
          summary: summary,
          calendar: calendar,
          today: today,
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
