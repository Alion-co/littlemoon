import 'day_utils.dart';
import 'digits.dart';
import 'jalali.dart';
import 'math_utils.dart';

enum CalendarType { jalali, gregorian }

/// یک ماه در تقویم انتخاب‌شده (شمسی یا میلادی).
class CalMonth {
  final int year;
  final int month;

  const CalMonth(this.year, this.month);

  @override
  bool operator ==(Object other) =>
      other is CalMonth && other.year == year && other.month == month;

  @override
  int get hashCode => year * 100 + month;
}

/// همه‌ی نمایش و محاسبه‌ی تاریخ در UI از این کلاس رد می‌شه،
/// تا شمسی/میلادی و فارسی/انگلیسی یک‌جا کنترل بشه.
class AppCalendar {
  final CalendarType type;
  final String lang;

  const AppCalendar({required this.type, required this.lang});

  bool get isJalali => type == CalendarType.jalali;
  bool get isFa => lang == 'fa';

  String n(Object value) => localizeDigits(value.toString(), lang);

  // ---------- ماه ----------

  CalMonth monthOf(DateTime date) {
    if (isJalali) {
      final j = JalaliDate.fromDateTime(date);
      return CalMonth(j.year, j.month);
    }
    return CalMonth(date.year, date.month);
  }

  int dayOfMonth(DateTime date) =>
      isJalali ? JalaliDate.fromDateTime(date).day : date.day;

  int yearOf(DateTime date) => monthOf(date).year;

  DateTime firstDayOf(CalMonth m) => isJalali
      ? JalaliDate(m.year, m.month, 1).toDateTime()
      : DateTime.utc(m.year, m.month, 1);

  CalMonth next(CalMonth m) =>
      m.month == 12 ? CalMonth(m.year + 1, 1) : CalMonth(m.year, m.month + 1);

  CalMonth previous(CalMonth m) =>
      m.month == 1 ? CalMonth(m.year - 1, 12) : CalMonth(m.year, m.month - 1);

  int lengthOf(CalMonth m) => daysBetween(firstDayOf(m), firstDayOf(next(m)));

  // ---------- هفته ----------

  /// زبان‌هایی که هفته‌شون از شنبه شروع می‌شه.
  bool get _saturdayFirst => isJalali || lang == 'fa' || lang == 'ar';

  /// اولین روز هفته به فرمت [DateTime.weekday].
  int get firstWeekday =>
      _saturdayFirst ? DateTime.saturday : DateTime.monday;

  /// هفت روز هفته به ترتیب نمایش.
  List<int> get weekdayOrder =>
      List.generate(7, (i) => (firstWeekday - 1 + i) % 7 + 1);

  DateTime startOfWeek(DateTime date) =>
      addDays(date, -((date.weekday - firstWeekday + 7) % 7));

  // ---------- متن ----------

  static const _jalaliMonths = <String, List<String>>{
    'fa': [
      'فروردین', 'اردیبهشت', 'خرداد', 'تیر', 'مرداد', 'شهریور', //
      'مهر', 'آبان', 'آذر', 'دی', 'بهمن', 'اسفند',
    ],
    'ar': [
      'فروردين', 'أرديبهشت', 'خرداد', 'تير', 'مرداد', 'شهريور', //
      'مهر', 'آبان', 'آذر', 'دي', 'بهمن', 'إسفند',
    ],
    'en': [
      'Farvardin', 'Ordibehesht', 'Khordad', 'Tir', 'Mordad', 'Shahrivar', //
      'Mehr', 'Aban', 'Azar', 'Dey', 'Bahman', 'Esfand',
    ],
  };

  static const _gregorianMonths = <String, List<String>>{
    'fa': [
      'ژانویه', 'فوریه', 'مارس', 'آوریل', 'مه', 'ژوئن', //
      'ژوئیه', 'اوت', 'سپتامبر', 'اکتبر', 'نوامبر', 'دسامبر',
    ],
    'ar': [
      'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', //
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
    ],
    'es': [
      'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', //
      'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre',
    ],
    'tr': [
      'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran', //
      'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık',
    ],
    'en': [
      'January', 'February', 'March', 'April', 'May', 'June', //
      'July', 'August', 'September', 'October', 'November', 'December',
    ],
  };

  // اندیس صفر = دوشنبه (مطابق DateTime.weekday - 1)
  static const _weekdays = <String, List<String>>{
    'fa': [
      'دوشنبه', 'سه‌شنبه', 'چهارشنبه', 'پنجشنبه', 'جمعه', 'شنبه', 'یکشنبه', //
    ],
    'ar': [
      'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', //
      'الأحد',
    ],
    'es': [
      'lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', //
      'domingo',
    ],
    'tr': [
      'Pazartesi', 'Salı', 'Çarşamba', 'Perşembe', 'Cuma', 'Cumartesi', //
      'Pazar',
    ],
    'en': [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', //
      'Sunday',
    ],
  };

  static const _weekdaysShort = <String, List<String>>{
    'fa': ['د', 'س', 'چ', 'پ', 'ج', 'ش', 'ی'],
    'ar': ['ن', 'ث', 'ر', 'خ', 'ج', 'س', 'ح'],
    'es': ['L', 'M', 'X', 'J', 'V', 'S', 'D'],
    'tr': ['Pt', 'Sa', 'Ça', 'Pe', 'Cu', 'Ct', 'Pz'],
    'en': ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
  };

  /// لیست متن‌های زبان فعلی؛ اگه زبانی تعریف نشده باشه انگلیسی.
  List<String> _pick(Map<String, List<String>> table) =>
      table[lang] ?? table['en']!;

  String monthName(int month) {
    final list = _pick(isJalali ? _jalaliMonths : _gregorianMonths);
    return list[clampInt(month - 1, 0, 11)];
  }

  String weekdayName(int weekday) =>
      _pick(_weekdays)[clampInt(weekday - 1, 0, 6)];

  String weekdayShort(int weekday) =>
      _pick(_weekdaysShort)[clampInt(weekday - 1, 0, 6)];

  /// جداکننده‌ی فهرست در زبان فعلی.
  String get comma => (lang == 'fa' || lang == 'ar') ? '،' : ',';

  /// مثل «مهر ۱۴۰۵»، «October 2026» یا «octubre de 2026».
  String monthYear(CalMonth m) {
    final name = monthName(m.month);
    if (lang == 'es' && !isJalali) return '$name de ${m.year}';
    return n('$name ${m.year}');
  }

  /// مثل «۱۸ مهر»، «October 10» یا «10 de octubre».
  String dayMonth(DateTime date) {
    final name = monthName(monthOf(date).month);
    final d = dayOfMonth(date);
    if (!isJalali) {
      if (lang == 'en') return '$name $d';
      if (lang == 'es') return '$d de $name';
    }
    return n('$d $name');
  }

  /// مثل «۱۸ مهر ۱۴۰۵»، «October 10, 2026» یا «10 de octubre de 2026».
  String dayMonthYear(DateTime date) {
    final m = monthOf(date);
    final name = monthName(m.month);
    final d = dayOfMonth(date);
    if (!isJalali) {
      if (lang == 'en') return '$name $d, ${m.year}';
      if (lang == 'es') return '$d de $name de ${m.year}';
    }
    return n('$d $name ${m.year}');
  }

  /// مثل «شنبه، ۱۸ مهر» یا «Saturday, October 10».
  String weekdayDayMonth(DateTime date) =>
      '${weekdayName(date.weekday)}$comma ${dayMonth(date)}';
}
