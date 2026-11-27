import 'package:flutter/material.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/domain/engine/health_summary.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/info_row.dart';
import 'package:little_moon/shared/widgets/moon_card.dart';

/// میانگین خواب، شانس بارداری امروز و تخمک‌گذاری تأییدشده با دما.
class HealthSummaryCard extends StatelessWidget {
  final CycleSnapshot cycle;
  final HealthSummary summary;
  final AppCalendar calendar;
  final DateTime today;

  const HealthSummaryCard({
    super.key,
    required this.cycle,
    required this.summary,
    required this.calendar,
    required this.today,
  });

  String _fertilityText(AppLocalizations l10n) {
    if (!cycle.hasData) return l10n.notEnoughData;
    final kind = cycle.kindOf(today);
    if (kind == DayKind.ovulation) return l10n.chanceHigh;
    if (kind == DayKind.fertile) return l10n.chanceMedium;
    return l10n.chanceLow;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final divider = Divider(
      height: 1,
      color: context.theme.dividerColor.withValues(alpha: 0.6),
    );
    final sleep = summary.averageSleepMinutes;
    final confirmed = cycle.currentBbtOvulation;

    return MoonCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        children: [
          InfoRow(
            icon: Icons.bedtime_outlined,
            title: l10n.averageSleep7,
            value: sleep == null ? '—' : context.n(Labels.sleep(l10n, sleep)),
          ),
          divider,
          InfoRow(
            icon: Icons.spa_outlined,
            title: l10n.pregnancyChanceToday,
            value: _fertilityText(l10n),
          ),
          divider,
          InfoRow(
            icon: Icons.thermostat_outlined,
            title: l10n.bbtThisCycle,
            value: confirmed == null
                ? l10n.bbtNoShift
                : calendar.dayMonth(confirmed.ovulationDate),
          ),
        ],
      ),
    );
  }
}
