import 'package:flutter/material.dart';

import 'moon_colors.dart';
import 'theme_builder.dart';

/// شکوفه‌ی گیلاس — صورتی گرم و ملایم
class SakuraTheme {
  static const colors = MoonColors(
    heroStart: Color(0xFFFFE1E8),
    heroEnd: Color(0xFFFFF4EE),
    phaseBackground: Color(0xFFFFE4D6),
    phaseText: Color(0xFFB8552F),
    ringBackground: Color(0xFFFAD4DD),
    subtitle: Color(0xFF7A6A70),
    avatarBackground: Color(0xFFF5E4E8),
    avatarIcon: Color(0xFF9A8088),
    ovulation: Color(0xFFD9772B),
    tintA: Color(0xFFFFECF0),
    tintB: Color(0xFFFFF1E6),
  );

  static ThemeData get theme => buildAppTheme(
        brightness: Brightness.light,
        primary: const Color(0xFFE5668A),
        secondary: const Color(0xFFF2994A),
        background: const Color(0xFFFFF7F8),
        surface: const Color(0xFFFFFFFF),
        onSurface: const Color(0xFF3A2A30),
        outline: const Color(0xFFF5DCE3),
        colors: colors,
      );
}
