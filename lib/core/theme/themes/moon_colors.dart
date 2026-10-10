import 'package:flutter/material.dart';

@immutable
class MoonColors extends ThemeExtension<MoonColors> {
  final Color heroStart;
  final Color heroEnd;
  final Color phaseBackground;
  final Color phaseText;
  final Color ringBackground;
  final Color subtitle;
  final Color avatarBackground;
  final Color avatarIcon;

  /// رنگ نشانگر روز تخمک‌گذاری
  final Color ovulation;

  /// پس‌زمینه‌ی کارت‌های رنگی (مثل کارت‌های بینش)
  final Color tintA;
  final Color tintB;

  const MoonColors({
    required this.heroStart,
    required this.heroEnd,
    required this.phaseBackground,
    required this.phaseText,
    required this.ringBackground,
    required this.subtitle,
    required this.avatarBackground,
    required this.avatarIcon,
    this.ovulation = const Color(0xFF7B4DB3),
    this.tintA = const Color(0xFFFCEEF4),
    this.tintB = const Color(0xFFF3EEF9),
  });

  static const light = MoonColors(
    heroStart: Color(0xFFF9E3EC),
    heroEnd: Color(0xFFF8F1F6),
    phaseBackground: Color(0xFFEADDF8),
    phaseText: Color(0xFF7B4DB3),
    ringBackground: Color(0xFFF3D9E4),
    subtitle: Color(0xFF6B7280),
    avatarBackground: Color(0xFFE9E5EE),
    avatarIcon: Color(0xFF8A8493),
  );

  @override
  MoonColors copyWith({
    Color? heroStart,
    Color? heroEnd,
    Color? phaseBackground,
    Color? phaseText,
    Color? ringBackground,
    Color? subtitle,
    Color? avatarBackground,
    Color? avatarIcon,
    Color? ovulation,
    Color? tintA,
    Color? tintB,
  }) {
    return MoonColors(
      heroStart: heroStart ?? this.heroStart,
      heroEnd: heroEnd ?? this.heroEnd,
      phaseBackground: phaseBackground ?? this.phaseBackground,
      phaseText: phaseText ?? this.phaseText,
      ringBackground: ringBackground ?? this.ringBackground,
      subtitle: subtitle ?? this.subtitle,
      avatarBackground: avatarBackground ?? this.avatarBackground,
      avatarIcon: avatarIcon ?? this.avatarIcon,
      ovulation: ovulation ?? this.ovulation,
      tintA: tintA ?? this.tintA,
      tintB: tintB ?? this.tintB,
    );
  }

  @override
  MoonColors lerp(
      ThemeExtension<MoonColors>? other,
      double t,
      ) {
    if (other is! MoonColors) {
      return this;
    }

    return MoonColors(
      heroStart: Color.lerp(heroStart, other.heroStart, t) ?? heroStart,
      heroEnd: Color.lerp(heroEnd, other.heroEnd, t) ?? heroEnd,
      phaseBackground:
      Color.lerp(phaseBackground, other.phaseBackground, t) ??
          phaseBackground,
      phaseText:
      Color.lerp(phaseText, other.phaseText, t) ?? phaseText,
      ringBackground:
      Color.lerp(ringBackground, other.ringBackground, t) ??
          ringBackground,
      subtitle:
      Color.lerp(subtitle, other.subtitle, t) ?? subtitle,
      avatarBackground:
      Color.lerp(avatarBackground, other.avatarBackground, t) ??
          avatarBackground,
      avatarIcon:
      Color.lerp(avatarIcon, other.avatarIcon, t) ?? avatarIcon,
      ovulation: Color.lerp(ovulation, other.ovulation, t) ?? ovulation,
      tintA: Color.lerp(tintA, other.tintA, t) ?? tintA,
      tintB: Color.lerp(tintB, other.tintB, t) ?? tintB,
    );
  }
}
