import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/charts.dart';
import 'package:little_moon/shared/widgets/moon_card.dart';
import 'package:little_moon/shared/widgets/section_header.dart';

/// عنوان + کارت نمودار؛ با کمتر از دو نقطه پیام «داده‌ی کافی نیست» می‌ده.
class ChartCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<ChartPoint> points;
  final Widget Function() chart;

  const ChartCard({
    super.key,
    required this.title,
    required this.points,
    required this.chart,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title, subtitle: subtitle),
          const SizedBox(height: 12),
          MoonCard(
            child: points.length < 2
                ? Text(
                    l10n.chartNotEnoughData,
                    style: context.text.bodyMedium?.copyWith(
                      color: context.subtitle,
                      height: 1.6,
                    ),
                  )
                : chart(),
          ),
        ],
      ),
    );
  }
}
