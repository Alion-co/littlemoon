import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:little_moon/domain/engine/cycle_models.dart';

import 'moon_art.dart' show sparklePath;
import 'phase_layout.dart';

const double _twoPi = math.pi * 2;
const double _halfPi = math.pi / 2;

/// حلقه‌ی تم شب (لایه‌ی ثابت): کمان گرادیانیِ گذشته با سر گرد، خط‌چین آینده
/// به رنگ فازها و ستاره‌ی روز تخمک‌گذاری. فقط وقتی پیشرفت عوض بشه دوباره
/// کشیده می‌شه؛ ماه کوچک و ذرات در [NightKnobPainter]ـان.
class NightRingPainter extends CustomPainter {
  final double progress;
  final Color startColor;
  final Color endColor;
  final CyclePhaseLayout layout;

  NightRingPainter({
    required this.progress,
    required this.startColor,
    required this.endColor,
    required this.layout,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = ringRadius(size);
    final ringRect = Rect.fromCircle(center: center, radius: radius);
    final sweep = progress.clamp(0.0, 1.0) * _twoPi;

    // مسیر خیلی کم‌رنگ زیر همه‌چیز
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = Colors.white.withValues(alpha: 0.07),
    );

    // آینده: خط‌چین، هر تکه به رنگ فازش
    final dashPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    final dash = 5.0 / radius;
    final gap = 7.0 / radius;
    for (var a = sweep; a < _twoPi - 0.01; a += dash + gap) {
      final len = math.min(dash, _twoPi - a);
      dashPaint.color = CyclePhaseLayout.colorOf(
        layout.phaseAt((a + len / 2) / _twoPi),
      ).withValues(alpha: 0.62);
      canvas.drawArc(ringRect, a - _halfPi, len, false, dashPaint);
    }

    // گذشته: هاله + کمان گرادیانی با سر گرد
    if (sweep > 0.01) {
      canvas.drawArc(
        ringRect,
        -_halfPi,
        sweep,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8
          ..strokeCap = StrokeCap.round
          ..color = Colors.white.withValues(alpha: 0.10)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
      );
      canvas.drawArc(
        ringRect,
        -_halfPi,
        sweep,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4.5
          ..strokeCap = StrokeCap.round
          ..shader = SweepGradient(
            colors: [startColor, Colors.white, endColor],
            transform: const GradientRotation(-_halfPi - 0.2),
          ).createShader(ringRect),
      );
    }

    // ستاره‌ی روز تخمک‌گذاری
    final gold = CyclePhaseLayout.colorOf(CyclePhase.ovulation);
    final star =
        center +
        Offset.fromDirection(layout.ovulationFraction * _twoPi - _halfPi, radius);
    canvas.drawCircle(
      star,
      9,
      Paint()
        ..shader = RadialGradient(
          colors: [gold.withValues(alpha: 0.45), gold.withValues(alpha: 0)],
        ).createShader(Rect.fromCircle(center: star, radius: 9)),
    );
    canvas.drawPath(sparklePath(star, 6), Paint()..color = gold);
  }

  /// شعاع خط حلقه برای یک اندازه‌ی کادر.
  static double ringRadius(Size size) => size.shortestSide / 2 - 14;

  @override
  bool shouldRepaint(covariant NightRingPainter old) =>
      old.progress != progress ||
      old.startColor != startColor ||
      old.endColor != endColor ||
      old.layout != layout;
}

class _Mote {
  final double angle;
  final double radius; // نسبت به شعاع حلقه
  final double size;
  final double ax;
  final double ay;
  final int fx;
  final int fy;
  final int twinkle;
  final double phaseX;
  final double phaseY;
  final double alpha;

  const _Mote({
    required this.angle,
    required this.radius,
    required this.size,
    required this.ax,
    required this.ay,
    required this.fx,
    required this.fy,
    required this.twinkle,
    required this.phaseX,
    required this.phaseY,
    required this.alpha,
  });
}

/// لایه‌ی متحرکِ تم شب: ذرات ریز شناور دور حلقه و «ماه کوچک» روی نقطه‌ی
/// امروز با هاله‌ی نفس‌کش. با [clock] (یک دور = ۲۰ ثانیه) بدون rebuild فقط
/// خودش دوباره کشیده می‌شه. با [motion] = false ذرات نیستن و هاله ثابته.
class NightKnobPainter extends CustomPainter {
  final double progress;
  final CyclePhase phase;
  final Animation<double> clock;
  final bool motion;

  NightKnobPainter({
    required this.progress,
    required this.phase,
    required this.clock,
    required this.motion,
  }) : super(repaint: clock);

  // ثابت و یک‌بار ساخته می‌شن (نه تصادفی در هر فریم)
  static final List<_Mote> _motes = () {
    final random = math.Random(11);
    return List<_Mote>.generate(
      16,
      (_) => _Mote(
        angle: random.nextDouble() * _twoPi,
        radius: 0.80 + random.nextDouble() * 0.40,
        size: 0.8 + random.nextDouble() * 1.2,
        ax: 3 + random.nextDouble() * 6,
        ay: 3 + random.nextDouble() * 6,
        fx: 1 + random.nextInt(3),
        fy: 1 + random.nextInt(3),
        twinkle: 2 + random.nextInt(4),
        phaseX: random.nextDouble(),
        phaseY: random.nextDouble(),
        alpha: 0.25 + random.nextDouble() * 0.35,
      ),
    );
  }();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = NightRingPainter.ringRadius(size);
    final t = motion ? clock.value : 0.0;

    if (motion) {
      final dust = Paint();
      for (final m in _motes) {
        final base = center + Offset.fromDirection(m.angle, radius * m.radius);
        final pos =
            base +
            Offset(
              m.ax * math.sin(_twoPi * (m.fx * t + m.phaseX)),
              m.ay * math.cos(_twoPi * (m.fy * t + m.phaseY)),
            );
        final tw = 0.5 + 0.5 * math.sin(_twoPi * (m.twinkle * t + m.phaseX));
        dust.color = Colors.white.withValues(alpha: m.alpha * (0.35 + 0.65 * tw));
        canvas.drawCircle(pos, m.size, dust);
      }
    }

    // ماه کوچک روی نقطه‌ی امروز — بالای حلقه شروع می‌شه و ساعت‌گرد می‌ره
    final knob =
        center +
        Offset.fromDirection(progress.clamp(0.0, 1.0) * _twoPi - _halfPi, radius);

    final pulse = motion ? 0.5 + 0.5 * math.sin(_twoPi * 6 * t) : 0.5;
    final haloColor = Color.lerp(
      Colors.white,
      CyclePhaseLayout.colorOf(phase),
      0.45,
    )!;
    final haloR = 14.0 + 6.0 * pulse;
    canvas.drawCircle(
      knob,
      haloR,
      Paint()
        ..shader = RadialGradient(
          colors: [
            haloColor.withValues(alpha: 0.60),
            haloColor.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: knob, radius: haloR)),
    );

    canvas.drawCircle(knob, 8, Paint()..color = const Color(0xFFF4F2FF));

    final crater = Paint()
      ..color = const Color(0xFFBDB8D8).withValues(alpha: 0.6);
    canvas.drawCircle(knob + const Offset(-2.5, -1.5), 1.8, crater);
    canvas.drawCircle(knob + const Offset(2.2, 2.4), 1.3, crater);
  }

  @override
  bool shouldRepaint(NightKnobPainter old) =>
      old.progress != progress || old.phase != phase || old.motion != motion;
}
