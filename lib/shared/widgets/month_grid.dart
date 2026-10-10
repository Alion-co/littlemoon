import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/themes/moon_colors.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/core/utils/day_utils.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';

import 'day_kind_style.dart';

/// گرید ماهانه — هم شمسی هم میلادی (بسته به [calendar]).
class MonthGrid extends StatelessWidget {
  final AppCalendar calendar;
  final CalMonth month;
  final DateTime today;
  final DateTime? selectedDate;
  final DayKind Function(DateTime date) kindOf;
  final ValueChanged<DateTime> onSelect;

  /// روزهای بعد از این تاریخ غیرفعال می‌شن.
  final DateTime? maxDate;
  final bool framed;

  const MonthGrid({
    super.key,
    required this.calendar,
    required this.month,
    required this.today,
    required this.kindOf,
    required this.onSelect,
    this.selectedDate,
    this.maxDate,
    this.framed = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>();
    final subtitleColor = moon?.subtitle ?? theme.colorScheme.onSurfaceVariant;

    final firstDay = calendar.firstDayOf(month);
    final daysInMonth = calendar.lengthOf(month);
    final leadingEmpty =
        (firstDay.weekday - calendar.firstWeekday + 7) % 7;
    final rows = ((leadingEmpty + daysInMonth) / 7).ceil();
    final selected = selectedDate;
    final limit = maxDate;

    final grid = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            for (final weekday in calendar.weekdayOrder)
              Expanded(
                child: Center(
                  child: Text(
                    calendar.weekdayShort(weekday),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: subtitleColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        for (var row = 0; row < rows; row++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                for (var col = 0; col < 7; col++)
                  Expanded(
                    child: _buildCell(
                      context,
                      index: row * 7 + col - leadingEmpty,
                      firstDay: firstDay,
                      daysInMonth: daysInMonth,
                      selected: selected,
                      limit: limit,
                    ),
                  ),
              ],
            ),
          ),
      ],
    );

    if (!framed) return grid;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.6)),
      ),
      child: grid,
    );
  }

  Widget _buildCell(
    BuildContext context, {
    required int index,
    required DateTime firstDay,
    required int daysInMonth,
    required DateTime? selected,
    required DateTime? limit,
  }) {
    if (index < 0 || index >= daysInMonth) {
      return const SizedBox(height: 40);
    }

    final date = addDays(firstDay, index);
    final enabled = limit == null || !date.isAfter(limit);

    return _DayCell(
      label: calendar.n(index + 1),
      isToday: sameDay(date, today),
      isSelected: selected != null && sameDay(date, selected),
      enabled: enabled,
      kind: kindOf(date),
      onTap: enabled ? () => onSelect(date) : null,
    );
  }
}

class _DayCell extends StatelessWidget {
  final String label;
  final bool isToday;
  final bool isSelected;
  final bool enabled;
  final DayKind kind;
  final VoidCallback? onTap;

  const _DayCell({
    required this.label,
    required this.isToday,
    required this.isSelected,
    required this.enabled,
    required this.kind,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final isPeriod = kind == DayKind.period;

    Color background = Colors.transparent;
    if (isSelected) {
      background = primary;
    } else if (isPeriod) {
      background = primary.withValues(alpha: 0.16);
    } else if (isToday) {
      background = primary.withValues(alpha: 0.12);
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: background,
                border: isToday && !isSelected
                    ? Border.all(color: primary, width: 1.2)
                    : null,
              ),
              child: Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurface
                          .withValues(alpha: enabled ? 1 : 0.35),
                  fontWeight: (isToday || isSelected)
                      ? FontWeight.bold
                      : FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 2),
            DayKindDot(kind: kind, size: 5),
          ],
        ),
      ),
    );
  }
}
