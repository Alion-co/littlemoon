import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/core/theme/app_theme.dart';
import 'package:little_moon/core/theme/theme_mode.dart';
import 'package:little_moon/data/models/app_settings.dart';
import 'package:little_moon/domain/services/home_widget_sync.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';

import '../helpers/cycle_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ویجت', () {
    test('قالب متن‌ها با {n}', () {
      final fa = lookupAppLocalizations(const Locale('fa'));
      final data = HomeWidgetSync.buildData(
        cycle: sampleCycle(),
        settings: const AppSettings(),
        l10n: fa,
        theme: AppTheme.getTheme(AppThemeMode.moon),
      );
      expect(data['lm_has_data'], '1');
      expect(data['lm_t_day_discreet'], 'روز {n}');
      expect(data['lm_t_until'], contains('{n}'));
      expect(data['lm_persian_digits'], '1');
    });

    test('رنگ تم و ظاهر شب خودکار', () {
      final fa = lookupAppLocalizations(const Locale('fa'));
      final plain = HomeWidgetSync.buildData(
        cycle: sampleCycle(),
        settings: const AppSettings(),
        l10n: fa,
        theme: AppTheme.getTheme(AppThemeMode.moon),
      );
      expect(plain['lm_a_night'], '0');
      expect(plain['lm_a_pri'], isNotEmpty);
      expect(plain['lm_auto_night'], '0');
      expect(plain.containsKey('lm_n_night'), isFalse);

      final auto = HomeWidgetSync.buildData(
        cycle: sampleCycle(),
        settings: const AppSettings(),
        l10n: fa,
        theme: AppTheme.getTheme(AppThemeMode.moon),
        nightTheme: AppTheme.getTheme(AppThemeMode.nightRose),
      );
      expect(auto['lm_auto_night'], '1');
      expect(auto['lm_n_night'], '1');
    });
  });
}
