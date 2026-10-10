import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/features/symptoms/daily_log_sheet.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/glass.dart';
import 'package:little_moon/shared/widgets/option_pill.dart';

/// چیپ‌های ثبت سریع امروز — هر کدوم فرم ثبت رو روی همون بخش باز می‌کنه.
class CheckinChips extends ConsumerWidget {
  const CheckinChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final today = ref.watch(todayProvider);
    final log = ref.watch(todayLogProvider);

    final chips = [
      _ChipData(
        section: LogSection.flow,
        icon: Icons.water_drop_outlined,
        label: l10n.flow,
        done: log?.flow != null,
      ),
      _ChipData(
        section: LogSection.mood,
        icon: Icons.sentiment_satisfied_alt_outlined,
        label: l10n.mood,
        done: log?.mood != null,
      ),
      _ChipData(
        section: LogSection.pain,
        icon: Icons.bolt_outlined,
        label: l10n.pain,
        done: log?.pain != null,
      ),
      _ChipData(
        section: LogSection.energy,
        icon: Icons.air,
        label: l10n.energy,
        done: log?.energy != null,
      ),
      _ChipData(
        section: LogSection.sleep,
        icon: Icons.nightlight_outlined,
        label: l10n.sleep,
        done: log?.sleepMinutes != null,
      ),
      _ChipData(
        section: LogSection.symptoms,
        icon: Icons.eco_outlined,
        label: l10n.symptoms,
        done: log != null && log.symptoms.isNotEmpty,
      ),
    ];

    void open(_ChipData chip) {
      showDailyLogSheet(
        context,
        ref: ref,
        date: today,
        focus: chip.section,
      );
    }

    // تم شب: شش کاشی شیشه‌ای هم‌اندازه در یک ردیف
    if (isNightTheme(context)) {
      return Row(
        children: [
          for (var i = 0; i < chips.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            Expanded(
              child: _NightTile(data: chips[i], onTap: () => open(chips[i])),
            ),
          ],
        ],
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: chips.map((chip) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: 10),
            child: OptionPill(
              icon: chip.icon,
              label: chip.label,
              selected: chip.done,
              onTap: () => open(chip),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ChipData {
  final LogSection section;
  final IconData icon;
  final String label;
  final bool done;

  const _ChipData({
    required this.section,
    required this.icon,
    required this.label,
    required this.done,
  });
}

class _NightTile extends StatelessWidget {
  final _ChipData data;
  final VoidCallback onTap;

  const _NightTile({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.secondary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        decoration: BoxDecoration(
          color: data.done
              ? accent.withValues(alpha: 0.28)
              : Colors.white.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: data.done
                ? accent.withValues(alpha: 0.9)
                : Colors.white.withValues(alpha: 0.20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(data.icon, size: 24, color: Colors.white),
            const SizedBox(height: 6),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                data.label,
                maxLines: 1,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
