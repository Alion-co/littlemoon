import 'package:flutter/material.dart';

import 'moon_colors.dart';
import 'theme_builder.dart';

/// اقیانوس — فیروزه‌ای و آبی
class OceanTheme {
  static const colors = MoonColors(
    heroStart: Color(0xFFD8F1F3),
    heroEnd: Color(0xFFF0F8FB),
    phaseBackground: Color(0xFFDDE5FD),
    phaseText: Color(0xFF3F55C4),
    ringBackground: Color(0xFFC9E8EB),
    subtitle: Color(0xFF5F7277),
    avatarBackground: Color(0xFFE0ECEE),
    avatarIcon: Color(0xFF7A9096),
    ovulation: Color(0xFF3F55C4),
    tintA: Color(0xFFE5F5F6),
    tintB: Color(0xFFEAEFFE),
  );

  static ThemeData get theme => buildAppTheme(
        brightness: Brightness.light,
        primary: const Color(0xFF0F9BA8),
        secondary: const Color(0xFF6A84F5),
        background: const Color(0xFFF3FAFB),
        surface: const Color(0xFFFFFFFF),
        onSurface: const Color(0xFF16303A),
        outline: const Color(0xFFD2E8EB),
        colors: colors,
      );
}
