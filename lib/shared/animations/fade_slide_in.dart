import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// ورود نرم محتوا: محو + کمی حرکت از پایین.
class FadeSlideIn extends StatelessWidget {
  final Widget child;
  final Duration delay;

  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return child
        .animate(delay: delay)
        .fadeIn(duration: 350.ms, curve: Curves.easeOut)
        .slideY(
          begin: 0.06,
          end: 0,
          duration: 350.ms,
          curve: Curves.easeOut,
        );
  }
}
