import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/localization/calendar_provider.dart';
import 'package:little_moon/core/theme/themes/moon_colors.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/data/models/user_profile.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/data/repositories/profile_repository.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/dialogs.dart';
import 'package:little_moon/shared/widgets/moon_card.dart';
import 'package:little_moon/shared/widgets/page_header.dart';
import 'package:little_moon/shared/widgets/section_header.dart';
import 'package:little_moon/shared/widgets/tab_scaffold.dart';
import 'package:little_moon/shared/widgets/user_avatar.dart';

import 'edit_profile_sheet.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>();
    final l10n = AppLocalizations.of(context)!;
    final subtitleColor = moon?.subtitle ?? theme.colorScheme.onSurfaceVariant;

    final profile = ref.watch(profileProvider);
    final cycle = ref.watch(cycleProvider);
    final logs = ref.watch(logsProvider);
    final calendar = ref.watch(appCalendarProvider);
    final notifier = ref.read(profileProvider.notifier);

    final firstPeriod = cycle.periods.isEmpty ? null : cycle.periods.first.start;
    final displayName =
        profile.name.trim().isEmpty ? l10n.noName : profile.name.trim();

    return TabScaffold(
      currentIndex: 4,
      children: [
        const SizedBox(height: 12),
        PageHeader(
          title: l10n.profile,
          onBack: () => context.go('/home'),
        ),
        const SizedBox(height: 16),

        // ---------- کارت کاربر ----------
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
          child: Row(
            children: [
              UserAvatar(avatarId: profile.avatar, radius: 30),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      firstPeriod == null
                          ? l10n.noCycleDataTitle
                          : l10n.trackingSince(
                              calendar.dayMonthYear(firstPeriod),
                            ),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: subtitleColor,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: l10n.edit,
                onPressed: () => showEditProfileSheet(context),
                icon: const Icon(Icons.edit_outlined),
                color: theme.colorScheme.primary,
              ),
            ],
          ),
        ),

        // ---------- خلاصه ----------
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _CountTile(
                value: context.n(logs.length),
                label: l10n.daysLogged,
                color: moon?.tintA ?? const Color(0xFFFCEEF4),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _CountTile(
                value: context.n(cycle.periods.length),
                label: l10n.periodsLogged,
                color: moon?.tintB ?? const Color(0xFFF3EEF9),
              ),
            ),
          ],
        ),

        // ---------- تنظیمات چرخه ----------
        const SizedBox(height: 28),
        SectionHeader(
          title: l10n.cycleSettings,
          subtitle: l10n.cycleSettingsHint,
        ),
        const SizedBox(height: 14),
        MoonCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            children: [
              _SettingRow(
                icon: Icons.circle_outlined,
                title: l10n.cycleLength,
                value: context.n('${profile.cycleLength} ${l10n.days}'),
                onTap: () async {
                  final value = await showStepperDialog(
                    context: context,
                    title: l10n.cycleLength,
                    description: l10n.cycleLengthHint,
                    value: profile.cycleLength,
                    min: UserProfile.minCycleLength,
                    max: UserProfile.maxCycleLength,
                    unit: l10n.days,
                  );
                  if (value != null) {
                    await notifier.save(profile.copyWith(cycleLength: value));
                  }
                },
              ),
              Divider(
                height: 1,
                color: theme.dividerColor.withValues(alpha: 0.6),
              ),
              _SettingRow(
                icon: Icons.water_drop_outlined,
                title: l10n.periodLength,
                value: context.n('${profile.periodLength} ${l10n.days}'),
                onTap: () async {
                  final value = await showStepperDialog(
                    context: context,
                    title: l10n.periodLength,
                    description: l10n.periodLengthHint,
                    value: profile.periodLength,
                    min: UserProfile.minPeriodLength,
                    max: UserProfile.maxPeriodLength,
                    unit: l10n.days,
                  );
                  if (value != null) {
                    await notifier.save(profile.copyWith(periodLength: value));
                  }
                },
              ),
              Divider(
                height: 1,
                color: theme.dividerColor.withValues(alpha: 0.6),
              ),
              _SettingRow(
                icon: Icons.egg_outlined,
                title: l10n.lutealLength,
                value: context.n('${profile.lutealLength} ${l10n.days}'),
                onTap: () async {
                  final value = await showStepperDialog(
                    context: context,
                    title: l10n.lutealLength,
                    description: l10n.lutealLengthHint,
                    value: profile.lutealLength,
                    min: UserProfile.minLutealLength,
                    max: UserProfile.maxLutealLength,
                    unit: l10n.days,
                  );
                  if (value != null) {
                    await notifier.save(profile.copyWith(lutealLength: value));
                  }
                },
              ),
            ],
          ),
        ),

        // ---------- سایر ----------
        const SizedBox(height: 28),
        MoonCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            children: [
              _SettingRow(
                icon: Icons.settings_outlined,
                title: l10n.settings,
                value: '',
                onTap: () => context.push('/settings'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
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
        const SizedBox(height: 110),
      ],
    );
  }
}

class _CountTile extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _CountTile({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: moon?.subtitle ?? theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const _SettingRow({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>();
    final subtitleColor = moon?.subtitle ?? theme.colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
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
                  color: theme.colorScheme.onSurface,
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
            const SizedBox(width: 4),
            Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: subtitleColor,
            ),
          ],
        ),
      ),
    );
  }
}
