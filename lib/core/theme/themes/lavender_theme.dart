import 'package:flutter/material.dart';

import 'moon_colors.dart';
import 'theme_builder.dart';

/// اسطوخودوس — بنفش آرام
class LavenderTheme {
  static const colors = MoonColors(
    heroStart: Color(0xFFE9E1FB),
    heroEnd: Color(0xFFF6F2FD),
    phaseBackground: Color(0xFFFBDDEB),
    phaseText: Color(0xFFB83A77),
    ringBackground: Color(0xFFDDD2F7),
    subtitle: Color(0xFF6E6A80),
    avatarBackground: Color(0xFFE8E4F3),
    avatarIcon: Color(0xFF857F9B),
    ovulation: Color(0xFFDB2777),
    tintA: Color(0xFFF1ECFD),
    tintB: Color(0xFFFDEEF5),
  );

  static ThemeData get theme => buildAppTheme(
        brightness: Brightness.light,
        primary: const Color(0xFF8B5CF6),
        secondary: const Color(0xFFEC6FA9),
        background: const Color(0xFFF7F5FD),
        surface: const Color(0xFFFFFFFF),
        onSurface: const Color(0xFF241F35),
        outline: const Color(0xFFE3DCF5),
        colors: colors,
      );
}
