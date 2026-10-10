import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/local_store.dart';

/// زبان‌های برنامه با اسم بومی هر کدوم (برای نمایش در انتخابگر زبان).
const Map<String, String> appLanguages = {
  'fa': 'فارسی',
  'en': 'English',
  'ar': 'العربية',
  'es': 'Español',
  'tr': 'Türkçe',
};

final localeProvider =
StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier(ref.watch(localStoreProvider));
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier(this._store) : super(_read(_store));

  static const _storageKey = 'app_locale';

  final LocalStore _store;

  /// زبان پیش‌فرض برنامه فارسیه.
  static Locale _read(LocalStore store) {
    final saved = store.getString(_storageKey);
    if (saved != null && appLanguages.containsKey(saved)) {
      return Locale(saved);
    }
    return const Locale('fa');
  }

  void setEnglish() => setLanguage('en');

  void setPersian() => setLanguage('fa');

  /// [code] باید یکی از کلیدهای [appLanguages] باشه.
  void setLanguage(String code) {
    if (!appLanguages.containsKey(code)) return;
    state = Locale(code);
    _store.setString(_storageKey, code);
  }
}
