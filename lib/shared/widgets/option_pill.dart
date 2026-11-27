import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';

/// دکمه‌ی کپسولی قابل انتخاب (هم‌شکل چیپ‌های صفحه‌ی خانه).
class OptionPill extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback? onTap;

  const OptionPill({
    super.key,
    required this.label,
    this.icon,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = context.scheme.primary;
    final iconData = icon;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.br30,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: selected
                ? primary.withValues(alpha: 0.12)
                : context.scheme.surface,
            borderRadius: AppRadius.br30,
            border: Border.all(
              color: selected
                  ? primary
                  : theme.dividerColor.withValues(alpha: 0.7),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconData != null) ...[
                Icon(
                  iconData,
                  size: 18,
                  color: primary.withValues(alpha: selected ? 1 : 0.85),
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: context.text.labelLarge?.copyWith(
                  color: selected ? primary : context.scheme.onSurface,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
