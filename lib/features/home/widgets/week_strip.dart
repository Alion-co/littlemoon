import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/localization/calendar_provider.dart';
import 'package:little_moon/core/theme/themes/moon_colors.dart';
import 'package:little_moon/core/utils/day_utils.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/shared/widgets/day_kind_style.dart';
import 'package:little_moon/shared/widgets/glass.dart';

/// نوار هفته‌ی جاری با نشانگر وضعیت هر روز.
class WeekStrip extends ConsumerWidget {
  /// با زدن روی هر روز صدا زده می‌شه.
  final ValueChanged<DateTime>? onDayTap;

  const WeekStrip({super.key, this.onDayTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendar = ref.watch(appCalendarProvider);
    final cycle = ref.watch(cycleProvider);
    final today = ref.watch(todayProvider);

    final weekStart = calendar.startOfWeek(today);
    final onTap = onDayTap;

    final days = [
      for (var i = 0; i < 7; i++)
        _DayData(
          date: addDays(weekStart, i),
          label: calendar.weekdayShort(addDays(weekStart, i).weekday),
          dayText: calendar.n(calendar.dayOfMonth(addDays(weekStart, i))),
          isToday: sameDay(addDays(weekStart, i), today),
          kind: cycle.kindOf(addDays(weekStart, i)),
        ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: homeCardDecoration(context),
      child: Row(
        children: days.map((day) {
          // سهم مساوی برای هر روز تا روی هر عرضی جا بشه
          return Expanded(
            child: _DayItem(
              day: day,
              onTap: onTap == null ? null : () => onTap(day.date),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _DayData {
  final DateTime date;
  final String label;
  final String dayText;
  final bool isToday;
  final DayKind kind;

  const _DayData({
    required this.date,
    required this.label,
    required this.dayText,
    required this.isToday,
    required this.kind,
  });
}

class _DayItem extends StatelessWidget {
  final _DayData day;
  final VoidCallback? onTap;

  const _DayItem({required this.day, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>()!;
    final night = isNightTheme(context);

    // تم شب: روزِ امروز مثل یک ماه کوچکِ درخشان دیده می‌شه
    BoxDecoration todayDecoration;
    Color todayTextColor;
    if (night) {
      todayDecoration = BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          center: Alignment(-0.3, -0.3),
          colors: [Color(0xFFFFFFFF), Color(0xFFCFC9EA)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.45),
            blurRadius: 12,
          ),
        ],
      );
      todayTextColor = const Color(0xFF2A2748);
    } else {
      todayDecoration = BoxDecoration(
        color: theme.colorScheme.primary,
        shape: BoxShape.circle,
      );
      todayTextColor = theme.colorScheme.onPrimary;
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // حرف روز هفته
          Text(
            day.label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: moon.subtitle,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),

          // عدد تاریخ
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 36,
            height: 36,
            decoration: day.isToday
                ? todayDecoration
                : const BoxDecoration(shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(
              day.dayText,
              style: theme.textTheme.titleSmall?.copyWith(
                color: day.isToday
                    ? todayTextColor
                    : theme.colorScheme.onSurface,
                fontWeight: day.isToday ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 6),

          // نقطه‌ی وضعیت
          DayKindDot(kind: day.kind),
        ],
      ),
    );
  }
}
