part of 'calendar_page.dart';

/// نمای هفتگی
class _WeekView extends StatelessWidget {
  final AppCalendar calendar;
  final DateTime weekStart;
  final DateTime today;
  final DateTime selectedDate;
  final DayKind Function(DateTime date) kindOf;
  final ValueChanged<DateTime> onSelect;

  const _WeekView({
    required this.calendar,
    required this.weekStart,
    required this.today,
    required this.selectedDate,
    required this.kindOf,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: context.scheme.surface,
        borderRadius: AppRadius.br24,
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: List.generate(7, (i) {
          final date = addDays(weekStart, i);
          final isToday = sameDay(date, today);
          final isSelected = sameDay(date, selectedDate);

          return Expanded(
            child: GestureDetector(
              onTap: () => onSelect(date),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    calendar.weekdayShort(date.weekday),
                    style: context.text.labelMedium?.copyWith(
                      color: context.subtitle,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? context.scheme.primary
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: isToday && !isSelected
                          ? Border.all(
                              color: context.scheme.primary,
                              width: 1.2,
                            )
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      calendar.n(calendar.dayOfMonth(date)),
                      style: context.text.titleSmall?.copyWith(
                        color: isSelected
                            ? context.scheme.onPrimary
                            : context.scheme.onSurface,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  DayKindDot(kind: kindOf(date)),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// راهنمای رنگ نشانگرها
class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    Widget item(DayKind kind, String label) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DayKindDot(kind: kind, size: 8),
          const SizedBox(width: 6),
          Text(
            label,
            style: context.text.labelSmall?.copyWith(color: context.subtitle),
          ),
        ],
      );
    }

    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        item(DayKind.period, l10n.period),
        item(DayKind.predictedPeriod, l10n.predicted),
        item(DayKind.fertile, l10n.fertile),
        item(DayKind.ovulation, l10n.ovulation),
      ],
    );
  }
}

/// کارت جزئیات روز انتخاب‌شده
class _SelectedDayCard extends StatelessWidget {
  final DateTime date;
  final DateTime today;
  final AppCalendar calendar;
  final CycleSnapshot cycle;
  final DailyLog? log;
  final VoidCallback onLog;

  const _SelectedDayCard({
    required this.date,
    required this.today,
    required this.calendar,
    required this.cycle,
    required this.log,
    required this.onLog,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final kind = cycle.kindOf(date);
    final isFuture = date.isAfter(today);
    final entry = log;
    final cycleDay = cycle.cycleDayOf(date);

    final statusParts = <String>[
      if (kind != DayKind.none) Labels.dayKind(l10n, kind),
      if (cycleDay != null) context.n(l10n.cycleDayShort(cycleDay)),
    ];
    final statusText = statusParts.isEmpty
        ? (entry == null ? l10n.noDataLogged : l10n.dataLogged)
        : statusParts.join(' · ');

    final details = <String>[];
    if (entry != null) {
      final flow = entry.flow;
      final mood = entry.mood;
      final pain = entry.pain;
      final energy = entry.energy;
      final sleep = entry.sleepMinutes;
      if (flow != null) {
        details.add('${l10n.flow}: ${Labels.flow(l10n, flow)}');
      }
      if (mood != null) {
        details.add('${l10n.mood}: ${Labels.mood(l10n, mood)}');
      }
      if (pain != null) {
        details.add('${l10n.pain}: ${Labels.pain(l10n, pain)}');
      }
      if (energy != null) {
        details.add('${l10n.energy}: ${Labels.energy(l10n, energy)}');
      }
      if (sleep != null) {
        details.add('${l10n.sleep}: ${context.n(Labels.sleep(l10n, sleep))}');
      }
      for (final id in entry.symptoms) {
        details.add(Labels.symptom(l10n, id));
      }
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.scheme.surface,
        borderRadius: AppRadius.br24,
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      calendar.dayMonthYear(date),
                      style: context.text.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      statusText,
                      style: context.text.bodySmall?.copyWith(
                        color: context.subtitle,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isFuture)
                Material(
                  color: context.scheme.primary,
                  borderRadius: AppRadius.br16,
                  child: InkWell(
                    onTap: onLog,
                    borderRadius: AppRadius.br16,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            entry == null
                                ? Icons.add_rounded
                                : Icons.edit_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            entry == null ? l10n.logButton : l10n.edit,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          if (details.isNotEmpty) ...[
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final detail in details)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: context.scheme.primary.withValues(alpha: 0.08),
                      borderRadius: AppRadius.br14,
                    ),
                    child: Text(
                      detail,
                      style: context.text.labelMedium?.copyWith(
                        color: context.scheme.onSurface,
                      ),
                    ),
                  ),
              ],
            ),
          ],
          if (entry != null && entry.note.trim().isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              entry.note.trim(),
              style: context.text.bodySmall?.copyWith(
                color: context.subtitle,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
