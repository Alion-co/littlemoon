import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/localization/locale_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'core/debug/provider_stats.dart';
import 'core/utils/haptics.dart';
import 'data/database/local_store.dart';
import 'data/repositories/persisted_repository.dart';
import 'domain/services/app_lock.dart';
import 'domain/services/cycle_providers.dart';
import 'domain/services/data_reset.dart';
import 'domain/services/home_widget_sync.dart';
import 'domain/services/notification_planner.dart';
import 'domain/services/notification_service.dart';
import 'features/lock/lock_screen.dart';
import 'l10n/generated/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // حافظه‌ی محلی (کاملاً آفلاین) قبل از بالا اومدن برنامه آماده می‌شه
  final prefs = await SharedPreferences.getInstance();
  Haptics.enabled = prefs.getString(HapticsNotifier.storageKey) != 'off';

  // برنامه تا زیر نوار وضعیت و نوار پایین اندروید کشیده می‌شه
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // چیدمان برای حالت عمودی طراحی شده
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    ProviderScope(
      observers: [if (ProviderStats.enabled) ProviderStats()],
      overrides: [localStoreProvider.overrideWithValue(LocalStore(prefs))],
      child: const LittleMoon(),
    ),
  );
}

class LittleMoon extends ConsumerStatefulWidget {
  const LittleMoon({super.key});

  @override
  ConsumerState<LittleMoon> createState() => _LittleMoonState();
}

class _LittleMoonState extends ConsumerState<LittleMoon>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // اجازه‌ی نوتیفیکیشن بعد از اولین فریم پرسیده می‌شه
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationService.instance.requestPermission();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // قفل برنامه بعد از برگشتن از پس‌زمینه دوباره فعال می‌شه
    ref.read(appLockProvider.notifier).onLifecycleChanged(state);

    // نوشتن‌های عقب‌افتاده (ذخیره‌ی با debounce) قبل از رفتن به پس‌زمینه
    // یا بسته شدن برنامه روی دیسک می‌رن
    if (state != AppLifecycleState.resumed) {
      unawaited(PersistedRepository.flushAll());
    }

    // اگه برنامه بعد از نیمه‌شب دوباره باز بشه، «امروز» به‌روز می‌شه
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(todayProvider);
    }
  }

  /// «رمز رو فراموش کردم»: همه‌چیز پاک می‌شه و برنامه از اول شروع می‌شه.
  Future<void> _resetFromLockScreen() async {
    await resetAllAppData(ref);
    appRouter.go('/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final autoNight = ref.watch(autoNightThemeProvider);
    final locale = ref.watch(localeProvider);

    // یادآورهای گوشی با هر تغییر در چرخه/تنظیمات دوباره چیده می‌شن
    ref.watch(notificationSyncProvider);

    // ویجت صفحه‌ی اصلی گوشی هم همراه با چرخه به‌روز می‌شه
    ref.watch(homeWidgetSyncProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Little Moon',

      theme: AppTheme.getTheme(theme),
      // تم شب خودکار: با حالت تیره‌ی گوشی، تم شبِ هم‌خانواده نشون داده می‌شه
      darkTheme: autoNight ? AppTheme.getTheme(nightCounterpart(theme)) : null,
      themeMode: autoNight ? ThemeMode.system : ThemeMode.light,

      // Localization
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      routerConfig: appRouter,

      // نوارهای سیستم شفاف می‌شن تا رنگ خود صفحه زیرشون دیده بشه
      // (دیگه نوار سفید/سیاه پایین صفحه نمی‌افته) و رنگ آیکون‌هاشون
      // با روشن/تیره بودن تم هماهنگ می‌شه.
      builder: (context, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final iconBrightness = isDark ? Brightness.light : Brightness.dark;
        final media = MediaQuery.of(context);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: iconBrightness,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarDividerColor: Colors.transparent,
            systemNavigationBarIconBrightness: iconBrightness,
            systemNavigationBarContrastEnforced: false,
          ),
          child: MediaQuery(
            // اگه فونت سیستم خیلی بزرگ/کوچک تنظیم شده باشه، چیدمان به‌هم نریزه
            data: media.copyWith(
              textScaler: media.textScaler.clamp(
                minScaleFactor: 0.9,
                maxScaleFactor: 1.15,
              ),
            ),
            // روی تبلت و وب، محتوا وسط صفحه و با عرض موبایل می‌مونه
            child: ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: AppLockGate(
                    onResetApp: _resetFromLockScreen,
                    child: child ?? const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
