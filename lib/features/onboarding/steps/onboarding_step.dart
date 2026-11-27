import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/theme_context.dart';

import 'onboarding_palette.dart';

/// قالب هر صفحه‌ی راه‌اندازی: اسکرولِ با حاشیه‌ی ثابت.
class OnboardingStep extends StatelessWidget {
  final List<Widget> children;

  const OnboardingStep({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

/// عنوان درشتِ وسط‌چین + توضیح زیرش.
class OnboardingHeading extends StatelessWidget {
  final String title;
  final String? body;

  const OnboardingHeading({super.key, required this.title, this.body});

  @override
  Widget build(BuildContext context) {
    final bodyText = body;
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: context.text.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: OnboardingPalette.of(context).deep,
            height: 1.4,
          ),
        ),
        if (bodyText != null) ...[
          const SizedBox(height: 8),
          Text(
            bodyText,
            textAlign: TextAlign.center,
            style: context.text.bodyMedium?.copyWith(
              color: context.subtitle,
              height: 1.6,
            ),
          ),
        ],
      ],
    );
  }
}
