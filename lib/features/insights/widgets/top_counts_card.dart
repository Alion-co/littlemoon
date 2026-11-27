import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/shared/widgets/bar_row.dart';
import 'package:little_moon/shared/widgets/moon_card.dart';

/// کارت میله‌ای «پرتکرارترین‌ها» (علائم یا خلق‌وخو)؛ [entries] از بیشترین
/// به کمترین مرتب‌شده.
class TopCountsCard<T> extends StatelessWidget {
  final List<MapEntry<T, int>> entries;
  final String Function(T key) labelOf;
  final String emptyText;
  final Color color;
  final int? limit;

  const TopCountsCard({
    super.key,
    required this.entries,
    required this.labelOf,
    required this.emptyText,
    required this.color,
    this.limit,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return MoonCard(
        child: Text(
          emptyText,
          style: context.text.bodyMedium?.copyWith(color: context.subtitle),
        ),
      );
    }
    final shown = limit == null ? entries : entries.take(limit!);
    return MoonCard(
      child: Column(
        children: [
          for (final entry in shown)
            BarRow(
              label: labelOf(entry.key),
              factor: barFactor(entry.value, entries.first.value),
              color: color.withValues(alpha: 0.7),
              valueText: context.n(entry.value),
            ),
        ],
      ),
    );
  }
}
