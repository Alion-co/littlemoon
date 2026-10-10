import 'package:flutter/material.dart';

import 'moon_colors.dart';
import 'theme_builder.dart';

/// غروب — نارنجی و هلویی
class SunsetTheme {
  static const colors = MoonColors(
    heroStart: Color(0xFFFFE3D3),
    heroEnd: Color(0xFFFFF5EC),
    phaseBackground: Color(0xFFFBDCE8),
    phaseText: Color(0xFFB8356F),
    ringBackground: Color(0xFFFBD5C2),
    subtitle: Color(0xFF7A6A62),
    avatarBackground: Color(0xFFF3E6DE),
    avatarIcon: Color(0xFF9A857A),
    ovulation: Color(0xFFC2317A),
    tintA: Color(0xFFFFEEE4),
    tintB: Color(0xFFFDECF3),
  );

  static ThemeData get theme => buildAppTheme(
        brightness: Brightness.light,
        primary: const Color(0xFFEC6A3A),
        secondary: const Color(0xFFD84D88),
        background: const Color(0xFFFFF8F3),
        surface: const Color(0xFFFFFFFF),
        onSurface: const Color(0xFF3A2A22),
        outline: const Color(0xFFF6DDCD),
        colors: colors,
      );
}
