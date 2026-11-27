import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/core/utils/day_utils.dart';
import 'package:little_moon/data/database/local_store.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/data/repositories/cycle_tags_repository.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/data/repositories/persisted_repository.dart';
import 'package:little_moon/data/repositories/profile_repository.dart';
import 'package:little_moon/data/repositories/settings_repository.dart';
import 'package:little_moon/domain/engine/health_summary.dart';
import 'package:little_moon/domain/engine/symptom_stats.dart';
import 'package:little_moon/domain/services/backup_service.dart';
import 'package:little_moon/domain/services/data_registry.dart';
import 'package:little_moon/domain/services/stats_providers.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _today = DateTime.utc(2026, 11, 21);

Future<ProviderContainer> _container([
  Map<String, Object> initial = const {},
]) async {
  SharedPreferences.setMockInitialValues(initial);
  final prefs = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [localStoreProvider.overrideWithValue(LocalStore(prefs))],
  );
  addTearDown(container.dispose);
  addTearDown(PersistedRepository.flushAll);
  return container;
}

void main() {
  group('SymptomStats (P3-1)', () {
    test('شمارش و ترتیب علائم و خلق‌وخو در ۹۰ روز اخیر', () {
      final logs = [
        DailyLog(
          date: addDays(_today, -1),
          symptoms: const {'cramps', 'headache'},
          mood: Mood.calm,
        ),
        DailyLog(
          date: addDays(_today, -2),
          symptoms: const {'cramps'},
          mood: Mood.calm,
        ),
        DailyLog(
          date: addDays(_today, -3),
          symptoms: const {'bloating'},
          mood: Mood.sad,
        ),
        // خارج از بازه: ۹۰ روز پیش و آینده
        DailyLog(date: addDays(_today, -90), symptoms: const {'bloating'}),
        DailyLog(date: addDays(_today, 1), symptoms: const {'bloating'}),
      ];
      final stats = SymptomStats.from(logs, _today);

      expect(stats.symptoms.first.key, 'cramps');
      expect(stats.symptoms.first.value, 2);
      expect(stats.symptoms.length, 3);
      expect(stats.symptoms.firstWhere((e) => e.key == 'bloating').value, 1);
      expect(stats.moods.first.key, Mood.calm);
      expect(stats.moods.first.value, 2);
      expect(stats.topSymptomIds(1), ['cramps']);
    });

    test('بدون ثبت: لیست خالی', () {
      final stats = SymptomStats.from(const [], _today);
      expect(stats.symptoms, isEmpty);
      expect(stats.moods, isEmpty);
      expect(stats.topSymptomIds(5), isEmpty);
    });
  });

  group('HealthSummary (P3-1)', () {
    test('آخرین وزن/دما و میانگین خواب ۷ روز', () {
      final logs = [
        DailyLog(date: addDays(_today, -5), weightKg: 60, sleepMinutes: 420),
        DailyLog(
          date: addDays(_today, -1),
          weightKg: 61,
          temperatureC: 36.5,
          sleepMinutes: 480,
        ),
        DailyLog(date: addDays(_today, -10), sleepMinutes: 60),
      ];
      final summary = HealthSummary.from(logs, _today);
      expect(summary.weightKg, 61);
      expect(summary.temperatureC, 36.5);
      expect(summary.averageSleepMinutes, 450);
    });

    test('بدون داده: همه null', () {
      final summary = HealthSummary.from(const [], _today);
      expect(summary.weightKg, isNull);
      expect(summary.temperatureC, isNull);
      expect(summary.averageSleepMinutes, isNull);
    });

    test('provider ها از ثبت‌ها محاسبه می‌شن', () async {
      final container = await _container();
      await container
          .read(logsProvider.notifier)
          .save(
            DailyLog(
              date: container.read(todayProvider),
              weightKg: 58,
              symptoms: const {'cramps'},
            ),
          );
      expect(container.read(healthSummaryProvider).weightKg, 58);
      expect(container.read(symptomStatsProvider).symptoms.first.key, 'cramps');
    });
  });

  group('ذخیره‌سازی یکپارچه (P3-2)', () {
    test('داده‌ی قدیمی بدون برچسب نسخه خونده می‌شه', () async {
      final container = await _container({
        'daily_logs_v1': '{"2026-11-20":{"flow":"medium"}}',
        'unusual_cycles_v1': '{"starts":["2026-10-01","bad"]}',
      });
      expect(container.read(logsProvider).length, 1);
      expect(container.read(unusualCyclesProvider), {'2026-10-01'});
    });

    test('بعد از ذخیره، نسخه‌ی ساختار نوشته می‌شه', () async {
      final container = await _container();
      await container.read(unusualCyclesProvider.notifier).replaceAll({
        '2026-10-01',
      });
      final store = container.read(localStoreProvider);
      expect(store.getString('unusual_cycles_v1.schema'), '1');
      expect(store.getJson('unusual_cycles_v1'), {
        'starts': ['2026-10-01'],
      });
    });

    test('داده‌ی خراب = مقدار خالی', () async {
      final container = await _container({
        'daily_logs_v1': 'not json',
        'user_profile_v1': '[]',
      });
      expect(container.read(logsProvider), isEmpty);
      expect(container.read(profileProvider).onboardingDone, isFalse);
    });

    test('هر چهار تکه توی فهرست ثبت‌نام هستن', () async {
      final container = await _container();
      final keys = [
        for (final slice in container.read(dataSlicesProvider)) slice.backupKey,
      ];
      expect(keys, ['logs', 'unusualCycles', 'settings', 'profile']);
    });

    test('پشتیبان‌گیری و بازیابی رفت‌وبرگشتی', () async {
      final source = await _container();
      await source
          .read(logsProvider.notifier)
          .save(
            DailyLog(
              date: DateTime.utc(2026, 11, 1),
              flow: FlowLevel.medium,
              symptoms: const {'cramps'},
            ),
          );
      await source
          .read(unusualCyclesProvider.notifier)
          .setUnusual(DateTime.utc(2026, 11, 1), true);
      await source
          .read(profileProvider.notifier)
          .save(
            source
                .read(profileProvider)
                .copyWith(name: 'Sara', cycleLength: 30),
          );
      final json = BackupService.encode(source.read(dataSlicesProvider));

      final target = await _container();
      final slices = target.read(dataSlicesProvider);
      final sections = BackupService.decode(json, slices);
      expect(sections, isNotNull);
      await BackupService.restore(slices, sections!);

      expect(target.read(logsProvider).length, 1);
      expect(target.read(unusualCyclesProvider), {'2026-11-01'});
      expect(target.read(profileProvider).name, 'Sara');
      expect(target.read(profileProvider).cycleLength, 30);
      // بعد از بازیابی دوباره وارد معرفی نمی‌شه
      expect(target.read(profileProvider).onboardingDone, isTrue);
    });

    test('پشتیبان قدیمی بدون unusualCycles معتبره', () async {
      final container = await _container();
      final slices = container.read(dataSlicesProvider);
      final sections = BackupService.decode(
        '{"app":"little_moon","version":1,"logs":{}}',
        slices,
      );
      expect(sections, isNotNull);
      await BackupService.restore(slices, sections!);
      expect(container.read(unusualCyclesProvider), isEmpty);
      expect(container.read(profileProvider).onboardingDone, isTrue);
    });

    test('پشتیبان نامعتبر رد می‌شه', () async {
      final container = await _container();
      final slices = container.read(dataSlicesProvider);
      expect(BackupService.decode('nope', slices), isNull);
      expect(BackupService.decode('{"app":"other","logs":{}}', slices), isNull);
      // بدون کلید logs
      expect(
        BackupService.decode('{"app":"little_moon","version":1}', slices),
        isNull,
      );
    });

    test('ریست همه‌ی تکه‌ها رو خالی می‌کنه', () async {
      final container = await _container();
      await container
          .read(logsProvider.notifier)
          .save(
            DailyLog(date: DateTime.utc(2026, 11, 1), flow: FlowLevel.heavy),
          );
      await container
          .read(settingsProvider.notifier)
          .save(container.read(settingsProvider));
      for (final slice in container.read(dataSlicesProvider)) {
        await slice.reset();
      }
      expect(container.read(logsProvider), isEmpty);
      expect(container.read(unusualCyclesProvider), isEmpty);
      expect(container.read(profileProvider).onboardingDone, isFalse);
    });
  });
}
