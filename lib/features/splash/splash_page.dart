import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/data/repositories/profile_repository.dart';
import 'package:little_moon/shared/widgets/glass.dart';

/// اسپلش Little Moon:
/// فقط نوشته‌ی برند (بدون آیکون ماه)، با خط‌های رزگلد که یکی‌یکی کشیده می‌شن
/// و ستاره‌هایی که ظاهر می‌شن و چشمک می‌زنن.
///
/// رنگ‌ها از تم فعلی برنامه میان (primary، secondary و پس‌زمینه‌ی تم)، پس
/// اسپلش با بقیه‌ی برنامه هماهنگه؛ در تم‌های شب هم پس‌زمینه‌ی شبانه و نوشته‌ی
/// روشن داره.
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with TickerProviderStateMixin {
  static const _animDuration = Duration(milliseconds: 3000);
  static const _hold = Duration(milliseconds: 500);

  late final AnimationController _main;
  late final AnimationController _twinkle;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _main = AnimationController(vsync: this, duration: _animDuration);
    _twinkle = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    // اگه کاربر انیمیشن‌ها رو در تنظیمات گوشی خاموش کرده، مستقیم حالت نهایی
    final reduce = WidgetsBinding
        .instance
        .platformDispatcher
        .accessibilityFeatures
        .disableAnimations;

    if (reduce) {
      _main.value = 1;
    } else {
      _main.forward();
      _twinkle.repeat(reverse: true);
    }

    _timer = Timer(reduce ? const Duration(milliseconds: 900) : _animDuration + _hold, () {
      if (!mounted) return;
      // بار اول → راه‌اندازی اولیه، بعدش مستقیم خانه
      final done = ref.read(profileProvider).onboardingDone;
      context.go(done ? '/home' : '/onboarding');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _main.dispose();
    _twinkle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = _SplashPalette.of(context);
    final night = palette.night;
    final iconBrightness = night ? Brightness.light : Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // نوار پایین کاملاً شفاف و بدون اسکریم؛ این استایل کل استایل بالاتر
      // (main.dart) رو جایگزین می‌کنه، پس systemNavigationBarContrastEnforced
      // باید همین‌جا هم false باشه، وگرنه اندروید یه نوار سفید زیر
      // گرادیان می‌کشه.
      value: (night ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark)
          .copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
        systemNavigationBarIconBrightness: iconBrightness,
      ),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [palette.bgTop, palette.bgBottom],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: _designW,
                    height: _designH,
                    child: Stack(
                      children: [
                        // خط‌ها و ستاره‌ها
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _OrnamentPainter(_main, _twinkle, palette),
                          ),
                        ),
                        // نوشته‌ی برند
                        Positioned.fill(
                          child: AnimatedBuilder(
                            animation: _main,
                            builder: (context, _) =>
                                _Wordmark(t: _main.value, palette: palette),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ───────────────────────── رنگ‌ها و اندازه‌ها ─────────────────────────

/// رنگ‌های اسپلش، گرفته‌شده از تم فعلی.
@immutable
class _SplashPalette {
  const _SplashPalette({
    required this.night,
    required this.bgTop,
    required this.bgBottom,
    required this.textLight,
    required this.textDark,
    required this.shine,
    required this.roseA,
    required this.roseB,
  });

  final bool night;
  final Color bgTop;
  final Color bgBottom;
  final Color textLight;
  final Color textDark;

  /// درخششِ نوری که روی نوشته می‌گذره
  final Color shine;

  /// دو سرِ گرادیان خط‌ها و ستاره‌ها
  final Color roseA;
  final Color roseB;

  factory _SplashPalette.of(BuildContext context) {
    final scheme = context.scheme;
    final base = Theme.of(context).scaffoldBackgroundColor;
    final night = isNightTheme(context);

    if (night) {
      // مثل آسمان شبِ صفحه‌ی خانه
      return _SplashPalette(
        night: true,
        bgTop: Color.lerp(base, Colors.black, 0.30) ?? base,
        bgBottom: Color.lerp(base, scheme.secondary, 0.20) ?? base,
        textLight: Color.lerp(scheme.primary, Colors.white, 0.80)!,
        textDark: Color.lerp(scheme.primary, Colors.white, 0.50)!,
        shine: Colors.white,
        roseA: Color.lerp(scheme.secondary, Colors.white, 0.25)!,
        roseB: Color.lerp(scheme.primary, Colors.white, 0.15)!,
      );
    }

    return _SplashPalette(
      night: false,
      bgTop: Color.lerp(base, scheme.primary, 0.07) ?? base,
      bgBottom: Color.lerp(base, scheme.primary, 0.20) ?? base,
      textLight: Color.lerp(scheme.primary, Colors.white, 0.10)!,
      textDark: Color.lerp(scheme.primary, Colors.black, 0.40)!,
      shine: Color.lerp(scheme.primary, Colors.white, 0.60)!,
      roseA: scheme.secondary,
      roseB: scheme.primary,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is _SplashPalette &&
      other.night == night &&
      other.bgTop == bgTop &&
      other.bgBottom == bgBottom &&
      other.textLight == textLight &&
      other.textDark == textDark &&
      other.shine == shine &&
      other.roseA == roseA &&
      other.roseB == roseB;

  @override
  int get hashCode => Object.hash(
    night,
    bgTop,
    bgBottom,
    textLight,
    textDark,
    shine,
    roseA,
    roseB,
  );
}

/// فضای طراحی؛ همه‌ی مختصات پایین توی همین قاب ۶۰۰×۱۸۰ هستن و FittedBox
/// اون رو با اندازه‌ی صفحه مقیاس می‌کنه.
const _designW = 600.0;
const _designH = 180.0;

// ───────────────────────── زمان‌بندی (۰ تا ۱ روی کل انیمیشن) ─────────────────────────

double _seg(double v, double begin, double end, Curve curve) {
  if (v <= begin) return 0;
  if (v >= end) return 1;
  return curve.transform((v - begin) / (end - begin));
}

// ───────────────────────── نوشته‌ی برند ─────────────────────────

class _Wordmark extends StatelessWidget {
  const _Wordmark({required this.t, required this.palette});

  final double t;
  final _SplashPalette palette;

  @override
  Widget build(BuildContext context) {
    final appear = _seg(t, 0.0, 0.30, Curves.easeOutCubic);

    // درخششِ نوری که یک‌بار روی نوشته می‌گذره (بعد از ظاهر شدن)
    final sweep = _seg(t, 0.55, 0.95, Curves.easeInOut);
    final pos = -0.25 + sweep * 1.5;
    double c(double v) => v.clamp(0.0, 1.0);

    return Opacity(
      opacity: appear,
      child: Transform.translate(
        offset: Offset(0, 8 * (1 - appear)),
        child: Align(
          alignment: const Alignment(0, 0.02),
          child: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  palette.textLight,
                  palette.textLight,
                  palette.shine,
                  palette.textDark,
                  palette.textDark,
                ],
                stops: [0, c(pos - 0.18), c(pos), c(pos + 0.18), 1],
              ).createShader(rect);
            },
            child: const Text(
              'Little Moon',
              maxLines: 1,
              style: TextStyle(
                // یه فونت سریف شیک (مثلاً Cormorant Garamond) توی pubspec
                // اضافه کن؛ تا وقتی نیست، فونت serif سیستم استفاده می‌شه.
                fontFamily: 'CormorantGaramond',
                fontFamilyFallback: ['serif'],
                fontSize: 76,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
                height: 1.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ───────────────────────── خط‌ها و ستاره‌ها ─────────────────────────

class _Line {
  _Line({
    required this.path,
    required this.begin,
    required this.end,
    required this.width,
  }) : metric = path.computeMetrics().first;

  final Path path;
  final ui.PathMetric metric;
  final double begin;
  final double end;
  final double width;
}

class _Star {
  const _Star(this.center, this.radius, this.begin, this.phase);

  final Offset center;
  final double radius;
  final double begin;
  final double phase;
}

final List<_Line> _lines = [
  // خط زیر نوشته، از چپ
  _Line(
    path: Path()
      ..moveTo(98, 148)
      ..cubicTo(165, 168, 262, 162, 324, 130),
    begin: 0.12,
    end: 0.52,
    width: 2.6,
  ),
  // قوس بزرگ بالا و راستِ نوشته
  _Line(
    path: Path()
      ..moveTo(396, 68)
      ..cubicTo(440, 32, 520, 12, 568, 40)
      ..cubicTo(602, 60, 606, 96, 584, 120),
    begin: 0.25,
    end: 0.72,
    width: 2.8,
  ),
  // قوس کوچکِ پایین‌راست
  _Line(
    path: Path()
      ..moveTo(420, 140)
      ..cubicTo(474, 164, 552, 152, 592, 112),
    begin: 0.38,
    end: 0.80,
    width: 2.0,
  ),
];

const List<_Star> _stars = [
  _Star(Offset(574, 62), 17, 0.46, 0.0), // ستاره‌ی بزرگ
  _Star(Offset(84, 126), 6, 0.52, 0.3),
  _Star(Offset(400, 40), 5, 0.58, 0.6),
  _Star(Offset(618, 40), 4, 0.64, 0.15),
  _Star(Offset(618, 88), 3.5, 0.70, 0.75),
  _Star(Offset(393, 156), 4, 0.76, 0.45),
  _Star(Offset(540, 156), 4.5, 0.82, 0.9),
];

class _OrnamentPainter extends CustomPainter {
  _OrnamentPainter(this.main, this.twinkle, this.palette)
    : super(repaint: Listenable.merge([main, twinkle]));

  final Animation<double> main;
  final Animation<double> twinkle;
  final _SplashPalette palette;

  @override
  void paint(Canvas canvas, Size size) {
    final t = main.value;

    for (final line in _lines) {
      final p = _seg(t, line.begin, line.end, Curves.easeInOutCubic);
      if (p > 0) _drawLine(canvas, line, p);
    }

    for (final s in _stars) {
      final p = _seg(t, s.begin, s.begin + 0.18, Curves.easeOutBack);
      if (p > 0) _drawStar(canvas, s, p);
    }
  }

  /// خط با ضخامت متغیر (کلفت وسط، نازک دو سر) که تا درصد [p] کشیده شده
  void _drawLine(Canvas canvas, _Line line, double p) {
    final total = line.metric.length;
    final visible = total * p;
    final steps = (visible / 3).ceil().clamp(2, 240);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < steps; i++) {
      final d0 = visible * i / steps;
      final d1 = visible * (i + 1) / steps;
      final p0 = line.metric.getTangentForOffset(d0)?.position;
      final p1 = line.metric.getTangentForOffset(d1)?.position;
      if (p0 == null || p1 == null) continue;

      final u = ((d0 + d1) / 2) / total;
      final taper = math.pow(math.sin(math.pi * u), 0.7).toDouble();
      paint
        ..strokeWidth = line.width * taper.clamp(0.18, 1.0)
        ..color = Color.lerp(palette.roseA, palette.roseB, u)!;
      canvas.drawLine(p0, p1, paint);
    }

    // نقطه‌ی درخشان روی نوکِ خط، تا وقتی داره کشیده می‌شه
    if (p < 1) {
      final tip = line.metric.getTangentForOffset(visible)?.position;
      if (tip != null) {
        canvas.drawCircle(
          tip,
          4,
          Paint()
            ..color = const Color(0xCCFFE3D6)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
        );
        canvas.drawCircle(tip, 1.6, Paint()..color = Colors.white);
      }
    }
  }

  /// ستاره‌ی چهارپر خمیده، با ظاهر شدن (scale) و چشمک ملایم
  void _drawStar(Canvas canvas, _Star s, double p) {
    final tw = 0.5 + 0.5 * math.sin((twinkle.value + s.phase) * math.pi * 2);
    final pulse = p >= 1 ? 1.0 + 0.14 * tw : p;
    final r = s.radius * pulse;
    final k = r * 0.14;
    final c = s.center;

    final path = Path()
      ..moveTo(c.dx, c.dy - r)
      ..quadraticBezierTo(c.dx + k, c.dy - k, c.dx + r, c.dy)
      ..quadraticBezierTo(c.dx + k, c.dy + k, c.dx, c.dy + r)
      ..quadraticBezierTo(c.dx - k, c.dy + k, c.dx - r, c.dy)
      ..quadraticBezierTo(c.dx - k, c.dy - k, c.dx, c.dy - r)
      ..close();

    final alpha = p.clamp(0.0, 1.0);

    // هاله
    canvas.drawCircle(
      c,
      r * 0.9,
      Paint()
        ..color = palette.roseA.withValues(
          alpha: 0.35 * alpha * (0.6 + 0.4 * tw),
        )
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.5),
    );

    // خودِ ستاره
    canvas.drawPath(
      path,
      Paint()
        ..shader = ui.Gradient.linear(
          Offset(c.dx - r, c.dy - r),
          Offset(c.dx + r, c.dy + r),
          [
            palette.roseA.withValues(alpha: alpha),
            palette.roseB.withValues(alpha: alpha),
          ],
        ),
    );
  }

  @override
  bool shouldRepaint(covariant _OrnamentPainter old) =>
      old.palette != palette;
}
