import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/localization/calendar_provider.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/core/utils/haptics.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/data/repositories/profile_repository.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/features/home/widgets/app_header.dart';
import 'package:little_moon/features/home/widgets/cycle_hero_card.dart';
import 'package:little_moon/features/home/widgets/daily_tips_card.dart';
import 'package:little_moon/shared/widgets/floating_navbar.dart';
import 'package:little_moon/features/home/widgets/night_sky_background.dart';
import 'package:little_moon/features/home/widgets/phase_layout.dart';
import 'package:little_moon/features/home/widgets/period_quick_action.dart';
import 'package:little_moon/features/home/widgets/quick_log_card.dart';
import 'package:little_moon/features/home/widgets/reminders_sheet.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/date_picker_sheet.dart';
import 'package:little_moon/shared/widgets/glass.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  String _greeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return l10n.goodMorning;
    if (hour >= 12 && hour < 17) return l10n.goodAfternoon;
    if (hour >= 17 && hour < 22) return l10n.homeGreeting;
    return l10n.goodNight;
  }

  /// متن زیر فاز: فاصله تا پریود بعدی، تأخیر، یا روز چندم پریود.
  String? _statusText(
    BuildContext context,
    AppLocalizations l10n,
    CycleSnapshot cycle,
  ) {
    final until = cycle.daysUntilNextPeriod ?? 0;
    if (cycle.isPeriodOngoing) {
      return context.n(l10n.periodDayNumber(cycle.cycleDay ?? 1));
    }
    if (until < 0) return context.n(Labels.latePeriod(l10n, -until));
    if (until == 0) return l10n.periodExpectedToday;
    if (until == 1) return l10n.periodExpectedTomorrow;
    return null;
  }

  /// بازه‌ی باروری برای کارت لمسِ ماه؛ اگه موتور چرخه هنوز نمی‌دونه `null`.
  String? _fertileText(
    AppLocalizations l10n,
    AppCalendar calendar,
    CycleSnapshot cycle,
  ) {
    final start = cycle.fertileStart;
    final end = cycle.fertileEnd;
    if (start == null || end == null) return null;
    return Labels.dateRange(l10n, calendar, start, end);
  }

  String _healthNote(AppLocalizations l10n, CycleSnapshot cycle) {
    // تأخیر از بقیه مهم‌تره
    switch (cycle.lateLevel) {
      case LateLevel.veryLate:
        return l10n.cycleLateNote;
      case LateLevel.beyondRange:
        return l10n.cycleLateMildNote;
      case LateLevel.withinRange:
        return l10n.cycleLateWithinRangeNote;
      case LateLevel.none:
        break;
    }

    final concerns = cycle.concerns;
    if (concerns.contains(CycleConcern.possibleMissedLog)) {
      return l10n.cycleMissedLogNote;
    }
    if (concerns.contains(CycleConcern.shortCycles)) {
      return l10n.cycleShortNote;
    }
    if (concerns.contains(CycleConcern.longCycles)) {
      return l10n.cycleLongNote;
    }
    if (concerns.contains(CycleConcern.highVariation)) {
      return l10n.cycleIrregularNote;
    }
    return l10n.cycleHealthy;
  }

  Future<void> _logFirstPeriod(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final today = ref.read(todayProvider);
    final picked = await showMoonDatePicker(
      context: context,
      calendar: ref.read(appCalendarProvider),
      initialDate: today,
      today: today,
      maxDate: today,
      title: l10n.lastPeriodQuestion,
    );
    if (picked == null) return;

    await ref
        .read(logsProvider.notifier)
        .markPeriod(
          picked,
          ref.read(profileProvider).periodLength,
          notAfter: today,
        );
  }

  void _showPredictionInfo(BuildContext context, CycleSnapshot cycle) {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.predictionInfoTitle),
        content: Text(
          cycle.hasData
              ? '${l10n.predictionInfoBody}\n\n'
                    '${Labels.confidence(l10n, cycle.confidence)}'
              : l10n.predictionInfoBody,
          style: const TextStyle(height: 1.6),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.ok),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final profile = ref.watch(profileProvider);
    final cycle = ref.watch(cycleProvider);
    final calendar = ref.watch(appCalendarProvider);
    final today = ref.watch(todayProvider);
    final reminders = ref.watch(remindersProvider);

    final phase = cycle.phase;
    final night = isNightTheme(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // تم شب: آسمان پشت کل صفحه (حتی زیر نوارهای سیستم)
          if (night) const Positioned.fill(child: NightSkyBackground()),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),

                        AppHeader(
                          userName: profile.name,
                          avatar: profile.avatar,
                          greeting: _greeting(l10n),
                          dateText: calendar.weekdayDayMonth(today),
                          hasReminders: reminders.isNotEmpty,
                          onNotificationTap: () => showRemindersSheet(context),
                          onProfileTap: () => context.go('/profile'),
                        ),

                        const SizedBox(height: 20),

                        if (cycle.hasData && phase != null)
                          CycleHeroCard(
                            currentDay: cycle.cycleDay ?? 1,
                            phaseKey: Labels.phaseKey(phase),
                            daysUntilPeriod: cycle.daysUntilNextPeriod ?? 0,
                            cycleProgress: cycle.progress,
                            statusText: _statusText(context, l10n, cycle),
                            fertileText: _fertileText(l10n, calendar, cycle),
                            layout: CyclePhaseLayout.fromSnapshot(cycle),
                            note: _healthNote(l10n, cycle),
                            noteIsAlert:
                                cycle.lateLevel != LateLevel.none ||
                                cycle.concerns.isNotEmpty,
                            onInfoTap: () {
                              Haptics.tap();
                              _showPredictionInfo(context, cycle);
                            },
                          )
                        else
                          CycleEmptyCard(
                            onLogPeriod: () => _logFirstPeriod(context, ref),
                          ),

                        if (cycle.hasData) ...[
                          const SizedBox(height: 12),
                          const PeriodQuickAction(),
                        ],

                        const SizedBox(height: 20),

                        // ثبت روزانه: ثبت سریع + دکمه‌ی «ثبت دقیق»
                        const QuickLogCard(),

                        if (cycle.hasData && phase != null) ...[
                          const SizedBox(height: 14),
                          const DailyTipsCard(),
                        ],

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                const FloatingNavbar(currentIndex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
