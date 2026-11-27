import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/haptics.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/domain/services/daily_tips.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/animations/soft_motion.dart';
import 'package:little_moon/shared/widgets/glass.dart';

/// پیشنهادهای کوتاه امروز، متناسب با فاز چرخه: تغذیه، حرکت و استراحت.
/// محتوا ثابت و آفلاینه؛ با لمس هر پیشنهاد، یکی دیگه نشون داده می‌شه.
class DailyTipsCard extends ConsumerStatefulWidget {
  const DailyTipsCard({super.key});

  @override
  ConsumerState<DailyTipsCard> createState() => _DailyTipsCardState();
}

class _DailyTipsCardState extends ConsumerState<DailyTipsCard> {
  final Map<TipCategory, int> _shift = {};

  static IconData _icon(TipCategory category) {
    switch (category) {
      case TipCategory.nutrition:
        return Icons.restaurant_outlined;
      case TipCategory.movement:
        return Icons.directions_walk_rounded;
      case TipCategory.rest:
        return Icons.bedtime_outlined;
    }
  }

  void _next(TipCategory category) {
    Haptics.tap();
    setState(() => _shift[category] = (_shift[category] ?? 0) + 1);
  }

  @override
  Widget build(BuildContext context) {
    final cycle = ref.watch(cycleProvider);
    final phase = cycle.phase;
    if (!cycle.hasData || phase == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final today = ref.watch(todayProvider);
    final night = isNightTheme(context);

    final textColor = night ? Colors.white : context.scheme.onSurface;
    final softColor = night
        ? Colors.white.withValues(alpha: 0.7)
        : context.subtitle;
    final accent = night ? Colors.white : context.scheme.primary;
    final dividerColor = night
        ? Colors.white.withValues(alpha: 0.14)
        : theme.dividerColor.withValues(alpha: 0.7);

    final rows = <Widget>[];
    for (final category in TipCategory.values) {
      final pool = Labels.tipPool(l10n, phase, category);
      final shift = _shift[category] ?? 0;
      final index = DailyTips.indexFor(
        day: today,
        category: category,
        poolSize: pool.length,
        shift: shift,
      );
      final tip = DailyTips.pick(
        pool,
        day: today,
        category: category,
        shift: shift,
      );
      if (tip == null) continue;

      if (rows.isNotEmpty) {
        rows.add(Divider(height: 1, color: dividerColor));
      }
      rows.add(
        InkWell(
          onTap: () => _next(category),
          borderRadius: AppRadius.br14,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: night ? 0.14 : 0.10),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(_icon(category), size: 18, color: accent),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Labels.tipCategory(l10n, category),
                        style: context.text.labelMedium?.copyWith(
                          color: softColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      SoftSwitcher(
                        child: Text(
                          tip,
                          key: ValueKey('${category.name}-$index'),
                          style: context.text.bodyMedium?.copyWith(
                            color: textColor,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (rows.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: homeCardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline_rounded, size: 20, color: accent),
              const SizedBox(width: 8),
              Text(
                l10n.dailyTipsTitle,
                style: context.text.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ...rows,
          const SizedBox(height: 6),
          Text(
            l10n.tipsTapHint,
            style: context.text.bodySmall?.copyWith(color: softColor),
          ),
        ],
      ),
    );
  }
}
