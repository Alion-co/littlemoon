import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/localization/locale_provider.dart';
import 'package:little_moon/core/theme/app_theme.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/theme/theme_mode.dart';
import 'package:little_moon/core/theme/theme_provider.dart';
import 'package:little_moon/core/theme/themes/moon_colors.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/core/utils/haptics.dart';
import 'package:little_moon/data/repositories/settings_repository.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/language_picker.dart';
import 'package:little_moon/shared/widgets/segmented_toggle.dart';

import 'settings_widgets.dart';
import 'widget_gallery.dart';

/// ظاهر و زبان: زبان، تقویم، تم، تم شب خودکار و ویجت‌های صفحه‌ی اصلی.
class AppearanceSettingsPage extends ConsumerWidget {
  const AppearanceSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.watch(settingsProvider);
    final currentTheme = ref.watch(themeProvider);
    final language = ref.watch(localeProvider).languageCode;

    return SettingsScaffold(
      title: l10n.settingsAppearance,
      children: [
        SettingsCaption(l10n.language),
        SettingsGroup(
          children: [
            SettingsTile(
              icon: Icons.translate_rounded,
              title: l10n.language,
              value: appLanguages[language] ?? language,
              showChevron: true,
              onTap: () => showLanguageSheet(context),
            ),
          ],
        ),

        SettingsCaption(l10n.calendarType),
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
          onChanged: (type) => ref
              .read(settingsProvider.notifier)
              .save(settings.copyWith(calendarType: type)),
        ),

        SettingsCaption(l10n.theme),
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
                      onTap: () =>
                          ref.read(themeProvider.notifier).changeTheme(mode),
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 14),
        SettingsGroup(
          children: [
            SettingsSwitchTile(
              icon: Icons.dark_mode_outlined,
              title: l10n.autoNightTheme,
              subtitle: l10n.autoNightThemeHint,
              value: ref.watch(autoNightThemeProvider),
              onChanged: ref.read(autoNightThemeProvider.notifier).set,
            ),
            SettingsSwitchTile(
              icon: Icons.vibration_rounded,
              title: l10n.hapticsTitle,
              subtitle: l10n.hapticsHint,
              value: ref.watch(hapticsProvider),
              onChanged: (value) {
                ref.read(hapticsProvider.notifier).set(value);
                Haptics.tap();
              },
            ),
          ],
        ),

        // ---------- ویجت‌ها (فقط اندروید) ----------
        if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) ...[
          SettingsCaption(l10n.widgetTitle),
          const WidgetGallery(),
        ],
      ],
    );
  }
}

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
                  borderRadius: AppRadius.br18,
                  border: Border.all(
                    color: selected
                        ? context.scheme.primary
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
                        borderRadius: AppRadius.br10,
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
                        Expanded(child: bar(colors?.tintA ?? scheme.surface)),
                        const SizedBox(width: 4),
                        Expanded(child: bar(colors?.tintB ?? scheme.surface)),
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
                      color: context.scheme.primary,
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
            style: context.text.labelSmall?.copyWith(
              color: selected
                  ? context.scheme.primary
                  : context.scheme.onSurface,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
