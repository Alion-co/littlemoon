import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/data/repositories/cycle_tags_repository.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/bar_row.dart';
import 'package:little_moon/shared/widgets/dialogs.dart';
import 'package:little_moon/shared/widgets/moon_card.dart';

class HistoryCard extends ConsumerWidget {
  final CycleSnapshot cycle;
  final AppCalendar calendar;

  const HistoryCard({super.key, required this.cycle, required this.calendar});

  /// علامت «چرخه‌ی غیرعادی» رو بعد از تأیید روشن/خاموش می‌کنه.
  Future<void> _toggleUnusual(
    BuildContext context,
    WidgetRef ref,
    CycleRecord record,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showConfirmDialog(
      context: context,
      title: l10n.unusualCycle,
      message: record.excluded
          ? l10n.unusualCycleUndoHint
          : l10n.unusualCycleHint,
      confirmLabel: record.excluded ? l10n.unmarkUnusual : l10n.markUnusual,
    );
    if (!confirmed) return;
    await ref
        .read(unusualCyclesProvider.notifier)
        .setUnusual(record.start, !record.excluded);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final all = cycle.cycles;
    final recent = all.length > 8 ? all.sublist(all.length - 8) : all;

    if (recent.isEmpty) {
      return MoonCard(
        child: Text(
          l10n.historyEmpty,
          style: context.text.bodyMedium?.copyWith(
            color: context.subtitle,
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
            BarRow(
              label: calendar.dayMonth(record.start),
              labelWidth: 86,
              labelColor: context.subtitle,
              factor: record.length / longest,
              barHeight: 12,
              color: record.excluded
                  ? context.scheme.secondary.withValues(alpha: 0.5)
                  : record.valid
                  ? context.scheme.primary.withValues(alpha: 0.75)
                  : theme.dividerColor,
              extra: SizedBox(
                width: 38,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (cycle.bbtOvulationFor(record.start) != null)
                      Icon(
                        Icons.egg_outlined,
                        size: 14,
                        color:
                            context.moon?.ovulation ?? context.scheme.secondary,
                      ),
                    if (record.excluded)
                      Icon(
                        Icons.flag_outlined,
                        size: 14,
                        color: context.scheme.secondary,
                      ),
                  ],
                ),
              ),
              valueText: context.n('${record.length} ${l10n.days}'),
              valueWidth: 64,
              onTap: record.valid
                  ? () => _toggleUnusual(context, ref, record)
                  : null,
            ),
          const SizedBox(height: 6),
          Text(
            l10n.historyTapHint,
            style: context.text.bodySmall?.copyWith(
              color: context.subtitle,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
