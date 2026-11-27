import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/domain/services/reminder_service.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';

String reminderText(AppLocalizations l10n, AppReminder reminder) {
  switch (reminder.type) {
    case ReminderType.periodSoon:
      return reminder.days == 1
          ? l10n.reminderPeriodTomorrow
          : l10n.reminderPeriodSoon(reminder.days);
    case ReminderType.periodToday:
      return l10n.reminderPeriodToday;
    case ReminderType.periodLate:
      return Labels.latePeriod(l10n, reminder.days);
    case ReminderType.fertileSoon:
      return l10n.reminderFertileSoon;
    case ReminderType.fertileToday:
      return l10n.reminderFertileToday;
    case ReminderType.ovulationToday:
      return l10n.reminderOvulationToday;
    case ReminderType.logToday:
      return l10n.reminderLogToday;
    case ReminderType.patternSoon:
      return l10n.reminderPatternSoon(
        Labels.patternNames(l10n, reminder.patterns),
      );
  }
}

IconData reminderIcon(ReminderType type) {
  switch (type) {
    case ReminderType.periodSoon:
    case ReminderType.periodToday:
    case ReminderType.periodLate:
      return Icons.water_drop_outlined;
    case ReminderType.fertileSoon:
    case ReminderType.fertileToday:
      return Icons.spa_outlined;
    case ReminderType.ovulationToday:
      return Icons.egg_outlined;
    case ReminderType.logToday:
      return Icons.edit_outlined;
    case ReminderType.patternSoon:
      return Icons.lightbulb_outline;
  }
}

/// لیست یادآورهای امروز (زنگوله‌ی بالای صفحه‌ی خانه).
Future<void> showRemindersSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(borderRadius: AppRadius.sheetTop),
    builder: (sheetContext) => const _RemindersSheet(),
  );
}

class _RemindersSheet extends ConsumerWidget {
  const _RemindersSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final reminders = ref.watch(remindersProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.dividerColor,
                borderRadius: AppRadius.br4,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.reminders,
            style: context.text.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.scheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          if (reminders.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  l10n.noReminders,
                  style: context.text.bodyMedium?.copyWith(
                    color: context.subtitle,
                  ),
                ),
              ),
            )
          else
            for (final reminder in reminders)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: AppRadius.br18,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        reminderIcon(reminder.type),
                        size: 20,
                        color: context.scheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          context.n(reminderText(l10n, reminder)),
                          style: context.text.bodyMedium?.copyWith(
                            color: context.scheme.onSurface,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
