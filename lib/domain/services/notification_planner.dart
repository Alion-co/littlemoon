import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/localization/locale_provider.dart';
import '../../core/utils/day_utils.dart';
import '../../core/utils/digits.dart';
import '../../data/models/app_settings.dart';
import '../../data/repositories/settings_repository.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../core/localization/labels.dart';
import '../engine/cycle_engine.dart';
import '../engine/pattern_finder.dart';
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
  static const _lateBaseId = 2100;

  /// هشدار زودهنگام الگوها: ۲۲۰۰ + شماره (حداکثر [PatternFinder.maxPatterns] تا).
  static const _patternBaseId = 2200;

  /// چند روز بعد از تاریخ پیش‌بینی‌شده، اگه هنوز عادت ماهانه ثبت نشده،
  /// یادآور تأخیر بیاد.
  static const lateReminderDays = [3, 7];
  static const _dailyBaseId = 3000;
  static const _pillBaseId = 4000;

  /// برای چند روز آینده یادآور قرص چیده بشه (با هر باز شدن برنامه تمدید می‌شه).
  static const pillDays = 14;

  static List<PlannedNotification> build({
    required CycleSnapshot cycle,
    required AppSettings settings,
    required AppLocalizations l10n,
    required bool loggedToday,
    required DateTime now,
    List<PersonalPattern> patterns = const [],
  }) {
    final plan = <PlannedNotification>[];
    final lang = l10n.localeName;

    // حالت مخفی: عنوان و متن خنثی، تا کسی که صفحه‌ی گوشی رو می‌بینه
    // از موضوع یادآور چیزی نفهمه.
    final discreet = settings.discreetNotifications;
    final title = discreet ? l10n.discreetTitle : l10n.appTitle;
    String cycleText(String text) => discreet ? l10n.discreetCycleBody : text;

    /// تاریخِ فقط‌روز → همون روز در ساعت محلی [hour]
    DateTime at(DateTime day, int hour) =>
        DateTime(day.year, day.month, day.day, hour);

    void add(int id, DateTime when, String body) {
      if (!when.isAfter(now)) return;
      plan.add(
        PlannedNotification(
          id: id,
          when: when,
          title: title,
          body: localizeDigits(body, lang),
          discreet: discreet,
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
            cycleText(
              before == 1
                  ? l10n.reminderPeriodTomorrow
                  : l10n.reminderPeriodSoon(before),
            ),
          );
          add(
            _periodBaseId + i * 2 + 1,
            at(start, cycleHour),
            cycleText(l10n.reminderPeriodToday),
          );
        }
      }

      // ---------- هشدار زودهنگام الگوهای شخصی ----------
      // مثلاً اگه معمولاً ۲ روز قبل از عادت ماهانه سردرد می‌گیری، ۳ روز
      // قبلش یک یادآوری ملایم میاد. فقط برای عادت ماهانه‌ی بعدی.
      if (settings.periodReminder) {
        final starts = cycle.upcomingPeriods;
        final first = cycle.daysLate > 0 ? 1 : 0;
        if (first < starts.length) {
          final start = starts[first];
          final byDay = <int, List<PersonalPattern>>{};
          for (final pattern in PatternFinder.warnable(patterns)) {
            byDay.putIfAbsent(pattern.day, () => []).add(pattern);
          }
          final days = byDay.keys.toList()..sort();
          for (var i = 0; i < days.length; i++) {
            final day = days[i];
            add(
              _patternBaseId + i,
              at(
                addDays(start, -(day + PatternFinder.warningLeadDays)),
                cycleHour,
              ),
              cycleText(
                l10n.reminderPatternSoon(
                  Labels.patternNames(l10n, byDay[day]!),
                ),
              ),
            );
          }
        }
      }

      // ---------- تأخیر ----------
      // با ثبت شروع عادت ماهانه، برنامه دوباره چیده می‌شه و این‌ها حذف می‌شن.
      final expected = cycle.nextPeriodStart;
      if (settings.lateReminder && expected != null && !cycle.isPeriodOngoing) {
        for (var i = 0; i < lateReminderDays.length; i++) {
          final days = lateReminderDays[i];
          add(
            _lateBaseId + i,
            at(addDays(expected, days), cycleHour),
            cycleText(l10n.reminderLate(days)),
          );
        }
      }

      // ---------- باروری و تخمک‌گذاری ----------
      final fertileStart = cycle.fertileStart;
      if (settings.fertileReminder && fertileStart != null) {
        add(
          _fertileId,
          at(addDays(fertileStart, -1), cycleHour),
          cycleText(l10n.reminderFertileSoon),
        );
      }

      final ovulation = cycle.nextOvulation;
      if (settings.ovulationReminder && ovulation != null) {
        add(
          _ovulationId,
          at(ovulation, cycleHour),
          cycleText(l10n.reminderOvulationToday),
        );
      }
    }

    // ---------- ثبت روزانه ----------
    if (settings.dailyLogReminder) {
      for (var i = 0; i < dailyLogDays; i++) {
        if (i == 0 && loggedToday) continue;
        final day = DateTime(now.year, now.month, now.day + i);
        add(
          _dailyBaseId + i,
          at(day, dailyLogHour),
          discreet ? l10n.discreetLogBody : l10n.reminderLogToday,
        );
      }
    }

    // ---------- قرص ----------
    if (settings.pillReminder) {
      for (var i = 0; i < pillDays; i++) {
        add(
          _pillBaseId + i,
          DateTime(
            now.year,
            now.month,
            now.day + i,
            settings.pillHour,
            settings.pillMinute,
          ),
          discreet ? l10n.discreetPillBody : l10n.reminderPill,
        );
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
  final loggedToday = ref.watch(todayLogProvider.select((log) => log != null));
  final patterns = ref.watch(patternsProvider);

  final plan = NotificationPlanner.build(
    cycle: cycle,
    settings: settings,
    l10n: lookupAppLocalizations(locale),
    loggedToday: loggedToday,
    now: DateTime.now(),
    patterns: patterns,
  );

  unawaited(NotificationService.instance.replaceAll(plan));
});
