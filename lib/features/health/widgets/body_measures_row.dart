import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/domain/engine/health_summary.dart';
import 'package:little_moon/features/health/measure_editor.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/stat_tile.dart';

/// دو کاشی‌ی «وزن» و «دمای بدن» (لمس = ثبت/ویرایش برای امروز).
class BodyMeasuresRow extends ConsumerWidget {
  final HealthSummary summary;
  final DailyLog todayLog;
  final AppCalendar calendar;

  const BodyMeasuresRow({
    super.key,
    required this.summary,
    required this.todayLog,
    required this.calendar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final weight = summary.weightKg;
    final weightDate = summary.weightDate;
    final temperature = summary.temperatureC;
    final temperatureDate = summary.temperatureDate;

    return Row(
      children: [
        Expanded(
          child: StatTile(
            icon: Icons.monitor_weight_outlined,
            title: l10n.weight,
            value: weight == null
                ? '—'
                : context.n('${Labels.decimal(weight)} ${l10n.kg}'),
            caption: weightDate == null
                ? l10n.tapToAdd
                : calendar.dayMonth(weightDate),
            color: context.tintA,
            iconColor: context.scheme.primary,
            onTap: () => MeasureEditor.editWeight(context, ref, todayLog),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatTile(
            icon: Icons.thermostat_outlined,
            title: l10n.bodyTemperature,
            value: temperature == null
                ? '—'
                : context.n('${Labels.decimal(temperature)} °C'),
            caption: temperatureDate == null
                ? l10n.tapToAdd
                : calendar.dayMonth(temperatureDate),
            color: context.tintB,
            iconColor: context.scheme.secondary,
            onTap: () => MeasureEditor.editTemperature(context, ref, todayLog),
          ),
        ),
      ],
    );
  }
}
