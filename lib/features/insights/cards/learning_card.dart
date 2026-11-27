import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/moon_card.dart';

/// چیزی که اپ از دمای پایه و چرخه‌های خودِ کاربر یاد گرفته.
class LearningCard extends StatelessWidget {
  final CycleSnapshot cycle;
  final AppCalendar calendar;

  const LearningCard({super.key, required this.cycle, required this.calendar});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final learned = cycle.lutealSource == LutealSource.learned;
    final confirmed = cycle.currentBbtOvulation;

    Widget row(String title, String value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
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

    return MoonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.thermostat_outlined, color: context.scheme.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.bbtLearningTitle,
                  style: context.text.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          row(
            learned ? l10n.lutealPersonal : l10n.lutealDefault,
            context.n('${cycle.lutealLength} ${l10n.days}'),
          ),
          row(
            l10n.bbtThisCycle,
            confirmed == null
                ? l10n.bbtNoShift
                : calendar.dayMonth(confirmed.ovulationDate),
          ),
          if (cycle.bbtRefined) row(l10n.bbtRefinedNote, '✓'),
          if (cycle.unusualCycleCount > 0)
            row(l10n.unusualCyclesCount, context.n(cycle.unusualCycleCount)),
          const SizedBox(height: 6),
          Text(
            learned ? l10n.lutealLearnedHint : l10n.lutealNeedMore,
            style: context.text.bodySmall?.copyWith(
              color: context.subtitle,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
