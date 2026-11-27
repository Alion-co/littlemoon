import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/domain/engine/pattern_finder.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/moon_card.dart';

/// «الگوهای تو»: چیزهایی که در چند چرخه، در یک زمان مشخص تکرار شدن.
class PatternsCard extends ConsumerWidget {
  const PatternsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final patterns = ref.watch(patternsProvider);

    if (patterns.isEmpty) {
      return MoonCard(
        child: Text(
          l10n.patternsEmpty,
          style: context.text.bodyMedium?.copyWith(
            color: context.subtitle,
            height: 1.6,
          ),
        ),
      );
    }

    IconData iconFor(PersonalPattern pattern) {
      switch (pattern.subject) {
        case PatternSubject.symptom:
          return Icons.eco_outlined;
        case PatternSubject.mood:
          final mood = pattern.mood;
          return mood == null
              ? Icons.sentiment_neutral_outlined
              : Labels.moodIcon(mood);
        case PatternSubject.pain:
          return Icons.bolt_outlined;
      }
    }

    return MoonCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          for (var i = 0; i < patterns.length; i++) ...[
            if (i > 0)
              Divider(
                height: 1,
                color: theme.dividerColor.withValues(alpha: 0.5),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: context.scheme.primary.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      iconFor(patterns[i]),
                      size: 18,
                      color: context.scheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Labels.patternSubject(l10n, patterns[i]),
                          style: context.text.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.scheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          context.n(Labels.patternWhen(l10n, patterns[i])),
                          style: context.text.bodySmall?.copyWith(
                            color: context.scheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    context.n(l10n.patternSeen(patterns[i].cycles)),
                    style: context.text.labelSmall?.copyWith(
                      color: context.subtitle,
                    ),
                  ),
                ],
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: Text(
              l10n.patternsNote,
              style: context.text.bodySmall?.copyWith(
                color: context.subtitle,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
