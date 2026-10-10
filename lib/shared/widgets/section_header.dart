import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/themes/moon_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>();
    final trailingWidget = trailing;
    final subtitleText = subtitle;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              if (subtitleText != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitleText,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: moon?.subtitle ??
                        theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailingWidget != null) trailingWidget,
      ],
    );
  }
}
