import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import '../../data/database/local_store.dart';

/// طول رمز عددی قفل برنامه.
const appLockPinLength = 4;

/// تنظیمات ذخیره‌شده‌ی قفل. خود رمز هیچ‌وقت ذخیره نمی‌شه، فقط هش نمک‌دارش.
///
/// این تنظیمات عمداً جدا از [AppSettings] نگه داشته می‌شن تا داخل متن
/// پشتیبان نرن؛ بازگردانی پشتیبان روی گوشی دیگه نباید رمز قبلی رو بیاره.
class AppLockConfig {
  final bool enabled;
  final bool biometric;
  final String salt;
  final String hash;

  const AppLockConfig({
    this.enabled = false,
    this.biometric = false,
    this.salt = '',
    this.hash = '',
  });

  Map<String, dynamic> toJson() => {
    'enabled': enabled,
    'biometric': biometric,
    'salt': salt,
    'hash': hash,
  };

  factory AppLockConfig.fromJson(Map<String, dynamic> json) {
    final salt = json['salt'];
    final hash = json['hash'];
    final valid = salt is String && hash is String && hash.isNotEmpty;
    return AppLockConfig(
      enabled: valid && json['enabled'] == true,
      biometric: valid && json['biometric'] == true,
      salt: valid ? salt : '',
      hash: valid ? hash : '',
    );
  }
}

/// وضعیت لحظه‌ای قفل.
class AppLockState {
  final AppLockConfig config;

  /// صفحه‌ی قفل الان روی برنامه هست یا نه.
  final bool locked;

  /// بعد از چند تلاش اشتباه، تا این لحظه ورود رمز غیرفعاله.
  final DateTime? blockedUntil;

  const AppLockState({
    required this.config,
    required this.locked,
    this.blockedUntil,
  });

  bool get enabled => config.enabled;

  AppLockState copyWith({
    AppLockConfig? config,
    bool? locked,
    DateTime? blockedUntil,
    bool clearBlock = false,
  }) {
    return AppLockState(
      config: config ?? this.config,
      locked: locked ?? this.locked,
      blockedUntil: clearBlock ? null : (blockedUntil ?? this.blockedUntil),
    );
  }
}

/// اثر انگشت / تشخیص چهره‌ی گوشی (فقط اندروید).
abstract final class BiometricAuth {
  static final LocalAuthentication _auth = LocalAuthentication();

  static bool get _supported =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  /// گوشی اثر انگشت یا قفل امن داره و کاربر حداقل یکی رو ثبت کرده.
  static Future<bool> isAvailable() async {
    if (!_supported) return false;
    try {
      final canCheck = await _auth.canCheckBiometrics;
      final supported = await _auth.isDeviceSupported();
      return canCheck && supported;
    } catch (error) {
      debugPrint('Biometric check failed: $error');
      return false;
    }
  }

  static Future<bool> authenticate(String reason) async {
    if (!_supported) return false;
    try {
      return await _auth.authenticate(localizedReason: reason);
    } catch (error) {
      debugPrint('Biometric auth failed: $error');
      return false;
    }
  }
}

/// قفل برنامه با رمز عددی و (اختیاری) اثر انگشت.
///
/// برنامه وقتی از پس‌زمینه برمی‌گرده دوباره قفل می‌شه. چند ثانیه‌ی کوتاه
/// ([_grace]) نادیده گرفته می‌شه تا پایین کشیدن نوار اعلان‌ها یا یک
/// جابه‌جایی سریع، برنامه رو قفل نکنه.
class AppLockNotifier extends StateNotifier<AppLockState> {
  AppLockNotifier(this._store)
    : _failedAttempts = _readFailedAttempts(_store),
      super(_initial(_store));

  static const storageKey = 'app_lock_v1';

  /// تلاش‌های اشتباه و زمان پایان مسدودی؛ جدا از تنظیمات رمز ذخیره می‌شن تا
  /// با بستن یا کشتن برنامه صفر نشن.
  static const attemptsKey = 'app_lock_attempts_v1';
  static const _maxAttempts = 5;
  static const _blockDuration = Duration(seconds: 30);
  static const _grace = Duration(seconds: 5);

  final LocalStore _store;

  int _failedAttempts;
  DateTime? _backgroundSince;

  /// وقتی پنجره‌ی اثر انگشت یا اشتراک‌گذاری باز می‌شه، برنامه موقتاً
  /// به پس‌زمینه می‌ره؛ این دفعه نباید قفل بشه.
  bool _ignoreNextBackground = false;
  bool _biometricInProgress = false;

  static AppLockState _initial(LocalStore store) {
    final json = store.getJson(storageKey);
    final config = json == null
        ? const AppLockConfig()
        : AppLockConfig.fromJson(json);
    // اگه قفل فعاله، برنامه از همون اول قفل باز می‌شه
    return AppLockState(
      config: config,
      locked: config.enabled,
      blockedUntil: config.enabled ? _readBlockedUntil(store) : null,
    );
  }

  static int _readFailedAttempts(LocalStore store) {
    final value = store.getJson(attemptsKey)?['failed'];
    if (value is! num) return 0;
    return value.toInt().clamp(0, _maxAttempts - 1);
  }

