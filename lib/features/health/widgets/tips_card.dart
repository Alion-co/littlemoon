import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/shared/widgets/moon_card.dart';

/// فهرست توصیه‌ها با آیکن لامپ.
class TipsCard extends StatelessWidget {
  final List<String> tips;

  const TipsCard({super.key, required this.tips});

  @override
  Widget build(BuildContext context) {
    return MoonCard(
      child: Column(
        children: [
          for (final tip in tips)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.lightbulb_outline_rounded,
                      size: 18,
                      color: context.scheme.primary.withValues(alpha: 0.85),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      tip,
                      style: context.text.bodyMedium?.copyWith(
                        color: context.scheme.onSurface,
                        height: 1.5,
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
