import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_strings.dart';
import '../../core/localization/locale_provider.dart';
import '../../core/utils/day_utils.dart';
import '../../core/utils/digits.dart';
import '../../data/models/app_settings.dart';
import '../../data/repositories/settings_repository.dart';
import '../../l10n/generated/app_localizations.dart';
import '../engine/cycle_engine.dart';
import 'cycle_providers.dart';
import 'notification_service.dart';

/// از روی وضعیت چرخه و تنظیمات، لیست نوتیفیکیشن‌های آینده رو می‌سازه.
abstract final class NotificationPlanner {
  /// ساعت یادآورهای چرخه (پریود، باروری، تخمک‌گذاری)
  static const cycleHour = 9;

  /// ساعت یادآور ثبت روزانه
  static const dailyLogHour = 21;

  /// برای چند روز آینده یادآور ثبت روزانه چیده بشه.
  /// با هر بار باز شدن برنامه دوباره پر می‌شه.
  static const dailyLogDays = 14;

  static const _periodBaseId = 1000;
  static const _fertileId = 2000;
  static const _ovulationId = 2001;
  static const _dailyBaseId = 3000;

  static List<PlannedNotification> build({
    required CycleSnapshot cycle,
    required AppSettings settings,
    required AppLocalizations l10n,
    required bool loggedToday,
    required DateTime now,
  }) {
    final plan = <PlannedNotification>[];
    final lang = l10n.localeName;

    /// تاریخِ فقط‌روز → همون روز در ساعت محلی [hour]
    DateTime at(DateTime day, int hour) =>
        DateTime(day.year, day.month, day.day, hour);

    void add(int id, DateTime when, String body) {
      if (!when.isAfter(now)) return;
      plan.add(
        PlannedNotification(
          id: id,
          when: when,
          title: AppInfo.appName,
          body: localizeDigits(body, lang),
        ),
      );
    }

    if (cycle.hasData) {
      // ---------- پریود ----------
      if (settings.periodReminder) {
        final before = settings.periodReminderDays;
        final starts = cycle.upcomingPeriods;

        // اگه پریود عقب افتاده، اولین مورد «امروز» فرضیه و اعلان نمی‌خواد
        final first = cycle.daysLate > 0 ? 1 : 0;
        for (var i = first; i < starts.length && i < first + 3; i++) {
          final start = starts[i];
          add(
            _periodBaseId + i * 2,
            at(addDays(start, -before), cycleHour),
            before == 1
                ? l10n.reminderPeriodTomorrow
                : l10n.reminderPeriodSoon(before),
          );
          add(
            _periodBaseId + i * 2 + 1,
            at(start, cycleHour),
            l10n.reminderPeriodToday,
          );
        }
      }

      // ---------- باروری و تخمک‌گذاری ----------
      final fertileStart = cycle.fertileStart;
      if (settings.fertileReminder && fertileStart != null) {
        add(
          _fertileId,
          at(addDays(fertileStart, -1), cycleHour),
          l10n.reminderFertileSoon,
        );
      }

      final ovulation = cycle.nextOvulation;
      if (settings.ovulationReminder && ovulation != null) {
        add(_ovulationId, at(ovulation, cycleHour), l10n.reminderOvulationToday);
      }
    }

    // ---------- ثبت روزانه ----------
    if (settings.dailyLogReminder) {
      for (var i = 0; i < dailyLogDays; i++) {
        if (i == 0 && loggedToday) continue;
        final day = DateTime(now.year, now.month, now.day + i);
        add(_dailyBaseId + i, at(day, dailyLogHour), l10n.reminderLogToday);
      }
    }

    return plan;
  }
}

/// نوتیفیکیشن‌های گوشی رو با وضعیت فعلی برنامه هماهنگ نگه می‌داره.
/// کافیه یک‌بار در ریشه‌ی برنامه `watch` بشه.
final notificationSyncProvider = Provider<void>((ref) {
  final cycle = ref.watch(cycleProvider);
  final settings = ref.watch(settingsProvider);
  final locale = ref.watch(localeProvider);
  final loggedToday = ref.watch(todayLogProvider) != null;

  final plan = NotificationPlanner.build(
    cycle: cycle,
    settings: settings,
    l10n: lookupAppLocalizations(locale),
    loggedToday: loggedToday,
    now: DateTime.now(),
  );

  unawaited(NotificationService.instance.replaceAll(plan));
});
