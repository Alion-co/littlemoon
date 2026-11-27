import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// شمارنده‌ی به‌روزرسانی providerها برای اندازه‌گیری (P4-4).
///
/// فقط وقتی روشنه که با این پرچم اجرا کنی:
///   flutter run --profile --dart-define=PROVIDER_STATS=true
/// هر ۱۰ ثانیه (در صورت تغییر) جدول تعداد به‌روزرسانی هر provider رو توی
/// کنسول چاپ می‌کنه؛ مثلاً ببین با ۲۰ بار ثبت آب، `Provider<CycleSnapshot>`
/// چند بار به‌روز شده.
class ProviderStats extends ProviderObserver {
  static const enabled = bool.fromEnvironment('PROVIDER_STATS');

  final Map<String, int> _counts = {};
  Timer? _timer;
  bool _dirty = false;

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    final name = provider.name ?? provider.runtimeType.toString();
    _counts[name] = (_counts[name] ?? 0) + 1;
    _dirty = true;
    _timer ??= Timer.periodic(const Duration(seconds: 10), (_) => report());
  }

  /// جدول تعداد به‌روزرسانی‌ها (بیشترین بالا).
  void report() {
    if (!_dirty) return;
    _dirty = false;
    final entries = _counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final buffer = StringBuffer('--- ProviderStats ---');
    for (final entry in entries.take(25)) {
      buffer.write('\n${entry.value.toString().padLeft(5)}  ${entry.key}');
    }
    debugPrint(buffer.toString());
  }
}
