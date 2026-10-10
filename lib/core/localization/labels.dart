import 'package:flutter/material.dart';

import '../../data/models/daily_log.dart';
import '../../domain/engine/cycle_engine.dart';
import '../../l10n/generated/app_localizations.dart';
import '../theme/theme_mode.dart';

/// تبدیل مقدارهای داخلی (enum و شناسه) به متن و آیکون قابل نمایش.
abstract final class Labels {
  static String flow(AppLocalizations l10n, FlowLevel level) {
    switch (level) {
      case FlowLevel.none:
        return l10n.flowNone;
      case FlowLevel.spotting:
        return l10n.flowSpotting;
      case FlowLevel.light:
        return l10n.flowLight;
      case FlowLevel.medium:
        return l10n.flowMedium;
      case FlowLevel.heavy:
        return l10n.flowHeavy;
    }
  }

  static String mood(AppLocalizations l10n, Mood mood) {
    switch (mood) {
      case Mood.happy:
        return l10n.moodHappy;
      case Mood.calm:
        return l10n.moodCalm;
      case Mood.sensitive:
        return l10n.moodSensitive;
      case Mood.sad:
        return l10n.moodSad;
      case Mood.irritable:
        return l10n.moodIrritable;
      case Mood.anxious:
        return l10n.moodAnxious;
    }
  }

  static IconData moodIcon(Mood mood) {
    switch (mood) {
      case Mood.happy:
        return Icons.sentiment_very_satisfied_outlined;
      case Mood.calm:
        return Icons.sentiment_satisfied_alt_outlined;
      case Mood.sensitive:
        return Icons.sentiment_neutral_outlined;
      case Mood.sad:
        return Icons.sentiment_dissatisfied_outlined;
      case Mood.irritable:
        return Icons.sentiment_very_dissatisfied_outlined;
      case Mood.anxious:
        return Icons.mood_bad_outlined;
    }
  }

  /// ۰ تا ۳
  static String pain(AppLocalizations l10n, int level) {
    switch (level) {
      case 0:
        return l10n.painNone;
      case 1:
        return l10n.mild;
      case 2:
        return l10n.medium;
      default:
        return l10n.painSevere;
    }
  }

  /// ۱ تا ۳
  static String energy(AppLocalizations l10n, int level) {
    switch (level) {
      case 1:
        return l10n.energyLow;
      case 2:
        return l10n.medium;
      default:
        return l10n.energyHigh;
    }
  }

  static String symptom(AppLocalizations l10n, String id) {
    switch (id) {
      case SymptomIds.cramps:
        return l10n.symptomCramps;
      case SymptomIds.headache:
        return l10n.symptomHeadache;
      case SymptomIds.backPain:
        return l10n.symptomBackPain;
      case SymptomIds.bloating:
        return l10n.symptomBloating;
      case SymptomIds.breastTenderness:
        return l10n.symptomBreastTenderness;
      case SymptomIds.acne:
        return l10n.symptomAcne;
      case SymptomIds.nausea:
        return l10n.symptomNausea;
      case SymptomIds.fatigue:
        return l10n.symptomFatigue;
      case SymptomIds.cravings:
        return l10n.symptomCravings;
      case SymptomIds.insomnia:
        return l10n.symptomInsomnia;
      case SymptomIds.dizziness:
        return l10n.symptomDizziness;
      case SymptomIds.discharge:
        return l10n.symptomDischarge;
      default:
        return id;
    }
  }

  static String phase(AppLocalizations l10n, CyclePhase phase) {
    switch (phase) {
      case CyclePhase.menstrual:
        return l10n.menstrualPhase;
      case CyclePhase.follicular:
        return l10n.follicularPhase;
      case CyclePhase.ovulation:
        return l10n.ovulationPhase;
      case CyclePhase.luteal:
        return l10n.lutealPhase;
    }
  }

  /// کلید فاز برای ویجت‌هایی که با کلید متنی کار می‌کنن.
  static String phaseKey(CyclePhase phase) {
    switch (phase) {
      case CyclePhase.menstrual:
        return 'menstrualPhase';
      case CyclePhase.follicular:
        return 'follicularPhase';
      case CyclePhase.ovulation:
        return 'ovulationPhase';
      case CyclePhase.luteal:
        return 'lutealPhase';
    }
  }

  static String dayKind(AppLocalizations l10n, DayKind kind) {
    switch (kind) {
      case DayKind.period:
        return l10n.periodDay;
      case DayKind.predictedPeriod:
        return l10n.predictedPeriodDay;
      case DayKind.fertile:
        return l10n.fertileWindow;
      case DayKind.ovulation:
        return l10n.ovulationDay;
      case DayKind.none:
        return l10n.noDataLogged;
    }
  }

  static String regularity(AppLocalizations l10n, CycleRegularity value) {
    switch (value) {
      case CycleRegularity.regular:
        return l10n.regular;
      case CycleRegularity.irregular:
        return l10n.irregular;
      case CycleRegularity.unknown:
        return l10n.notEnoughData;
    }
  }

  static String theme(AppLocalizations l10n, AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.moon:
        return l10n.themeMoon;
      case AppThemeMode.sakura:
        return l10n.themeSakura;
      case AppThemeMode.lavender:
        return l10n.themeLavender;
      case AppThemeMode.ocean:
        return l10n.themeOcean;
      case AppThemeMode.mint:
        return l10n.themeMint;
      case AppThemeMode.sunset:
        return l10n.themeSunset;
      case AppThemeMode.midnight:
        return l10n.themeMidnight;
      case AppThemeMode.nightRose:
        return l10n.themeNightRose;
    }
  }

  /// «پریود X روز عقب افتاده»
  static String latePeriod(AppLocalizations l10n, int days) =>
      days == 1 ? l10n.periodLateOneDay : l10n.periodLateBy(days);

  /// مثل «۷ ساعت و ۳۰ دقیقه» / «7h 30m»
  static String sleep(AppLocalizations l10n, int minutes) {
    final hours = minutes ~/ 60;
    final rest = minutes % 60;
    if (rest == 0) return l10n.sleepHours(hours);
    return l10n.sleepHoursMinutes(hours, rest);
  }

  /// عدد اعشاری بدون صفر اضافه: 36.5 → «36.5»، 60.0 → «60»
  static String decimal(double value) {
    final fixed = value.toStringAsFixed(1);
    return fixed.endsWith('.0') ? fixed.substring(0, fixed.length - 2) : fixed;
  }
}
