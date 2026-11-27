import 'package:flutter/material.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/domain/engine/cycle_models.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/glass.dart';

import 'cycle_hero_day.dart';
import 'cycle_hero_night.dart';
import 'phase_layout.dart';

export 'cycle_empty_card.dart';

class CycleHeroCard extends StatelessWidget {
  final int currentDay;
  final String phaseKey;
  final int daysUntilPeriod;
  final double cycleProgress;

  /// اگه داده بشه به‌جای «X روز تا پریود بعدی» نمایش داده می‌شه
  /// (مثلاً وقتی پریود عقب افتاده یا امروز شروع می‌شه).
  final String? statusText;

  /// جمله‌ی پایین کارت درباره‌ی وضعیت چرخه.
  final String? note;

  /// فقط برای نمای روز: جمله‌ی زیر کارت وقتی نشون داده می‌شه که این `true`
  /// باشه (تأخیر، چرخه‌ی کوتاه/بلند، بی‌نظمی)؛ در حالت عادی کارت ساده می‌مونه.
  final bool noteIsAlert;
  final VoidCallback? onInfoTap;

  /// متن آماده‌ی بازه‌ی باروری («۱۲ تا ۱۶ آبان»)؛ اگه معلوم نبود `null`.
  /// فقط کارتِ لمسِ ماه (نمای روز) ازش استفاده می‌کنه.
  final String? fertileText;

  /// تقسیم فازها روی حلقه؛ اگه داده نشه از طول‌های پیش‌فرض (۲۸ روزه) ساخته می‌شه.
  final CyclePhaseLayout? layout;

  const CycleHeroCard({
    super.key,
    required this.currentDay,
    required this.phaseKey,
    required this.daysUntilPeriod,
    this.cycleProgress = 0.5,
    this.statusText,
    this.note,
    this.noteIsAlert = false,
    this.onInfoTap,
    this.fertileText,
    this.layout,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final phaseText = switch (phaseKey) {
      'follicularPhase' => l10n.follicularPhase,
      'lutealPhase' => l10n.lutealPhase,
      'menstrualPhase' => l10n.menstrualPhase,
      'ovulationPhase' => l10n.ovulationPhase,
      _ => phaseKey,
    };
    final status =
        statusText ?? context.n(l10n.daysUntilPeriod(daysUntilPeriod));

    final phaseLayout =
        layout ??
        CyclePhaseLayout.of(cycleLength: 28, periodLength: 5, lutealLength: 14);
    final phase = switch (phaseKey) {
      'follicularPhase' => CyclePhase.follicular,
      'lutealPhase' => CyclePhase.luteal,
      'ovulationPhase' => CyclePhase.ovulation,
      _ => CyclePhase.menstrual,
    };
    String phaseLabel(CyclePhase p) => switch (p) {
      CyclePhase.menstrual => l10n.menstrualPhase,
      CyclePhase.follicular => l10n.follicularPhase,
      CyclePhase.ovulation => l10n.ovulationPhase,
      CyclePhase.luteal => l10n.lutealPhase,
    };

    return isNightTheme(context)
        ? HeroNightLayout(
            currentDay: currentDay,
            phaseText: phaseText,
            status: status,
            cycleProgress: cycleProgress,
            layout: phaseLayout,
            phase: phase,
            phaseLabel: phaseLabel,
            fertileText: fertileText,
            note: note,
            onInfoTap: onInfoTap,
          )
        : HeroDayLayout(
            currentDay: currentDay,
            phaseText: phaseText,
            cycleProgress: cycleProgress,
            layout: phaseLayout,
            phase: phase,
            phaseLabel: phaseLabel,
            status: status,
            fertileText: fertileText,
            note: noteIsAlert ? note : null,
            onInfoTap: onInfoTap,
          );
  }
}
