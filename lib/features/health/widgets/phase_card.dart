import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/features/health/phase_content.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';

/// کارت بالای صفحه‌ی سلامت: برچسب فاز فعلی + توضیح کوتاه.
class PhaseCard extends StatelessWidget {
  final CyclePhase? phase;

  const PhaseCard({super.key, required this.phase});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.moon?.heroStart ?? context.scheme.surface,
            context.moon?.heroEnd ?? context.scheme.surface,
          ],
        ),
        borderRadius: AppRadius.br28,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: context.moon?.phaseBackground,
              borderRadius: AppRadius.br20,
            ),
            child: Text(
              phase == null ? l10n.yourBody : Labels.phase(l10n, phase!),
              style: context.text.labelMedium?.copyWith(
                color: context.moon?.phaseText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            PhaseContent.about(l10n, phase),
            style: context.text.bodyMedium?.copyWith(
              color: context.scheme.onSurface,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
