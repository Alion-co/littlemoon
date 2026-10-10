import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/constants/app_strings.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/app_theme.dart';
import 'package:little_moon/core/theme/theme_mode.dart';
import 'package:little_moon/core/theme/theme_provider.dart';
import 'package:little_moon/core/theme/themes/moon_colors.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/data/repositories/profile_repository.dart';
import 'package:little_moon/data/repositories/settings_repository.dart';
import 'package:little_moon/domain/services/backup_service.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/dialogs.dart';
import 'package:little_moon/shared/widgets/language_picker.dart';
import 'package:little_moon/shared/widgets/moon_card.dart';
import 'package:little_moon/shared/widgets/page_header.dart';
import 'package:little_moon/shared/widgets/section_header.dart';
import 'package:little_moon/shared/widgets/segmented_toggle.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  Future<void> _exportBackup(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final json = BackupService.encode(
      BackupData(
        profile: ref.read(profileProvider),
        settings: ref.read(settingsProvider),
        logs: ref.read(logsProvider),
      ),
    );
    await Clipboard.setData(ClipboardData(text: json));
    if (context.mounted) showAppSnackBar(context, l10n.backupCopied);
  }

  Future<void> _importBackup(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final raw = await showTextInputDialog(
      context: context,
      title: l10n.restoreBackup,
      hint: l10n.restoreHint,
      maxLength: 2000000,
      maxLines: 8,
      keyboardType: TextInputType.multiline,
    );
    if (raw == null || raw.trim().isEmpty) return;

    final data = BackupService.decode(raw);
    if (data == null) {
      if (context.mounted) showAppSnackBar(context, l10n.restoreInvalid);
      return;
    }
    if (!context.mounted) return;

    final confirmed = await showConfirmDialog(
      context: context,
      title: l10n.restoreBackup,
      message: l10n.restoreConfirm,
      confirmLabel: l10n.restore,
    );
    if (!confirmed) return;

    await ref.read(logsProvider.notifier).replaceAll(data.logs);
    await ref
        .read(profileProvider.notifier)
        .save(data.profile.copyWith(onboardingDone: true));
    await ref.read(settingsProvider.notifier).save(data.settings);
    if (context.mounted) showAppSnackBar(context, l10n.restoreDone);
  }

  Future<void> _deleteAll(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showConfirmDialog(
      context: context,
      title: l10n.deleteAllData,
      message: l10n.deleteAllConfirm,
      confirmLabel: l10n.delete,
      destructive: true,
    );
    if (!confirmed) return;

    await ref.read(logsProvider.notifier).clear();
    await ref.read(settingsProvider.notifier).reset();
    await ref.read(profileProvider.notifier).reset();
    if (context.mounted) context.go('/onboarding');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>();
    final l10n = AppLocalizations.of(context)!;
    final subtitleColor = moon?.subtitle ?? theme.colorScheme.onSurfaceVariant;

    final settings = ref.watch(settingsProvider);
    final currentTheme = ref.watch(themeProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);

    Widget divider() => Divider(
          height: 1,
          color: theme.dividerColor.withValues(alpha: 0.6),
        );

    Widget switchRow(String title, bool value, ValueChanged<bool> onChanged) {
      return SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        value: value,
        onChanged: onChanged,
      );
    }

    Widget actionRow(
      IconData icon,
      String title,
      VoidCallback onTap, {
      Color? color,
    }) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              Icon(icon, size: 20, color: color ?? theme.colorScheme.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: color ?? theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            PageHeader(
              title: l10n.settings,
              onBack: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/profile');
                }
              },
            ),
            const SizedBox(height: 16),

            // ---------- زبان ----------
            SectionHeader(title: l10n.language),
            const SizedBox(height: 12),
            const LanguagePicker(),

            // ---------- تقویم ----------
            const SizedBox(height: 24),
            SectionHeader(title: l10n.calendarType),
            const SizedBox(height: 12),
            SegmentedToggle<CalendarType>(
              selected: settings.calendarType,
              options: [
                ToggleOption(
                  value: CalendarType.jalali,
                  label: l10n.calendarJalali,
                ),
                ToggleOption(
                  value: CalendarType.gregorian,
                  label: l10n.calendarGregorian,
                ),
              ],
              onChanged: (type) => settingsNotifier.save(
                settings.copyWith(calendarType: type),
              ),
            ),

            // ---------- تم ----------
            const SizedBox(height: 24),
            SectionHeader(title: l10n.theme),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                // چهار پیش‌نمایش در هر ردیف
                const gap = 10.0;
                final width = (constraints.maxWidth - gap * 3) / 4;

                return Wrap(
                  spacing: gap,
                  runSpacing: 14,
                  children: [
                    for (final mode in AppThemeMode.values)
                      SizedBox(
                        width: width,
                        child: _ThemePreview(
                          mode: mode,
                          label: Labels.theme(l10n, mode),
                          selected: mode == currentTheme,
                          onTap: () => ref
                              .read(themeProvider.notifier)
                              .changeTheme(mode),
                        ),
                      ),
                  ],
                );
              },
            ),

            // ---------- یادآورها ----------
            const SizedBox(height: 24),
            SectionHeader(
              title: l10n.reminders,
              subtitle: l10n.remindersHint,
            ),
            const SizedBox(height: 12),
            MoonCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                children: [
                  switchRow(
                    l10n.reminderPeriodSetting,
                    settings.periodReminder,
                    (value) => settingsNotifier.save(
                      settings.copyWith(periodReminder: value),
                    ),
                  ),
                  if (settings.periodReminder) ...[
                    divider(),
                    InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () async {
                        final value = await showStepperDialog(
                          context: context,
                          title: l10n.reminderDaysBefore,
                          value: settings.periodReminderDays,
                          min: 1,
                          max: 7,
                          unit: l10n.days,
                        );
                        if (value != null) {
                          await settingsNotifier.save(
                            settings.copyWith(periodReminderDays: value),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                l10n.reminderDaysBefore,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                            Text(
                              context.n(
                                '${settings.periodReminderDays} ${l10n.days}',
                              ),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  divider(),
                  switchRow(
                    l10n.reminderFertileSetting,
                    settings.fertileReminder,
                    (value) => settingsNotifier.save(
                      settings.copyWith(fertileReminder: value),
                    ),
                  ),
                  divider(),
                  switchRow(
                    l10n.reminderOvulationSetting,
                    settings.ovulationReminder,
                    (value) => settingsNotifier.save(
                      settings.copyWith(ovulationReminder: value),
                    ),
                  ),
                  divider(),
                  switchRow(
                    l10n.reminderLogSetting,
                    settings.dailyLogReminder,
                    (value) => settingsNotifier.save(
                      settings.copyWith(dailyLogReminder: value),
                    ),
                  ),
                ],
              ),
            ),

            // ---------- داده‌ها ----------
            const SizedBox(height: 24),
            SectionHeader(title: l10n.dataAndBackup, subtitle: l10n.backupHint),
            const SizedBox(height: 12),
            MoonCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                children: [
                  actionRow(
                    Icons.content_copy_rounded,
                    l10n.copyBackup,
                    () => _exportBackup(context, ref),
                  ),
                  divider(),
                  actionRow(
                    Icons.file_download_outlined,
                    l10n.restoreBackup,
                    () => _importBackup(context, ref),
                  ),
                  divider(),
                  actionRow(
                    Icons.delete_outline_rounded,
                    l10n.deleteAllData,
                    () => _deleteAll(context, ref),
                    color: theme.colorScheme.error,
                  ),
                ],
              ),
            ),

            // ---------- درباره ----------
            const SizedBox(height: 24),
            MoonCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: actionRow(
                      Icons.info_outline_rounded,
                      l10n.aboutDeveloper,
                      () => context.push('/about'),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: subtitleColor,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.shield_outlined, size: 16, color: subtitleColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.privacyNote,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: subtitleColor,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                context.n('${AppInfo.appName} ${AppInfo.version}'),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: subtitleColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// پیش‌نمایش کوچک هر تم: یک صفحه‌ی مینیاتوری با رنگ‌های واقعی همون تم.
class _ThemePreview extends StatelessWidget {
  final AppThemeMode mode;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ThemePreview({
    required this.mode,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final preview = AppTheme.getTheme(mode);
    final colors = preview.extension<MoonColors>();
    final scheme = preview.colorScheme;

    final heroStart = colors?.heroStart ?? scheme.surface;
    final heroEnd = colors?.heroEnd ?? scheme.surface;

    Widget bar(Color color, {double height = 9}) {
      return Container(
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 104,
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: preview.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: selected
                        ? theme.colorScheme.primary
                        : theme.dividerColor.withValues(alpha: 0.8),
                    width: selected ? 2 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // کارت بالای صفحه‌ی خانه با حلقه‌ی چرخه
                    Container(
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [heroStart, heroEnd],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: FractionallySizedBox(
                                widthFactor: 0.8,
                                child: bar(scheme.primary, height: 6),
                              ),
                            ),
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: scheme.secondary,
                                width: 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    bar(scheme.surface, height: 12),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: bar(colors?.tintA ?? scheme.surface),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: bar(colors?.tintB ?? scheme.surface),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Center(
                      child: SizedBox(
                        width: 26,
                        child: bar(scheme.primary, height: 5),
                      ),
                    ),
                  ],
                ),
              ),
              if (selected)
                PositionedDirectional(
                  top: -6,
                  end: -6,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.scaffoldBackgroundColor,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: selected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
