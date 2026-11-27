import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/data/models/daily_log.dart';

void main() {
  group('ثبت سریع', () {
    test('حال و علائم بدون پاک شدن بقیه‌ی ثبت', () {
      final log = DailyLog(
        date: DateTime.utc(2026, 8, 10),
        flow: FlowLevel.light,
        pain: 2,
        weightKg: 58,
      );
      final next = log.withMood(Mood.calm).withSymptoms({'bloating'});
      expect(next.mood, Mood.calm);
      expect(next.symptoms, {'bloating'});
      expect(next.flow, FlowLevel.light);
      expect(next.pain, 2);
      expect(next.weightKg, 58);
      expect(next.withMood(null).mood, isNull);
    });
  });
}
