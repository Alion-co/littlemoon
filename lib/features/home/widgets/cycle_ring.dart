import 'package:flutter/material.dart';

class CycleRingPainter extends CustomPainter {
  final double progress;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;

  CycleRingPainter({
    required this.progress,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius = size.width / 2;

    // حلقه‌های پس‌زمینه
    final bgPaint = Paint()
      ..color = backgroundColor.withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.5;

    canvas.drawCircle(
      center,
      radius - 8,
      bgPaint,
    );

    canvas.drawCircle(
      center,
      radius - 20,
      bgPaint,
    );

    canvas.drawCircle(
      center,
      radius - 32,
      bgPaint,
    );

    // حلقه پیشرفت
    final progressPaint = Paint()
      ..shader = SweepGradient(
        colors: [
          primaryColor,
          secondaryColor,
          primaryColor.withValues(alpha: 0.7),
        ],
        startAngle: -1.5708,
        endAngle: 4.7124,
      ).createShader(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7.5
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius - 8,
      ),
      -1.5708,
      progress.clamp(0.0, 1.0) * 6.2832,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CycleRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.secondaryColor != secondaryColor ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
const double _twoPi = 6.283185307179586;
const double _halfPi = 1.5707963267948966;

/// حلقه‌ی تم روشن: مدارهای ظریف + حلقه‌ی پیشرفت + دایره‌ی پُر وسط.
class OrbitRingPainter extends CustomPainter {
  final double progress;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;

  OrbitRingPainter({
    required this.progress,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final shortest = size.width < size.height ? size.width : size.height;
    final radius = shortest / 2 - 6;

    // مدارها
    final orbitA = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = secondaryColor.withValues(alpha: 0.55);
    final orbitB = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = primaryColor.withValues(alpha: 0.30);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-0.10);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset.zero,
        width: size.width - 4,
        height: radius * 1.05,
      ),
      orbitA,
    );
    canvas.restore();

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(0.45);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset.zero,
        width: radius * 1.75,
        height: radius * 1.25,
      ),
      orbitB,
    );
    canvas.restore();

    // مسیر حلقه
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..color = backgroundColor.withValues(alpha: 0.55);
    canvas.drawCircle(center, radius, trackPaint);

    // حلقه‌ی پیشرفت
    final ringRect = Rect.fromCircle(center: center, radius: radius);
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [
          secondaryColor.withValues(alpha: 0.75),
          primaryColor.withValues(alpha: 0.80),
          primaryColor,
        ],
        transform: const GradientRotation(-_halfPi - 0.2),
      ).createShader(ringRect);

    final sweep = progress.clamp(0.0, 1.0) * _twoPi;
    if (sweep > 0) {
      canvas.drawArc(ringRect, -_halfPi, sweep, false, progressPaint);
    }

    // نقطه‌های روی مدار
    final dotA = Paint()..color = primaryColor.withValues(alpha: 0.85);
    final dotB = Paint()..color = secondaryColor;
    canvas.drawCircle(
      Offset(center.dx, center.dy - radius * 0.62),
      3,
      dotA,
    );
    canvas.drawCircle(
      Offset(center.dx + radius * 0.66, center.dy),
      3.2,
      dotB,
    );
    canvas.drawCircle(
      Offset(center.dx, center.dy + radius * 0.62),
      3,
      dotA,
    );

    // دایره‌ی وسط (عدد روز روی این می‌شینه)
    final corePaint = Paint()..color = primaryColor.withValues(alpha: 0.85);
    canvas.drawCircle(center, radius * 0.36, corePaint);
  }

  @override
  bool shouldRepaint(covariant OrbitRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.secondaryColor != secondaryColor ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}

/// حلقه‌ی تم شب: خط باریک درخشان با یک «ماه کوچک» روی نقطه‌ی پیشرفت.
class NightRingPainter extends CustomPainter {
  final double progress;
  final Color startColor;
  final Color endColor;

  NightRingPainter({
    required this.progress,
    required this.startColor,
    required this.endColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final shortest = size.width < size.height ? size.width : size.height;
    final radius = shortest / 2 - 14;
    final ringRect = Rect.fromCircle(center: center, radius: radius);

    // مسیر کم‌رنگ
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.white.withValues(alpha: 0.14);
    canvas.drawCircle(center, radius, trackPaint);

    final sweep = progress.clamp(0.0, 1.0) * _twoPi;

    if (sweep > 0) {
      // هاله‌ی حلقه
      final glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round
        ..color = Colors.white.withValues(alpha: 0.10)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawArc(ringRect, -_halfPi, sweep, false, glowPaint);

      final progressPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.5
        ..strokeCap = StrokeCap.round
        ..shader = SweepGradient(
          colors: [startColor, Colors.white, endColor],
          transform: const GradientRotation(-_halfPi - 0.2),
        ).createShader(ringRect);
      canvas.drawArc(ringRect, -_halfPi, sweep, false, progressPaint);
    }

    // ماه کوچک روی نقطه‌ی پیشرفت — بالای حلقه شروع می‌شه و ساعت‌گرد می‌ره
    final angle = sweep - _halfPi;
    final knob = center + Offset.fromDirection(angle, radius);

    final knobGlow = Paint()
      ..color = Colors.white.withValues(alpha: 0.45)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(knob, 13, knobGlow);

    final knobPaint = Paint()..color = const Color(0xFFF4F2FF);
    canvas.drawCircle(knob, 8, knobPaint);

    final craterPaint = Paint()
      ..color = const Color(0xFFBDB8D8).withValues(alpha: 0.6);
    canvas.drawCircle(knob + const Offset(-2.5, -1.5), 1.8, craterPaint);
    canvas.drawCircle(knob + const Offset(2.2, 2.4), 1.3, craterPaint);
  }

  @override
  bool shouldRepaint(covariant NightRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.startColor != startColor ||
        oldDelegate.endColor != endColor;
  }
}
