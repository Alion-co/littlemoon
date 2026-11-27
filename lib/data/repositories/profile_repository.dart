import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/local_store.dart';
import '../models/user_profile.dart';
import 'data_slice.dart';
import 'persisted_repository.dart';

class ProfileRepository extends PersistedRepository<UserProfile> {
  ProfileRepository(super.store);

  @override
  String get storageKey => 'user_profile_v1';

  @override
  String get backupKey => 'profile';

  @override
  UserProfile get emptyValue => const UserProfile();

  @override
  Map<String, dynamic> encode(UserProfile value) => value.toJson();

  @override
  UserProfile decode(Object? raw) => raw is Map
      ? UserProfile.fromJson(Map<String, dynamic>.from(raw))
      : emptyValue;
}

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepository(ref.watch(localStoreProvider)),
);

class ProfileNotifier extends StateNotifier<UserProfile> implements DataSlice {
  ProfileNotifier(this._repository) : super(_repository.load());

  final ProfileRepository _repository;

  Future<void> save(UserProfile profile) async {
    state = profile;
    await _repository.save(profile);
  }

  // ---------- DataSlice ----------

  @override
  String get backupKey => _repository.backupKey;

  @override
  bool acceptsBackup(Object? raw) => true;

  @override
  Object? exportBackup() => _repository.toBackup(state);

  /// بعد از بازیابی، کاربر نباید دوباره وارد معرفی (onboarding) بشه.
  @override
  Future<void> importBackup(Object? raw) =>
      save(_repository.fromBackup(raw).copyWith(onboardingDone: true));

  @override
  Future<void> reset() => save(const UserProfile());
}

final profileProvider = StateNotifierProvider<ProfileNotifier, UserProfile>(
  (ref) => ProfileNotifier(ref.watch(profileRepositoryProvider)),
);
