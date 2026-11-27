import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:little_moon/core/utils/haptics.dart';
import 'package:little_moon/domain/engine/cycle_models.dart';
import 'package:little_moon/shared/animations/soft_motion.dart';

import 'phase_layout.dart';
import 'ring_drag.dart';

const double _twoPi = math.pi * 2;
const double _halfPi = math.pi / 2;

/// ستاره‌ی چهارپر (✦) به شعاع [r] دور [c].
Path sparklePath(Offset c, double r) {
  final k = r * 0.22;
  return Path()
    ..moveTo(c.dx, c.dy - r)
    ..quadraticBezierTo(c.dx + k, c.dy - k, c.dx + r, c.dy)
    ..quadraticBezierTo(c.dx + k, c.dy + k, c.dx, c.dy + r)
    ..quadraticBezierTo(c.dx - k, c.dy + k, c.dx - r, c.dy)
    ..quadraticBezierTo(c.dx - k, c.dy - k, c.dx, c.dy - r)
    ..close();
}

/// آیکون ستاره‌ی چهارپر هم‌اندازه‌ی آیکون‌های متریال.
class SparkleIcon extends StatelessWidget {
  final double size;
  final Color color;

  const SparkleIcon({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _SparklePainter(color),
    );
  }
}

class _SparklePainter extends CustomPainter {
  final Color color;

  const _SparklePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      sparklePath(size.center(Offset.zero), size.width / 2),
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(_SparklePainter old) => old.color != color;
}

/// لایه‌ی ثابت ماه: مدار (کمان پیشرفت + خط‌چین آینده) و ماه با دیسک کم‌رنگ.
/// فقط وقتی [progress] یا رنگ‌ها عوض بشن دوباره کشیده می‌شه؛ هاله‌ی
/// تارِ ماه همین‌جاست تا در هر فریم انیمیشن حساب نشه.
class MoonCrescentPainter extends CustomPainter {
  final double progress;
  final Color startColor;
  final Color endColor;
  final CyclePhaseLayout layout;
  final CyclePhase phase;

  const MoonCrescentPainter({
    required this.progress,
    required this.startColor,
    required this.endColor,
    required this.layout,
    required this.phase,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final orbit = size.shortestSide / 2 - 2;
    final p = progress.clamp(0.0, 1.0);

    _paintOrbit(canvas, center, orbit, p);
    _paintMoon(canvas, center, orbit, p);
  }

  /// گذشته‌ی چرخه: کمان گرادیانی با سر گرد. آینده: خط‌چین کم‌رنگ.
  void _paintOrbit(Canvas canvas, Offset center, double orbit, double p) {
    final rect = Rect.fromCircle(center: center, radius: orbit);
    final sweep = p * _twoPi;

    // آینده (خط‌چین) از سرِ کمان تا بالای مدار؛ هر تکه به رنگ فازش
    final dashPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    final dash = 3.0 / orbit;
    final gap = 4.5 / orbit;
    for (var a = sweep; a < _twoPi - 0.01; a += dash + gap) {
      final len = math.min(dash, _twoPi - a);
      dashPaint.color = CyclePhaseLayout.colorOf(
        layout.phaseAt((a + len / 2) / _twoPi),
      ).withValues(alpha: 0.60);
      canvas.drawArc(rect, a - _halfPi, len, false, dashPaint);
    }

    // گذشته (کمان گرادیانی)
    if (sweep > 0.01) {
      canvas.drawArc(
        rect,
        -_halfPi,
        sweep,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.4
          ..strokeCap = StrokeCap.round
          ..shader = SweepGradient(
            startAngle: 0,
            endAngle: _twoPi,
            colors: [startColor, endColor, endColor],
            stops: [0.0, p.clamp(0.01, 1.0), 1.0],
            transform: const GradientRotation(-_halfPi),
          ).createShader(rect),
      );
    }

    // ستاره‌ی ریز روی روز تخمک‌گذاری
    final star =
        center +
        Offset.fromDirection(layout.ovulationFraction * _twoPi - _halfPi, orbit);
    canvas.drawPath(
      sparklePath(star, 4.4),
      Paint()
        ..color = CyclePhaseLayout.colorOf(CyclePhase.ovulation),
    );
  }

  /// دیسک کامل (خیلی کم‌رنگ، مثل نور زمین روی ماه) + بخش روشن با لبه‌ی
  /// درخشان و چند دهانه.
  void _paintMoon(Canvas canvas, Offset center, double orbit, double p) {
    // هرچه چرخه جلوتر می‌ره، دیسکِ برش‌دهنده دورتر می‌شه و ماه پُرتر؛
    // آخر چرخه ماه کامله.
    final r = orbit * 0.62;
    final cut = r * (0.20 + 1.70 * p);
    final lit = Path.combine(
      PathOperation.difference,
      Path()..addOval(Rect.fromCircle(center: Offset.zero, radius: r)),
      Path()
        ..addOval(
          Rect.fromCircle(center: Offset(cut, cut * 0.35), radius: r * 0.85),
        ),
    );
    final discRect = Rect.fromCircle(center: Offset.zero, radius: r);
    // رنگ و هاله‌ی ماه با فاز عوض می‌شه
    final tint = CyclePhaseLayout.colorOf(phase);
    final mix = CyclePhaseLayout.moonMix(phase);
    final litStart = Color.lerp(startColor, tint, mix)!;
    final litEnd = Color.lerp(endColor, tint, mix * 0.6)!;
    final glow = Color.lerp(startColor, tint, 0.7)!;
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [litStart, litEnd],
    ).createShader(discRect);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-0.35);

