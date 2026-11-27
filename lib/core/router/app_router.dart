import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/about/about_page.dart';
import '../../features/calendar/calendar_page.dart';
import '../../features/health/health_page.dart';
import '../../features/home/home_page.dart';
import '../../features/insights/charts_page.dart';
import '../../features/insights/insights_page.dart';
import '../../features/onboarding/onboarding_page.dart';
import '../../features/profile/profile_page.dart';
import '../../features/settings/appearance_settings_page.dart';
import '../../features/settings/data_settings_page.dart';
import '../../features/settings/privacy_settings_page.dart';
import '../../features/settings/reminder_settings_page.dart';
import '../../features/settings/settings_page.dart';
import '../../features/splash/splash_page.dart';

/// صفحه‌های نوار پایین بدون انیمیشن جابه‌جا می‌شن تا حس «تب» بدن.
GoRoute _tabRoute(String path, Widget child) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) =>
        NoTransitionPage<void>(key: state.pageKey, child: child),
  );
}

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    _tabRoute('/home', const HomePage()),
    _tabRoute('/calendar', const CalendarPage()),
    _tabRoute('/insights', const InsightsPage()),
    _tabRoute('/health', const HealthPage()),
    _tabRoute('/profile', const ProfilePage()),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
      routes: [
        GoRoute(
          path: 'appearance',
          builder: (context, state) => const AppearanceSettingsPage(),
        ),
        GoRoute(
          path: 'reminders',
          builder: (context, state) => const ReminderSettingsPage(),
        ),
        GoRoute(
          path: 'privacy',
          builder: (context, state) => const PrivacySettingsPage(),
        ),
        GoRoute(
          path: 'data',
          builder: (context, state) => const DataSettingsPage(),
        ),
      ],
    ),
    GoRoute(path: '/charts', builder: (context, state) => const ChartsPage()),
    GoRoute(path: '/about', builder: (context, state) => const AboutPage()),
  ],
);
