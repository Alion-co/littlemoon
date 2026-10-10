import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/localization/locale_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'data/database/local_store.dart';
import 'domain/services/cycle_providers.dart';
import 'domain/services/notification_planner.dart';
import 'domain/services/notification_service.dart';
import 'l10n/generated/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // حافظه‌ی محلی (کاملاً آفلاین) قبل از بالا اومدن برنامه آماده می‌شه
  final prefs = await SharedPreferences.getInstance();

  // برنامه تا زیر نوار وضعیت و نوار پایین اندروید کشیده می‌شه
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // چیدمان برای حالت عمودی طراحی شده
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    ProviderScope(
      overrides: [
        localStoreProvider.overrideWithValue(LocalStore(prefs)),
      ],
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
    // اگه برنامه بعد از نیمه‌شب دوباره باز بشه، «امروز» به‌روز می‌شه
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(todayProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final locale = ref.watch(localeProvider);

    // یادآورهای گوشی با هر تغییر در چرخه/تنظیمات دوباره چیده می‌شن
    ref.watch(notificationSyncProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Little Moon',

      theme: AppTheme.getTheme(theme),

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
                  child: child ?? const SizedBox.shrink(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
