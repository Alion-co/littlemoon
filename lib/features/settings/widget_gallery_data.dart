part of 'widget_gallery.dart';

/// داده‌ی نمایشی پیش‌نمایش، از روی وضعیت فعلی چرخه.
class _WidgetData {
  /// سرتیتر وسط حلقه: «روز ۱۴» (یا 🌙 وقتی داده نیست).
  final String day;

  /// نام فاز و رنگ نقطه‌ی کنارش؛ `null` یعنی ردیف فاز نمایش داده نمی‌شه.
  final String? phase;
  final Color? phaseColor;

  final String? status;
  final double progress;

  /// تقسیم فازها روی حلقه و فاز امروز (برای حلقه‌ی هیرو).
  final CyclePhaseLayout layout;
  final CyclePhase ringPhase;

  const _WidgetData({
    required this.day,
    required this.phase,
    required this.phaseColor,
    required this.status,
    required this.progress,
    required this.layout,
    required this.ringPhase,
  });
}

_WidgetData _buildWidgetData(BuildContext context, WidgetRef ref) {
  final l10n = AppLocalizations.of(context)!;
  final cycle = ref.watch(cycleProvider);
  final discreet = ref.watch(settingsProvider).discreetNotifications;
  final phase = cycle.phase;
  final day = cycle.cycleDay;

  if (!cycle.hasData || phase == null || day == null) {
    return _WidgetData(
      day: '🌙',
      phase: discreet ? null : l10n.noCycleDataTitle,
      phaseColor: null,
      status: null,
      progress: 0,
      layout: CyclePhaseLayout.of(
        cycleLength: 28,
        periodLength: 5,
        lutealLength: 14,
      ),
      ringPhase: CyclePhase.menstrual,
    );
  }

  final dayText = context.n(l10n.dayOfCycle(day));
  final layout = CyclePhaseLayout.fromSnapshot(cycle);

  // حالت مخفی: فقط شماره‌ی روز، بدون فاز و وضعیت
  if (discreet) {
    return _WidgetData(
      day: dayText,
      phase: null,
      phaseColor: null,
      status: null,
      progress: cycle.progress,
      layout: layout,
      ringPhase: phase,
    );
  }

  final until = cycle.daysUntilNextPeriod ?? 0;
  final String status;
  if (cycle.isPeriodOngoing) {
    status = l10n.periodDayNumber(day);
  } else if (until > 1) {
    status = l10n.daysUntilPeriod(until);
  } else if (until == 1) {
    status = l10n.periodExpectedTomorrow;
  } else if (until == 0) {
    status = l10n.periodExpectedToday;
  } else {
    status = Labels.latePeriod(l10n, -until);
  }

  return _WidgetData(
    day: dayText,
    phase: Labels.phase(l10n, phase),
    phaseColor: CyclePhaseLayout.colorOf(phase),
    status: context.n(status),
    progress: cycle.progress,
    layout: layout,
    ringPhase: phase,
  );
}
