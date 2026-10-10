import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/about/about_page.dart';
import '../../features/calendar/calendar_page.dart';
import '../../features/health/health_page.dart';
import '../../features/home/home_page.dart';
import '../../features/insights/insights_page.dart';
import '../../features/onboarding/onboarding_page.dart';
import '../../features/profile/profile_page.dart';
import '../../features/settings/settings_page.dart';
import '../../features/splash/splash_page.dart';

/// صفحه‌های نوار پایین بدون انیمیشن جابه‌جا می‌شن تا حس «تب» بدن.
GoRoute _tabRoute(String path, Widget child) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) => NoTransitionPage<void>(
      key: state.pageKey,
      child: child,
    ),
  );
}

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
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
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutPage(),
    ),
  ],
);
