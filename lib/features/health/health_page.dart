import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/localization/calendar_provider.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/themes/moon_colors.dart';
import 'package:little_moon/core/utils/day_utils.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/dialogs.dart';
import 'package:little_moon/shared/widgets/moon_card.dart';
import 'package:little_moon/shared/widgets/page_header.dart';
import 'package:little_moon/shared/widgets/section_header.dart';
import 'package:little_moon/shared/widgets/tab_scaffold.dart';

const _waterGoal = 8;

class HealthPage extends ConsumerWidget {
  const HealthPage({super.key});

  List<String> _phaseTips(AppLocalizations l10n, CyclePhase? phase) {
    switch (phase) {
      case CyclePhase.menstrual:
        return [l10n.tipMenstrual1, l10n.tipMenstrual2, l10n.tipMenstrual3];
      case CyclePhase.follicular:
        return [l10n.tipFollicular1, l10n.tipFollicular2, l10n.tipFollicular3];
      case CyclePhase.ovulation:
        return [l10n.tipOvulation1, l10n.tipOvulation2, l10n.tipOvulation3];
      case CyclePhase.luteal:
        return [l10n.tipLuteal1, l10n.tipLuteal2, l10n.tipLuteal3];
      case null:
        return [l10n.tipGeneral1, l10n.tipGeneral2, l10n.tipGeneral3];
    }
  }

  String _phaseAbout(AppLocalizations l10n, CyclePhase? phase) {
    switch (phase) {
      case CyclePhase.menstrual:
        return l10n.aboutMenstrual;
      case CyclePhase.follicular:
        return l10n.aboutFollicular;
      case CyclePhase.ovulation:
        return l10n.aboutOvulation;
      case CyclePhase.luteal:
        return l10n.aboutLuteal;
      case null:
        return l10n.aboutNoData;
    }
  }

  /// عدد اعشاری رو از ورودی کاربر می‌خونه (رقم فارسی و ممیز هم قبوله).
  double? _parseNumber(String raw) {
    final normalized = toLatinDigits(raw).replaceAll(',', '.').trim();
    if (normalized.isEmpty) return null;
    return double.tryParse(normalized);
  }

