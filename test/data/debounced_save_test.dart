import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/data/database/local_store.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/data/repositories/cycle_tags_repository.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/data/repositories/persisted_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<LocalStore> _store() async {
  SharedPreferences.setMockInitialValues({});
  return LocalStore(await SharedPreferences.getInstance());
}

DailyLog _log(int water) =>
    DailyLog(date: DateTime.utc(2026, 11, 1), waterGlasses: water);

void main() {
  group('ذخیره‌ی با debounce (P4-2)', () {
    test(
      'چند save پشت‌هم تا flush روی دیسک نمی‌ره، بعدش آخرین مقدار',
      () async {
        final store = await _store();
        final repository = LogRepository(store);

        await repository.save({'2026-11-01': _log(1)});
        await repository.save({'2026-11-01': _log(2)});
        await repository.save({'2026-11-01': _log(3)});
        expect(store.getJson(repository.storageKey), isNull);

        await repository.flush();
        final saved = repository.load();
        expect(saved['2026-11-01']?.waterGlasses, 3);
        expect(store.getString('${repository.storageKey}.schema'), '1');
      },
    );

    test('بعد از فاصله‌ی تأخیر خودش نوشته می‌شه', () async {
      final store = await _store();
      final repository = LogRepository(store);

      await repository.save({'2026-11-01': _log(2)});
      await Future<void>.delayed(
        repository.saveDelay + const Duration(milliseconds: 100),
      );
      expect(repository.load()['2026-11-01']?.waterGlasses, 2);
    });

    test('flushAll همه‌ی repositoryهای منتظر رو می‌نویسه', () async {
      final store = await _store();
      final repository = LogRepository(store);
      await repository.save({'2026-11-01': _log(4)});
      expect(store.getJson(repository.storageKey), isNull);

      await PersistedRepository.flushAll();
      expect(repository.load()['2026-11-01']?.waterGlasses, 4);
    });

    test('flush بدون چیزی منتظر، بی‌اثره', () async {
      final store = await _store();
      final repository = LogRepository(store);
      await repository.flush();
      expect(store.getJson(repository.storageKey), isNull);
    });

    test('repositoryهای بدون تأخیر همون لحظه می‌نویسن', () async {
      final store = await _store();
      final repository = CycleTagsRepository(store);
      await repository.save({'2026-10-01'});
      expect(store.getJson(repository.storageKey), {
        'starts': ['2026-10-01'],
      });
    });
  });
}
