import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/themes/moon_colors.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';

/// رنگ نشانگر هر نوع روز (پریود، باروری، تخمک‌گذاری).
Color? dayKindColor(BuildContext context, DayKind kind) {
  final theme = Theme.of(context);
  final moon = theme.extension<MoonColors>();

  switch (kind) {
    case DayKind.period:
    case DayKind.predictedPeriod:
      return theme.colorScheme.primary;
    case DayKind.fertile:
      return theme.colorScheme.secondary;
    case DayKind.ovulation:
      return moon?.ovulation ?? const Color(0xFF7B4DB3);
    case DayKind.none:
      return null;
  }
}

/// نقطه‌ی وضعیت زیر عدد روز. پریودِ پیش‌بینی‌شده توخالی کشیده می‌شه.
class DayKindDot extends StatelessWidget {
  final DayKind kind;
  final double size;

  const DayKindDot({super.key, required this.kind, this.size = 6});

  @override
  Widget build(BuildContext context) {
    final color = dayKindColor(context, kind);
    if (color == null) return SizedBox(width: size, height: size);

    final hollow = kind == DayKind.predictedPeriod;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: hollow ? Colors.transparent : color,
        shape: BoxShape.circle,
        border: hollow ? Border.all(color: color, width: 1.3) : null,
      ),
    );
  }
}
