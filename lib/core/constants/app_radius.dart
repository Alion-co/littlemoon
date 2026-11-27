import 'package:flutter/painting.dart';

abstract final class AppRadius {
  static const sm = 12.0;
  static const md = 18.0;
  static const lg = 24.0;
  static const xl = 30.0;

  // ---- BorderRadius آماده (const) ----
  // به‌جای `BorderRadius.circular(n)`؛ عدد در اسم، همون گردیِ قبلیه.
  static const br4 = BorderRadius.all(Radius.circular(4));
  static const br8 = BorderRadius.all(Radius.circular(8));
  static const br10 = BorderRadius.all(Radius.circular(10));
  static const br12 = BorderRadius.all(Radius.circular(12));
  static const br14 = BorderRadius.all(Radius.circular(14));
  static const br16 = BorderRadius.all(Radius.circular(16));
  static const br18 = BorderRadius.all(Radius.circular(18));
  static const br20 = BorderRadius.all(Radius.circular(20));
  static const br22 = BorderRadius.all(Radius.circular(22));
  static const br24 = BorderRadius.all(Radius.circular(24));
  static const br26 = BorderRadius.all(Radius.circular(26));
  static const br28 = BorderRadius.all(Radius.circular(28));
  static const br30 = BorderRadius.all(Radius.circular(30));

  /// بالای شیت‌های پایین‌صفحه
  static const sheetTop = BorderRadius.vertical(top: Radius.circular(28));
}
