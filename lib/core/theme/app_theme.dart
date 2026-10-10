import 'package:flutter/material.dart';

import 'theme_mode.dart';
import 'themes/lavender_theme.dart';
import 'themes/midnight_theme.dart';
import 'themes/mint_theme.dart';
import 'themes/moon_theme.dart';
import 'themes/night_rose_theme.dart';
import 'themes/ocean_theme.dart';
import 'themes/sakura_theme.dart';
import 'themes/sunset_theme.dart';

class AppTheme {
  static ThemeData getTheme(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.moon:
        return MoonTheme.light;

      case AppThemeMode.sakura:
        return SakuraTheme.theme;

      case AppThemeMode.lavender:
        return LavenderTheme.theme;

      case AppThemeMode.ocean:
        return OceanTheme.theme;

      case AppThemeMode.mint:
        return MintTheme.theme;

      case AppThemeMode.sunset:
        return SunsetTheme.theme;

      case AppThemeMode.midnight:
        return MidnightTheme.theme;

      case AppThemeMode.nightRose:
        return NightRoseTheme.theme;
    }
  }
}
