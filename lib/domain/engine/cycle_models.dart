import '../../core/utils/day_utils.dart';

enum CyclePhase { menstrual, follicular, ovulation, luteal }

enum DayKind { none, period, predictedPeriod, fertile, ovulation }

enum CycleRegularity { unknown, regular, irregular }

/// میزان اطمینان به پیش‌بینی (از تعداد و یکنواختی چرخه‌های اخیر).
enum PredictionConfidence { low, medium, high }

/// وضعیت تأخیر عادت ماهانه نسبت به بازه‌ی پیش‌بینی.
enum LateLevel {
  /// تأخیری نیست.
  none,

  /// دیر شده، ولی هنوز داخل نوسان معمول چرخه‌های خود کاربره.
  withinRange,

  /// از بازه‌ی معمول بیرون زده (تا یک هفته).
  beyondRange,

  /// بیشتر از یک هفته.
  veryLate,
}

/// طول فاز لوتئال از کجا اومده.
enum LutealSource {
  /// عدد پروفایل (پیش‌فرض ۱۴) — هنوز داده‌ی کافی برای یادگیری نیست.
  profile,

  /// از چرخه‌های تأییدشده‌ی خودِ کاربر (با دمای پایه) یاد گرفته شده.
  learned,
}

/// نگرانی‌های قابل‌توجه درباره‌ی الگوی چرخه (نه تشخیص پزشکی).
enum CycleConcern {
  /// میانگین چرخه کمتر از ۲۱ روز
  shortCycles,

  /// میانگین چرخه بیشتر از ۳۵ روز
  longCycles,

  /// یک چرخه‌ی خیلی طولانی که احتمالاً ثبت یک پریود جا افتاده
  possibleMissedLog,

  /// اختلاف زیاد بین کوتاه‌ترین و بلندترین چرخه
  highVariation,
}

/// یک دوره‌ی پریود ثبت‌شده (از اولین تا آخرین روز خونریزی).
class PeriodRange {
  final DateTime start;
  final DateTime end;

  const PeriodRange(this.start, this.end);

  int get length => daysBetween(start, end) + 1;
}

/// یک چرخه‌ی کامل: از شروع یک پریود تا شروع پریود بعدی.
class CycleRecord {
  final DateTime start;
  final int length;
  final int periodLength;

  /// چرخه‌های خیلی کوتاه/بلند (معمولاً به‌خاطر ثبت‌نشدن یک پریود)
  /// در میانگین‌گیری حساب نمی‌شن.
  final bool valid;

  /// کاربر این چرخه رو «غیرعادی» علامت زده (بیماری، سفر، استرس، ...)؛
  /// در میانگین، پراکندگی و یادگیری فاز لوتئال شرکت نمی‌کنه.
  final bool excluded;

  const CycleRecord({
    required this.start,
    required this.length,
    required this.periodLength,
    required this.valid,
    this.excluded = false,
  });

  /// این چرخه در محاسبه‌ی میانگین و پیش‌بینی حساب می‌شه.
  bool get counted => valid && !excluded;
}

/// تعیین فاز چرخه برای امروز.
abstract final class CyclePhaseResolver {
  static CyclePhase resolve({
    required bool bleedingNow,
    required int cycleDay,
    required int ovulationDay,
  }) {
    if (bleedingNow) return CyclePhase.menstrual;
    if (cycleDay < ovulationDay - 1) return CyclePhase.follicular;
    if (cycleDay <= ovulationDay + 1) return CyclePhase.ovulation;
    return CyclePhase.luteal;
  }
}
