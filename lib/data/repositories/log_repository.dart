import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/day_utils.dart';
import '../database/local_store.dart';
import '../models/daily_log.dart';

/// خواندن/نوشتن ثبت‌های روزانه روی حافظه‌ی دستگاه.
class LogRepository {
  LogRepository(this._store);

  static const storageKey = 'daily_logs_v1';

  final LocalStore _store;

  Map<String, DailyLog> loadAll() {
    final json = _store.getJson(storageKey);
    if (json == null) return {};
    return decode(json);
  }

  Future<void> saveAll(Map<String, DailyLog> logs) =>
      _store.setJson(storageKey, encode(logs));

  static Map<String, dynamic> encode(Map<String, DailyLog> logs) => {
        for (final entry in logs.entries) entry.key: entry.value.toJson(),
      };

  static Map<String, DailyLog> decode(Map<String, dynamic> json) {
    final result = <String, DailyLog>{};
    for (final entry in json.entries) {
      final date = parseDayKey(entry.key);
      final value = entry.value;
      if (date == null || value is! Map) continue;
      final log = DailyLog.fromJson(date, Map<String, dynamic>.from(value));
      if (!log.isEmpty) result[dayKey(date)] = log;
    }
    return result;
  }
}

final logRepositoryProvider = Provider<LogRepository>(
  (ref) => LogRepository(ref.watch(localStoreProvider)),
);

/// همه‌ی ثبت‌های روزانه؛ کلید = `yyyy-MM-dd`.
class LogsNotifier extends StateNotifier<Map<String, DailyLog>> {
  LogsNotifier(this._repository) : super(_repository.loadAll());

  final LogRepository _repository;

  DailyLog? logFor(DateTime date) => state[dayKey(date)];

  /// ثبت یک روز رو ذخیره می‌کنه؛ اگه خالی باشه حذفش می‌کنه.
  Future<void> save(DailyLog log) async {
    final next = Map<String, DailyLog>.of(state);
    if (log.isEmpty) {
      next.remove(dayKey(log.date));
    } else {
      next[dayKey(log.date)] = log;
    }
    state = next;
    await _repository.saveAll(next);
  }

  Future<void> delete(DateTime date) async {
    final next = Map<String, DailyLog>.of(state)..remove(dayKey(date));
    state = next;
    await _repository.saveAll(next);
  }

  /// یک بازه رو به‌عنوان روزهای پریود علامت می‌زنه (برای شروع کار با برنامه).
  ///
  /// روزهای بعد از [notAfter] (معمولاً امروز) علامت نمی‌خورن.
  Future<void> markPeriod(
    DateTime start,
    int length, {
    DateTime? notAfter,
  }) async {
    final next = Map<String, DailyLog>.of(state);
    for (var i = 0; i < length; i++) {
      final date = addDays(start, i);
      if (notAfter != null && date.isAfter(notAfter)) break;
      final existing = next[dayKey(date)] ?? DailyLog(date: date);
      if (existing.isPeriodDay) continue;
      next[dayKey(date)] = existing.withFlow(FlowLevel.medium);
    }
    state = next;
    await _repository.saveAll(next);
  }

  Future<void> replaceAll(Map<String, DailyLog> logs) async {
    state = Map<String, DailyLog>.of(logs);
    await _repository.saveAll(state);
  }

  Future<void> clear() => replaceAll(const {});
}

final logsProvider =
    StateNotifierProvider<LogsNotifier, Map<String, DailyLog>>(
  (ref) => LogsNotifier(ref.watch(logRepositoryProvider)),
);
