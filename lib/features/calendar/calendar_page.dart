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
import 'package:little_moon/features/symptoms/daily_log_sheet.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/day_kind_style.dart';
import 'package:little_moon/shared/widgets/month_grid.dart';
import 'package:little_moon/shared/widgets/month_navigator.dart';
import 'package:little_moon/shared/widgets/page_header.dart';
import '../home/widgets/floating_navbar.dart';

enum CalendarViewMode { month, week }

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  CalendarViewMode _viewMode = CalendarViewMode.month;

  /// یک روز از ماهی که الان نمایش داده می‌شه.
  late DateTime _anchor;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    final today = ref.read(todayProvider);
    _anchor = today;
    _selectedDate = today;
  }

  void _shiftMonth(AppCalendar calendar, int direction) {
    final current = calendar.monthOf(_anchor);
    final target =
        direction > 0 ? calendar.next(current) : calendar.previous(current);
    setState(() => _anchor = calendar.firstDayOf(target));
  }

  void _shiftWeek(int direction) {
    setState(() {
      _selectedDate = addDays(_selectedDate, 7 * direction);
      _anchor = _selectedDate;
    });
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      _anchor = date;
    });
  }

  void _goToToday() {
    final today = ref.read(todayProvider);
    setState(() {
      _selectedDate = today;
      _anchor = today;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>();
    final l10n = AppLocalizations.of(context)!;
    final subtitleColor = moon?.subtitle ?? theme.colorScheme.onSurfaceVariant;

    final calendar = ref.watch(appCalendarProvider);
    final cycle = ref.watch(cycleProvider);
    final today = ref.watch(todayProvider);
    final logs = ref.watch(logsProvider);

    final visibleMonth = calendar.monthOf(_anchor);
    final weekStart = calendar.startOfWeek(_selectedDate);

    return PopScope(
      // دکمه‌ی برگشت اندروید: به‌جای خروج از برنامه برگرد به خانه
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) context.go('/home');
      },
      child: Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    // عنوان صفحه
                    PageHeader(
                      title: l10n.calendar,
                      onBack: () => context.go('/home'),
                      trailing: TextButton(
                        onPressed: _goToToday,
                        child: Text(l10n.today),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // تاگل ماه/هفته
                    _ViewModeToggle(
                      mode: _viewMode,
                      onChanged: (mode) => setState(() => _viewMode = mode),
                    ),

                    const SizedBox(height: 20),

                    if (_viewMode == CalendarViewMode.month)
                      MonthNavigator(
                        label: calendar.monthYear(visibleMonth),
                        onPrevious: () => _shiftMonth(calendar, -1),
                        onNext: () => _shiftMonth(calendar, 1),
                      )
                    else
                      MonthNavigator(
                        label: calendar.monthYear(calendar.monthOf(weekStart)),
                        onPrevious: () => _shiftWeek(-1),
                        onNext: () => _shiftWeek(1),
                      ),

                    const SizedBox(height: 16),

                    if (_viewMode == CalendarViewMode.month)
                      MonthGrid(
                        calendar: calendar,
                        month: visibleMonth,
                        today: today,
                        selectedDate: _selectedDate,
                        kindOf: cycle.kindOf,
                        onSelect: _selectDate,
                      )
                    else
                      _WeekView(
                        calendar: calendar,
                        weekStart: weekStart,
                        today: today,
                        selectedDate: _selectedDate,
                        kindOf: cycle.kindOf,
                        onSelect: _selectDate,
                      ),

                    const SizedBox(height: 20),

                    // راهنمای رنگ‌ها
                    _Legend(subtitleColor: subtitleColor),

                    const SizedBox(height: 24),

                    // جزئیات روز انتخاب‌شده
                    _SelectedDayCard(
                      date: _selectedDate,
                      today: today,
                      calendar: calendar,
                      cycle: cycle,
                      log: logs[dayKey(_selectedDate)],
                      onLog: () => showDailyLogSheet(
                        context,
                        ref: ref,
                        date: _selectedDate,
                      ),
                    ),

                    const SizedBox(height: 110),
                  ],
                ),
              ),
            ),
            const FloatingNavbar(currentIndex: 1),
          ],
        ),
      ),
      ),
    );
  }
}

/// تاگل بین نمایش ماهانه و هفتگی
class _ViewModeToggle extends StatelessWidget {
  final CalendarViewMode mode;
  final ValueChanged<CalendarViewMode> onChanged;

  const _ViewModeToggle({required this.mode, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ToggleButton(
              label: l10n.month,
              selected: mode == CalendarViewMode.month,
              onTap: () => onChanged(CalendarViewMode.month),
            ),
          ),
          Expanded(
            child: _ToggleButton(
              label: l10n.week,
              selected: mode == CalendarViewMode.week,
              onTap: () => onChanged(CalendarViewMode.week),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ToggleButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: selected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

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
    final moon = theme.extension<MoonColors>();
    final subtitleColor = moon?.subtitle ?? theme.colorScheme.onSurfaceVariant;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
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
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: subtitleColor,
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
                        ? theme.colorScheme.primary
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: isToday && !isSelected
                        ? Border.all(
                            color: theme.colorScheme.primary,
                            width: 1.2,
                          )
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    calendar.n(calendar.dayOfMonth(date)),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: isSelected
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurface,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
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
  final Color subtitleColor;

  const _Legend({required this.subtitleColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    Widget item(DayKind kind, String label) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DayKindDot(kind: kind, size: 8),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(color: subtitleColor),
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
    final moon = theme.extension<MoonColors>();
    final l10n = AppLocalizations.of(context)!;
    final subtitleColor = moon?.subtitle ?? theme.colorScheme.onSurfaceVariant;

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
        details.add(
          '${l10n.sleep}: ${context.n(Labels.sleep(l10n, sleep))}',
        );
      }
      for (final id in entry.symptoms) {
        details.add(Labels.symptom(l10n, id));
      }
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
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
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      statusText,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: subtitleColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isFuture)
                Material(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: onLog,
                    borderRadius: BorderRadius.circular(16),
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
                      color: theme.colorScheme.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      detail,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
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
              style: theme.textTheme.bodySmall?.copyWith(
                color: subtitleColor,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
