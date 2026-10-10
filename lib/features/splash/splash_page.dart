import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/data/repositories/profile_repository.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(milliseconds: 2400), () {
      if (!mounted) return;
      // بار اول → راه‌اندازی اولیه، بعدش مستقیم خانه
      final done = ref.read(profileProvider).onboardingDone;
      context.go(done ? '/home' : '/onboarding');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Text(
          'Little Moon',
          style: TextStyle(
            fontFamily: 'Vazirmatn',
            fontSize: 34,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: Theme.of(context).colorScheme.primary,
          ),
        )
            .animate()
            .fadeIn(duration: 700.ms, curve: Curves.easeOut)
            .scale(
          begin: const Offset(0.92, 0.92),
          end: const Offset(1, 1),
          duration: 900.ms,
          curve: Curves.easeOutBack,
        )
            .then()
            .shimmer(duration: 1200.ms),
      ),
    );
  }
}
