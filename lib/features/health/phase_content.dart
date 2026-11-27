import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';

/// متن‌های هر فاز چرخه (توصیه‌ها و توضیح کوتاه)؛ `null` یعنی داده‌ای نیست.
abstract final class PhaseContent {
  static List<String> tips(AppLocalizations l10n, CyclePhase? phase) {
    switch (phase) {
      case CyclePhase.menstrual:
        return [l10n.tipMenstrual1, l10n.tipMenstrual2, l10n.tipMenstrual3];
      case CyclePhase.follicular:
        return [l10n.tipFollicular1, l10n.tipFollicular2, l10n.tipFollicular3];
      case CyclePhase.ovulation:
        return [l10n.tipOvulation1, l10n.tipOvulation2, l10n.tipOvulation3];
      case CyclePhase.luteal:
        return [l10n.tipLuteal1, l10n.tipLuteal2, l10n.tipLuteal3];
      case null:
        return [l10n.tipGeneral1, l10n.tipGeneral2, l10n.tipGeneral3];
    }
  }

  static String about(AppLocalizations l10n, CyclePhase? phase) {
    switch (phase) {
      case CyclePhase.menstrual:
        return l10n.aboutMenstrual;
      case CyclePhase.follicular:
        return l10n.aboutFollicular;
      case CyclePhase.ovulation:
        return l10n.aboutOvulation;
      case CyclePhase.luteal:
        return l10n.aboutLuteal;
      case null:
        return l10n.aboutNoData;
    }
  }
}
