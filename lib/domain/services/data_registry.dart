import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/data/repositories/cycle_tags_repository.dart';
import 'package:little_moon/data/repositories/data_slice.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/data/repositories/profile_repository.dart';
import 'package:little_moon/data/repositories/settings_repository.dart';

/// فهرست همه‌ی داده‌های کاربر؛ پشتیبان‌گیری، بازیابی و حذف همه‌ی داده‌ها
/// فقط از همین فهرست می‌خونن.
///
/// برای داده‌ی جدید: notifier رو `implements DataSlice` کن و اینجا اضافه‌اش
/// کن. هیچ جای دیگه‌ای لازم نیست عوض بشه. (قفل برنامه عمداً بیرونه: توی
/// پشتیبان نمی‌ره و جدا غیرفعال می‌شه.)
final dataSlicesProvider = Provider<List<DataSlice>>((ref) {
  return [
    ref.read(logsProvider.notifier),
    ref.read(unusualCyclesProvider.notifier),
    ref.read(settingsProvider.notifier),
    ref.read(profileProvider.notifier),
  ];
});
