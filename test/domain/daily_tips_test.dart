import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/core/utils/day_utils.dart';
import 'package:little_moon/domain/services/daily_tips.dart';

void main() {
  final day = DateTime.utc(2026, 3, 1);

  group('parsePool', () {
    test('پیشنهادها با | جدا می‌شن', () {
      expect(DailyTips.parsePool('الف|ب|ج'), ['الف', 'ب', 'ج']);
    });

    test('فاصله‌ها و بخش‌های خالی نادیده گرفته می‌شن', () {
      expect(DailyTips.parsePool(' a | |b |'), ['a', 'b']);
      expect(DailyTips.parsePool(''), isEmpty);
    });
  });

  group('indexFor', () {
    test('همیشه داخل بازه‌ی لیست می‌مونه', () {
      for (final size in [1, 2, 3, 5, 8]) {
        for (var d = 0; d < 40; d++) {
          for (final category in TipCategory.values) {
            final index = DailyTips.indexFor(
              day: addDays(day, d),
              category: category,
              poolSize: size,
              shift: d % 4,
            );
            expect(index, inInclusiveRange(0, size - 1));
          }
        }
      }
    });

    test('در یک روز همیشه نتیجه یکسانه', () {
      final a = DailyTips.indexFor(
        day: day,
        category: TipCategory.rest,
        poolSize: 3,
      );
      final b = DailyTips.indexFor(
        day: DateTime.utc(2026, 3, 1, 18, 30),
        category: TipCategory.rest,
        poolSize: 3,
      );
      // ساعت فرقی نمی‌کنه چون روز با epochDay حساب می‌شه
      expect(a, b);
    });

    test('هر روز یکی جلوتر می‌ره', () {
      final today = DailyTips.indexFor(
        day: day,
        category: TipCategory.nutrition,
        poolSize: 3,
      );
      final tomorrow = DailyTips.indexFor(
        day: addDays(day, 1),
        category: TipCategory.nutrition,
        poolSize: 3,
      );
      expect(tomorrow, (today + 1) % 3);
    });

    test('shift (لمس کاربر) یکی دیگه نشون می‌ده', () {
      final base = DailyTips.indexFor(
        day: day,
        category: TipCategory.movement,
        poolSize: 3,
      );
      final next = DailyTips.indexFor(
        day: day,
        category: TipCategory.movement,
        poolSize: 3,
        shift: 1,
      );
      expect(next, (base + 1) % 3);
    });

    test('با ۳ پیشنهاد، سه دسته همیشه پیشنهاد متفاوتی می‌گیرن', () {
      for (var d = 0; d < 30; d++) {
        final indexes = {
          for (final category in TipCategory.values)
            DailyTips.indexFor(
              day: addDays(day, d),
              category: category,
              poolSize: 3,
            ),
        };
        expect(indexes.length, 3);
      }
    });

    test('لیست خالی → ۰', () {
      expect(
        DailyTips.indexFor(day: day, category: TipCategory.rest, poolSize: 0),
        0,
      );
    });
  });

  group('pick', () {
    test('لیست خالی → null', () {
      expect(
        DailyTips.pick(const [], day: day, category: TipCategory.rest),
        isNull,
      );
    });

    test('یکی از پیشنهادهای لیست برمی‌گرده', () {
      const pool = ['الف', 'ب', 'ج'];
      final tip = DailyTips.pick(pool, day: day, category: TipCategory.rest);
      expect(pool, contains(tip));
    });
  });
}
