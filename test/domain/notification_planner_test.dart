import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/data/models/app_settings.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/domain/services/notification_planner.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';

import '../helpers/cycle_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('نوتیفیکیشن‌ها', () {
    final fa = lookupAppLocalizations(const Locale('fa'));
    final now = DateTime(2026, 9, 5, 12);

    test('حالت مخفی هیچ اشاره‌ای به چرخه نداره', () {
      final plan = NotificationPlanner.build(
        cycle: sampleCycle(),
        settings: const AppSettings(discreetNotifications: true),
        l10n: fa,
        loggedToday: false,
        now: now,
      );
      expect(plan, isNotEmpty);
      for (final item in plan) {
        expect(item.discreet, isTrue);
        expect(item.title, fa.discreetTitle);
        expect(item.body, isNot(contains('عادت')));
        expect(item.body, isNot(contains('باروری')));
        expect(item.body, isNot(contains('تخمک')));
      }
    });

    test('یادآور قرص هر روز در ساعت انتخابی', () {
      final plan = NotificationPlanner.build(
        cycle: CycleSnapshot.empty(today: DateTime.utc(2026, 9, 5)),
        settings: const AppSettings(
          dailyLogReminder: false,
          pillReminder: true,
          pillHour: 21,
          pillMinute: 15,
        ),
        l10n: fa,
        loggedToday: false,
        now: now,
      );
      expect(plan.length, NotificationPlanner.pillDays);
      expect(plan.first.when, DateTime(2026, 9, 5, 21, 15));
      expect(plan.first.body, fa.reminderPill);
      expect(plan.map((p) => p.id).toSet().length, plan.length);
    });
  });

  group('یادآور تأخیر', () {
    final fa = lookupAppLocalizations(const Locale('fa'));

    test('۳ و ۷ روز بعد از تاریخ پیش‌بینی', () {
      final sample = samplePatternData();
      final expected = sample.cycle.nextPeriodStart!;
      final plan = NotificationPlanner.build(
        cycle: sample.cycle,
        settings: const AppSettings(dailyLogReminder: false),
        l10n: fa,
        loggedToday: true,
        now: DateTime(2026, 8, 10, 12),
      );
      final late = plan.where((p) => p.body.contains('عقب افتاده')).toList();
      expect(late.length, 2);
      expect(late.map((p) => DateTime(p.when.year, p.when.month, p.when.day)), [
        DateTime(expected.year, expected.month, expected.day + 3),
        DateTime(expected.year, expected.month, expected.day + 7),
      ]);
    });

    test('خاموش کردنش', () {
      final plan = NotificationPlanner.build(
        cycle: samplePatternData().cycle,
        settings: const AppSettings(lateReminder: false),
        l10n: fa,
        loggedToday: true,
        now: DateTime(2026, 8, 10, 12),
      );
      expect(plan.where((p) => p.body.contains('عقب افتاده')), isEmpty);
    });
  });
}
