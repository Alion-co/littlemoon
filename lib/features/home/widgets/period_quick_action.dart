import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/glass.dart';

/// ثبت یک‌ضربه‌ای «امروز پریودم» — مهم‌ترین داده برای دقت پیش‌بینی.
class PeriodQuickAction extends ConsumerWidget {
  const PeriodQuickAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final today = ref.watch(todayProvider);
    final log = ref.watch(todayLogProvider);
    final cycle = ref.watch(cycleProvider);

    final isPeriodToday = log?.isPeriodDay ?? false;
    final primary = theme.colorScheme.primary;
    final night = isNightTheme(context);
    final idleColor = night ? Colors.white : primary;

    String label;
    if (isPeriodToday) {
      label = l10n.periodLoggedToday;
    } else if (cycle.isPeriodOngoing) {
      label = l10n.periodContinuesToday;
    } else {
      label = l10n.periodStartedToday;
    }

    Future<void> toggle() async {
      final current = log ?? DailyLog(date: today);
      final next = current.withFlow(isPeriodToday ? null : FlowLevel.medium);
      await ref.read(logsProvider.notifier).save(next);
    }

    return Material(
      color: isPeriodToday
          ? primary
          : primary.withValues(alpha: night ? 0.28 : 0.10),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: toggle,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          child: Row(
            children: [
              Icon(
                isPeriodToday
                    ? Icons.check_circle_rounded
                    : Icons.water_drop_outlined,
                size: 20,
                color: isPeriodToday ? Colors.white : idleColor,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: isPeriodToday ? Colors.white : idleColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (isPeriodToday)
                Text(
                  l10n.undo,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
