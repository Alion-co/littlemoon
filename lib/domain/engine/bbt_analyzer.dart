import '../../core/utils/day_utils.dart';

/// یک تخمک‌گذاری که با جهش دمای پایه (BBT) تأیید شده.
class BbtOvulation {
  /// شروع چرخه‌ای که این تخمک‌گذاری توش اتفاق افتاده.
  final DateTime cycleStart;

  /// روز تخمک‌گذاری = آخرین روز دمای پایین، یک روز قبل از جهش.
  final DateTime ovulationDate;

  /// اولین روز دمای بالا.
  final DateTime shiftStart;

  /// خط پوششی: بالاترین دمای ۶ روز قبل از جهش (به درجه‌ی سانتی‌گراد).
  final double coverline;

  const BbtOvulation({
    required this.cycleStart,
    required this.ovulationDate,
    required this.shiftStart,
    required this.coverline,
  });

  /// شماره‌ی روز چرخه‌ای که تخمک‌گذاری توش بوده (روز اول = ۱).
  int get cycleDay => daysBetween(cycleStart, ovulationDate) + 1;
}

/// تشخیص جهش دمای پایه با «قانون ۳ بالای ۶» (روش رایج تشخیص تخمک‌گذاری):
///
///  • خط پوششی = بالاترین دما در ۶ اندازه‌گیری قبل از جهش
///  • سه اندازه‌گیریِ پشت‌سرهم باید از خط پوششی بالاتر باشن
///  • سومی حداقل ۰٫۲ درجه بالاتر از خط پوششی باشه
///
/// دمای بدن بعد از تخمک‌گذاری (به‌خاطر پروژسترون) حدود ۰٫۲ تا ۰٫۵ درجه
/// بالا می‌ره و تا آخر چرخه همون‌جا می‌مونه. این جهش تخمک‌گذاری رو
/// **بعد از وقوعش** تأیید می‌کنه، نه قبلش — پس برای پیش‌بینی چرخه‌ی بعدی
/// (و یادگیری طول فاز لوتئال) به کار می‌آد، نه برای تعیین روز باروری آینده.
///
/// کاملاً خالص: فقط تاریخ و عدد می‌گیره.
abstract final class BbtAnalyzer {
  /// دماهای بیرون از این بازه (تب، خطای تایپ، دمای محیط) نادیده گرفته می‌شن.
  static const minTemp = 35.0;
  static const maxTemp = 38.0;

  /// تعداد اندازه‌گیری قبل از جهش که خط پوششی ازشون ساخته می‌شه.
  static const baselineReadings = 6;

  /// اون ۶ اندازه‌گیری باید توی این‌همه روز قبل از جهش باشن.
  static const baselineWindowDays = 10;

  /// سه دمای بالا باید توی این‌همه روز بعد از اولین دمای بالا باشن.
  static const shiftWindowDays = 4;

  /// دمای سوم باید حداقل این‌قدر (درجه) بالاتر از خط پوششی باشه.
  static const thirdRise = 0.2;

  /// زودترین روز چرخه (۱ = روز اول) که جهش می‌تونه شروع بشه.
  static const earliestShiftCycleDay = 8;

  /// دما به صدم درجه گرد می‌شه تا مقایسه‌ها از خطای اعشاری در امان بمونن.
  static int? _hundredths(double value) {
    if (value.isNaN || value < minTemp || value > maxTemp) return null;
    return (value * 100).round();
  }

  /// دماهای معتبر رو به نقشه‌ی «شماره‌ی روز ← صدم درجه» تبدیل می‌کنه.
  static Map<int, int> normalize(Iterable<MapEntry<DateTime, double>> temps) {
    final result = <int, int>{};
    for (final entry in temps) {
      final value = _hundredths(entry.value);
      if (value != null) result[epochDay(entry.key)] = value;
    }
    return result;
  }

  /// تعداد دماهای معتبر در بازه‌ی [start] تا [endExclusive).
  static int countReadings(
    Map<int, int> readings,
    DateTime start,
    DateTime endExclusive,
  ) {
    final from = epochDay(start);
    final to = epochDay(endExclusive);
    var count = 0;
    for (final day in readings.keys) {
      if (day >= from && day < to) count++;
    }
    return count;
  }

  /// جهش دما در چرخه‌ی [start] تا [endExclusive) رو پیدا می‌کنه
  /// (`null` = جهش واضحی دیده نشد یا داده کافی نیست).
  ///
  /// [readings] خروجی [normalize] هست.
  static BbtOvulation? detect({
    required DateTime start,
    required DateTime endExclusive,
    required Map<int, int> readings,
  }) {
    final from = epochDay(start);
    final to = epochDay(endExclusive); // خودش داخل بازه نیست

    for (var day = from + earliestShiftCycleDay - 1; day < to; day++) {
      final first = readings[day];
      if (first == null) continue;

      // ۶ اندازه‌گیری قبل از این روز (فقط داخل همین چرخه)
      final baseline = <int>[];
      for (
        var back = day - 1;
        back >= from &&
            back >= day - baselineWindowDays &&
            baseline.length < baselineReadings;
        back--
      ) {
        final value = readings[back];
        if (value != null) baseline.add(value);
      }
      if (baseline.length < baselineReadings) continue;

      var cover = baseline.first;
      for (final value in baseline) {
        if (value > cover) cover = value;
      }
      if (first <= cover) continue;

      // دو دمای بعدی (داخل پنجره‌ی چند روزه)
      final next = <int>[];
      for (
        var ahead = day + 1;
        ahead < to && ahead <= day + shiftWindowDays && next.length < 2;
        ahead++
      ) {
        final value = readings[ahead];
        if (value != null) next.add(value);
      }
      if (next.length < 2) continue;
      if (next[0] <= cover || next[1] <= cover) continue;
      if (next[1] < cover + (thirdRise * 100).round()) continue;

      return BbtOvulation(
        cycleStart: dayOnly(start),
        ovulationDate: DateTime.utc(1970, 1, 1 + (day - 1)),
        shiftStart: DateTime.utc(1970, 1, 1 + day),
        coverline: cover / 100,
      );
    }
    return null;
  }
}