  Future<void> _editWeight(
    BuildContext context,
    WidgetRef ref,
    DailyLog log,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final current = log.weightKg;
    final input = await showTextInputDialog(
      context: context,
      title: l10n.weight,
      initialValue: current == null ? '' : Labels.decimal(current),
      hint: l10n.weightHint,
      suffix: l10n.kg,
      maxLength: 6,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
    if (input == null) return;

    final value = _parseNumber(input);
    if (input.trim().isNotEmpty && (value == null || value < 20 || value > 300)) {
      if (context.mounted) showAppSnackBar(context, l10n.invalidValue);
      return;
    }
    await ref.read(logsProvider.notifier).save(log.withWeight(value));
  }

  Future<void> _editTemperature(
    BuildContext context,
    WidgetRef ref,
    DailyLog log,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final current = log.temperatureC;
    final input = await showTextInputDialog(
      context: context,
      title: l10n.bodyTemperature,
      initialValue: current == null ? '' : Labels.decimal(current),
      hint: l10n.temperatureHint,
      suffix: '°C',
      maxLength: 5,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
    if (input == null) return;

    final value = _parseNumber(input);
    if (input.trim().isNotEmpty && (value == null || value < 34 || value > 42)) {
      if (context.mounted) showAppSnackBar(context, l10n.invalidValue);
      return;
    }
    await ref.read(logsProvider.notifier).save(log.withTemperature(value));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>();
    final l10n = AppLocalizations.of(context)!;
    final subtitleColor = moon?.subtitle ?? theme.colorScheme.onSurfaceVariant;

    final cycle = ref.watch(cycleProvider);
    final calendar = ref.watch(appCalendarProvider);
    final today = ref.watch(todayProvider);
    final logs = ref.watch(logsProvider);
    final todayLog = logs[dayKey(today)] ?? DailyLog(date: today);

    final phase = cycle.phase;
    final water = todayLog.waterGlasses ?? 0;

    // آخرین وزن و دمای ثبت‌شده + میانگین خواب ۷ روز اخیر
    DailyLog? lastWeight;
    DailyLog? lastTemperature;
    var sleepSum = 0;
    var sleepCount = 0;
    for (final log in logs.values) {
      if (log.weightKg != null &&
          (lastWeight == null || log.date.isAfter(lastWeight.date))) {
        lastWeight = log;
      }
      if (log.temperatureC != null &&
          (lastTemperature == null ||
              log.date.isAfter(lastTemperature.date))) {
        lastTemperature = log;
      }
      final sleep = log.sleepMinutes;
      final age = daysBetween(log.date, today);
      if (sleep != null && age >= 0 && age < 7) {
        sleepSum += sleep;
        sleepCount++;
      }
    }

    final weightValue = lastWeight?.weightKg;
    final weightDate = lastWeight?.date;
    final temperatureValue = lastTemperature?.temperatureC;
    final temperatureDate = lastTemperature?.date;

    String fertilityText;
    final todayKind = cycle.kindOf(today);
    if (!cycle.hasData) {
      fertilityText = l10n.notEnoughData;
    } else if (todayKind == DayKind.ovulation) {
      fertilityText = l10n.chanceHigh;
    } else if (todayKind == DayKind.fertile) {
      fertilityText = l10n.chanceMedium;
    } else {
      fertilityText = l10n.chanceLow;
    }

    return TabScaffold(
      currentIndex: 3,
      children: [
        const SizedBox(height: 12),
        PageHeader(
          title: l10n.health,
          onBack: () => context.go('/home'),
        ),
        const SizedBox(height: 16),

        // ---------- فاز فعلی ----------
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                moon?.heroStart ?? theme.colorScheme.surface,
                moon?.heroEnd ?? theme.colorScheme.surface,
              ],
            ),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: moon?.phaseBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  phase == null ? l10n.yourBody : Labels.phase(l10n, phase),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: moon?.phaseText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _phaseAbout(l10n, phase),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),

        // ---------- توصیه‌ها ----------
        const SizedBox(height: 28),
        SectionHeader(title: l10n.tipsForYou),
        const SizedBox(height: 14),
        MoonCard(
          child: Column(
            children: [
              for (final tip in _phaseTips(l10n, phase))
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Icon(
                          Icons.lightbulb_outline_rounded,
                          size: 18,
                          color: theme.colorScheme.primary
                              .withValues(alpha: 0.85),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          tip,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),

        // ---------- آب ----------
        const SizedBox(height: 28),
        SectionHeader(title: l10n.todayTracking),
        const SizedBox(height: 14),
        MoonCard(
          child: Row(
            children: [
              Icon(
                Icons.local_drink_outlined,
                color: theme.colorScheme.secondary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.water,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: subtitleColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      context.n(l10n.glassesOfGoal(water, _waterGoal)),
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: water >= _waterGoal ? 1.0 : water / _waterGoal,
                        minHeight: 8,
                        backgroundColor:
                            theme.dividerColor.withValues(alpha: 0.6),
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: water <= 0
                    ? null
                    : () => ref
                        .read(logsProvider.notifier)
                        .save(todayLog.withWater(water - 1)),
                icon: const Icon(Icons.remove_rounded),
              ),
              IconButton.filled(
                onPressed: water >= 20
                    ? null
                    : () => ref
                        .read(logsProvider.notifier)
                        .save(todayLog.withWater(water + 1)),
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // ---------- وزن و دما ----------
        Row(
          children: [
            Expanded(
              child: _MeasureTile(
                icon: Icons.monitor_weight_outlined,
                title: l10n.weight,
                value: weightValue == null
                    ? '—'
                    : context.n('${Labels.decimal(weightValue)} ${l10n.kg}'),
                caption: weightDate == null
                    ? l10n.tapToAdd
                    : calendar.dayMonth(weightDate),
                color: moon?.tintA ?? const Color(0xFFFCEEF4),
                iconColor: theme.colorScheme.primary,
                onTap: () => _editWeight(context, ref, todayLog),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MeasureTile(
                icon: Icons.thermostat_outlined,
                title: l10n.bodyTemperature,
                value: temperatureValue == null
                    ? '—'
                    : context.n('${Labels.decimal(temperatureValue)} °C'),
                caption: temperatureDate == null
                    ? l10n.tapToAdd
                    : calendar.dayMonth(temperatureDate),
                color: moon?.tintB ?? const Color(0xFFF3EEF9),
                iconColor: theme.colorScheme.secondary,
                onTap: () => _editTemperature(context, ref, todayLog),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // ---------- خواب و باروری ----------
        MoonCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Column(
            children: [
              _InfoRow(
                icon: Icons.bedtime_outlined,
                title: l10n.averageSleep7,
                value: sleepCount == 0
                    ? '—'
                    : context.n(
                        Labels.sleep(
                          l10n,
                          // گرد کردن به نزدیک‌ترین ۵ دقیقه
                          ((sleepSum / sleepCount) / 5).round() * 5,
                        ),
                      ),
              ),
              Divider(height: 1, color: theme.dividerColor.withValues(alpha: 0.6)),
              _InfoRow(
                icon: Icons.spa_outlined,
                title: l10n.pregnancyChanceToday,
                value: fertilityText,
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
        Text(
          l10n.medicalDisclaimer,
          style: theme.textTheme.bodySmall?.copyWith(
            color: subtitleColor,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 110),
      ],
    );
  }
}

class _MeasureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String caption;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const _MeasureTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.caption,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>();
    final subtitleColor = moon?.subtitle ?? theme.colorScheme.onSurfaceVariant;

    return Material(
      color: color,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 22,
                    color: iconColor.withValues(alpha: 0.85),
                  ),
                  const Spacer(),
                  Icon(Icons.edit_outlined, size: 16, color: subtitleColor),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: subtitleColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                caption,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: subtitleColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.colorScheme.primary.withValues(alpha: 0.85),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: moon?.subtitle ?? theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
