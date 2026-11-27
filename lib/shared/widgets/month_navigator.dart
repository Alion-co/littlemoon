import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/theme_context.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onPrevious,
          icon: const Icon(Icons.chevron_left_rounded),
          color: context.scheme.onSurface,
        ),
        Text(
          label,
          style: context.text.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.scheme.onSurface,
          ),
        ),
        IconButton(
          onPressed: onNext,
          icon: const Icon(Icons.chevron_right_rounded),
          color: context.scheme.onSurface,
        ),
      ],
    );
  }
}
