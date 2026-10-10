import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/settings_repository.dart';
import '../utils/app_calendar.dart';
import 'locale_provider.dart';

/// تقویم فعال برنامه (شمسی/میلادی + زبان) برای نمایش همه‌ی تاریخ‌ها.
final appCalendarProvider = Provider<AppCalendar>((ref) {
  final type = ref.watch(settingsProvider.select((s) => s.calendarType));
  final locale = ref.watch(localeProvider);
  return AppCalendar(type: type, lang: locale.languageCode);
});
