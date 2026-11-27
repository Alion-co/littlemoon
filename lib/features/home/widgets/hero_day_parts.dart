import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/shared/animations/soft_motion.dart';

import 'moon_art.dart';

/// قرصِ «فاز قاعدگی» با ستاره‌ی چهارپر؛ حاشیه‌دار و نیمه‌شفاف.
class HeroPhaseChip extends StatelessWidget {
  final String text;

  const HeroPhaseChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final primary = context.scheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.55),
        borderRadius: AppRadius.br20,
        border: Border.all(color: primary.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SoftSwitcher(
            child: Text(
              text,
              key: ValueKey(text),
              style: context.text.labelLarge?.copyWith(
                color: primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 6),
          SparkleIcon(size: 13, color: primary),
        ],
      ),
    );
  }
}

/// جمله‌ی توضیحِ چرخه؛ فقط وقتی چیزی برای گفتن هست (تأخیر، بی‌نظمی) میاد.
class HeroNote extends StatelessWidget {
  final String text;

  const HeroNote({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.text.bodySmall?.copyWith(
        color: context.subtitle,
        height: 1.4,
      ),
    );
  }
}
