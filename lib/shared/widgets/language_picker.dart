import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/localization/locale_provider.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';

/// نشان کوتاه هر زبان داخل دایره.
const Map<String, String> _languageBadges = {
  'fa': 'فا',
  'en': 'En',
  'ar': 'ع',
  'es': 'Es',
  'tr': 'Tr',
};

/// انتخاب زبان: یک کارت که زبان فعلی رو نشون می‌ده و با زدن روش
/// لیست زبان‌ها از پایین صفحه باز می‌شه.
class LanguagePicker extends ConsumerWidget {
  const LanguagePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final current = ref.watch(localeProvider).languageCode;

    return Material(
      color: context.scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.br20,
        side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.6)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => showLanguageSheet(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              _LanguageBadge(code: current, selected: true),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  appLanguages[current] ?? current,
                  style: context.text.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.scheme.onSurface,
                  ),
                ),
              ),
              Icon(Icons.language_rounded, size: 20, color: context.subtitle),
              const SizedBox(width: 6),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 22,
                color: context.subtitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showLanguageSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(borderRadius: AppRadius.sheetTop),
    builder: (sheetContext) => const _LanguageSheet(),
  );
}

class _LanguageSheet extends ConsumerWidget {
  const _LanguageSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final current = ref.watch(localeProvider).languageCode;
    final primary = context.scheme.primary;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: theme.dividerColor,
              borderRadius: AppRadius.br4,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.language,
            style: context.text.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.scheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          for (final entry in appLanguages.entries)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Material(
                color: entry.key == current
                    ? primary.withValues(alpha: 0.10)
                    : theme.scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.br18,
                  side: BorderSide(
                    color: entry.key == current ? primary : Colors.transparent,
                    width: 1.4,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    ref.read(localeProvider.notifier).setLanguage(entry.key);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        _LanguageBadge(
                          code: entry.key,
                          selected: entry.key == current,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: context.text.titleSmall?.copyWith(
                              fontWeight: entry.key == current
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: entry.key == current
                                  ? primary
                                  : context.scheme.onSurface,
                            ),
                          ),
                        ),
                        if (entry.key == current)
                          Icon(
                            Icons.check_circle_rounded,
                            size: 22,
                            color: primary,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _LanguageBadge extends StatelessWidget {
  final String code;
  final bool selected;

  const _LanguageBadge({required this.code, required this.selected});

  @override
  Widget build(BuildContext context) {
    final primary = context.scheme.primary;

    return Container(
      width: 38,
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? primary : primary.withValues(alpha: 0.12),
      ),
      child: Text(
        _languageBadges[code] ?? code.toUpperCase(),
        style: context.text.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: selected ? Colors.white : primary,
          height: 1.1,
        ),
      ),
    );
  }
}
