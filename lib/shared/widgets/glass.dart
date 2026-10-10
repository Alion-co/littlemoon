import 'package:flutter/material.dart';

/// تم‌های تیره «حالت شب» دارن: پس‌زمینه‌ی آسمان شب و کارت‌های شیشه‌ای.
bool isNightTheme(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

/// ظاهر کارت‌های صفحه‌ی خانه: در تم روشن سطح سفید با حاشیه‌ی ظریف،
/// در تم تیره شیشه‌ی نیمه‌شفاف روی آسمان شب.
BoxDecoration homeCardDecoration(BuildContext context, {double radius = 24}) {
  final theme = Theme.of(context);

  if (theme.brightness == Brightness.dark) {
    return BoxDecoration(
      color: Colors.white.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
    );
  }

  return BoxDecoration(
    color: theme.colorScheme.surface,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: theme.dividerColor.withValues(alpha: 0.6)),
  );
}
