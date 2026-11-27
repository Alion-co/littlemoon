import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/day_utils.dart';
import '../database/local_store.dart';
import 'data_slice.dart';
import 'persisted_repository.dart';

/// چرخه‌هایی که کاربر «غیرعادی» علامت زده (بیماری، سفر، استرس، ...).
///
/// هر چرخه با تاریخ شروعش (`yyyy-MM-dd`) شناخته می‌شه. این چرخه‌ها توی
/// میانگین، پراکندگی و یادگیری فاز لوتئال حساب نمی‌شن.
class CycleTagsRepository extends PersistedRepository<Set<String>> {
  CycleTagsRepository(super.store);

  @override
  String get storageKey => 'unusual_cycles_v1';

  @override
  String get backupKey => 'unusualCycles';

  @override
  Set<String> get emptyValue => const <String>{};

  @override
  Map<String, dynamic> encode(Set<String> value) => {
    'starts': _sortedList(value),
  };

  @override
  Set<String> decode(Object? raw) =>
      _validKeys(raw is Map ? raw['starts'] : null);

  // در پشتیبان خودِ لیست نوشته می‌شه، نه {'starts': [...]}
  @override
  Object? toBackup(Set<String> value) => _sortedList(value);

  @override
  Set<String> fromBackup(Object? raw) => _validKeys(raw);

  static List<String> _sortedList(Set<String> starts) =>
      starts.toList()..sort();

  /// فقط کلیدهای تاریخِ معتبر نگه داشته می‌شن (برای پشتیبان‌های قدیمی
  /// یا خراب، مجموعه‌ی خالی برمی‌گرده).
  static Set<String> _validKeys(Object? raw) {
    if (raw is! List) return <String>{};
    final result = <String>{};
    for (final item in raw) {
      if (item is String && parseDayKey(item) != null) result.add(item);
    }
    return result;
  }
}

final cycleTagsRepositoryProvider = Provider<CycleTagsRepository>(
  (ref) => CycleTagsRepository(ref.watch(localStoreProvider)),
);

/// مجموعه‌ی تاریخ شروع چرخه‌های غیرعادی (کلید `yyyy-MM-dd`).
class UnusualCyclesNotifier extends StateNotifier<Set<String>>
    implements DataSlice {
  UnusualCyclesNotifier(this._repository) : super(_repository.load());

  final CycleTagsRepository _repository;

  bool isUnusual(DateTime cycleStart) => state.contains(dayKey(cycleStart));

  /// برچسب «غیرعادی» رو روشن یا خاموش می‌کنه.
  Future<void> setUnusual(DateTime cycleStart, bool value) async {
    final next = Set<String>.of(state);
    if (value) {
      next.add(dayKey(cycleStart));
    } else {
      next.remove(dayKey(cycleStart));
    }
    state = next;
    await _repository.save(next);
  }

  Future<void> replaceAll(Set<String> starts) async {
    state = Set<String>.of(starts);
    await _repository.save(state);
  }

  Future<void> clear() => replaceAll(const <String>{});

  // ---------- DataSlice ----------

  @override
  String get backupKey => _repository.backupKey;

  // پشتیبان‌های قدیمی این کلید رو ندارن
  @override
  bool acceptsBackup(Object? raw) => true;

  @override
  Object? exportBackup() => _repository.toBackup(state);

  @override
  Future<void> importBackup(Object? raw) =>
      replaceAll(_repository.fromBackup(raw));

  @override
  Future<void> reset() => clear();
}

final unusualCyclesProvider =
    StateNotifierProvider<UnusualCyclesNotifier, Set<String>>(
      (ref) => UnusualCyclesNotifier(ref.watch(cycleTagsRepositoryProvider)),
    );
