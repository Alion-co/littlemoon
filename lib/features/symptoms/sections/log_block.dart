import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/theme_context.dart';

/// یک فیلد داخل کارت: برچسب کوچک با آیکن + (اختیاری) مقدار انتهای ردیف + محتوا.
/// [anchorKey] برای پریدن مستقیم به همین فیلد (`Scrollable.ensureVisible`).
class LogBlock extends StatelessWidget {
  final IconData icon;
  final String title;
  final Key? anchorKey;
  final Widget? trailing;
  final bool first;
  final Widget child;

  const LogBlock({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
    this.anchorKey,
    this.trailing,
    this.first = false,
  });

  @override
  Widget build(BuildContext context) {
    final trailingWidget = trailing;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          key: anchorKey,
          padding: EdgeInsets.only(top: first ? 4 : 22, bottom: 12),
          child: Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: context.scheme.primary.withValues(alpha: 0.8),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: context.text.labelLarge?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: context.scheme.onSurface.withValues(alpha: 0.78),
                  ),
                ),
              ),
              if (trailingWidget != null) trailingWidget,
            ],
          ),
        ),
        child,
      ],
    );
  }
}
