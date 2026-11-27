import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/haptics.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/domain/services/stats_providers.dart';
import 'package:little_moon/features/home/widgets/mood_button.dart';
import 'package:little_moon/features/home/widgets/quick_log_hint.dart';
import 'package:little_moon/features/home/widgets/symptom_chip.dart';
import 'package:little_moon/features/symptoms/daily_log_sheet.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/glass.dart';

/// علائمی که اگه کاربر هنوز چیزی ثبت نکرده، در ثبت سریع پیشنهاد می‌شن.
const _defaultQuickSymptoms = [
  SymptomIds.cramps,
  SymptomIds.headache,
  SymptomIds.bloating,
  SymptomIds.fatigue,
  SymptomIds.backPain,
];

const _quickSymptomCount = 5;

/// پرتکرارترین علائم ۹۰ روز اخیر کاربر؛ اگه کمتر از ۵ تا بود با
/// پیش‌فرض‌ها پر می‌شه.
final quickSymptomsProvider = Provider<List<String>>((ref) {
  final stats = ref.watch(symptomStatsProvider);

  final result = stats.topSymptomIds(_quickSymptomCount);
  for (final id in _defaultQuickSymptoms) {
    if (result.length >= _quickSymptomCount) break;
    if (!result.contains(id)) result.add(id);
  }
  return result;
});

/// ثبت سریع امروز: حال و علائم با یک لمس ذخیره می‌شن، بدون باز کردن
/// فرم کامل. لمس دوباره همون گزینه رو برمی‌داره.
class QuickLogCard extends ConsumerWidget {
  const QuickLogCard({super.key});

  Future<void> _save(WidgetRef ref, DailyLog log) async {
    Haptics.tap();
    await ref.read(logsProvider.notifier).save(log);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final night = isNightTheme(context);
    final subtitleColor = night
        ? Colors.white.withValues(alpha: 0.75)
        : context.subtitle;

    final today = ref.watch(todayProvider);
    final log = ref.watch(todayLogProvider) ?? DailyLog(date: today);
    final symptoms = ref.watch(quickSymptomsProvider);

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: homeCardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.flash_on_rounded,
                size: 20,
                color: context.scheme.primary,
              ),
              const SizedBox(width: 6),
              Text(
                l10n.quickLog,
                style: context.text.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.scheme.onSurface,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: QuickLogHint(
                  text: l10n.quickLogHint,
                  color: subtitleColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ---------- حال ----------
          Row(
            children: [
              for (final mood in Mood.values)
                Expanded(
                  child: MoodButton(
                    mood: mood,
                    label: Labels.mood(l10n, mood),
                    selected: log.mood == mood,
                    onTap: () => _save(
                      ref,
                      log.withMood(log.mood == mood ? null : mood),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // ---------- علائم ----------
          Row(
            children: [
              for (var i = 0; i < symptoms.length; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                Expanded(
                  child: SymptomChip(
                    label: Labels.symptom(l10n, symptoms[i]),
                    selected: log.symptoms.contains(symptoms[i]),
                    onTap: () {
                      final next = Set<String>.of(log.symptoms);
                      if (!next.remove(symptoms[i])) next.add(symptoms[i]);
                      _save(ref, log.withSymptoms(next));
                    },
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // ---------- ثبت دقیق: همون فرم کامل ----------
          _DetailedLogButton(
            label: l10n.detailedLog,
            onTap: () => showDailyLogSheet(context, ref: ref, date: today),
          ),
        ],
      ),
    );
  }
}

/// دکمه‌ی کم‌حجم پایین کارت که فرم کامل ثبت امروز رو باز می‌کنه.
class _DetailedLogButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _DetailedLogButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final night = isNightTheme(context);
    final accent = night ? context.scheme.secondary : context.scheme.primary;
    final color = night ? Colors.white : accent;

    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: accent.withValues(alpha: night ? 0.30 : 0.10),
        borderRadius: AppRadius.br30,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.br30,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit_note_rounded, size: 20, color: color),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: context.text.labelLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
