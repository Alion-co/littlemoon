import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';

/// نسبتِ `value` به `max` برای پهنای میله (بین ۰ و ۱).
double barFactor(num value, num max) => max <= 0 ? 0.0 : value / max;

/// ردیفِ میله‌ای: لیبل، میله‌ی نسبی و مقدار؛ جای `_CountBar` و میله‌های تاریخچه.
///
/// [extra] جای اختیاری بین میله و مقدار برای نشانه‌هاست (مثلاً آیکن تخمک‌گذاری).
/// با دادن [onTap] ردیف قابل‌لمس می‌شه.
class BarRow extends StatelessWidget {
  final String label;
  final double factor;
  final Color color;
  final String valueText;
  final double labelWidth;
  final double valueWidth;
  final double barHeight;
  final Color? labelColor;
  final Widget? extra;
  final VoidCallback? onTap;

  const BarRow({
    super.key,
    required this.label,
    required this.factor,
    required this.color,
    required this.valueText,
    this.labelWidth = 110,
    this.valueWidth = 34,
    this.barHeight = 10,
    this.labelColor,
    this.extra,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final row = Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          SizedBox(
            width: labelWidth,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.text.bodySmall?.copyWith(
                color: labelColor ?? context.scheme.onSurface,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: FractionallySizedBox(
                widthFactor: factor,
                child: Container(
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: AppRadius.br8,
                  ),
                ),
              ),
            ),
          ),
          if (extra != null) extra!,
          SizedBox(
            width: valueWidth,
            child: Text(
              valueText,
              textAlign: TextAlign.end,
              style: context.text.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );

    if (onTap == null) return row;
    return InkWell(borderRadius: AppRadius.br10, onTap: onTap, child: row);
  }
}
