import 'package:flutter/material.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/number_stepper.dart';

import 'onboarding_step.dart';

/// مراحل ۳ و ۴: انتخاب یک عدد (طول پریود / طول چرخه) با استپر.
/// [footer] زیر استپر می‌آد (مثلاً هشدار پزشکی).
class LengthStep extends StatelessWidget {
  final String title;
  final String hint;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;
  final Widget? footer;

  const LengthStep({
    super.key,
    required this.title,
    required this.hint,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return OnboardingStep(
      children: [
        OnboardingHeading(title: title, body: hint),
        const SizedBox(height: 48),
        Center(
          child: NumberStepper(
            value: value,
            min: min,
            max: max,
            unit: l10n.days,
            onChanged: onChanged,
          ),
        ),
        if (footer != null) ...[const SizedBox(height: 40), footer!],
      ],
    );
  }
}
