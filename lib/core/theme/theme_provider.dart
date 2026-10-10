import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/local_store.dart';
import 'theme_mode.dart';

final themeProvider =
StateNotifierProvider<ThemeNotifier, AppThemeMode>((ref) {
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
