import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_lock.dart';
import 'data_registry.dart';

/// همه‌ی داده‌های برنامه رو پاک می‌کنه: هر چی توی `dataSlicesProvider` ثبت
/// شده (ثبت‌ها، پروفایل، تنظیمات، ...) و قفل.
///
/// هم از «حذف همه‌ی داده‌ها» در تنظیمات و هم از «رمز رو فراموش کردم»
/// روی صفحه‌ی قفل صدا زده می‌شه.
Future<void> resetAllAppData(WidgetRef ref) async {
  for (final slice in ref.read(dataSlicesProvider)) {
    await slice.reset();
  }
  await ref.read(appLockProvider.notifier).disable();
}
