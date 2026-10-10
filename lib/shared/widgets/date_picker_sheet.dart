import 'package:flutter/material.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';

import 'month_grid.dart';
import 'month_navigator.dart';

/// انتخاب تاریخ با تقویم خود برنامه (شمسی/میلادی).
Future<DateTime?> showMoonDatePicker({
  required BuildContext context,
  required AppCalendar calendar,
  required DateTime initialDate,
  required DateTime today,
  required String title,
  DateTime? maxDate,
}) {
  return showModalBottomSheet<DateTime>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (sheetContext) => _DatePickerSheet(
      calendar: calendar,
      initialDate: initialDate,
      today: today,
      title: title,
      maxDate: maxDate,
    ),
  );
}

class _DatePickerSheet extends StatefulWidget {
  final AppCalendar calendar;
  final DateTime initialDate;
  final DateTime today;
  final String title;
  final DateTime? maxDate;

  const _DatePickerSheet({
    required this.calendar,
    required this.initialDate,
    required this.today,
    required this.title,
    required this.maxDate,
  });

  @override
  State<_DatePickerSheet> createState() => _DatePickerSheetState();
}

class _DatePickerSheetState extends State<_DatePickerSheet> {
  late CalMonth _month = widget.calendar.monthOf(widget.initialDate);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final calendar = widget.calendar;
    final limit = widget.maxDate;

    final canGoNext = limit == null ||
        !calendar.firstDayOf(calendar.next(_month)).isAfter(limit);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: theme.dividerColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          MonthNavigator(
            label: calendar.monthYear(_month),
            onPrevious: () =>
                setState(() => _month = calendar.previous(_month)),
            onNext: canGoNext
                ? () => setState(() => _month = calendar.next(_month))
                : null,
          ),
          const SizedBox(height: 8),
          MonthGrid(
            calendar: calendar,
            month: _month,
            today: widget.today,
            selectedDate: widget.initialDate,
            maxDate: limit,
            framed: false,
            kindOf: (_) => DayKind.none,
            onSelect: (date) => Navigator.of(context).pop(date),
          ),
        ],
      ),
    );
  }
}
