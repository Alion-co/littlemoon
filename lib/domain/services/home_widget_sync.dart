import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Brightness, Color, ThemeData;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';

import '../../core/localization/locale_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/theme/themes/moon_colors.dart';
import '../../core/utils/day_utils.dart';
import '../../data/models/app_settings.dart';
import '../../data/repositories/settings_repository.dart';
import '../../l10n/generated/app_localizations.dart';
import '../engine/cycle_engine.dart';
import 'cycle_providers.dart';

/// داده‌های ویجت صفحه‌ی اصلی گوشی (مربع ۲×۲، هم‌شکل کارت هیرو در تم فعلی) رو
/// به‌روز می‌کنه.
///
/// ویجت خودش (کد کاتلین در اندروید) هر روز «روز چندم چرخه» و «چند روز
/// تا عادت ماهانه» رو از روی همین داده‌ها حساب می‌کنه؛ برای همین حتی اگه
/// برنامه چند روز باز نشه، عددها درست می‌مونن. متن‌ها هم به‌صورت قالب
/// (با `{n}` به‌جای عدد) و به زبان فعلی برنامه فرستاده می‌شن.
abstract final class HomeWidgetSync {
  /// کلاس ویجت در اندروید.
  static const _provider = 'ir.littlemoon.MoonWidgetProvider';

  /// عددی که در متن‌ها با `{n}` جایگزین می‌شه.
  static const _marker = 987654;

  static bool get _supported =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  static String _template(String text) => text.replaceAll('$_marker', '{n}');

  /// همه‌ی داده‌ها به‌صورت متن ذخیره می‌شن تا خوندنشون در کاتلین ساده باشه.
  static Map<String, String> buildData({
    required CycleSnapshot cycle,
    required AppSettings settings,
    required AppLocalizations l10n,
    required ThemeData theme,
    ThemeData? nightTheme,
  }) {
    final lastStart = cycle.lastPeriodStart;

    return {
      // رنگ و حالت (روز/شب) ویجت از تم برنامه؛ «تم شب خودکار» با حالت تیره‌ی
      // گوشی عوض می‌شه، پس ظاهر شب هم جدا فرستاده می‌شه
      ..._look('a', theme),
      if (nightTheme != null) ..._look('n', nightTheme),
      'lm_auto_night': nightTheme != null ? '1' : '0',
      'lm_has_data': cycle.hasData && lastStart != null ? '1' : '0',
      'lm_last_start': lastStart == null ? '' : '${epochDay(lastStart)}',
      'lm_avg_cycle': '${cycle.avgCycleLength}',
      'lm_period_length': '${cycle.avgPeriodLength}',
      'lm_luteal': '${cycle.lutealLength}',
      'lm_discreet': settings.discreetNotifications ? '1' : '0',
      'lm_persian_digits': l10n.localeName == 'fa' ? '1' : '0',
      // جهت چیدمان ویجت بر اساس زبان برنامه
      'lm_rtl': l10n.localeName == 'fa' || l10n.localeName == 'ar' ? '1' : '0',
      // سرتیتر وسط حلقه، همان متن هیرو: «روز ۱۴»
      'lm_t_day_discreet': _template(l10n.dayOfCycle(_marker)),
      'lm_t_period_day': _template(l10n.periodDayNumber(_marker)),
      'lm_t_until': _template(l10n.daysUntilPeriod(_marker)),
      'lm_t_tomorrow': l10n.periodExpectedTomorrow,
      'lm_t_today': l10n.periodExpectedToday,
      'lm_t_late': _template(l10n.periodLateBy(_marker)),
      'lm_t_late_one': l10n.periodLateOneDay,
      'lm_t_empty': l10n.noCycleDataTitle,
      'lm_t_phase_menstrual': l10n.menstrualPhase,
      'lm_t_phase_follicular': l10n.follicularPhase,
      'lm_t_phase_ovulation': l10n.ovulationPhase,
      'lm_t_phase_luteal': l10n.lutealPhase,
    };
  }

  /// رنگ‌های هیرو در یک تم: پس‌زمینه‌ی کارت، رنگ حلقه/ماه، متن‌ها و حاشیه.
  static Map<String, String> _look(String prefix, ThemeData theme) {
    final scheme = theme.colorScheme;
    final moon = theme.extension<MoonColors>();
    String argb(Color c) => '${c.toARGB32()}';
    return {
      'lm_${prefix}_night': theme.brightness == Brightness.dark ? '1' : '0',
      'lm_${prefix}_bg': argb(theme.scaffoldBackgroundColor),
      'lm_${prefix}_hs': argb(moon?.heroStart ?? scheme.surface),
      'lm_${prefix}_he': argb(moon?.heroEnd ?? scheme.surface),
      'lm_${prefix}_pri': argb(scheme.primary),
      'lm_${prefix}_sec': argb(scheme.secondary),
      'lm_${prefix}_sub': argb(moon?.subtitle ?? scheme.onSurfaceVariant),
      'lm_${prefix}_ink': argb(scheme.onSurface),
      'lm_${prefix}_line': argb(theme.dividerColor),
    };
  }

  static Future<void> push(Map<String, String> data) async {
    if (!_supported) return;
    try {
      for (final entry in data.entries) {
        await HomeWidget.saveWidgetData<String>(entry.key, entry.value);
      }
      await HomeWidget.updateWidget(qualifiedAndroidName: _provider);
    } catch (error) {
      debugPrint('Home widget update failed: $error');
    }
  }

  /// آیا لانچر گوشی اجازه می‌ده برنامه خودش ویجت رو اضافه کنه (اندروید ۸+).
  static Future<bool> canPin() async {
    if (!_supported) return false;
    try {
      return await HomeWidget.isRequestPinWidgetSupported() ?? false;
    } catch (_) {
      return false;
    }
  }

  /// پنجره‌ی «افزودن ویجت به صفحه‌ی اصلی» خود گوشی رو باز می‌کنه.
  static Future<bool> pin() async {
    if (!_supported) return false;
    try {
      await HomeWidget.requestPinWidget(qualifiedAndroidName: _provider);
      return true;
    } catch (error) {
      debugPrint('Pinning home widget failed: $error');
      return false;
    }
  }
}

/// آیا افزودن مستقیم ویجت از داخل برنامه روی این گوشی ممکنه.
final canPinWidgetProvider = FutureProvider<bool>(
  (ref) => HomeWidgetSync.canPin(),
);

/// ویجت رو با وضعیت فعلی چرخه، تنظیمات و زبان هماهنگ نگه می‌داره.
/// کافیه یک‌بار در ریشه‌ی برنامه `watch` بشه.
final homeWidgetSyncProvider = Provider<void>((ref) {
  final mode = ref.watch(themeProvider);
  final data = HomeWidgetSync.buildData(
    cycle: ref.watch(cycleProvider),
    settings: ref.watch(settingsProvider),
    l10n: lookupAppLocalizations(ref.watch(localeProvider)),
    theme: AppTheme.getTheme(mode),
    nightTheme: ref.watch(autoNightThemeProvider)
        ? AppTheme.getTheme(nightCounterpart(mode))
        : null,
  );
  unawaited(HomeWidgetSync.push(data));
});
