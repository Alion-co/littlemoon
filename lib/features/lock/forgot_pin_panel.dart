import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';

/// «رمزم رو فراموش کردم»: اول یک دکمه‌ی ساده، بعد کادر تأیید پاک‌کردن
/// همه‌چیز (داخل خودِ صفحه، چون دیالوگ معمولی بالای قفل باز نمی‌شه).
class ForgotPinPanel extends StatelessWidget {
  final bool confirming;
  final bool resetting;
  final VoidCallback onAsk;
  final VoidCallback onCancel;
  final VoidCallback onReset;

  const ForgotPinPanel({
    super.key,
    required this.confirming,
    required this.resetting,
    required this.onAsk,
    required this.onCancel,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (!confirming) {
      return TextButton(
        onPressed: onAsk,
        child: Text(l10n.forgotPin, style: TextStyle(color: context.subtitle)),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.scheme.surface,
        borderRadius: AppRadius.br20,
        border: Border.all(
          color: context.theme.dividerColor.withValues(alpha: 0.6),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.forgotPinBody,
            style: context.text.bodySmall?.copyWith(
              color: context.scheme.onSurface,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: resetting ? null : onCancel,
                  child: Text(l10n.cancel),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: context.scheme.error,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: resetting ? null : onReset,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(l10n.resetApp),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
