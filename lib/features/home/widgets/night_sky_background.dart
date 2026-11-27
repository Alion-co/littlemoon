import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/shared/animations/soft_motion.dart';

import 'moon_art.dart' show sparklePath;

/// پس‌زمینه‌ی تم شب: آسمان پرستاره، ماه، ابر، تپه‌ها و شاخه‌های گل.
///
/// همه‌چیز با کد کشیده می‌شه (بدون فایل تصویر) تا روی هر اندازه‌ی صفحه
/// تمیز بمونه و حجم برنامه بالا نره.
class NightSkyBackground extends StatelessWidget {
  const NightSkyBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        RepaintBoundary(
          child: CustomPaint(
            size: Size.infinite,
            painter: _NightSkyPainter(
              base: theme.scaffoldBackgroundColor,
              accent: context.scheme.secondary,
              flower: context.scheme.primary,
              moonOnLeft: Directionality.of(context) == TextDirection.rtl,
            ),
          ),
        ),
        // ستاره‌های چشمک‌زن و ستاره‌ی دنباله‌دار، جدا از آسمان ثابت تا آسمان
        // و تپه‌ها در هر فریم دوباره کشیده نشن
        const _SkyTwinkle(),
      ],
    );
  }
}

class _SkyTwinkle extends StatefulWidget {
  const _SkyTwinkle();

  @override
  State<_SkyTwinkle> createState() => _SkyTwinkleState();
}

class _SkyTwinkleState extends State<_SkyTwinkle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _clock = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 20),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (reduceMotion(context)) {
      _clock.stop();
    } else if (!_clock.isAnimating) {
      _clock.repeat();
    }
  }

  @override
  void dispose() {
    _clock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: RepaintBoundary(
        child: CustomPaint(
          size: Size.infinite,
          painter: _TwinklePainter(
            clock: _clock,
            motion: !reduceMotion(context),
          ),
        ),
      ),
    );
  }
}

class _TwinklePainter extends CustomPainter {
  final Animation<double> clock;
  final bool motion;

  _TwinklePainter({required this.clock, required this.motion})
    : super(repaint: clock);

  // جای ستاره‌ها ثابته و یک‌بار ساخته می‌شه (x و y نسبت به صفحه)
  static final List<({double x, double y, double r, int cycles, double phase})>
  _stars = () {
    final random = math.Random(21);
    return List.generate(
      14,
      (_) => (
        x: random.nextDouble(),
        y: random.nextDouble() * 0.55,
        r: 1.8 + random.nextDouble() * 1.6,
        cycles: 2 + random.nextInt(4),
        phase: random.nextDouble(),
      ),
    );
  }();

  @override
  void paint(Canvas canvas, Size size) {
    if (!motion || size.isEmpty) return;
    final t = clock.value;
    final paint = Paint();

    for (final s in _stars) {
      final tw = 0.5 + 0.5 * math.sin(2 * math.pi * (s.cycles * t + s.phase));
      paint.color = Colors.white.withValues(alpha: 0.10 + 0.75 * tw);
      canvas.drawPath(
        sparklePath(
          Offset(s.x * size.width, s.y * size.height),
          s.r * (0.7 + 0.3 * tw),
        ),
        paint,
      );
    }

    // ستاره‌ی دنباله‌ی خیلی کوتاه، هر ۲۰ ثانیه (حدود ۱٫۲ ثانیه)
    const from = 0.55;
    const to = 0.61;
    if (t >= from && t < to) {
      final u = (t - from) / (to - from);
      final a = Offset(size.width * 0.92, size.height * 0.05);
      final b = Offset(size.width * 0.42, size.height * 0.20);
      final head = Offset.lerp(a, b, Curves.easeOut.transform(u))!;
      final dir = (b - a) / (b - a).distance;
      final fade = math.sin(math.pi * u);
      final tail = head - dir * (size.width * 0.25 * fade);
      canvas.drawLine(
        tail,
        head,
        Paint()
          ..strokeWidth = 1.6
          ..strokeCap = StrokeCap.round
          ..shader = ui.Gradient.linear(tail, head, [
            Colors.white.withValues(alpha: 0),
            Colors.white.withValues(alpha: 0.9 * fade),
          ]),
      );
    }
  }

  @override
  bool shouldRepaint(_TwinklePainter old) => old.motion != motion;
}

class _NightSkyPainter extends CustomPainter {
  final Color base;
  final Color accent;
  final Color flower;
  final bool moonOnLeft;

