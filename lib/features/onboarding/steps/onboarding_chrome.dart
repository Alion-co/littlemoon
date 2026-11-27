import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/shared/widgets/moon_logo.dart';

import 'onboarding_palette.dart';

/// پس‌زمینه‌ی گرادیانیِ نرم (بلاش ← یاسی ملایم) با درخشش بالا و چند ستاره‌ی
/// طلایی.
class OnboardingBackground extends StatelessWidget {
  final Widget child;

  const OnboardingBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final p = OnboardingPalette.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [p.bgTop, p.bgBottom],
        ),
      ),
      child: CustomPaint(
        painter: _BackdropPainter(glow: p.glow, gold: p.gold),
        child: child,
      ),
    );
  }
}

class _BackdropPainter extends CustomPainter {
  final Color glow;
  final Color gold;

  _BackdropPainter({required this.glow, required this.gold});

  // موقعیت (نسبی) و اندازه‌ی هر ستاره
  static const _stars = <(double, double, double)>[
    (0.10, 0.12, 8),
    (0.90, 0.28, 5),
    (0.07, 0.60, 6),
    (0.92, 0.74, 9),
    (0.20, 0.92, 5),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    // درخشش نرم بالای صفحه
    final glowRect = Rect.fromCircle(
      center: Offset(size.width * 0.5, size.height * 0.10),
      radius: size.width * 0.75,
    );
    canvas.drawRect(
      glowRect,
      Paint()
        ..shader = RadialGradient(colors: [glow, glow.withValues(alpha: 0)])
            .createShader(glowRect),
    );

    final paint = Paint()..color = gold.withValues(alpha: 0.55);
    for (final (x, y, r) in _stars) {
      final c = Offset(x * size.width, y * size.height);
      final path = Path()
        ..moveTo(c.dx, c.dy - r)
        ..quadraticBezierTo(c.dx, c.dy, c.dx + r, c.dy)
        ..quadraticBezierTo(c.dx, c.dy, c.dx, c.dy + r)
        ..quadraticBezierTo(c.dx, c.dy, c.dx - r, c.dy)
        ..quadraticBezierTo(c.dx, c.dy, c.dx, c.dy - r)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BackdropPainter old) =>
      old.glow != glow || old.gold != gold;
}

/// نوار بالا: دکمه‌ی برگشتِ گردِ ظریف، نوار پیشرفت و ماه کوچک.
/// چیدمان مثل طرح ثابته (برگشت چپ، ماه راست).
class OnboardingTopBar extends StatelessWidget {
  final int stepCount;
  final int current;
  final VoidCallback onBack;

  const OnboardingTopBar({
    super.key,
    required this.stepCount,
    required this.current,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
        child: Row(
          children: [
            _BackButton(onTap: onBack),
            const SizedBox(width: 18),
            Expanded(
              child: _Progress(stepCount: stepCount, current: current),
            ),
            const SizedBox(width: 18),
            const MoonEmblem(size: 48),
          ],
        ),
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  final int stepCount;
  final int current;

  const _Progress({required this.stepCount, required this.current});

  @override
  Widget build(BuildContext context) {
    final p = OnboardingPalette.of(context);
    final on = p.buttonEnd;
    final off = p.deep.withValues(alpha: 0.18);

    return Row(
      children: [
        for (var i = 0; i < stepCount; i++) ...[
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: i == current ? 15 : 7,
            height: i == current ? 15 : 7,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: i == current ? Border.all(color: p.gold, width: 1) : null,
            ),
            child: Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i <= current ? on : off,
              ),
            ),
          ),
          if (i < stepCount - 1)
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 1.5,
                color: i < current ? on : off,
              ),
            ),
        ],
      ],
    );
  }
}

/// دکمه‌ی اصلی: گرادیانِ رزِ عمیق، سایه‌ی نرم و خط طلایی ظریف. جمع‌وجور و
/// وسط‌چین، با یک فلشِ کوچک؛ با لمس کمی کوچیک می‌شه.
class OnboardingPillButton extends StatefulWidget {
  final String label;
  final bool busy;
  final VoidCallback onPressed;

  const OnboardingPillButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.busy = false,
  });

  @override
  State<OnboardingPillButton> createState() => _OnboardingPillButtonState();
}

class _OnboardingPillButtonState extends State<OnboardingPillButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final p = OnboardingPalette.of(context);
    const radius = BorderRadius.all(Radius.circular(30));

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
      child: Center(
        child: AnimatedScale(
          scale: _pressed ? 0.96 : 1,
          duration: const Duration(milliseconds: 120),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: radius,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [p.buttonStart, p.buttonEnd],
              ),
              boxShadow: [
                BoxShadow(
                  color: p.buttonShadow,
                  blurRadius: 22,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            foregroundDecoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(
                color: p.gold.withValues(alpha: 0.7),
                width: 0.8,
              ),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: radius,
                onTap: widget.busy ? null : widget.onPressed,
                onHighlightChanged: (value) => setState(() => _pressed = value),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 200,
                    minHeight: 52,
                  ),
                  child: Center(
                    widthFactor: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      child: widget.busy
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.2,
                                color: Colors.white,
                              ),
                            )
                          : Directionality(
                              textDirection: TextDirection.ltr,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    widget.label,
                                    style: context.text.titleMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withValues(
                                        alpha: 0.22,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 15,
                                      color: Colors.white,
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
        ),
      ),
    );
  }
}

/// دکمه‌ی برگشتِ گردِ شیشه‌ای به سبک iOS: تار شدنِ پس‌زمینه، فلشِ نازک،
/// لبه‌ی براق و سایه‌ی نرم؛ با لمس کمی کوچیک می‌شه.
class _BackButton extends StatefulWidget {
  final VoidCallback onTap;

  const _BackButton({required this.onTap});

  @override
  State<_BackButton> createState() => _BackButtonState();
}

class _BackButtonState extends State<_BackButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final p = OnboardingPalette.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.9 : 1,
        duration: const Duration(milliseconds: 120),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: p.buttonShadow.withValues(alpha: 0.16),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.85),
                      Colors.white.withValues(alpha: 0.35),
                    ],
                  ),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.9),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: CustomPaint(
                    size: const Size(11, 19),
                    painter: _ChevronPainter(p.deep),
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

/// فلشِ برگشتِ پُرنگ و گوشه‌گرد (ضخامت ۳) به سبک iOS.
class _ChevronPainter extends CustomPainter {
  final Color color;

  _ChevronPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(0, size.height / 2)
      ..lineTo(size.width, size.height);
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant _ChevronPainter old) => old.color != color;
}

/// ستاره‌ی چهارپرِ کوچک (✦) برای خط‌جداکننده‌ها.
class SparkleMark extends StatelessWidget {
  final double size;
  final Color color;

  const SparkleMark({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) =>
      CustomPaint(size: Size.square(size), painter: _SparkleMarkPainter(color));
}

class _SparkleMarkPainter extends CustomPainter {
  final Color color;

  _SparkleMarkPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.width / 2;
    final path = Path()
      ..moveTo(c.dx, c.dy - r)
      ..quadraticBezierTo(c.dx, c.dy, c.dx + r, c.dy)
      ..quadraticBezierTo(c.dx, c.dy, c.dx, c.dy + r)
      ..quadraticBezierTo(c.dx, c.dy, c.dx - r, c.dy)
      ..quadraticBezierTo(c.dx, c.dy, c.dx, c.dy - r)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _SparkleMarkPainter old) => old.color != color;
}
