import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/local_store.dart';
import 'theme_mode.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, AppThemeMode>((ref) {
  return ThemeNotifier(ref.watch(localStoreProvider));
});

class ThemeNotifier extends StateNotifier<AppThemeMode> {
  ThemeNotifier(this._store) : super(_read(_store));

  static const _storageKey = 'app_theme';

  final LocalStore _store;

  static AppThemeMode _read(LocalStore store) {
    final saved = store.getString(_storageKey);
    for (final mode in AppThemeMode.values) {
      if (mode.name == saved) return mode;
    }
    return AppThemeMode.moon;
  }

  void changeTheme(AppThemeMode theme) {
    state = theme;
    _store.setString(_storageKey, theme.name);
  }
}

/// «تم شب خودکار»: وقتی گوشی روی حالت تیره‌ست، به‌جای تم روشن انتخابی
/// تم شبِ هم‌خانواده‌اش نشون داده می‌شه.
final autoNightThemeProvider =
    StateNotifierProvider<AutoNightThemeNotifier, bool>((ref) {
      return AutoNightThemeNotifier(ref.watch(localStoreProvider));
    });

class AutoNightThemeNotifier extends StateNotifier<bool> {
  AutoNightThemeNotifier(this._store)
    : super(_store.getString(_storageKey) == 'on');

  static const _storageKey = 'app_theme_auto_night';

  final LocalStore _store;

  void set(bool value) {
    state = value;
    _store.setString(_storageKey, value ? 'on' : 'off');
  }
}

/// تم شب متناسب با هر تم: تم‌های صورتی/گرم → «رز شب»، بقیه → «نیمه‌شب».
/// تم‌هایی که خودشون تیره‌ان همون می‌مونن.
AppThemeMode nightCounterpart(AppThemeMode mode) {
  switch (mode) {
    case AppThemeMode.midnight:
    case AppThemeMode.nightRose:
      return mode;
    case AppThemeMode.moon:
    case AppThemeMode.sakura:
    case AppThemeMode.sunset:
      return AppThemeMode.nightRose;
    case AppThemeMode.lavender:
    case AppThemeMode.ocean:
    case AppThemeMode.mint:
      return AppThemeMode.midnight;
  }
}
