import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:little_moon/domain/engine/cycle_models.dart';
import 'package:little_moon/domain/engine/cycle_snapshot.dart';
import 'package:little_moon/domain/engine/day_marks.dart';

/// تقسیم یک چرخه به چهار فاز (قاعدگی، فولیکولار، تخمک‌گذاری، لوتئال) روی
/// حلقه. همون قانون `CyclePhaseResolver` رو دنبال می‌کنه تا فازِ نمایش‌داده‌شده
/// روی حلقه با فاز واقعی امروز یکی باشه.
///
/// «کسر» یعنی عددی بین ۰ و ۱ روی حلقه (۰ = بالای حلقه، ساعت‌گرد).
class CyclePhaseLayout {
  final int cycleLength;
  final int periodLength;

  /// شماره‌ی روز تخمک‌گذاری (روز اول چرخه = ۱).
  final int ovulationDay;

  const CyclePhaseLayout._(this.cycleLength, this.periodLength, this.ovulationDay);

  factory CyclePhaseLayout.of({
    required int cycleLength,
    required int periodLength,
    required int lutealLength,
  }) {
    final length = math.max(10, math.min(cycleLength, 120));
    final ovulation = DayMarks.ovulationOffset(length, lutealLength) + 1;
    final period = math.max(1, math.min(periodLength, ovulation - 2));
    return CyclePhaseLayout._(length, period, ovulation);
  }

  factory CyclePhaseLayout.fromSnapshot(CycleSnapshot cycle) =>
      CyclePhaseLayout.of(
        cycleLength: cycle.avgCycleLength,
        periodLength: cycle.avgPeriodLength,
        lutealLength: cycle.lutealLength,
      );

  /// روز چرخه‌ی متناظر با یک نقطه‌ی روی حلقه (۱ تا طول چرخه).
  int dayAt(double fraction) =>
      math.max(1, math.min((fraction * cycleLength).ceil(), cycleLength));

  CyclePhase phaseOfDay(int day) {
    if (day <= periodLength) return CyclePhase.menstrual;
    if (day < ovulationDay - 1) return CyclePhase.follicular;
    if (day <= ovulationDay + 1) return CyclePhase.ovulation;
    return CyclePhase.luteal;
  }

  CyclePhase phaseAt(double fraction) => phaseOfDay(dayAt(fraction));

  /// مرز فازها روی حلقه: پایان قاعدگی، شروع تخمک‌گذاری، پایان تخمک‌گذاری.
  List<double> get boundaries => [
    periodLength / cycleLength,
    (ovulationDay - 2) / cycleLength,
    (ovulationDay + 1) / cycleLength,
  ];

  /// جای روز تخمک‌گذاری روی حلقه (وسط روزش).
  double get ovulationFraction => (ovulationDay - 0.5) / cycleLength;

  @override
  bool operator ==(Object other) =>
      other is CyclePhaseLayout &&
      other.cycleLength == cycleLength &&
      other.periodLength == periodLength &&
      other.ovulationDay == ovulationDay;

  @override
  int get hashCode => Object.hash(cycleLength, periodLength, ovulationDay);

  // ---- ظاهر هر فاز ----

  static Color colorOf(CyclePhase phase) => switch (phase) {
    CyclePhase.menstrual => const Color(0xFFE76F8F),
    CyclePhase.follicular => const Color(0xFFA58BEA),
    CyclePhase.ovulation => const Color(0xFFF4B45B),
    CyclePhase.luteal => const Color(0xFF7F93E6),
  };

  /// چقدر رنگ فاز توی رنگ ماه قاطی بشه.
  static double moonMix(CyclePhase phase) => switch (phase) {
    CyclePhase.menstrual => 0.18,
    CyclePhase.follicular => 0.22,
    CyclePhase.ovulation => 0.42,
    CyclePhase.luteal => 0.26,
  };

  /// شدت هاله‌ی ماه: روزهای تخمک‌گذاری پرنورتر، قاعدگی ملایم‌تر.
  static double glowAlpha(CyclePhase phase) => switch (phase) {
    CyclePhase.menstrual => 0.18,
    CyclePhase.follicular => 0.30,
    CyclePhase.ovulation => 0.55,
    CyclePhase.luteal => 0.28,
  };

  static double glowBlur(CyclePhase phase) => switch (phase) {
    CyclePhase.menstrual => 8,
    CyclePhase.follicular => 10,
    CyclePhase.ovulation => 13,
    CyclePhase.luteal => 9,
  };
}
