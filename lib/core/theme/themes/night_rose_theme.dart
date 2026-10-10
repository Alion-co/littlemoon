import 'package:flutter/material.dart';

import 'moon_colors.dart';
import 'theme_builder.dart';

/// رز شب — تم تیره با قرمز گرم
class NightRoseTheme {
  static const colors = MoonColors(
    heroStart: Color(0xFF4A2433),
    heroEnd: Color(0xFF2A1D22),
    phaseBackground: Color(0xFF54382B),
    phaseText: Color(0xFFFFD2B0),
    ringBackground: Color(0xFF55303C),
    subtitle: Color(0xFFB8A6AC),
    avatarBackground: Color(0xFF3A2A30),
    avatarIcon: Color(0xFFC9B4BB),
    ovulation: Color(0xFFFFB37A),
    tintA: Color(0xFF3D222C),
    tintB: Color(0xFF3B2B24),
  );

  static ThemeData get theme => buildAppTheme(
        brightness: Brightness.dark,
        primary: const Color(0xFFE55C7C),
        secondary: const Color(0xFFF0A160),
        background: const Color(0xFF1B1417),
        surface: const Color(0xFF281E22),
        onSurface: const Color(0xFFF8EEF0),
        outline: const Color(0xFF45333A),
        colors: colors,
      );
}
