import 'package:flutter/material.dart';

import 'moon_colors.dart';

/// همه‌ی تم‌ها با همین تابع ساخته می‌شن تا شکل کارت‌ها، فونت و گردی
/// گوشه‌ها بین تم‌ها یکی بمونه و فقط رنگ‌ها عوض بشه.
ThemeData buildAppTheme({
  required Brightness brightness,
  required Color primary,
  required Color secondary,
  required Color background,
  required Color surface,
  required Color onSurface,
  required Color outline,
  required MoonColors colors,
}) {
  final isDark = brightness == Brightness.dark;

  final scheme = isDark
      ? ColorScheme.dark(
          primary: primary,
          secondary: secondary,
          surface: surface,
          error: const Color(0xFFF87171),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: onSurface,
        )
      : ColorScheme.light(
          primary: primary,
          secondary: secondary,
          surface: surface,
          error: const Color(0xFFEF4444),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: onSurface,
        );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    fontFamily: 'Vazirmatn',
    colorScheme: scheme,
    scaffoldBackgroundColor: background,
    dividerColor: outline,
    cardTheme: CardThemeData(
      color: surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
    ),
    extensions: [colors],
  );
}
