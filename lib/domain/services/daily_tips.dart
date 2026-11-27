import '../../core/utils/day_utils.dart';

/// دسته‌های پیشنهاد روزانه.
enum TipCategory { nutrition, movement, rest }

/// انتخاب پیشنهاد روزانه از میان چند پیشنهاد هر فاز (کاملاً آفلاین).
///
/// هر روز یکی جلوتر می‌ره و هر دسته آفست جدا داره تا سه پیشنهاد کنار هم
/// همیشه با هم عوض نشن. در یک روز، همه‌جا نتیجه یکسانه.
abstract final class DailyTips {
  /// متن چندپیشنهادی «الف|ب|ج» رو به لیست تبدیل می‌کنه.
  static List<String> parsePool(String raw) {
    return [
      for (final part in raw.split('|'))
        if (part.trim().isNotEmpty) part.trim(),
    ];
  }

  /// شماره‌ی پیشنهاد امروز در یک لیست به اندازه‌ی [poolSize].
  /// [shift] برای «یکی دیگه نشون بده» (لمس کاربر) استفاده می‌شه.
  static int indexFor({
    required DateTime day,
    required TipCategory category,
    required int poolSize,
    int shift = 0,
  }) {
    if (poolSize <= 0) return 0;
    final value = epochDay(day) + category.index * 2 + shift;
    return ((value % poolSize) + poolSize) % poolSize;
  }

  /// پیشنهاد امروز، یا `null` اگه لیست خالیه.
  static String? pick(
    List<String> pool, {
    required DateTime day,
    required TipCategory category,
    int shift = 0,
  }) {
    if (pool.isEmpty) return null;
    return pool[indexFor(
      day: day,
      category: category,
      poolSize: pool.length,
      shift: shift,
    )];
  }
}
