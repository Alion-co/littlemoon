import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/day_utils.dart';
import '../database/local_store.dart';
import '../models/daily_log.dart';
import 'data_slice.dart';
import 'persisted_repository.dart';

/// خواندن/نوشتن ثبت‌های روزانه روی حافظه‌ی دستگاه.
class LogRepository extends PersistedRepository<Map<String, DailyLog>> {
  LogRepository(super.store);

  @override
  String get storageKey => 'daily_logs_v1';

  @override
  String get backupKey => 'logs';

  @override
  Map<String, DailyLog> get emptyValue => const {};

  // ثبت آب/خلق‌وخو/... پشت‌سرهم زیاد پیش می‌آد؛ چند تغییر یک‌بار نوشته می‌شه
  @override
  Duration get saveDelay => const Duration(milliseconds: 600);

  @override
  Map<String, dynamic> encode(Map<String, DailyLog> value) => {
    for (final entry in value.entries) entry.key: entry.value.toJson(),
  };

  @override
  Map<String, DailyLog> decode(Object? raw) {
    if (raw is! Map) return const {};
    final result = <String, DailyLog>{};
    for (final entry in raw.entries) {
      final key = entry.key;
      final value = entry.value;
      final date = key is String ? parseDayKey(key) : null;
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
class LogsNotifier extends StateNotifier<Map<String, DailyLog>>
    implements DataSlice {
  LogsNotifier(this._repository) : super(_repository.load());

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
    await _repository.save(next);
  }

  Future<void> delete(DateTime date) async {
    final next = Map<String, DailyLog>.of(state)..remove(dayKey(date));
    state = next;
    await _repository.save(next);
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
    await _repository.save(next);
  }

  Future<void> replaceAll(Map<String, DailyLog> logs) async {
    state = Map<String, DailyLog>.of(logs);
    await _repository.save(state);
    // جایگزینی کامل (بازیابی/ریست) نباید عقب بیفته
    await _repository.flush();
  }

  Future<void> clear() => replaceAll(const {});

  // ---------- DataSlice ----------

  @override
  String get backupKey => _repository.backupKey;

  /// بدون کلید `logs` پشتیبان معتبر نیست.
  @override
  bool acceptsBackup(Object? raw) => raw is Map;

  @override
  Object? exportBackup() => _repository.toBackup(state);

  @override
  Future<void> importBackup(Object? raw) =>
      replaceAll(_repository.fromBackup(raw));

  @override
  Future<void> reset() => clear();
}

final logsProvider = StateNotifierProvider<LogsNotifier, Map<String, DailyLog>>(
  (ref) => LogsNotifier(ref.watch(logRepositoryProvider)),
);
