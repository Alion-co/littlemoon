import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/moon_card.dart';

/// هدف روزانه‌ی لیوان آب.
const waterGoal = 8;

/// بیشترین تعداد لیوان قابل ثبت در یک روز.
const _waterMax = 20;

/// کارت آب امروز: نوار پیشرفت + دکمه‌های کم/زیاد.
class WaterCard extends ConsumerWidget {
  final DailyLog todayLog;

  const WaterCard({super.key, required this.todayLog});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final water = todayLog.waterGlasses ?? 0;

    void setWater(int value) =>
        ref.read(logsProvider.notifier).save(todayLog.withWater(value));

    return MoonCard(
      child: Row(
        children: [
          Icon(Icons.local_drink_outlined, color: context.scheme.secondary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.water,
                  style: context.text.bodySmall?.copyWith(
                    color: context.subtitle,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  context.n(l10n.glassesOfGoal(water, waterGoal)),
                  style: context.text.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.scheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: AppRadius.br8,
                  child: LinearProgressIndicator(
                    value: water >= waterGoal ? 1.0 : water / waterGoal,
                    minHeight: 8,
                    backgroundColor: context.theme.dividerColor.withValues(
                      alpha: 0.6,
                    ),
                    color: context.scheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: water <= 0 ? null : () => setWater(water - 1),
            icon: const Icon(Icons.remove_rounded),
          ),
          IconButton.filled(
            onPressed: water >= _waterMax ? null : () => setWater(water + 1),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }
}
