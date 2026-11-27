import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';

import 'soft_chip.dart';

/// کادر یادداشت آزاد (حداکثر ۵۰۰ نویسه).
class NoteField extends StatelessWidget {
  final TextEditingController controller;

  const NoteField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return TextField(
      controller: controller,
      minLines: 3,
      maxLines: 5,
      maxLength: 500,
      textInputAction: TextInputAction.newline,
      style: context.text.bodyMedium,
      decoration: InputDecoration(
        hintText: l10n.noteHint,
        hintStyle: context.text.bodySmall?.copyWith(
          color: context.subtitle.withValues(alpha: 0.8),
        ),
        counterText: '',
        filled: true,
        fillColor: softFill(context),
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: AppRadius.br20,
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
