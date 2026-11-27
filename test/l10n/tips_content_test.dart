import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/domain/services/daily_tips.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';

/// مطمئن می‌شه برای هر زبان، هر فاز و هر دسته دقیقاً ۳ پیشنهاد پر هست
/// (اگه ARB یه زبان ناقص باشه، اینجا قرمز می‌شه).
void main() {
  for (final code in ['en', 'fa', 'ar', 'tr', 'es']) {
    test('پیشنهادهای روزانه‌ی $code کامل‌ان', () {
      final l10n = lookupAppLocalizations(Locale(code));
      for (final phase in CyclePhase.values) {
        for (final category in TipCategory.values) {
          final pool = Labels.tipPool(l10n, phase, category);
          expect(pool.length, 3, reason: '$code / $phase / $category');
          for (final tip in pool) {
            expect(tip.trim(), isNotEmpty);
          }
        }
      }
    });

    test('عنوان دسته‌ها در $code خالی نیست', () {
      final l10n = lookupAppLocalizations(Locale(code));
      for (final category in TipCategory.values) {
        expect(Labels.tipCategory(l10n, category).trim(), isNotEmpty);
      }
    });
  }
}
