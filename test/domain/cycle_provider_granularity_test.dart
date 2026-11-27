import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/data/database/local_store.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/data/repositories/persisted_repository.dart';
import 'package:little_moon/data/repositories/profile_repository.dart';
import 'package:little_moon/domain/engine/cycle_inputs.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> _container() async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [localStoreProvider.overrideWithValue(LocalStore(prefs))],
  );
  addTearDown(container.dispose);
  addTearDown(PersistedRepository.flushAll);
  return container;
}

/// بازمحاسبه‌ی providerها و خبر دادن به listenerها یک نوبت از event loop
/// بعد از تغییر انجام می‌شه؛ قبل از شمردن باید صبر کرد.
Future<void> _settle() => Future<void>.delayed(Duration.zero);

void main() {
  group('CycleInputs / PatternInputs', () {
    test('فقط روز پریود و دما برداشته می‌شه', () {
      final logs = {
        '2026-11-01': DailyLog(
          date: DateTime.utc(2026, 11, 1),
          flow: FlowLevel.medium,
        ),
        '2026-11-02': DailyLog(
          date: DateTime.utc(2026, 11, 2),
          waterGlasses: 5,
        ),
        '2026-11-03': DailyLog(
          date: DateTime.utc(2026, 11, 3),
          temperatureC: 36.4,
        ),
      };
      final inputs = CycleInputs.from(logs);
      expect(inputs.periodDays, [DateTime.utc(2026, 11, 1)]);
      expect(inputs.temperatures.single.value, 36.4);
    });

    test('تغییر آب/وزن/یادداشت ورودی چرخه رو عوض نمی‌کنه', () {
      final base = DailyLog(
        date: DateTime.utc(2026, 11, 1),
        flow: FlowLevel.medium,
      );
      final before = CycleInputs.from({'2026-11-01': base});
      final after = CycleInputs.from({
        '2026-11-01': base.withWater(6).withWeight(60),
      });
      expect(after, equals(before));
      expect(after.hashCode, before.hashCode);
    });

    test('تغییر پریود یا دما ورودی رو عوض می‌کنه', () {
      final a = CycleInputs.from({
        '2026-11-01': DailyLog(
          date: DateTime.utc(2026, 11, 1),
          flow: FlowLevel.medium,
        ),
      });
      final b = CycleInputs.from({
        '2026-11-01': DailyLog(
          date: DateTime.utc(2026, 11, 1),
          flow: FlowLevel.heavy,
        ),
        '2026-11-02': DailyLog(
          date: DateTime.utc(2026, 11, 2),
          flow: FlowLevel.light,
        ),
      });
      final c = CycleInputs.from({
        '2026-11-01': DailyLog(
          date: DateTime.utc(2026, 11, 1),
          temperatureC: 36.5,
        ),
      });
      final d = CycleInputs.from({
        '2026-11-01': DailyLog(
          date: DateTime.utc(2026, 11, 1),
          temperatureC: 36.6,
        ),
      });
      expect(a == b, isFalse);
      expect(c == d, isFalse);
    });

    test('PatternInputs آب و وزن رو نادیده می‌گیره', () {
      final base = DailyLog(
        date: DateTime.utc(2026, 11, 1),
        symptoms: const {'cramps'},
      );
      final before = PatternInputs.from({'2026-11-01': base});
      final after = PatternInputs.from({
        '2026-11-01': base.withWater(3),
        '2026-11-02': DailyLog(
          date: DateTime.utc(2026, 11, 2),
          waterGlasses: 4,
        ),
      });
      expect(after, equals(before));
      final changed = PatternInputs.from({
        '2026-11-01': base.withSymptoms(const {'headache'}),
      });
      expect(changed == before, isFalse);
    });
  });

  group('cycleProvider (P4-1)', () {
    test('آب/وزن/علائم موتور چرخه رو دوباره اجرا نمی‌کنه', () async {
      final container = await _container();
      final today = container.read(todayProvider);
      final notifier = container.read(logsProvider.notifier);

      var cycleRuns = 0;
      container.read(cycleProvider);
      container.listen(cycleProvider, (_, __) => cycleRuns++);

      await notifier.save(DailyLog(date: today).withWater(4));
      await notifier.save(DailyLog(date: today).withWater(5).withWeight(60));
      await notifier.save(
        DailyLog(date: today).withWeight(60).withSymptoms(const {'cramps'}),
      );
      await _settle();
      expect(cycleRuns, 0);

      // ولی روز پریود یا دما چرخه رو عوض می‌کنه
      await notifier.save(DailyLog(date: today).withFlow(FlowLevel.medium));
      await _settle();
      expect(cycleRuns, 1);
      await notifier.save(
        DailyLog(date: today).withFlow(FlowLevel.medium).withTemperature(36.5),
      );
      await _settle();
      expect(cycleRuns, 2);
    });

    test('تغییر نام پروفایل بی‌اثره، تغییر طول چرخه نه', () async {
      final container = await _container();
      var cycleRuns = 0;
      container.read(cycleProvider);
      container.listen(cycleProvider, (_, __) => cycleRuns++);

      final profile = container.read(profileProvider);
      final notifier = container.read(profileProvider.notifier);
      await notifier.save(profile.copyWith(name: 'Sara', avatar: 2));
      await _settle();
      expect(cycleRuns, 0);

      await notifier.save(profile.copyWith(cycleLength: 31));
      await _settle();
      expect(cycleRuns, 1);
    });

    test('patternsProvider با ثبت آب دوباره محاسبه نمی‌شه', () async {
      final container = await _container();
      final today = container.read(todayProvider);
      final notifier = container.read(logsProvider.notifier);

      var runs = 0;
      container.read(patternsProvider);
      container.listen(patternInputsProvider, (_, __) => runs++);

      await notifier.save(DailyLog(date: today).withWater(3));
      await _settle();
      expect(runs, 0);
      await notifier.save(
        DailyLog(date: today).withSymptoms(const {'headache'}),
      );
      await _settle();
      expect(runs, 1);
    });
  });
}
