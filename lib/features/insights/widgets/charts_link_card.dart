import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/moon_card.dart';

/// کارت میان‌بُر به صفحه‌ی نمودارها.
class ChartsLinkCard extends StatelessWidget {
  const ChartsLinkCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MoonCard(
      onTap: () => context.push('/charts'),
      child: Row(
        children: [
          Icon(Icons.show_chart_rounded, color: context.scheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l10n.charts,
              style: context.text.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.scheme.onSurface,
              ),
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: context.subtitle),
        ],
      ),
    );
  }
}
