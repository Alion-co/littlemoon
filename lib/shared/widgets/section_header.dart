import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/theme_context.dart';

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
                style: context.text.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.scheme.onSurface,
                ),
              ),
              if (subtitleText != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitleText,
                  style: context.text.bodyMedium?.copyWith(
                    color: context.subtitle,
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
