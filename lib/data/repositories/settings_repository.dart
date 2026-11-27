import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/local_store.dart';
import '../models/app_settings.dart';
import 'data_slice.dart';
import 'persisted_repository.dart';

class SettingsRepository extends PersistedRepository<AppSettings> {
  SettingsRepository(super.store);

  @override
  String get storageKey => 'app_settings_v1';

  @override
  String get backupKey => 'settings';

  @override
  AppSettings get emptyValue => const AppSettings();

  @override
  Map<String, dynamic> encode(AppSettings value) => value.toJson();

  @override
  AppSettings decode(Object? raw) => raw is Map
      ? AppSettings.fromJson(Map<String, dynamic>.from(raw))
      : emptyValue;
}

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(localStoreProvider)),
);

class SettingsNotifier extends StateNotifier<AppSettings> implements DataSlice {
  SettingsNotifier(this._repository) : super(_repository.load());

  final SettingsRepository _repository;

  Future<void> save(AppSettings settings) async {
    state = settings;
    await _repository.save(settings);
  }

  // ---------- DataSlice ----------

  @override
  String get backupKey => _repository.backupKey;

  @override
  bool acceptsBackup(Object? raw) => true;

  @override
  Object? exportBackup() => _repository.toBackup(state);

  @override
  Future<void> importBackup(Object? raw) => save(_repository.fromBackup(raw));

  @override
  Future<void> reset() => save(const AppSettings());
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>(
  (ref) => SettingsNotifier(ref.watch(settingsRepositoryProvider)),
);
