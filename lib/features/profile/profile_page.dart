import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/localization/calendar_provider.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/data/models/user_profile.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/data/repositories/profile_repository.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/dialogs.dart';
import 'package:little_moon/shared/widgets/page_header.dart';
import 'package:little_moon/shared/widgets/section_header.dart';
import 'package:little_moon/shared/widgets/stat_tile.dart';
import 'package:little_moon/shared/widgets/tab_scaffold.dart';
import 'package:little_moon/shared/widgets/user_avatar.dart';

import 'edit_profile_sheet.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    final profile = ref.watch(profileProvider);
    final cycle = ref.watch(cycleProvider);
    final loggedDays = ref.watch(logsProvider.select((logs) => logs.length));
    final calendar = ref.watch(appCalendarProvider);
    final notifier = ref.read(profileProvider.notifier);

    final firstPeriod = cycle.periods.isEmpty
        ? null
        : cycle.periods.first.start;
    final displayName = profile.name.trim().isEmpty
        ? l10n.noName
        : profile.name.trim();

    // رنگ آیکن‌ها از خود تم می‌آد تا توی همه‌ی تم‌ها (روشن و تیره) جور باشه.
    final cycleColor = context.scheme.primary;
    final periodColor = context.scheme.secondary;
    final lutealColor = context.moon?.ovulation ?? context.scheme.tertiary;

    Future<void> editValue({
      required String title,
      required String description,
      required int value,
      required int min,
      required int max,
      required UserProfile Function(int) apply,
    }) async {
      final result = await showStepperDialog(
        context: context,
        title: title,
        description: description,
        value: value,
        min: min,
        max: max,
        unit: l10n.days,
      );
      if (result != null) await notifier.save(apply(result));
    }

    return TabScaffold(
      currentIndex: -1,
      children: [
        const SizedBox(height: 12),
        PageHeader(title: l10n.profile, onBack: () => context.go('/home')),
        const SizedBox(height: 16),

        // ---------- کارت کاربر ----------
        _ProfileHeaderCard(
          avatarId: profile.avatar,
          name: displayName,
          subtitle: firstPeriod == null
              ? l10n.noCycleDataTitle
              : l10n.trackingSince(calendar.dayMonthYear(firstPeriod)),
          editTooltip: l10n.edit,
          onEdit: () => showEditProfileSheet(context),
        ),

        // ---------- خلاصه ----------
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatTile.count(
                value: context.n(loggedDays),
                label: l10n.daysLogged,
                color: context.tintA,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatTile.count(
                value: context.n(cycle.periods.length),
                label: l10n.periodsLogged,
                color: context.tintB,
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
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: StatTile(
                  title: l10n.cycleLength,
                  value: context.n('${profile.cycleLength} ${l10n.days}'),
                  icon: Icons.circle_outlined,
                  iconColor: cycleColor,
                  color: _soft(context, cycleColor),
                  fitTitle: true,
                  onTap: () => editValue(
                    title: l10n.cycleLength,
                    description: l10n.cycleLengthHint,
                    value: profile.cycleLength,
                    min: UserProfile.minCycleLength,
                    max: UserProfile.maxCycleLength,
                    apply: (v) => profile.copyWith(cycleLength: v),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: StatTile(
                  title: l10n.periodLength,
                  value: context.n('${profile.periodLength} ${l10n.days}'),
                  icon: Icons.water_drop_outlined,
                  iconColor: periodColor,
                  color: _soft(context, periodColor),
                  fitTitle: true,
                  onTap: () => editValue(
                    title: l10n.periodLength,
                    description: l10n.periodLengthHint,
                    value: profile.periodLength,
                    min: UserProfile.minPeriodLength,
                    max: UserProfile.maxPeriodLength,
                    apply: (v) => profile.copyWith(periodLength: v),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: StatTile(
                  title: l10n.lutealLength,
                  value: context.n('${profile.lutealLength} ${l10n.days}'),
                  icon: Icons.egg_outlined,
                  iconColor: lutealColor,
                  color: _soft(context, lutealColor),
                  fitTitle: true,
                  onTap: () => editValue(
                    title: l10n.lutealLength,
                    description: l10n.lutealLengthHint,
                    value: profile.lutealLength,
                    min: UserProfile.minLutealLength,
                    max: UserProfile.maxLutealLength,
                    apply: (v) => profile.copyWith(lutealLength: v),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 110),
      ],
    );
  }

  /// پس‌زمینه‌ی ملایم هر کاشی: رنگ آیکن، خیلی کم‌رنگ روی سطح کارت.
  static Color _soft(BuildContext context, Color base) => Color.alphaBlend(
    base.withValues(alpha: 0.12),
    context.scheme.surface,
  );
}

/// کارت بالای پروفایل: آواتار بزرگ با حلقه‌ی گرادیانتی، نام و زیرعنوان
/// وسط‌چین، و نشان مداد روی گوشه‌ی آواتار برای ویرایش.
class _ProfileHeaderCard extends StatelessWidget {
  final int avatarId;
  final String name;
  final String subtitle;
  final String editTooltip;
  final VoidCallback onEdit;

  const _ProfileHeaderCard({
    required this.avatarId,
    required this.name,
    required this.subtitle,
    required this.editTooltip,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.moon?.heroStart ?? scheme.surface,
            context.moon?.heroEnd ?? scheme.surface,
          ],
        ),
        borderRadius: AppRadius.br28,
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              // حلقه‌ی گرادیانتی دور آواتار
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [scheme.primary, scheme.secondary],
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: scheme.surface,
                  ),
                  child: UserAvatar(avatarId: avatarId, radius: 40),
                ),
              ),
              // نشان مداد (ویرایش)
              PositionedDirectional(
                end: -2,
                bottom: -2,
                child: Tooltip(
                  message: editTooltip,
                  child: Material(
                    color: scheme.primary,
                    shape: CircleBorder(
                      side: BorderSide(color: scheme.surface, width: 2.5),
                    ),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: onEdit,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.edit_rounded,
                          size: 16,
                          color: scheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            name,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: context.text.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: context.text.bodySmall?.copyWith(color: context.subtitle),
          ),
        ],
      ),
    );
  }
}
