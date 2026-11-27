import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';

/// کاشیِ رنگیِ عدد و لیبل؛ جای `_StatTile`، `_MeasureTile` و `_CountTile`.
///
/// - بدون `icon` (`StatTile.count`): عدد بزرگ و زیرش لیبل
/// - با `icon`: آیکن، عنوان و مقدار
/// - با `caption` و `onTap`: کاشیِ قابل‌لمس که آیکن ویرایش هم نشون می‌ده
class StatTile extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData? icon;
  final Color? iconColor;
  final String? caption;
  final VoidCallback? onTap;

  /// روی گوشی‌های باریک عنوان کوچیک می‌شه به‌جای اینکه بریده بشه.
  final bool fitTitle;

  const StatTile({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required IconData this.icon,
    required Color this.iconColor,
    this.caption,
    this.onTap,
    this.fitTitle = false,
  });

  /// عدد بزرگ بالا و لیبل زیرش، بدون آیکن.
  const StatTile.count({
    super.key,
    required this.value,
    required String label,
    required this.color,
  }) : title = label,
       icon = null,
       iconColor = null,
       caption = null,
       onTap = null,
       fitTitle = false;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: icon == null ? _countBody(context) : _tileBody(context),
      ),
    );

    if (onTap == null) {
      return Container(
        decoration: BoxDecoration(color: color, borderRadius: AppRadius.br22),
        child: content,
      );
    }
    return Material(
      color: color,
      borderRadius: AppRadius.br22,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.br22,
        child: content,
      ),
    );
  }

  List<Widget> _countBody(BuildContext context) {
    return [
      Text(
        value,
        style: context.text.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: context.scheme.onSurface,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        title,
        style: context.text.bodySmall?.copyWith(color: context.subtitle),
      ),
    ];
  }

  List<Widget> _tileBody(BuildContext context) {
    final titleText = Text(
      title,
      maxLines: 1,
      softWrap: fitTitle ? false : null,
      overflow: fitTitle ? null : TextOverflow.ellipsis,
      style: context.text.bodySmall?.copyWith(color: context.subtitle),
    );

    return [
      Row(
        children: [
          Icon(icon, size: 22, color: iconColor!.withValues(alpha: 0.85)),
          if (onTap != null) ...[
            const Spacer(),
            Icon(Icons.edit_outlined, size: 16, color: context.subtitle),
          ],
        ],
      ),
      const SizedBox(height: 14),
      if (fitTitle)
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: titleText,
        )
      else
        titleText,
      const SizedBox(height: 4),
      Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.text.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: context.scheme.onSurface,
        ),
      ),
      if (caption != null) ...[
        const SizedBox(height: 2),
        Text(
          caption!,
          style: context.text.labelSmall?.copyWith(color: context.subtitle),
        ),
      ],
    ];
  }
}
