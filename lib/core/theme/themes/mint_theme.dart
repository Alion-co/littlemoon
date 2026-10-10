import 'package:flutter/material.dart';

import 'moon_colors.dart';
import 'theme_builder.dart';

/// نعنا — سبز تازه
class MintTheme {
  static const colors = MoonColors(
    heroStart: Color(0xFFDDF3E7),
    heroEnd: Color(0xFFF3FAF5),
    phaseBackground: Color(0xFFFDE6D8),
    phaseText: Color(0xFFB85C2E),
    ringBackground: Color(0xFFCBEBD9),
    subtitle: Color(0xFF617268),
    avatarBackground: Color(0xFFE2EDE6),
    avatarIcon: Color(0xFF7D9186),
    ovulation: Color(0xFFD9692B),
    tintA: Color(0xFFE7F6EE),
    tintB: Color(0xFFFEF0E6),
  );

  static ThemeData get theme => buildAppTheme(
        brightness: Brightness.light,
        primary: const Color(0xFF2E9E78),
        secondary: const Color(0xFFF0895C),
        background: const Color(0xFFF4FAF6),
        surface: const Color(0xFFFFFFFF),
        onSurface: const Color(0xFF1B3229),
        outline: const Color(0xFFD5EBDE),
        colors: colors,
      );
}
