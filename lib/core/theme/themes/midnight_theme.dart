import 'package:flutter/material.dart';

import 'moon_colors.dart';
import 'theme_builder.dart';

/// نیمه‌شب — تم تیره با بنفش و صورتی
class MidnightTheme {
  static const colors = MoonColors(
    heroStart: Color(0xFF2C2A52),
    heroEnd: Color(0xFF1D1C38),
    phaseBackground: Color(0xFF3A3668),
    phaseText: Color(0xFFD9CBFF),
    ringBackground: Color(0xFF3A3760),
    subtitle: Color(0xFFB8B4D0),
    avatarBackground: Color(0xFF2E2C50),
    avatarIcon: Color(0xFFB9B2CC),
    ovulation: Color(0xFFC9A8FF),
    tintA: Color(0xFF302540),
    tintB: Color(0xFF2A2848),
  );

  static ThemeData get theme => buildAppTheme(
        brightness: Brightness.dark,
        primary: const Color(0xFFE0669B),
        secondary: const Color(0xFFA594F0),
        background: const Color(0xFF14132B),
        surface: const Color(0xFF201F3C),
        onSurface: const Color(0xFFF1EEF8),
        outline: const Color(0xFF37345A),
        colors: colors,
      );
}
