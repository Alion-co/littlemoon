import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/local_store.dart';
import '../models/user_profile.dart';

class ProfileRepository {
  ProfileRepository(this._store);

  static const storageKey = 'user_profile_v1';

  final LocalStore _store;

  UserProfile load() {
    final json = _store.getJson(storageKey);
    return json == null ? const UserProfile() : UserProfile.fromJson(json);
  }

  Future<void> save(UserProfile profile) =>
      _store.setJson(storageKey, profile.toJson());
}

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepository(ref.watch(localStoreProvider)),
);

class ProfileNotifier extends StateNotifier<UserProfile> {
  ProfileNotifier(this._repository) : super(_repository.load());

  final ProfileRepository _repository;

  Future<void> save(UserProfile profile) async {
    state = profile;
    await _repository.save(profile);
  }

  Future<void> reset() => save(const UserProfile());
}

final profileProvider = StateNotifierProvider<ProfileNotifier, UserProfile>(
  (ref) => ProfileNotifier(ref.watch(profileRepositoryProvider)),
);
