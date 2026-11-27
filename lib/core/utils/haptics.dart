import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/data/database/local_store.dart';

/// لمس حسی (لرزش ظریف) برای لحظه‌های مهم: لمس تب، ذخیره، ثبت پریود.
/// از «تنظیمات › ظاهر» قابل خاموش شدنه.
abstract final class Haptics {
  /// در `main()` از روی تنظیم ذخیره‌شده مقدار می‌گیره.
  static bool enabled = true;

  /// لمس خیلی سبک: تعویض تب، انتخاب.
  static void tap() {
    if (enabled) HapticFeedback.selectionClick();
  }

  /// تأیید کوتاه: ذخیره شد، ثبت شد.
  static void success() {
    if (enabled) HapticFeedback.lightImpact();
  }
}

final hapticsProvider = StateNotifierProvider<HapticsNotifier, bool>((ref) {
  return HapticsNotifier(ref.watch(localStoreProvider));
});

class HapticsNotifier extends StateNotifier<bool> {
  HapticsNotifier(this._store) : super(_store.getString(storageKey) != 'off');

  static const storageKey = 'haptics_enabled';

  final LocalStore _store;

  void set(bool value) {
    state = value;
    Haptics.enabled = value;
    _store.setString(storageKey, value ? 'on' : 'off');
  }
}
