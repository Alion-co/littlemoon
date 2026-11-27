import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/theme_context.dart';

/// رنگ‌های «لوکس» راه‌اندازی. در تم روشن، پالت ثابتِ برند (صورتیِ طرح مرجع و
/// رزگلدِ ماه)؛ در تم‌های شب، از رنگ اصلی تم ساخته می‌شه.
@immutable
class OnboardingPalette {
  final Color bgTop;
  final Color bgBottom;
  final Color glow;

  /// رنگ عنوان‌ها: رزِ عمیق (در تم شب روشن).
  final Color deep;
  final Color gold;
  final Color glassFill;
  final Color glassBorder;
  final Color buttonStart;
  final Color buttonEnd;
  final Color buttonShadow;

  const OnboardingPalette({
    required this.bgTop,
    required this.bgBottom,
    required this.glow,
    required this.deep,
    required this.gold,
    required this.glassFill,
    required this.glassBorder,
    required this.buttonStart,
    required this.buttonEnd,
    required this.buttonShadow,
  });

  factory OnboardingPalette.of(BuildContext context) {
    final primary = context.scheme.primary;
    final hsl = HSLColor.fromColor(primary);
    final dark = context.theme.brightness == Brightness.dark;

    Color tone(double lightness, double saturation, {double hueShift = 0}) =>
        hsl
            .withLightness(lightness)
            .withSaturation(saturation)
            .withHue((hsl.hue + hueShift) % 360)
            .toColor();

    if (dark) {
      const gold = Color(0xFFE2C48D);
      final base = context.theme.scaffoldBackgroundColor;
      return OnboardingPalette(
        bgTop: Color.lerp(base, primary, 0.16)!,
        bgBottom: base,
        glow: primary.withValues(alpha: 0.18),
        deep: tone(0.86, 0.7),
        gold: gold,
        glassFill: Colors.white.withValues(alpha: 0.06),
        glassBorder: gold.withValues(alpha: 0.28),
        buttonStart: tone(0.62, 0.65),
        buttonEnd: tone(0.46, 0.6, hueShift: 12),
        buttonShadow: primary.withValues(alpha: 0.35),
      );
    }

    // پالت برند، برداشته از طرح مرجع: صورتیِ پاستلی، رزِ تیره و رزگلد.
    const gold = Color(0xFFE8AA84);
    const deep = Color(0xFFA8165F);
    return OnboardingPalette(
      bgTop: const Color(0xFFFFE6F3),
      bgBottom: const Color(0xFFFDD6EA),
      glow: Colors.white.withValues(alpha: 0.8),
      deep: deep,
      gold: gold,
      glassFill: Colors.white.withValues(alpha: 0.55),
      glassBorder: gold.withValues(alpha: 0.5),
      buttonStart: const Color(0xFFE0589A),
      buttonEnd: const Color(0xFFB2205F),
      buttonShadow: const Color(0xFFB2205F).withValues(alpha: 0.30),
    );
  }
}
