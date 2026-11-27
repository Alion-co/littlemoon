import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/animations/soft_motion.dart';

import 'moon_art.dart';

/// کارت کوچیکِ باز شده با لمس ماه (یا حلقه): فاصله تا پریود بعدی و بازه‌ی
/// باروری. لمسش دوباره می‌بندتش. [dark] برای تم شب.
class MoonInfoCard extends StatelessWidget {
  final String status;
  final String? fertileText;
  final VoidCallback onTap;
  final bool dark;

  const MoonInfoCard({
    super.key,
    required this.status,
    required this.fertileText,
    required this.onTap,
    this.dark = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final accent = dark ? Colors.white : context.scheme.primary;
    final main = dark ? Colors.white : context.scheme.onSurface;
    final soft = dark ? Colors.white.withValues(alpha: 0.78) : context.subtitle;
    final fertile = fertileText;

    final card = GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: dark
              ? Colors.white.withValues(alpha: 0.09)
              : Colors.white.withValues(alpha: 0.55),
          borderRadius: AppRadius.br16,
          border: Border.all(
            color: dark
                ? Colors.white.withValues(alpha: 0.20)
                : accent.withValues(alpha: 0.28),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SparkleIcon(size: 12, color: accent),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    status,
                    style: context.text.labelLarge?.copyWith(
                      color: main,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            if (fertile != null) ...[
              const SizedBox(height: 6),
              Text(
                '${l10n.fertileWindow}: $fertile',
                style: context.text.bodySmall?.copyWith(
                  color: soft,
                  height: 1.4,
                ),
              ),
            ],
          ],
        ),
      ),
    );

    return reduceMotion(context)
        ? card
        : card.animate().fadeIn(duration: 240.ms);
  }
}
