import 'dart:convert';

import '../../data/repositories/data_slice.dart';

/// پشتیبان‌گیری آفلاین: کل داده‌ها به یک متن JSON تبدیل می‌شه که کاربر
/// می‌تونه خودش هر جا خواست نگه داره و بعداً برگردونه.
///
/// اینجا هیچ داده‌ی خاصی شناخته نمی‌شه؛ هر تکه از طریق [DataSlice] می‌آد
/// (فهرستش توی `dataSlicesProvider` ثبت شده).
abstract final class BackupService {
  static const _app = 'little_moon';
  static const _version = 1;

  /// اسم پیشنهادی فایل پشتیبان، مثل `little-moon-backup-2026-10-27.json`.
  static String fileName(DateTime now) {
    String two(int v) => v < 10 ? '0$v' : '$v';
    return 'little-moon-backup-${now.year}-${two(now.month)}-${two(now.day)}.json';
  }

  static String encode(Iterable<DataSlice> slices) {
    return const JsonEncoder.withIndent(' ').convert({
      'app': _app,
      'version': _version,
      for (final slice in slices) slice.backupKey: slice.exportBackup(),
    });
  }

  /// بخش‌های پشتیبان (کلید ← مقدار خام)، یا `null` اگه متن معتبر نباشه.
  static Map<String, Object?>? decode(String raw, Iterable<DataSlice> slices) {
    try {
      final decoded = jsonDecode(raw.trim());
      if (decoded is! Map) return null;
      if (decoded['app'] != _app) return null;

      final sections = <String, Object?>{};
      for (final slice in slices) {
        final value = decoded[slice.backupKey];
        if (!slice.acceptsBackup(value)) return null;
        sections[slice.backupKey] = value;
      }
      return sections;
    } catch (_) {
      return null;
    }
  }

  /// داده‌های فعلی رو با بخش‌های [sections] جایگزین می‌کنه.
  static Future<void> restore(
    Iterable<DataSlice> slices,
    Map<String, Object?> sections,
  ) async {
    for (final slice in slices) {
      await slice.importBackup(sections[slice.backupKey]);
    }
  }
}
