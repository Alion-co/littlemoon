import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';

class ToggleOption<T> {
  final T value;
  final String label;
  final IconData? icon;

  const ToggleOption({required this.value, required this.label, this.icon});
}

/// انتخابگر چندتایی تمام‌عرض (هم‌شکل تاگل ماه/هفته‌ی تقویم).
class SegmentedToggle<T> extends StatelessWidget {
  final List<ToggleOption<T>> options;
  final T selected;
  final ValueChanged<T> onChanged;

  const SegmentedToggle({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.scheme.surface,
        borderRadius: AppRadius.br20,
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          for (final option in options)
            Expanded(
              child: _Segment(
                label: option.label,
                icon: option.icon,
                selected: option.value == selected,
                onTap: () => onChanged(option.value),
              ),
            ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback onTap;

  const _Segment({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? context.scheme.onPrimary
        : context.scheme.onSurface;
    final iconData = icon;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? context.scheme.primary : Colors.transparent,
          borderRadius: AppRadius.br16,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconData != null) ...[
              Icon(iconData, size: 18, color: color),
              const SizedBox(width: 6),
            ],
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.text.labelLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
