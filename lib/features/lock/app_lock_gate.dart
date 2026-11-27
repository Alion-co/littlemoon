import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/domain/services/app_lock.dart';

import 'lock_screen.dart';

/// اگه قفل فعال و برنامه قفل باشه، صفحه‌ی قفل رو روی کل برنامه می‌کشه.
///
/// بالای Navigator قرار می‌گیره، پس دیالوگ‌ها و برگه‌های باز هم زیرش
/// پنهان می‌مونن.
class AppLockGate extends ConsumerWidget {
  final Widget child;

  /// وقتی کاربر رمز رو فراموش کرده و می‌خواد همه‌چیز پاک بشه.
  final Future<void> Function() onResetApp;

  const AppLockGate({super.key, required this.child, required this.onResetApp});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locked = ref.watch(appLockProvider.select((s) => s.locked));

    return Stack(
      fit: StackFit.expand,
      children: [
        // محتوای برنامه زیر قفل نه دیده می‌شه، نه لمس می‌شه
        ExcludeSemantics(
          excluding: locked,
          child: IgnorePointer(ignoring: locked, child: child),
        ),
        if (locked) LockScreen(onResetApp: onResetApp),
      ],
    );
  }
}
