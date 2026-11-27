import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/localization/locale_provider.dart';
import 'package:little_moon/core/theme/theme_provider.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/data/models/app_settings.dart';
import 'package:little_moon/data/repositories/settings_repository.dart';
import 'package:little_moon/domain/services/app_lock.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/designed_by.dart';

import 'settings_widgets.dart';

/// صفحه‌ی اصلی تنظیمات: فقط فهرست بخش‌ها. هر بخش صفحه‌ی خودش رو داره
/// تا همه‌چیز یک‌جا و شلوغ نباشه.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  /// تعداد یادآورهای روشن (برای توضیح زیر «یادآورها»).
  static int _activeReminders(AppSettings s) => [
    s.periodReminder,
    s.lateReminder,
    s.fertileReminder,
    s.ovulationReminder,
    s.dailyLogReminder,
    s.pillReminder,
  ].where((on) => on).length;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    final settings = ref.watch(settingsProvider);
    final themeMode = ref.watch(themeProvider);
    final language = ref.watch(localeProvider).languageCode;
    final lock = ref.watch(appLockProvider);

    final appearance = [
      Labels.theme(l10n, themeMode),
      appLanguages[language] ?? language,
      settings.calendarType == CalendarType.jalali
          ? l10n.calendarJalali
          : l10n.calendarGregorian,
    ].join(' · ');

    return SettingsScaffold(
      title: l10n.settings,
      fallbackRoute: '/home',
      navIndex: 4,
      // امضای سازنده همیشه پایین صفحه
      footer: const DesignedBy(),
      children: [
        const SizedBox(height: 8),
        SettingsGroup(
          children: [
            SettingsTile(
              icon: Icons.palette_outlined,
              title: l10n.settingsAppearance,
              subtitle: appearance,
              showChevron: true,
              onTap: () => context.push('/settings/appearance'),
            ),
            SettingsTile(
              icon: Icons.notifications_none_rounded,
              title: l10n.reminders,
              subtitle: context.n(
                l10n.remindersOnCount(_activeReminders(settings)),
              ),
              showChevron: true,
              onTap: () => context.push('/settings/reminders'),
            ),
            SettingsTile(
              icon: Icons.lock_outline_rounded,
              title: l10n.privacySection,
              subtitle: lock.enabled
                  ? l10n.appLockStatusOn
                  : l10n.appLockStatusOff,
              showChevron: true,
              onTap: () => context.push('/settings/privacy'),
            ),
            SettingsTile(
              icon: Icons.cloud_outlined,
              title: l10n.dataAndBackup,
              subtitle: l10n.settingsDataSubtitle,
              showChevron: true,
              onTap: () => context.push('/settings/data'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SettingsGroup(
          children: [
            SettingsTile(
              icon: Icons.info_outline_rounded,
              title: l10n.aboutDeveloper,
              showChevron: true,
              onTap: () => context.push('/about'),
            ),
          ],
        ),
      ],
    );
  }
}
