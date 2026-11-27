import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';

/// رنگ نشانگر هر نوع روز (پریود، باروری، تخمک‌گذاری).
Color? dayKindColor(BuildContext context, DayKind kind) {
  switch (kind) {
    case DayKind.period:
    case DayKind.predictedPeriod:
      return context.scheme.primary;
    case DayKind.fertile:
      return context.scheme.secondary;
    case DayKind.ovulation:
      return context.moon?.ovulation ?? const Color(0xFF7B4DB3);
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
