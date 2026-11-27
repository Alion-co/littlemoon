import 'package:flutter/material.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/moon_card.dart';

class PredictionsCard extends StatelessWidget {
  final CycleSnapshot cycle;
  final AppCalendar calendar;

  const PredictionsCard({
    super.key,
    required this.cycle,
    required this.calendar,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
                style: context.text.bodyMedium?.copyWith(
                  color: context.subtitle,
                ),
              ),
            ),
            Text(
              value,
              style: context.text.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.scheme.onSurface,
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
      // عادت ماهانه‌ی بعدی به‌صورت بازه: «۱۲ تا ۱۶ آبان»
      final earliest = cycle.nextPeriodEarliest;
      final latest = cycle.nextPeriodLatest;
      if (index == 0 && earliest != null && latest != null) {
        return Labels.dateRange(l10n, calendar, earliest, latest);
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
              context.scheme.primary,
              i == 0 ? l10n.nextPeriod : l10n.followingPeriod,
              periodValue(i),
            ),
          if (fertileStart != null && fertileEnd != null)
            row(
              Icons.spa_outlined,
              context.scheme.secondary,
              l10n.fertileWindow,
              '${calendar.dayMonth(fertileStart)} – '
              '${calendar.dayMonth(fertileEnd)}',
            ),
          if (ovulation != null)
            row(
              Icons.egg_outlined,
              context.moon?.ovulation ?? const Color(0xFF7B4DB3),
              l10n.ovulationDay,
              calendar.dayMonth(ovulation),
            ),
        ],
      ),
    );
  }
}
