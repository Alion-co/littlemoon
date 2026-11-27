import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// وقتی کاربر در تنظیمات گوشی «کاهش حرکت» رو روشن کرده، انیمیشن‌ها
/// (غیر از تغییر خود مقدار) اجرا نمی‌شن.
bool reduceMotion(BuildContext context) =>
    MediaQuery.disableAnimationsOf(context);

/// جایگزینی نرم محتوا: وقتی `key` بچه عوض بشه، قبلی محو و جدید با کمی
/// حرکت از پایین میاد (مثلاً عوض شدن فاز یا شماره‌ی روز).
class SoftSwitcher extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final AlignmentGeometry alignment;

  const SoftSwitcher({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 380),
    this.alignment = AlignmentDirectional.centerStart,
  });

  @override
  Widget build(BuildContext context) {
    if (reduceMotion(context)) return child;

    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      layoutBuilder: (current, previous) => Stack(
        alignment: alignment,
        children: [...previous, if (current != null) current],
      ),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.25),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      ),
      child: child,
    );
  }
}

/// مقدار رو نرم به مقدار جدید می‌رسونه: بار اول از صفر پُر می‌شه
/// (مثل حلقه‌ی چرخه)، و با تغییر مقدار از همون‌جا که هست ادامه می‌ده.
class AnimatedProgress extends StatelessWidget {
  final double value;
  final Duration duration;
  final Widget Function(BuildContext context, double value) builder;

  const AnimatedProgress({
    super.key,
    required this.value,
    required this.builder,
    this.duration = const Duration(milliseconds: 1100),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value),
      duration: reduceMotion(context) ? Duration.zero : duration,
      curve: Curves.easeOutCubic,
      builder: (context, current, _) => builder(context, current),
    );
  }
}

/// «نفس کشیدن»: بزرگ و کوچک شدن خیلی ملایم و بی‌پایان.
class Breathing extends StatelessWidget {
  final Widget child;
  final double scale;

  const Breathing({super.key, required this.child, this.scale = 1.025});

  @override
  Widget build(BuildContext context) {
    if (reduceMotion(context)) return child;

    // انیمیشن بی‌پایانه: با RepaintBoundary بچه یک‌بار رسم می‌شه و فقط
    // لایه‌اش بزرگ و کوچک می‌شه، نه کل صفحه‌ی زیرش در هر فریم.
    return RepaintBoundary(child: child)
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scale(
          begin: const Offset(1, 1),
          end: Offset(scale, scale),
          duration: 3200.ms,
          curve: Curves.easeInOut,
        );
  }
}
