import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/localization/calendar_provider.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/theme_context.dart';
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
import 'package:little_moon/shared/widgets/floating_navbar.dart';

import 'year_view.dart';

part 'calendar_toggle.dart';
part 'calendar_views.dart';

enum CalendarViewMode { month, week, year }

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
    final target = direction > 0
        ? calendar.next(current)
        : calendar.previous(current);
    setState(() => _anchor = calendar.firstDayOf(target));
  }

  void _shiftYear(AppCalendar calendar, int direction) {
    final year = calendar.yearOf(_anchor) + direction;
    setState(() => _anchor = calendar.firstDayOf(CalMonth(year, 1)));
  }

  void _openMonth(AppCalendar calendar, CalMonth month) {
    setState(() {
      _viewMode = CalendarViewMode.month;
      _anchor = calendar.firstDayOf(month);
    });
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
    final l10n = AppLocalizations.of(context)!;

    final calendar = ref.watch(appCalendarProvider);
    final cycle = ref.watch(cycleProvider);
    final today = ref.watch(todayProvider);
    final selectedLog = ref.watch(
      logsProvider.select((logs) => logs[dayKey(_selectedDate)]),
    );

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

                      if (_viewMode == CalendarViewMode.year)
                        MonthNavigator(
                          label: calendar.n(calendar.yearOf(_anchor)),
                          onPrevious: () => _shiftYear(calendar, -1),
                          onNext: () => _shiftYear(calendar, 1),
                        )
                      else if (_viewMode == CalendarViewMode.month)
                        MonthNavigator(
                          label: calendar.monthYear(visibleMonth),
                          onPrevious: () => _shiftMonth(calendar, -1),
                          onNext: () => _shiftMonth(calendar, 1),
                        )
                      else
                        MonthNavigator(
                          label: calendar.monthYear(
                            calendar.monthOf(weekStart),
                          ),
                          onPrevious: () => _shiftWeek(-1),
                          onNext: () => _shiftWeek(1),
                        ),

                      const SizedBox(height: 16),

                      if (_viewMode == CalendarViewMode.year)
                        YearView(
                          calendar: calendar,
                          year: calendar.yearOf(_anchor),
                          today: today,
                          kindOf: cycle.kindOf,
                          onMonthTap: (month) => _openMonth(calendar, month),
                        )
                      else if (_viewMode == CalendarViewMode.month)
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
                      const _Legend(),

                      const SizedBox(height: 24),

                      // جزئیات روز انتخاب‌شده (در نمای سالانه لازم نیست)
                      if (_viewMode != CalendarViewMode.year)
                        _SelectedDayCard(
                          date: _selectedDate,
                          today: today,
                          calendar: calendar,
                          cycle: cycle,
                          log: selectedLog,
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
              const FloatingNavbar(currentIndex: 0),
            ],
          ),
        ),
      ),
    );
  }
}
