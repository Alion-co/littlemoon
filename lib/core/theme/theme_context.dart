import 'package:flutter/material.dart';

import 'themes/moon_colors.dart';

/// میان‌بُر برای رنگ‌ها و استایل‌های تم، به‌جای تکرار
/// `Theme.of(context)` و `theme.extension<MoonColors>()` در همه‌ی صفحه‌ها.
extension MoonThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get scheme => theme.colorScheme;

  TextTheme get text => theme.textTheme;

  /// رنگ‌های اختصاصی برنامه (`null` فقط اگه تم، `MoonColors` نداشته باشه).
  MoonColors? get moon => theme.extension<MoonColors>();

  /// رنگ متن‌های کم‌رنگ (زیرعنوان، توضیح، لیبل).
  Color get subtitle => moon?.subtitle ?? scheme.onSurfaceVariant;

  /// پس‌زمینه‌ی کارت‌های رنگی (صورتی‌ و یاسیِ ملایم).
  Color get tintA => moon?.tintA ?? const Color(0xFFFCEEF4);

  Color get tintB => moon?.tintB ?? const Color(0xFFF3EEF9);
}
