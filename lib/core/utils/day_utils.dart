/// ابزارهای کار با «تاریخِ فقط‌روز».
///
/// همه‌ی تاریخ‌ها به‌صورت نیمه‌شب UTC نگه داشته می‌شن تا تغییر ساعت
/// (DST) هیچ‌وقت باعث یک روز جابه‌جایی در محاسبه‌ی چرخه نشه.
library;

DateTime dayOnly(DateTime d) => DateTime.utc(d.year, d.month, d.day);

DateTime addDays(DateTime d, int days) =>
    DateTime.utc(d.year, d.month, d.day + days);

/// تعداد روز از [from] تا [to] (اگه [to] جلوتر باشه مثبته).
int daysBetween(DateTime from, DateTime to) =>
    dayOnly(to).difference(dayOnly(from)).inDays;

bool sameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

/// شماره‌ی روز از مبدأ یونیکس — کلید سریع برای Map/Set.
int epochDay(DateTime d) =>
    dayOnly(d).millisecondsSinceEpoch ~/ Duration.millisecondsPerDay;

String _two(int n) => n < 10 ? '0$n' : '$n';

/// کلید ذخیره‌سازی به شکل `yyyy-MM-dd` (همیشه میلادی).
String dayKey(DateTime d) => '${d.year}-${_two(d.month)}-${_two(d.day)}';

DateTime? parseDayKey(String? key) {
  if (key == null) return null;
  final parts = key.split('-');
  if (parts.length != 3) return null;
  final y = int.tryParse(parts[0]);
  final m = int.tryParse(parts[1]);
  final d = int.tryParse(parts[2]);
  if (y == null || m == null || d == null) return null;
  return DateTime.utc(y, m, d);
}
