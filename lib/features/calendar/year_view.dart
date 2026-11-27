import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/core/utils/day_utils.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/shared/widgets/day_kind_style.dart';

/// نمای سالانه: دوازده ماه کوچک با رنگ روزهای عادت ماهانه، پیش‌بینی،
/// باروری و تخمک‌گذاری. لمس هر ماه همون ماه رو در نمای ماهانه باز می‌کنه.
class YearView extends StatelessWidget {
  final AppCalendar calendar;
  final int year;
  final DateTime today;
  final DayKind Function(DateTime date) kindOf;
  final ValueChanged<CalMonth> onMonthTap;

  const YearView({
    super.key,
    required this.calendar,
    required this.year,
    required this.today,
    required this.kindOf,
    required this.onMonthTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 10.0;
        // روی گوشی سه ستون، روی صفحه‌های پهن‌تر چهار ستون
        final columns = constraints.maxWidth > 480 ? 4 : 3;
        final width = (constraints.maxWidth - gap * (columns - 1)) / columns;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (var month = 1; month <= 12; month++)
              SizedBox(
                width: width,
                child: _MiniMonth(
                  calendar: calendar,
                  month: CalMonth(year, month),
                  today: today,
                  kindOf: kindOf,
                  onTap: () => onMonthTap(CalMonth(year, month)),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _MiniMonth extends StatelessWidget {
  final AppCalendar calendar;
  final CalMonth month;
  final DateTime today;
  final DayKind Function(DateTime date) kindOf;
  final VoidCallback onTap;

  const _MiniMonth({
    required this.calendar,
    required this.month,
    required this.today,
    required this.kindOf,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final first = calendar.firstDayOf(month);
    final length = calendar.lengthOf(month);
    final leading = (first.weekday - calendar.firstWeekday + 7) % 7;
    final rows = ((leading + length) / 7).ceil();
    final isCurrent = calendar.monthOf(today) == month;

    Widget cell(int index) {
      if (index < 0 || index >= length) return const SizedBox(height: 11);
      final date = addDays(first, index);
      final kind = kindOf(date);
      final color = dayKindColor(context, kind);
      final isToday = sameDay(date, today);

      return SizedBox(
        height: 11,
        child: Center(
          child: Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: switch (kind) {
                DayKind.period => color,
                DayKind.ovulation => color,
                DayKind.fertile => color?.withValues(alpha: 0.45),
                DayKind.predictedPeriod => Colors.transparent,
                DayKind.none => theme.dividerColor.withValues(alpha: 0.9),
              },
              border: kind == DayKind.predictedPeriod && color != null
                  ? Border.all(color: color, width: 1.2)
                  : (isToday
                        ? Border.all(
                            color: context.scheme.onSurface,
                            width: 1.2,
                          )
                        : null),
            ),
          ),
        ),
      );
    }

    return Material(
      color: context.scheme.surface,
      borderRadius: AppRadius.br16,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.br16,
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
          decoration: BoxDecoration(
            borderRadius: AppRadius.br16,
            border: Border.all(
              color: isCurrent
                  ? context.scheme.primary
                  : theme.dividerColor.withValues(alpha: 0.6),
              width: isCurrent ? 1.4 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  calendar.monthName(month.month),
                  style: context.text.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isCurrent
                        ? context.scheme.primary
                        : context.scheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              for (var r = 0; r < rows; r++)
                Row(
                  children: [
                    for (var c = 0; c < 7; c++)
                      Expanded(child: cell(r * 7 + c - leading)),
                  ],
                ),
              // ردیف خالی برای ماه‌های پنج‌هفته‌ای تا کارت‌ها هم‌قد بمونن
              for (var r = rows; r < 6; r++) const SizedBox(height: 11),
            ],
          ),
        ),
      ),
    );
  }
}
