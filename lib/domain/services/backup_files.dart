import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

enum BackupFileResult { saved, cancelled, failed }

/// ذخیره و باز کردن فایل پشتیبان با پنجره‌ی فایل خود گوشی.
///
/// هیچ مجوز دسترسی به حافظه لازم نیست: کاربر خودش محل ذخیره یا فایل
/// رو انتخاب می‌کنه و برنامه فقط همون یک فایل رو می‌بینه.
abstract final class BackupFiles {
  /// فایل‌های پشتیبان معمولاً چند صد کیلوبایت هستن؛ بیشتر از این یعنی
  /// احتمالاً فایل اشتباهی انتخاب شده.
  static const maxBytes = 20 * 1024 * 1024;

  static Future<BackupFileResult> save(
    String json, {
    required String fileName,
    required String dialogTitle,
  }) async {
    try {
      final bytes = Uint8List.fromList(utf8.encode(json));
      final saved = await FilePicker.saveFile(
        dialogTitle: dialogTitle,
        fileName: fileName,
        bytes: bytes,
        mimeType: 'application/json',
      );
      // روی وب فایل مستقیم دانلود می‌شه و ممکنه آدرسی برنگرده
      if (saved == null && !kIsWeb) return BackupFileResult.cancelled;
      return BackupFileResult.saved;
    } catch (error) {
      debugPrint('Saving backup file failed: $error');
      return BackupFileResult.failed;
    }
  }

  /// متن فایل انتخاب‌شده، یا `null` اگه کاربر منصرف شد یا فایل خونده نشد.
  static Future<String?> pick() async {
    try {
      final file = await FilePicker.pickFile(type: FileType.any);
      if (file == null) return null;
      final size = file.lengthSync() ?? await file.length();
      if (size != null && size > maxBytes) return null;
      final bytes = await file.readAsBytes();
      return utf8.decode(bytes, allowMalformed: true);
    } catch (error) {
      debugPrint('Opening backup file failed: $error');
      return null;
    }
  }
}