  /// مسدودی‌ای که هنوز تموم نشده؛ وگرنه `null`.
  static DateTime? _readBlockedUntil(LocalStore store) {
    final value = store.getJson(attemptsKey)?['blockedUntil'];
    if (value is! num) return null;
    final until = DateTime.fromMillisecondsSinceEpoch(value.toInt());
    final now = DateTime.now();
    if (!until.isAfter(now)) return null;
    // ساعت گوشی رو عقب بکشن، مسدودی از سقف طبیعی‌اش بلندتر نمی‌شه
    final limit = now.add(_blockDuration);
    return until.isAfter(limit) ? limit : until;
  }

  /// وضعیت تلاش‌های اشتباه رو روی دیسک نگه می‌داره.
  Future<void> _persistAttempts() async {
    final blocked = state.blockedUntil;
    final blockedActive = blocked != null && blocked.isAfter(DateTime.now());
    if (_failedAttempts == 0 && !blockedActive) {
      await _store.remove(attemptsKey);
      return;
    }
    await _store.setJson(attemptsKey, {
      'failed': _failedAttempts,
      if (blockedActive) 'blockedUntil': blocked.millisecondsSinceEpoch,
    });
  }

  // ---------- رمز ----------

  static String _newSalt() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    return base64UrlEncode(bytes);
  }

  /// هش نمک‌دار و تکراری؛ برای رمز ۴ رقمی هم حدس زدن رو کندتر می‌کنه.
  static String _hash(String salt, String pin) {
    List<int> digest = utf8.encode('$salt:$pin');
    for (var i = 0; i < 5000; i++) {
      digest = sha256.convert(digest).bytes;
    }
    return base64UrlEncode(digest);
  }

  bool _matches(String pin) {
    final config = state.config;
    if (!config.enabled || config.hash.isEmpty) return false;
    return _hash(config.salt, pin) == config.hash;
  }

  Future<void> _saveConfig(AppLockConfig config) async {
    state = state.copyWith(config: config);
    await _store.setJson(storageKey, config.toJson());
  }

  /// قفل رو با رمز تازه فعال می‌کنه (یا رمز قبلی رو عوض می‌کنه).
  Future<void> setPin(String pin) async {
    final salt = _newSalt();
    await _saveConfig(
      AppLockConfig(
        enabled: true,
        biometric: state.config.biometric,
        salt: salt,
        hash: _hash(salt, pin),
      ),
    );
  }

  Future<void> disable() async {
    _failedAttempts = 0;
    await _store.remove(attemptsKey);
    await _store.remove(storageKey);
    state = const AppLockState(config: AppLockConfig(), locked: false);
  }

  Future<void> setBiometric(bool value) async {
    if (!state.enabled) return;
    final config = state.config;
    await _saveConfig(
      AppLockConfig(
        enabled: true,
        biometric: value,
        salt: config.salt,
        hash: config.hash,
      ),
    );
  }

  /// رمز رو بدون باز کردن قفل بررسی می‌کنه (مثلاً قبل از خاموش کردن قفل).
  bool verify(String pin) => _matches(pin);

  /// تلاش برای باز کردن قفل با رمز. اگه موقتاً مسدود باشه `false`.
  bool unlockWithPin(String pin) {
    final blocked = state.blockedUntil;
    if (blocked != null && DateTime.now().isBefore(blocked)) return false;

    if (_matches(pin)) {
      _failedAttempts = 0;
      state = state.copyWith(locked: false, clearBlock: true);
      unawaited(_persistAttempts());
      return true;
    }

    _failedAttempts++;
    if (_failedAttempts >= _maxAttempts) {
      _failedAttempts = 0;
      state = state.copyWith(blockedUntil: DateTime.now().add(_blockDuration));
    }
    unawaited(_persistAttempts());
    return false;
  }

  Future<bool> unlockWithBiometric(String reason) async {
    if (!state.enabled || !state.config.biometric) return false;
    if (_biometricInProgress) return false;
    _biometricInProgress = true;
    try {
      final ok = await BiometricAuth.authenticate(reason);
      if (ok) {
        _failedAttempts = 0;
        state = state.copyWith(locked: false, clearBlock: true);
        unawaited(_persistAttempts());
      }
      return ok;
    } finally {
      _biometricInProgress = false;
      // پنجره‌ی اثر انگشت خودش برنامه رو لحظه‌ای به پس‌زمینه می‌بره
      _backgroundSince = null;
    }
  }

  // ---------- چرخه‌ی عمر برنامه ----------

  /// قبل از باز کردن پنجره‌ی اشتراک‌گذاری صدا زده می‌شه تا برگشتن از اون
  /// باعث قفل شدن نشه.
  void ignoreNextBackground() => _ignoreNextBackground = true;

  void onLifecycleChanged(AppLifecycleState lifecycle) {
    if (!state.enabled || _biometricInProgress) return;

    switch (lifecycle) {
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        _backgroundSince ??= DateTime.now();
      case AppLifecycleState.resumed:
        final since = _backgroundSince;
        _backgroundSince = null;
        if (since == null) return;
        if (_ignoreNextBackground) {
          _ignoreNextBackground = false;
          return;
        }
        if (DateTime.now().difference(since) >= _grace) {
          state = state.copyWith(locked: true);
        }
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }
}

final appLockProvider = StateNotifierProvider<AppLockNotifier, AppLockState>((
  ref,
) {
  return AppLockNotifier(ref.watch(localStoreProvider));
});

/// آیا گوشی اثر انگشت آماده‌ی استفاده داره.
final biometricAvailableProvider = FutureProvider<bool>(
  (ref) => BiometricAuth.isAvailable(),
);
