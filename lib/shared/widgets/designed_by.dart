import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_info.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/shared/widgets/moon_logo.dart';

/// امضای پایین صفحه‌ها: «Designed by Alion» با نشان کوچک شیر.
class DesignedBy extends StatelessWidget {
  const DesignedBy({super.key});

  @override
  Widget build(BuildContext context) {
    final muted = context.subtitle;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.ltr,
      children: [
        Text(
          'Designed by ${AppInfo.developerName}',
          textDirection: TextDirection.ltr,
          style: context.text.bodySmall?.copyWith(
            color: muted,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(width: 8),
        const ClipOval(child: AlionBadge(size: 18)),
      ],
    );
  }
}