    // دیسک کم‌رنگ: ماه حتی وقتی هلال خیلی باریکه خوانا می‌مونه
    canvas.drawCircle(
      Offset.zero,
      r,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            startColor.withValues(alpha: 0.16),
            endColor.withValues(alpha: 0.10),
          ],
        ).createShader(discRect),
    );
    canvas.drawCircle(
      Offset.zero,
      r,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8
        ..color = startColor.withValues(alpha: 0.22),
    );

    // هاله‌ی تار و بخش روشن
    canvas.drawPath(
      lit,
      Paint()
        ..color = glow.withValues(alpha: CyclePhaseLayout.glowAlpha(phase))
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          CyclePhaseLayout.glowBlur(phase),
        ),
    );
    canvas.drawPath(lit, Paint()..shader = gradient);

    // لبه‌ی روشن و دهانه‌ها فقط روی بخش روشن
    canvas.save();
    canvas.clipPath(lit);
    canvas.drawCircle(
      Offset.zero,
      r - 0.6,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = Colors.white.withValues(alpha: 0.65),
    );
    final crater = Paint()
      ..color = Color.lerp(endColor, Colors.black, 0.30)!.withValues(
        alpha: 0.20,
      );
    for (final c in _craters) {
      canvas.drawCircle(Offset(c.dx * r, c.dy * r), c.dz * r, crater);
    }
    canvas.restore();

    canvas.restore();
  }

  // (x، y، شعاع) نسبت به شعاع ماه
  static const _craters = <({double dx, double dy, double dz})>[
    (dx: -0.32, dy: -0.26, dz: 0.16),
    (dx: 0.08, dy: 0.32, dz: 0.11),
    (dx: -0.50, dy: 0.18, dz: 0.08),
    (dx: 0.34, dy: -0.42, dz: 0.07),
  ];

  @override
  bool shouldRepaint(MoonCrescentPainter old) =>
      old.progress != progress ||
      old.startColor != startColor ||
      old.endColor != endColor ||
      old.layout != layout ||
      old.phase != phase;
}

/// لایه‌ی متحرک: ستاره‌های چشمک‌زن، ستاره‌ی دنباله‌دار و نقطه‌ی «امروز» با
/// هاله‌ی نفس‌کش. با [clock] (یک AnimationController مشترک، یک دور = ۲۰ ثانیه)
/// بدون rebuild فقط خودش دوباره کشیده می‌شه. با [motion] = false همه‌چیز
/// ثابته («کاهش حرکت»).
class MoonSkyPainter extends CustomPainter {
  final double progress;
  final Color startColor;
  final Animation<double> clock;
  final bool motion;

