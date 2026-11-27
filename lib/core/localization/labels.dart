import 'package:flutter/material.dart';

import '../../data/models/daily_log.dart';
import '../../domain/engine/cycle_engine.dart';
import '../../domain/engine/pattern_finder.dart';
import '../../domain/services/daily_tips.dart';
import '../../l10n/generated/app_localizations.dart';
import '../theme/theme_mode.dart';
import '../utils/app_calendar.dart';

/// تبدیل مقدارهای داخلی (enum و شناسه) به متن و آیکون قابل نمایش.
abstract final class Labels {
  static String flow(AppLocalizations l10n, FlowLevel level) => switch (level) {
    FlowLevel.none => l10n.flowNone,
    FlowLevel.spotting => l10n.flowSpotting,
    FlowLevel.light => l10n.flowLight,
    FlowLevel.medium => l10n.flowMedium,
    FlowLevel.heavy => l10n.flowHeavy,
  };

  static String mood(AppLocalizations l10n, Mood mood) => switch (mood) {
    Mood.happy => l10n.moodHappy,
    Mood.calm => l10n.moodCalm,
    Mood.sensitive => l10n.moodSensitive,
    Mood.sad => l10n.moodSad,
    Mood.irritable => l10n.moodIrritable,
    Mood.anxious => l10n.moodAnxious,
  };

  static IconData moodIcon(Mood mood) => switch (mood) {
    Mood.happy => Icons.sentiment_very_satisfied_outlined,
    Mood.calm => Icons.sentiment_satisfied_alt_outlined,
    Mood.sensitive => Icons.sentiment_neutral_outlined,
    Mood.sad => Icons.sentiment_dissatisfied_outlined,
    Mood.irritable => Icons.sentiment_very_dissatisfied_outlined,
    Mood.anxious => Icons.mood_bad_outlined,
  };

  /// ۰ تا ۳
  static String pain(AppLocalizations l10n, int level) => switch (level) {
    0 => l10n.painNone,
    1 => l10n.mild,
    2 => l10n.medium,
    _ => l10n.painSevere,
  };

  /// ۱ تا ۳
  static String energy(AppLocalizations l10n, int level) => switch (level) {
    1 => l10n.energyLow,
    2 => l10n.medium,
    _ => l10n.energyHigh,
  };

  static String symptom(AppLocalizations l10n, String id) => switch (id) {
    SymptomIds.cramps => l10n.symptomCramps,
    SymptomIds.headache => l10n.symptomHeadache,
    SymptomIds.backPain => l10n.symptomBackPain,
    SymptomIds.bloating => l10n.symptomBloating,
    SymptomIds.breastTenderness => l10n.symptomBreastTenderness,
    SymptomIds.acne => l10n.symptomAcne,
    SymptomIds.nausea => l10n.symptomNausea,
    SymptomIds.fatigue => l10n.symptomFatigue,
    SymptomIds.cravings => l10n.symptomCravings,
    SymptomIds.insomnia => l10n.symptomInsomnia,
    SymptomIds.dizziness => l10n.symptomDizziness,
    SymptomIds.discharge => l10n.symptomDischarge,
    _ => id,
  };

  static String phase(AppLocalizations l10n, CyclePhase phase) =>
      switch (phase) {
        CyclePhase.menstrual => l10n.menstrualPhase,
        CyclePhase.follicular => l10n.follicularPhase,
        CyclePhase.ovulation => l10n.ovulationPhase,
        CyclePhase.luteal => l10n.lutealPhase,
      };

  /// کلید فاز برای ویجت‌هایی که با کلید متنی کار می‌کنن.
  static String phaseKey(CyclePhase phase) => switch (phase) {
    CyclePhase.menstrual => 'menstrualPhase',
    CyclePhase.follicular => 'follicularPhase',
    CyclePhase.ovulation => 'ovulationPhase',
    CyclePhase.luteal => 'lutealPhase',
  };

  static String dayKind(AppLocalizations l10n, DayKind kind) => switch (kind) {
    DayKind.period => l10n.periodDay,
    DayKind.predictedPeriod => l10n.predictedPeriodDay,
    DayKind.fertile => l10n.fertileWindow,
    DayKind.ovulation => l10n.ovulationDay,
    DayKind.none => l10n.noDataLogged,
  };

  static String regularity(AppLocalizations l10n, CycleRegularity value) =>
      switch (value) {
        CycleRegularity.regular => l10n.regular,
        CycleRegularity.irregular => l10n.irregular,
        CycleRegularity.unknown => l10n.notEnoughData,
      };

  static String theme(AppLocalizations l10n, AppThemeMode mode) =>
      switch (mode) {
        AppThemeMode.moon => l10n.themeMoon,
        AppThemeMode.sakura => l10n.themeSakura,
        AppThemeMode.lavender => l10n.themeLavender,
        AppThemeMode.ocean => l10n.themeOcean,
        AppThemeMode.mint => l10n.themeMint,
        AppThemeMode.sunset => l10n.themeSunset,
        AppThemeMode.midnight => l10n.themeMidnight,
        AppThemeMode.nightRose => l10n.themeNightRose,
      };

