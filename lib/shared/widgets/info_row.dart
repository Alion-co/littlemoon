import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';

/// ردیفِ «آیکن + لیبل + مقدار» (فقط نمایشی)؛ جای `_InfoRow`.
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: _LabelValue(
        icon: icon,
        title: title,
        titleColor: context.subtitle,
        value: value,
      ),
    );
  }
}

/// ردیفِ قابل‌لمسِ تنظیمات: آیکن، عنوان، مقدار و فلش؛ جای `_SettingRow`.
class SettingRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const SettingRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.br14,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: _LabelValue(
          icon: icon,
          title: title,
          titleColor: context.scheme.onSurface,
          value: value,
          trailing: [
            const SizedBox(width: 4),
            Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: context.subtitle,
            ),
          ],
        ),
      ),
    );
  }
}

/// بدنه‌ی مشترک: آیکن، عنوان کش‌اومده، مقدار و (اختیاری) چیزهای آخر ردیف.
class _LabelValue extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color titleColor;
  final String value;
  final List<Widget> trailing;

  const _LabelValue({
    required this.icon,
    required this.title,
    required this.titleColor,
    required this.value,
    this.trailing = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: context.scheme.primary.withValues(alpha: 0.85),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: context.text.bodyMedium?.copyWith(color: titleColor),
          ),
        ),
        Text(
          value,
          style: context.text.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.scheme.onSurface,
          ),
        ),
        ...trailing,
      ],
    );
  }
}
