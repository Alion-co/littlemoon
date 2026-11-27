import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/moon_logo.dart';

import 'onboarding_chrome.dart';
import 'onboarding_palette.dart';

/// مرحله‌ی ۰: صفحه‌ی خوش‌آمد، مثل طرح مرجع (ماه، نام، سلام و دکمه‌ی شروع).
class WelcomeStep extends StatelessWidget {
  const WelcomeStep({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final p = OnboardingPalette.of(context);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const MoonEmblem(size: 180),
            const SizedBox(height: 8),
            // نام برند با فونتِ سریفِ سیستم؛ برای شکل دقیق‌تر طرح می‌شه یک
            // فونت سریف (مثل Cormorant Garamond) به برنامه اضافه کرد.
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) =>
                  LinearGradient(colors: [p.deep, p.buttonStart])
                      .createShader(bounds),
              child: const Text(
                'Little Moon',
                style: TextStyle(
                  fontFamily: 'serif',
                  fontFamilyFallback: ['Noto Serif', 'Georgia'],
                  fontSize: 42,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                  height: 1.15,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'CYCLE TRACKER',
              style: context.text.labelSmall?.copyWith(
                fontSize: 11,
                letterSpacing: 6,
                color: p.deep.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: p.gold.withValues(alpha: 0.6),
                    thickness: 0.8,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SparkleMark(size: 14, color: p.buttonStart),
                ),
                Expanded(
                  child: Divider(
                    color: p.gold.withValues(alpha: 0.6),
                    thickness: 0.8,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              l10n.onboardingHello,
              textAlign: TextAlign.center,
              style: context.text.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: p.deep,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    l10n.onboardingWelcomeLine,
                    textAlign: TextAlign.center,
                    style: context.text.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: p.deep,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Icon(Icons.favorite_border_rounded, size: 16, color: p.deep),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              l10n.onboardingTagline,
              textAlign: TextAlign.center,
              style: context.text.bodyMedium?.copyWith(
                color: p.deep.withValues(alpha: 0.75),
                height: 1.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
