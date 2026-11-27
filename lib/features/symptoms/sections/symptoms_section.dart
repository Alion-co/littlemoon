import 'package:flutter/material.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';

import 'soft_chip.dart';

/// علائم چندانتخابی؛ [onToggle] شناسه‌ی علامتِ لمس‌شده رو می‌گیره.
class SymptomsWrap extends StatelessWidget {
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  const SymptomsWrap({
    super.key,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final id in SymptomIds.all)
          SoftChip(
            label: Labels.symptom(l10n, id),
            selected: selected.contains(id),
            onTap: () => onToggle(id),
          ),
      ],
    );
  }
}
