import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/local_store.dart';
import '../models/app_settings.dart';

class SettingsRepository {
  SettingsRepository(this._store);

  static const storageKey = 'app_settings_v1';

  final LocalStore _store;

  AppSettings load() {
    final json = _store.getJson(storageKey);
    return json == null ? const AppSettings() : AppSettings.fromJson(json);
  }

  Future<void> save(AppSettings settings) =>
      _store.setJson(storageKey, settings.toJson());
}

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(localStoreProvider)),
);

class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier(this._repository) : super(_repository.load());

  final SettingsRepository _repository;

  Future<void> save(AppSettings settings) async {
    state = settings;
    await _repository.save(settings);
  }

  Future<void> reset() => save(const AppSettings());
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>(
  (ref) => SettingsNotifier(ref.watch(settingsRepositoryProvider)),
);
