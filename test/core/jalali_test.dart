import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/core/utils/jalali.dart';

void main() {
  group('JalaliDate', () {
    test('میلادی به شمسی', () {
      final j = JalaliDate.fromDateTime(DateTime.utc(2026, 10, 10));
      expect([j.year, j.month, j.day], [1405, 7, 18]);
    });

    test('شمسی به میلادی (نوروز و اسفند کبیسه)', () {
      expect(
        const JalaliDate(1405, 1, 1).toDateTime(),
        DateTime.utc(2026, 3, 21),
      );
      expect(
        const JalaliDate(1403, 12, 30).toDateTime(),
        DateTime.utc(2025, 3, 20),
      );
    });
  });
}
