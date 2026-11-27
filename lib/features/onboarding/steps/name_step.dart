import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/avatar_carousel.dart';
import 'package:little_moon/shared/widgets/language_picker.dart';
import 'package:little_moon/shared/widgets/user_avatar.dart';

import 'onboarding_palette.dart';
import 'onboarding_step.dart';

/// مرحله‌ی ۱ (بعد از خوش‌آمد): اسم، آواتار و زبان.
class NameStep extends StatelessWidget {
  final TextEditingController nameController;
  final int avatar;
  final ValueChanged<int> onAvatarChanged;

  const NameStep({
    super.key,
    required this.nameController,
    required this.avatar,
    required this.onAvatarChanged,
  });

  Widget _label(BuildContext context, String text) => Padding(
    padding: const EdgeInsetsDirectional.only(bottom: 10),
    child: Text(
      text,
      style: context.text.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: OnboardingPalette.of(context).deep,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final p = OnboardingPalette.of(context);
    final primary = p.buttonEnd;
    final border = OutlineInputBorder(
      borderRadius: AppRadius.br30,
      borderSide: BorderSide(color: p.glassBorder, width: 0.8),
    );

    return OnboardingStep(
      children: [
        // ---------- آواتار با نشان دوربین؛ با لمسش آواتار بعدی میاد ----------
        Center(
          child: GestureDetector(
            onTap: () => onAvatarChanged((avatar + 1) % (avatarCount + 1)),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                UserAvatar(avatarId: avatar, radius: 52),
                PositionedDirectional(
                  end: -2,
                  bottom: -2,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: primary,
                    child: Icon(
                      Icons.photo_camera_rounded,
                      size: 16,
                      color: context.scheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // قطاری و اسکرولی؛ با لمس آواتار بزرگ هم لیست دنبالش می‌ره
        AvatarCarousel(
          selected: avatar,
          onChanged: onAvatarChanged,
          radius: 26,
          selectedColor: primary,
        ),
        const SizedBox(height: 32),

        // ---------- اسم (اولین سؤال بعد از خوش‌آمد) ----------
        _label(context, l10n.yourName),
        TextField(
          controller: nameController,
          maxLength: 30,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: l10n.nameHint,
            counterText: '',
            filled: true,
            fillColor: p.glassFill,
            border: border,
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: BorderSide(color: p.buttonEnd, width: 1.2),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // ---------- زبان ----------
        _label(context, l10n.language),
        const LanguagePicker(),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.shield_outlined, size: 16, color: context.subtitle),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                l10n.privacyNote,
                style: context.text.bodySmall?.copyWith(
                  color: context.subtitle,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
