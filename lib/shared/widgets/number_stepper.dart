import 'package:flutter/material.dart';
import 'package:little_moon/core/utils/digits.dart';

/// انتخاب عدد با دکمه‌های کم/زیاد.
class NumberStepper extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final String? unit;
  final ValueChanged<int> onChanged;

  const NumberStepper({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unitText = unit;

    Widget button(IconData icon, bool enabled, VoidCallback onTap) {
      final color = theme.colorScheme.primary;
      return Material(
        color: color.withValues(alpha: enabled ? 0.12 : 0.05),
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: enabled ? onTap : null,
          child: SizedBox(
            width: 44,
            height: 44,
            child: Icon(
              icon,
              color: color.withValues(alpha: enabled ? 1 : 0.35),
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        button(Icons.remove_rounded, value > min, () => onChanged(value - 1)),
        SizedBox(
          width: 96,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.n(value),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              if (unitText != null)
                Text(
                  unitText,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
            ],
          ),
        ),
        button(Icons.add_rounded, value < max, () => onChanged(value + 1)),
      ],
    );
  }
}
