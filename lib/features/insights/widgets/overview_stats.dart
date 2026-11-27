import 'package:flutter/material.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/stat_tile.dart';

/// چهار کاشی‌ی آمار کلی چرخه (میانگین‌ها، نظم، تعداد چرخه‌ها).
class OverviewStats extends StatelessWidget {
  final CycleSnapshot cycle;

  const OverviewStats({super.key, required this.cycle});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final primary = context.scheme.primary;
    final secondary = context.scheme.secondary;

    Widget pair(StatTile a, StatTile b) => Row(
      children: [
        Expanded(child: a),
        const SizedBox(width: 12),
        Expanded(child: b),
      ],
    );

    return Column(
      children: [
        pair(
          StatTile(
            fitTitle: true,
            icon: Icons.circle_outlined,
            title: l10n.averageCycle,
            value: context.n('${cycle.avgCycleLength} ${l10n.days}'),
            color: context.tintA,
            iconColor: primary,
          ),
          StatTile(
            fitTitle: true,
            icon: Icons.water_drop_outlined,
            title: l10n.averagePeriod,
            value: context.n('${cycle.avgPeriodLength} ${l10n.days}'),
            color: context.tintB,
            iconColor: secondary,
          ),
        ),
        const SizedBox(height: 12),
        pair(
          StatTile(
            fitTitle: true,
            icon: Icons.waves_rounded,
            title: l10n.regularity,
            value: Labels.regularity(l10n, cycle.regularity),
            color: context.tintB,
            iconColor: secondary,
          ),
          StatTile(
            fitTitle: true,
            icon: Icons.timeline_rounded,
            title: l10n.cyclesTracked,
            value: context.n(cycle.cycles.length),
            color: context.tintA,
            iconColor: primary,
          ),
        ),
      ],
    );
  }
}
