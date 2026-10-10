import 'package:flutter/widgets.dart';

const _persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

/// رقم‌های لاتین داخل [input] رو به رقم فارسی تبدیل می‌کنه.
String toPersianDigits(String input) {
  final buffer = StringBuffer();
  for (final unit in input.codeUnits) {
    if (unit >= 48 && unit <= 57) {
      buffer.write(_persianDigits[unit - 48]);
    } else {
      buffer.writeCharCode(unit);
    }
  }
  return buffer.toString();
}

/// رقم‌های فارسی/عربی رو به لاتین برمی‌گردونه (برای خوندن ورودی کاربر).
String toLatinDigits(String input) {
  final buffer = StringBuffer();
  for (final rune in input.runes) {
    if (rune >= 0x06F0 && rune <= 0x06F9) {
      buffer.writeCharCode(rune - 0x06F0 + 48);
    } else if (rune >= 0x0660 && rune <= 0x0669) {
      buffer.writeCharCode(rune - 0x0660 + 48);
    } else if (rune == 0x066B || rune == 0x060C) {
      buffer.write('.');
    } else {
      buffer.writeCharCode(rune);
    }
  }
  return buffer.toString();
}

String localizeDigits(String input, String languageCode) =>
    languageCode == 'fa' ? toPersianDigits(input) : input;

extension LocalizedDigits on BuildContext {
  /// عدد/متن رو با رقم‌های زبان فعلی برنامه نشون می‌ده.
  String n(Object value) => localizeDigits(
        value.toString(),
        Localizations.localeOf(this).languageCode,
      );
}
