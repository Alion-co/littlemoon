import 'package:flutter/material.dart';

/// عنوان + دکمه‌های قبل/بعد.
///
/// آیکون‌های chevron خودشون در راست‌به‌چپ قرینه می‌شن، پس اینجا
/// نباید دستی جابه‌جا بشن.
class MonthNavigator extends StatelessWidget {
  final String label;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const MonthNavigator({
    super.key,
    required this.label,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onPrevious,
          icon: const Icon(Icons.chevron_left_rounded),
          color: theme.colorScheme.onSurface,
        ),
        Text(
          label,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        IconButton(
          onPressed: onNext,
          icon: const Icon(Icons.chevron_right_rounded),
          color: theme.colorScheme.onSurface,
        ),
      ],
    );
  }
}
