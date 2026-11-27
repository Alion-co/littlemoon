import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/glass.dart';

class InsightsGrid extends ConsumerWidget {
  const InsightsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final cycle = ref.watch(cycleProvider);
    final night = isNightTheme(context);

    final days = l10n.days;
    final minCycle = cycle.minCycleLength;
    final maxCycle = cycle.maxCycleLength;

    String pattern;
    if (minCycle == null || maxCycle == null) {
      pattern = '—';
    } else if (minCycle == maxCycle) {
      pattern = context.n('$minCycle $days');
    } else {
      pattern = context.n('$minCycle–$maxCycle $days');
    }

    return Row(
      children: [
        Expanded(
          child: _InsightCard(
            icon: night ? Icons.nightlight_round : Icons.circle_outlined,
            title: l10n.averageCycle,
            value: context.n('${cycle.avgCycleLength} $days'),
            backgroundColor: context.tintA,
            iconColor: context.scheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _InsightCard(
            icon: night ? Icons.auto_awesome : Icons.waves_rounded,
            title: l10n.recentPattern,
            value: pattern,
            backgroundColor: context.tintB,
            iconColor: context.scheme.secondary,
          ),
        ),
      ],
    );
  }
}

class _InsightCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color backgroundColor;
  final Color iconColor;

  const _InsightCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final night = isNightTheme(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: night
          ? homeCardDecoration(context, radius: 22)
          : BoxDecoration(color: backgroundColor, borderRadius: AppRadius.br22),
      child: Row(
        children: [
          // نشان گرد آیکون
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: night
                  ? Colors.white.withValues(alpha: 0.08)
                  : iconColor.withValues(alpha: 0.12),
            ),
            child: Icon(
              icon,
              size: 24,
              color: night
                  ? Colors.white.withValues(alpha: 0.9)
                  : iconColor.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.bodySmall?.copyWith(
                    color: context.subtitle,
                  ),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    value,
                    maxLines: 1,
                    style: context.text.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.scheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
