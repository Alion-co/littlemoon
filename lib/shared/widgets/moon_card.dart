import 'package:flutter/material.dart';

/// کارت پایه‌ی برنامه: سطح سفید، گوشه‌ی گرد و حاشیه‌ی ظریف.
class MoonCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final double radius;
  final bool bordered;
  final VoidCallback? onTap;

  const MoonCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color,
    this.radius = 24,
    this.bordered = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(radius);

    final content = Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? theme.colorScheme.surface,
        borderRadius: borderRadius,
        border: bordered
            ? Border.all(color: theme.dividerColor.withValues(alpha: 0.6))
            : null,
      ),
      child: child,
    );

    if (onTap == null) return content;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: content,
      ),
    );
  }
}
