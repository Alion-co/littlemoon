import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:little_moon/data/database/local_store.dart';
import 'package:little_moon/domain/services/app_lock.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('قفل برنامه', () {
    Future<AppLockNotifier> freshLock() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      return AppLockNotifier(LocalStore(prefs));
    }

    test('رمز درست و اشتباه', () async {
      final lock = await freshLock();
      expect(lock.state.enabled, isFalse);

      await lock.setPin('1234');
      expect(lock.state.enabled, isTrue);
      expect(lock.verify('1234'), isTrue);
      expect(lock.verify('4321'), isFalse);
      // خود رمز ذخیره نمی‌شه
      expect(lock.state.config.hash, isNot(contains('1234')));
    });

    test('بعد از ۵ تلاش اشتباه موقتاً مسدود می‌شه', () async {
      final lock = await freshLock();
      await lock.setPin('1234');
      for (var i = 0; i < 5; i++) {
        expect(lock.unlockWithPin('0000'), isFalse);
      }
      expect(lock.state.blockedUntil, isNotNull);
      // حتی رمز درست هم تا پایان مسدودی پذیرفته نمی‌شه
      expect(lock.unlockWithPin('1234'), isFalse);
    });

    test('برگشت از پس‌زمینه قفل می‌کنه، جابه‌جایی کوتاه نه', () async {
      final lock = await freshLock();
      await lock.setPin('1234');
      expect(lock.unlockWithPin('1234'), isTrue);

      lock
        ..onLifecycleChanged(AppLifecycleState.paused)
        ..onLifecycleChanged(AppLifecycleState.resumed);
      expect(lock.state.locked, isFalse);
    });

    test('خاموش کردن قفل همه‌چیز رو پاک می‌کنه', () async {
      final lock = await freshLock();
      await lock.setPin('1234');
      await lock.disable();
      expect(lock.state.enabled, isFalse);
      expect(lock.verify('1234'), isFalse);
    });
  });
}
