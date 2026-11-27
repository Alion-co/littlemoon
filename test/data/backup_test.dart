import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/data/models/app_settings.dart';
import 'package:little_moon/domain/services/backup_service.dart';

void main() {
  group('پشتیبان', () {
    test('اسم فایل', () {
      expect(
        BackupService.fileName(DateTime(2026, 3, 5)),
        'little-moon-backup-2026-03-05.json',
      );
    });

    test('پشتیبان قدیمی بدون تنظیم تأخیر', () {
      expect(AppSettings.fromJson(const {}).lateReminder, isTrue);
    });
  });
}
