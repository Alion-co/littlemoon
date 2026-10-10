import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/themes/moon_colors.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/glass.dart';

/// خلاصه‌ی ثبت امروز + دکمه‌ی «ثبت امروز».
class TodaySummaryCard extends ConsumerWidget {
  final VoidCallback? onLogTap;

  const TodaySummaryCard({super.key, this.onLogTap});

  /// خواب به شکل کوتاه تا در ستون باریک جا بشه: «7h 30m» / «۷:۳۰»
  String _sleepShort(BuildContext context, AppLocalizations l10n, int minutes) {
    if (l10n.localeName != 'fa') return Labels.sleep(l10n, minutes);
    final hours = minutes ~/ 60;
    final rest = minutes % 60;
    return context.n('$hours:${rest < 10 ? '0$rest' : '$rest'}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final log = ref.watch(todayLogProvider);
    final night = isNightTheme(context);

    const empty = '—';
    final mood = log?.mood;
    final energy = log?.energy;
    final pain = log?.pain;
    final sleep = log?.sleepMinutes;

    final items = [
      _SummaryItem(
        icon: Icons.sentiment_satisfied_alt_outlined,
        label: l10n.mood,
        value: mood == null ? empty : Labels.mood(l10n, mood),
        centered: night,
      ),
      _SummaryItem(
        icon: Icons.air,
        label: l10n.energy,
        value: energy == null ? empty : Labels.energy(l10n, energy),
        centered: night,
      ),
      _SummaryItem(
        icon: Icons.bolt_outlined,
        label: l10n.pain,
        value: pain == null ? empty : Labels.pain(l10n, pain),
        centered: night,
      ),
      _SummaryItem(
        icon: Icons.nightlight_outlined,
        label: l10n.sleep,
        value: sleep == null ? empty : _sleepShort(context, l10n, sleep),
        centered: night,
      ),
    ];

    final dividerColor = night
        ? Colors.white.withValues(alpha: 0.18)
        : theme.dividerColor.withValues(alpha: 0.9);

    final itemsRow = Row(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0)
            Container(
              width: 1,
              height: 34,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              color: dividerColor,
            ),
          Expanded(child: items[i]),
        ],
      ],
    );

    final title = Text(
      l10n.todaysSummary,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.onSurface,
      ),
    );

    final logLabel = l10n.logToday;

    // ---------- تم شب ----------
    if (night) {
      final accent = theme.colorScheme.secondary;

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: homeCardDecoration(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.14),
                ),
              ),
              child: itemsRow,
            ),
            const SizedBox(height: 12),
            Center(
              child: FractionallySizedBox(
                widthFactor: 0.78,
                child: Material(
                  color: accent.withValues(alpha: 0.30),
                  shape: StadiumBorder(
                    side: BorderSide(color: accent.withValues(alpha: 0.85)),
                  ),
                  child: InkWell(
                    onTap: onLogTap,
                    customBorder: const StadiumBorder(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            log == null
                                ? Icons.add_rounded
                                : Icons.edit_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            logLabel.replaceAll('\n', ' '),
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // ---------- تم روشن ----------
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 12, 16),
      decoration: homeCardDecoration(context),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                const SizedBox(height: 14),
                itemsRow,
              ],
            ),
          ),
          const SizedBox(width: 10),
          Material(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(18),
            child: InkWell(
              onTap: onLogTap,
              borderRadius: BorderRadius.circular(18),
              child: Container(
                width: 68,
                height: 92,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      log == null ? Icons.add_rounded : Icons.edit_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      logLabel,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool centered;

  const _SummaryItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.centered,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>();
    final subtitleColor = moon?.subtitle ?? theme.colorScheme.onSurfaceVariant;
    final iconColor = centered
        ? Colors.white.withValues(alpha: 0.85)
        : theme.colorScheme.primary.withValues(alpha: 0.85);

    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: iconColor),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: subtitleColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            maxLines: 1,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
