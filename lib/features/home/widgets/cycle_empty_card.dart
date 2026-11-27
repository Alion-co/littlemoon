import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/glass.dart';

/// کارت بالای صفحه وقتی هنوز هیچ پریودی ثبت نشده.
class CycleEmptyCard extends StatelessWidget {
  final VoidCallback onLogPeriod;

  const CycleEmptyCard({super.key, required this.onLogPeriod});

  @override
  Widget build(BuildContext context) {
    final moon = context.moon!;
    final l10n = AppLocalizations.of(context)!;
    final night = isNightTheme(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: night
          ? homeCardDecoration(context, radius: 28)
          : BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [moon.heroStart, moon.heroEnd],
              ),
              borderRadius: AppRadius.br28,
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.noCycleDataTitle,
            style: context.text.titleLarge?.copyWith(
              color: night ? Colors.white : context.scheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.noCycleDataBody,
            style: context.text.bodyMedium?.copyWith(
              color: moon.subtitle,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onLogPeriod,
            icon: const Icon(Icons.add_rounded),
            label: Text(l10n.logLastPeriod),
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: AppRadius.br18),
            ),
          ),
        ],
      ),
    );
  }
}