  MoonSkyPainter({
    required this.progress,
    required this.startColor,
    required this.clock,
    required this.motion,
  }) : super(repaint: clock);

  // بازه‌ی عبور ستاره‌ی دنباله‌دار در هر دور (حدود ۱٫۲ ثانیه)
  static const _shootStart = 0.40;
  static const _shootEnd = 0.46;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final orbit = size.shortestSide / 2 - 2;
    final t = motion ? clock.value : 0.0;

    // ستاره‌ها: سه ستاره با سرعت و تأخیر متفاوت (تعداد دورِ صحیح در هر
    // ۲۰ ثانیه تا دور آخر و اول بدون پرش بهم برسن)
    const stars = <({double x, double y, double r, int cycles, double phase})>[
      (x: 0.62, y: -0.34, r: 0.10, cycles: 3, phase: 0.0),
      (x: -0.78, y: 0.62, r: 0.06, cycles: 4, phase: 0.35),
      (x: -0.50, y: -0.86, r: 0.05, cycles: 5, phase: 0.7),
    ];
    final starPaint = Paint();
    for (final s in stars) {
      final tw = motion
          ? 0.5 + 0.5 * math.sin(_twoPi * (s.cycles * t + s.phase))
          : 1.0;
      starPaint.color = startColor.withValues(alpha: 0.30 + 0.60 * tw);
      canvas.drawPath(
        sparklePath(
          center + Offset(orbit * s.x, orbit * s.y),
          orbit * s.r * (0.85 + 0.15 * tw),
        ),
        starPaint,
      );
    }

    if (motion && t >= _shootStart && t < _shootEnd) {
      _paintShootingStar(canvas, size, (t - _shootStart) / (_shootEnd - _shootStart));
    }

    // نقطه‌ی امروز: هاله‌ی نرم که بزرگ و کوچک می‌شه (۶ نفس در هر دور)
    final pulse = motion ? 0.5 + 0.5 * math.sin(_twoPi * 6 * t) : 0.5;
    final dot =
        center +
        Offset.fromDirection(progress.clamp(0.0, 1.0) * _twoPi - _halfPi, orbit);
    final haloR = 8.0 + 4.0 * pulse;
    canvas.drawCircle(
      dot,
      haloR,
      Paint()
        ..shader = RadialGradient(
          colors: [
            startColor.withValues(alpha: 0.50),
            startColor.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: dot, radius: haloR)),
    );
    canvas.drawCircle(dot, 3.4, Paint()..color = startColor);
    canvas.drawCircle(
      dot,
      1.3,
      Paint()..color = Colors.white.withValues(alpha: 0.85),
    );
  }

  /// [u] از ۰ تا ۱: ستاره از گوشه‌ی بالا-راست به سمت چپ-پایین می‌ره و محو می‌شه.
  void _paintShootingStar(Canvas canvas, Size size, double u) {
    final from = Offset(size.width * 1.0, size.height * 0.02);
    final to = Offset(size.width * 0.55, size.height * 0.30);
    final head = Offset.lerp(from, to, Curves.easeOut.transform(u))!;
    final dir = (to - from) / (to - from).distance;
    final fade = math.sin(math.pi * u);
    final tail = head - dir * (size.width * 0.28 * fade);

    canvas.drawLine(
      tail,
      head,
      Paint()
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round
        ..shader = ui.Gradient.linear(tail, head, [
          startColor.withValues(alpha: 0),
          startColor.withValues(alpha: 0.9 * fade),
        ]),
    );
    canvas.drawCircle(
      head,
      1.4,
      Paint()..color = Colors.white.withValues(alpha: 0.9 * fade),
    );
  }

  @override
  bool shouldRepaint(MoonSkyPainter old) =>
      old.progress != progress ||
      old.startColor != startColor ||
      old.motion != motion;
}

