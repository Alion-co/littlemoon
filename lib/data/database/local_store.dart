import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ذخیره‌سازی محلی و کاملاً آفلاین برنامه.
///
/// داده‌ها به‌صورت JSON روی دستگاه نگه داشته می‌شن (اندروید: فایل محلی،
/// وب: localStorage مرورگر). هیچ چیزی به اینترنت فرستاده نمی‌شه.
class LocalStore {
  LocalStore(this._prefs);

  final SharedPreferences _prefs;

  String? getString(String key) => _prefs.getString(key);

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  Map<String, dynamic>? getJson(String key) {
    final raw = _prefs.getString(key);
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) return decoded;
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<void> setJson(String key, Map<String, dynamic> value) async {
    await _prefs.setString(key, jsonEncode(value));
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }
}

/// در `main()` با نمونه‌ی واقعی override می‌شه.
final localStoreProvider = Provider<LocalStore>((ref) {
  throw UnimplementedError('localStoreProvider must be overridden in main()');
});
