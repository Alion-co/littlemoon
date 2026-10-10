/// تبدیل تاریخ میلادی ↔ هجری شمسی (جلالی) — بدون وابستگی خارجی.
///
/// الگوریتم برای بازه‌ی ۱۳۰۹ تا ۱۴۷۸ شمسی روز‌به‌روز با تقویم رسمی
/// مقایسه و تأیید شده.
class JalaliDate {
  final int year;
  final int month;
  final int day;

  const JalaliDate(this.year, this.month, this.day);

  factory JalaliDate.fromDateTime(DateTime date) {
    const daysBeforeMonth = [
      0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, //
    ];

    final gy = date.year;
    final gm = date.month;
    final gd = date.day;
    final gy2 = gm > 2 ? gy + 1 : gy;

    var days = 355666 +
        365 * gy +
        (gy2 + 3) ~/ 4 -
        (gy2 + 99) ~/ 100 +
        (gy2 + 399) ~/ 400 +
        gd +
        daysBeforeMonth[gm - 1];

    var jy = -1595 + 33 * (days ~/ 12053);
    days = days % 12053;

    jy += 4 * (days ~/ 1461);
    days = days % 1461;

    if (days > 365) {
      jy += (days - 1) ~/ 365;
      days = (days - 1) % 365;
    }

    int jm;
    int jd;
    if (days < 186) {
      jm = 1 + days ~/ 31;
      jd = 1 + days % 31;
    } else {
      jm = 7 + (days - 186) ~/ 30;
      jd = 1 + (days - 186) % 30;
    }

    return JalaliDate(jy, jm, jd);
  }

  /// معادل میلادی، به‌صورت نیمه‌شب UTC.
  DateTime toDateTime() {
    final jy = year + 1595;

    var days = -355668 +
        365 * jy +
        (jy ~/ 33) * 8 +
        (jy % 33 + 3) ~/ 4 +
        day +
        (month < 7 ? (month - 1) * 31 : (month - 7) * 30 + 186);

    var gy = 400 * (days ~/ 146097);
    days = days % 146097;

    if (days > 36524) {
      days -= 1;
      gy += 100 * (days ~/ 36524);
      days = days % 36524;
      if (days >= 365) days += 1;
    }

    gy += 4 * (days ~/ 1461);
    days = days % 1461;

    if (days > 365) {
      gy += (days - 1) ~/ 365;
      days = (days - 1) % 365;
    }

    var gd = days + 1;
    final isLeap = (gy % 4 == 0 && gy % 100 != 0) || gy % 400 == 0;
    final monthLengths = [
      0, 31, isLeap ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, //
    ];

    var gm = 0;
    while (gm < 13 && gd > monthLengths[gm]) {
      gd -= monthLengths[gm];
      gm++;
    }

    return DateTime.utc(gy, gm, gd);
  }

  @override
  String toString() => '$year/$month/$day';
}
