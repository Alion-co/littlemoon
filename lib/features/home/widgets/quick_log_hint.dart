import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/theme_context.dart';

/// جمله‌ی کوچک کنار تیتر ثبت سریع (با قلب آخرش). اگه کامل جا نشه، کلاً
/// حذف می‌شه تا هیچ‌وقت نیمه‌کاره (با «…») دیده نشه.
class QuickLogHint extends StatelessWidget {
  final String text;
  final Color color;

  const QuickLogHint({super.key, required this.text, required this.color});

  static const _heartSize = 14.0;
  static const _gap = 4.0;

  @override
  Widget build(BuildContext context) {
    final style = context.text.labelSmall?.copyWith(color: color);
    final direction = Directionality.of(context);
    final scaler = MediaQuery.textScalerOf(context);

    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final painter = TextPainter(
            text: TextSpan(text: text, style: style),
            textDirection: direction,
            textScaler: scaler,
            maxLines: 1,
          )..layout();
          final needed = painter.width + _gap + _heartSize;
          painter.dispose();

          if (needed > constraints.maxWidth) return const SizedBox.shrink();

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(text, maxLines: 1, softWrap: false, style: style),
              const SizedBox(width: _gap),
              Icon(
                Icons.favorite_rounded,
                size: _heartSize,
                color: context.scheme.primary.withValues(alpha: 0.7),
              ),
            ],
          );
        },
      ),
    );
  }
}
