import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';

import '../helpers/cycle_fixtures.dart';

void main() {
  group('پیش‌بینی بازه‌ای', () {
    test('بدون چرخه‌ی کامل ± ۳ روز', () {
      expect(CycleEngine.spreadOf(const []), CycleEngine.defaultSpread);
      expect(CycleEngine.spreadOf(const [28]), CycleEngine.defaultSpread);
    });

    test('چرخه‌های یکسان حداقل ± ۱ روز', () {
      expect(CycleEngine.spreadOf(const [28, 28, 28]), 1);
    });

    test('چرخه‌های نامنظم بازه‌ی پهن‌تر و سقف ۷', () {
      expect(CycleEngine.spreadOf(const [24, 34, 26, 33]), 4);
      expect(CycleEngine.spreadOf(const [15, 60]), 7);
    });

    test('بازه دور تاریخ پیش‌بینی', () {
      final cycle = sampleCycle();
      final next = cycle.nextPeriodStart!;
      expect(cycle.nextPeriodEarliest, next.subtract(const Duration(days: 1)));
      expect(cycle.nextPeriodLatest, next.add(const Duration(days: 1)));
    });

    test('متن بازه در یک ماه، اسم ماه یک‌بار', () {
      final fa = lookupAppLocalizations(const Locale('fa'));
      const calendar = AppCalendar(type: CalendarType.jalali, lang: 'fa');
      // ۱۲ تا ۱۶ آبان ۱۴۰۵
      final text = Labels.dateRange(
        fa,
        calendar,
        DateTime.utc(2026, 11, 3),
        DateTime.utc(2026, 11, 7),
      );
      expect(text, '۱۲ تا ۱۶ آبان');

      final en = lookupAppLocalizations(const Locale('en'));
      const greg = AppCalendar(type: CalendarType.gregorian, lang: 'en');
      expect(
        Labels.dateRange(
          en,
          greg,
          DateTime.utc(2026, 10, 12),
          DateTime.utc(2026, 10, 16),
        ),
        'October 12 – 16',
      );
    });
  });
}