  _NightSkyPainter({
    required this.base,
    required this.accent,
    required this.flower,
    required this.moonOnLeft,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    if (w <= 0 || h <= 0) return;

    final rect = Offset.zero & size;

    // ---------- آسمان ----------
    final top = Color.lerp(base, Colors.black, 0.30) ?? base;
    final bottom = Color.lerp(base, accent, 0.20) ?? base;
    final skyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [top, base, bottom],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(rect);
    canvas.drawRect(rect, skyPaint);

    // ---------- ستاره‌ها (ثابت، نه تصادفی در هر بار کشیدن) ----------
    final random = math.Random(7);
    final starPaint = Paint();
    for (var i = 0; i < 120; i++) {
      final position = Offset(
        random.nextDouble() * w,
        random.nextDouble() * h * 0.62,
      );
      final radius = 0.4 + random.nextDouble() * 1.1;
      starPaint.color = Colors.white.withValues(
        alpha: 0.25 + random.nextDouble() * 0.6,
      );
      canvas.drawCircle(position, radius, starPaint);
    }

    // ---------- ماه ----------
    final moonCenter = Offset(moonOnLeft ? w * 0.17 : w * 0.83, h * 0.17);
    const moonRadius = 34.0;

    final haloPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);
    canvas.drawCircle(moonCenter, moonRadius * 2.1, haloPaint);

    final moonRect = Rect.fromCircle(center: moonCenter, radius: moonRadius);
    final moonPaint = Paint()
      ..shader = const RadialGradient(
        center: Alignment(-0.3, -0.3),
        colors: [Color(0xFFFFFFFF), Color(0xFFD7D3EA)],
      ).createShader(moonRect);
    canvas.drawCircle(moonCenter, moonRadius, moonPaint);

    final craterPaint = Paint()
      ..color = const Color(0xFFB4AFCD).withValues(alpha: 0.38);
    canvas.drawCircle(moonCenter + const Offset(-10, -8), 6, craterPaint);
    canvas.drawCircle(moonCenter + const Offset(9, 4), 8, craterPaint);
    canvas.drawCircle(moonCenter + const Offset(-4, 14), 4.5, craterPaint);
    canvas.drawCircle(moonCenter + const Offset(14, -14), 3.5, craterPaint);

    // ---------- ابرها ----------
    final cloudPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.07)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 22);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.12, h * 0.30),
        width: w * 0.55,
        height: h * 0.07,
      ),
      cloudPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.85, h * 0.36),
        width: w * 0.60,
        height: h * 0.08,
      ),
      cloudPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.45, h * 0.47),
        width: w * 0.70,
        height: h * 0.05,
      ),
      cloudPaint,
    );

    // ---------- تپه‌ها ----------
    final farHill = Path()
      ..moveTo(0, h * 0.60)
      ..quadraticBezierTo(w * 0.25, h * 0.52, w * 0.50, h * 0.59)
      ..quadraticBezierTo(w * 0.78, h * 0.66, w, h * 0.55)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    final farPaint = Paint()
      ..color = (Color.lerp(base, Colors.black, 0.18) ?? base).withValues(
        alpha: 0.85,
      );
    canvas.drawPath(farHill, farPaint);

    // درخشش دریاچه بین تپه‌ها
    final lakePaint = Paint()
      ..color = accent.withValues(alpha: 0.10)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.55, h * 0.67),
        width: w * 0.60,
        height: h * 0.035,
      ),
      lakePaint,
    );

    final nearHill = Path()
      ..moveTo(0, h * 0.71)
      ..quadraticBezierTo(w * 0.30, h * 0.64, w * 0.60, h * 0.73)
      ..quadraticBezierTo(w * 0.85, h * 0.79, w, h * 0.70)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    final nearPaint = Paint()
      ..color = Color.lerp(base, Colors.black, 0.38) ?? base;
    canvas.drawPath(nearHill, nearPaint);

    // ---------- شاخه‌های گل دو طرف ----------
    _drawSprig(canvas, Offset(w * 0.03, h), h * 0.34, 0.10);
    _drawSprig(canvas, Offset(w * 0.10, h), h * 0.22, -0.06);
    _drawSprig(canvas, Offset(w * 0.97, h), h * 0.36, -0.10);
    _drawSprig(canvas, Offset(w * 0.90, h), h * 0.24, 0.07);
  }

  /// یک ساقه‌ی خمیده با شکوفه‌های کوچک در دو طرف.
  void _drawSprig(Canvas canvas, Offset root, double height, double lean) {
    final tip = Offset(root.dx + lean * height, root.dy - height);
    final control = Offset(
      root.dx - lean * height * 0.6,
      root.dy - height * 0.55,
    );

    final stem = Path()
      ..moveTo(root.dx, root.dy)
      ..quadraticBezierTo(control.dx, control.dy, tip.dx, tip.dy);
    final stemPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = Colors.white.withValues(alpha: 0.20);
    canvas.drawPath(stem, stemPaint);

    final blossomPaint = Paint();
    for (var i = 2; i <= 10; i++) {
      final t = i / 10;
      final mt = 1 - t;
      final x = mt * mt * root.dx + 2 * mt * t * control.dx + t * t * tip.dx;
      final y = mt * mt * root.dy + 2 * mt * t * control.dy + t * t * tip.dy;
      final side = i.isEven ? 1.0 : -1.0;
      final radius = 4.6 - t * 2.6;

      blossomPaint.color = (i % 3 == 0 ? flower : accent).withValues(
        alpha: 0.50,
      );
      canvas.drawCircle(
        Offset(x + side * (6 - t * 3), y),
        radius,
        blossomPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _NightSkyPainter oldDelegate) {
    return oldDelegate.base != base ||
        oldDelegate.accent != accent ||
        oldDelegate.flower != flower ||
        oldDelegate.moonOnLeft != moonOnLeft;
  }
}