/// ماهِ کارت چرخه: اولین بار نرم پُر می‌شه (کمان و نقطه‌ی امروز از اول مدار
/// تا امروز می‌چرخن)، بعد ملایم «نفس می‌کشه»، ستاره‌ها چشمک می‌زنن و با
/// لمس نرم می‌پره. انگشت رو روی مدار بکشی نقطه دنبالش میاد و ماه و فاز اون
/// روز پیش‌نمایش داده می‌شه ([onPreview] با کسر روی مدار، و در پایان `null`).
/// یک AnimationController مشترک برای همه‌ی حرکت‌های بی‌پایان.
class MoonArt extends StatefulWidget {
  final double size;
  final double progress;
  final Color startColor;
  final Color endColor;
  final CyclePhaseLayout layout;
  final CyclePhase phase;
  final VoidCallback? onTap;
  final ValueChanged<double?>? onPreview;

  const MoonArt({
    super.key,
    required this.size,
    required this.progress,
    required this.startColor,
    required this.endColor,
    required this.layout,
    required this.phase,
    this.onTap,
    this.onPreview,
  });

  @override
  State<MoonArt> createState() => _MoonArtState();
}

class _MoonArtState extends State<MoonArt>
    with SingleTickerProviderStateMixin {
  late final AnimationController _clock = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 20),
  );
  bool _pop = false;

  /// جای انگشت روی مدار وقتی کاربر داره می‌کشه، وگرنه `null`.
  double? _drag;
  CyclePhase? _dragPhase;
  Duration _settle = const Duration(milliseconds: 1400);

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

  void _handleTap() {
    widget.onTap?.call();
    if (reduceMotion(context)) return;
    setState(() => _pop = true);
    Future<void>.delayed(const Duration(milliseconds: 140), () {
      if (mounted) setState(() => _pop = false);
    });
  }

  void _onDrag(double fraction) {
    final phase = widget.layout.phaseAt(fraction);
    // با رد شدن از مرز هر فاز یک تیک ظریف
    if (_dragPhase != null && _dragPhase != phase) Haptics.tap();
    _dragPhase = phase;
    setState(() => _drag = fraction);
    widget.onPreview?.call(fraction);
  }

  void _onDragEnd() {
    setState(() {
      _drag = null;
      _settle = const Duration(milliseconds: 700);
    });
    _dragPhase = null;
    widget.onPreview?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    final motion = !reduceMotion(context);
    final drag = _drag;
    final shown = drag ?? widget.progress;
    final phase = drag == null ? widget.phase : widget.layout.phaseAt(drag);

    return SizedBox.square(
      dimension: widget.size,
      child: RingDragDetector(
        ringInset: 2,
        innerReach: 11,
        outerReach: 4,
        onFraction: _onDrag,
        onEnd: _onDragEnd,
        onTap: widget.onTap == null ? null : _handleTap,
        child: GestureDetector(
          onTap: widget.onTap == null ? null : _handleTap,
          behavior: HitTestBehavior.opaque,
          child: AnimatedScale(
            scale: _pop ? 1.14 : 1.0,
            duration: Duration(milliseconds: _pop ? 140 : 520),
            curve: _pop ? Curves.easeOut : Curves.elasticOut,
            child: Breathing(
              child: AnimatedProgress(
                value: shown,
                // وسط کشیدن بدون تأخیر؛ بعد از رها کردن نرم برمی‌گرده
                duration: drag != null ? Duration.zero : _settle,
                builder: (context, value) => Stack(
                  fit: StackFit.expand,
                  children: [
                    RepaintBoundary(
                      child: CustomPaint(
                        painter: MoonCrescentPainter(
                          progress: value,
                          startColor: widget.startColor,
                          endColor: widget.endColor,
                          layout: widget.layout,
                          phase: phase,
                        ),
                      ),
                    ),
                    CustomPaint(
                      painter: MoonSkyPainter(
                        progress: value,
                        startColor: widget.startColor,
                        clock: _clock,
                        motion: motion,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
