import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/data/repositories/settings_repository.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/dialogs.dart';

import 'settings_widgets.dart';

/// یادآورها: چرخه (عادت ماهانه، تأخیر، باروری، تخمک‌گذاری) و روزانه
/// (ثبت روزانه، قرص).
class ReminderSettingsPage extends ConsumerWidget {
  const ReminderSettingsPage({super.key});

  Future<void> _pickDaysBefore(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.read(settingsProvider);
    final value = await showStepperDialog(
      context: context,
      title: l10n.reminderDaysBefore,
      value: settings.periodReminderDays,
      min: 1,
      max: 7,
      unit: l10n.days,
    );
    if (value == null) return;
    await ref
        .read(settingsProvider.notifier)
        .save(ref.read(settingsProvider).copyWith(periodReminderDays: value));
  }

  Future<void> _pickPillTime(BuildContext context, WidgetRef ref) async {
    final settings = ref.read(settingsProvider);
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: settings.pillHour,
        minute: settings.pillMinute,
      ),
    );
    if (picked == null) return;
    await ref
        .read(settingsProvider.notifier)
        .save(
          ref
              .read(settingsProvider)
              .copyWith(pillHour: picked.hour, pillMinute: picked.minute),
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    String two(int v) => v.toString().padLeft(2, '0');

    return SettingsScaffold(
      title: l10n.reminders,
      children: [
        SettingsCaption(l10n.cycleRemindersGroup),
        SettingsGroup(
          children: [
            SettingsSwitchTile(
              icon: Icons.water_drop_outlined,
              title: l10n.reminderPeriodSetting,
              value: settings.periodReminder,
              onChanged: (v) =>
                  notifier.save(settings.copyWith(periodReminder: v)),
            ),
            if (settings.periodReminder)
              SettingsTile(
                icon: Icons.event_outlined,
                title: l10n.reminderDaysBefore,
                value: context.n('${settings.periodReminderDays} ${l10n.days}'),
                showChevron: true,
                onTap: () => _pickDaysBefore(context, ref),
              ),
            SettingsSwitchTile(
              icon: Icons.hourglass_empty_rounded,
              title: l10n.lateReminderSetting,
              value: settings.lateReminder,
              onChanged: (v) =>
                  notifier.save(settings.copyWith(lateReminder: v)),
            ),
            SettingsSwitchTile(
              icon: Icons.spa_outlined,
              title: l10n.reminderFertileSetting,
              value: settings.fertileReminder,
              onChanged: (v) =>
                  notifier.save(settings.copyWith(fertileReminder: v)),
            ),
            SettingsSwitchTile(
              icon: Icons.egg_outlined,
              title: l10n.reminderOvulationSetting,
              value: settings.ovulationReminder,
              onChanged: (v) =>
                  notifier.save(settings.copyWith(ovulationReminder: v)),
            ),
          ],
        ),

        SettingsCaption(l10n.dailyRemindersGroup),
        SettingsGroup(
          children: [
            SettingsSwitchTile(
              icon: Icons.edit_note_rounded,
              title: l10n.reminderLogSetting,
              value: settings.dailyLogReminder,
              onChanged: (v) =>
                  notifier.save(settings.copyWith(dailyLogReminder: v)),
            ),
            SettingsSwitchTile(
              icon: Icons.medication_outlined,
              title: l10n.pillReminder,
              value: settings.pillReminder,
              onChanged: (v) =>
                  notifier.save(settings.copyWith(pillReminder: v)),
            ),
            if (settings.pillReminder)
              SettingsTile(
                icon: Icons.schedule_rounded,
                title: l10n.pillReminderTime,
                value: context.n(
                  '${two(settings.pillHour)}:${two(settings.pillMinute)}',
                ),
                showChevron: true,
                onTap: () => _pickPillTime(context, ref),
              ),
          ],
        ),
        SettingsFootnote(l10n.remindersHint),
      ],
    );
  }
}
