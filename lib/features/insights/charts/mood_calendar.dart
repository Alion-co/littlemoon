import 'package:flutter/material.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/core/utils/day_utils.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';

/// خلق‌وخوی روزهای اخیر به شکل جدول هفتگی: هر روز آیکون حالش.
/// رنگ فقط کمکیه (خوب/خنثی/سخت)؛ خود آیکون حال رو نشون می‌ده.
class MoodCalendar extends StatelessWidget {
  final Map<String, DailyLog> logs;
  final DateTime today;
  final int days;
  final AppCalendar calendar;

  const MoodCalendar({
    super.key,
    required this.logs,
    required this.today,
    required this.days,
    required this.calendar,
  });

  static Color _tone(ThemeData theme, Mood mood) {
    switch (mood) {
      case Mood.happy:
      case Mood.calm:
        return theme.colorScheme.secondary;
      case Mood.sensitive:
        return theme.colorScheme.onSurface.withValues(alpha: 0.55);
      case Mood.sad:
      case Mood.irritable:
      case Mood.anxious:
        return theme.colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final muted = context.subtitle;

    // از اول هفته‌ای که «days روز قبل» توش افتاده تا آخر هفته‌ی امروز
    final start = calendar.startOfWeek(addDays(today, -(days - 1)));
    final weeks = (daysBetween(start, today) ~/ 7) + 1;

    final rows = <Widget>[
      Row(
        children: [
          for (final weekday in calendar.weekdayOrder)
            Expanded(
              child: Center(
                child: Text(
                  calendar.weekdayShort(weekday),
                  style: context.text.labelSmall?.copyWith(color: muted),
                ),
              ),
            ),
        ],
      ),
      const SizedBox(height: 6),
    ];

    for (var w = 0; w < weeks; w++) {
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: [
              for (var d = 0; d < 7; d++)
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final date = addDays(start, w * 7 + d);
                      if (date.isAfter(today)) {
                        return const SizedBox(height: 30);
                      }
                      final mood = logs[dayKey(date)]?.mood;
                      return Tooltip(
                        message:
                            '${calendar.dayMonth(date)}${mood == null ? '' : ' · ${Labels.mood(l10n, mood)}'}',
                        child: SizedBox(
                          height: 30,
                          child: Center(
                            child: mood == null
                                ? Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: theme.dividerColor,
                                    ),
                                  )
                                : Icon(
                                    Labels.moodIcon(mood),
                                    size: 22,
                                    color: _tone(theme, mood),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      );
    }

    // راهنما: هر حال با آیکون و اسمش
    rows
      ..add(const SizedBox(height: 10))
      ..add(
        Wrap(
          spacing: 12,
          runSpacing: 6,
          children: [
            for (final mood in Mood.values)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Labels.moodIcon(mood),
                    size: 14,
                    color: _tone(theme, mood),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    Labels.mood(l10n, mood),
                    style: context.text.labelSmall?.copyWith(color: muted),
                  ),
                ],
              ),
          ],
        ),
      );

    return Column(children: rows);
  }
}