  /// «عادت ماهانه X روز عقب افتاده»
  static String latePeriod(AppLocalizations l10n, int days) =>
      days == 1 ? l10n.periodLateOneDay : l10n.periodLateBy(days);

  /// بازه‌ی دو تاریخ؛ اگه هر دو در یک ماه باشن، اسم ماه یک‌بار میاد:
  /// «۱۲ تا ۱۶ آبان»، «October 12 – 16»، «۲۸ مهر تا ۳ آبان».
  static String dateRange(
    AppLocalizations l10n,
    AppCalendar calendar,
    DateTime start,
    DateTime end,
  ) {
    final sameMonth = calendar.monthOf(start) == calendar.monthOf(end);
    if (!sameMonth) {
      return l10n.dateRange(calendar.dayMonth(start), calendar.dayMonth(end));
    }
    // در میلادیِ انگلیسی ماه اول میاد («October 12»)، بقیه روز اول
    final monthFirst = calendar.lang == 'en' && !calendar.isJalali;
    return monthFirst
        ? l10n.dateRange(
            calendar.dayMonth(start),
            calendar.n(calendar.dayOfMonth(end)),
          )
        : l10n.dateRange(
            calendar.n(calendar.dayOfMonth(start)),
            calendar.dayMonth(end),
          );
  }

  /// عنوان یک الگوی شخصی: اسم علامت، حال یا «درد».
  static String patternSubject(
    AppLocalizations l10n,
    PersonalPattern pattern,
  ) => switch (pattern.subject) {
    PatternSubject.symptom => symptom(l10n, pattern.id),
    PatternSubject.mood => switch (pattern.mood) {
      final value? => mood(l10n, value),
      null => pattern.id,
    },
    PatternSubject.pain => l10n.patternPain,
  };

  /// عنوان دسته‌ی پیشنهاد روزانه.
  static String tipCategory(AppLocalizations l10n, TipCategory category) =>
      switch (category) {
        TipCategory.nutrition => l10n.tipCategoryNutrition,
        TipCategory.movement => l10n.tipCategoryMovement,
        TipCategory.rest => l10n.tipCategoryRest,
      };

  /// پیشنهادهای یک دسته در یک فاز (هر فاز چند پیشنهاد با | جدا شده).
  static List<String> tipPool(
    AppLocalizations l10n,
    CyclePhase phase,
    TipCategory category,
  ) {
    final raw = switch (category) {
      TipCategory.nutrition => switch (phase) {
        CyclePhase.menstrual => l10n.tipNutritionMenstrual,
        CyclePhase.follicular => l10n.tipNutritionFollicular,
        CyclePhase.ovulation => l10n.tipNutritionOvulation,
        CyclePhase.luteal => l10n.tipNutritionLuteal,
      },
      TipCategory.movement => switch (phase) {
        CyclePhase.menstrual => l10n.tipMovementMenstrual,
        CyclePhase.follicular => l10n.tipMovementFollicular,
        CyclePhase.ovulation => l10n.tipMovementOvulation,
        CyclePhase.luteal => l10n.tipMovementLuteal,
      },
      TipCategory.rest => switch (phase) {
        CyclePhase.menstrual => l10n.tipRestMenstrual,
        CyclePhase.follicular => l10n.tipRestFollicular,
        CyclePhase.ovulation => l10n.tipRestOvulation,
        CyclePhase.luteal => l10n.tipRestLuteal,
      },
    };
    return DailyTips.parsePool(raw);
  }

  /// اسم چند الگو با هم، مثل «سردرد، نفخ» (برای هشدار زودهنگام).
  static String patternNames(
    AppLocalizations l10n,
    List<PersonalPattern> patterns,
  ) {
    final separator = (l10n.localeName == 'fa' || l10n.localeName == 'ar')
        ? '، '
        : ', ';
    final names = <String>[];
    for (final pattern in patterns) {
      final name = patternSubject(l10n, pattern).toLowerCase();
      if (!names.contains(name)) names.add(name);
    }
    return names.join(separator);
  }

  /// «اطمینان پیش‌بینی: زیاد»
  static String confidence(AppLocalizations l10n, PredictionConfidence value) =>
      switch (value) {
        PredictionConfidence.low => l10n.predictionConfidenceLow,
        PredictionConfidence.medium => l10n.predictionConfidenceMedium,
        PredictionConfidence.high => l10n.predictionConfidenceHigh,
      };

  /// «معمولاً حدود ۲ روز قبل از عادت ماهانه» / «معمولاً روز ۱ عادت ماهانه»
  static String patternWhen(AppLocalizations l10n, PersonalPattern pattern) =>
      switch (pattern.timing) {
        PatternTiming.beforePeriod =>
          pattern.day == 1
              ? l10n.patternDayBefore
              : l10n.patternDaysBefore(pattern.day),
        PatternTiming.duringPeriod => l10n.patternDuring(pattern.day),
      };

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
