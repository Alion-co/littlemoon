import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/data/models/app_settings.dart';

void main() {
  group('تنظیمات', () {
    test('پشتیبان قدیمی بدون کلیدهای تازه', () {
      final settings = AppSettings.fromJson(const {'periodReminder': true});
      expect(settings.discreetNotifications, isFalse);
      expect(settings.pillReminder, isFalse);
      expect(settings.pillHour, 22);
    });

    test('رفت‌وبرگشت JSON', () {
      const original = AppSettings(
        discreetNotifications: true,
        pillReminder: true,
        pillHour: 8,
        pillMinute: 30,
      );
      final copy = AppSettings.fromJson(original.toJson());
      expect(copy.discreetNotifications, isTrue);
      expect(copy.pillReminder, isTrue);
      expect([copy.pillHour, copy.pillMinute], [8, 30]);
    });
  });
}
