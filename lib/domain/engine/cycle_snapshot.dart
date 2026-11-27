import '../../core/utils/day_utils.dart';
import 'cycle_engine.dart';

/// وضعیت محاسبه‌شده‌ی چرخه در یک روز مشخص.
class CycleSnapshot {
  final DateTime today;
  final bool hasData;

  final List<PeriodRange> periods;
  final List<CycleRecord> cycles;

  /// طول چرخه‌های معتبرِ اخیر که مبنای میانگین بودن (حداکثر ۶ تا).
  final List<int> recentCycleLengths;

  final int avgCycleLength;
  final int avgPeriodLength;

  /// طول فاز لوتئالی که پیش‌بینی بر اساسش انجام شده (شخصی یا پیش‌فرض).
  final int lutealLength;

  /// [lutealLength] از پروفایل اومده یا از چرخه‌های خودِ کاربر.
  final LutealSource lutealSource;

  /// فاز لوتئال‌های تأییدشده با دمای پایه (قدیمی ← جدید).
  final List<int> lutealSamples;

  /// تخمک‌گذاری‌های تأییدشده با دمای پایه در همه‌ی چرخه‌ها.
  final List<BbtOvulation> bbtOvulations;

  /// تخمک‌گذاری چرخه‌ی فعلی با دما تأیید شده و پیش‌بینی پریود بعدی
  /// بر اساس اون اصلاح شده.
  final bool bbtRefined;

  /// تعداد دماهای معتبر ثبت‌شده در چرخه‌ی فعلی.
  final int bbtReadingsThisCycle;

  /// تعداد چرخه‌هایی که کاربر «غیرعادی» علامت زده.
  final int unusualCycleCount;

  final int? minCycleLength;
  final int? maxCycleLength;
  final CycleRegularity regularity;

  final DateTime? lastPeriodStart;

  /// شروع پیش‌بینی‌شده‌ی پریود بعدی (ممکنه در گذشته باشه = تأخیر).
  final DateTime? nextPeriodStart;

  /// چند روز زودتر یا دیرتر از [nextPeriodStart] هم محتمله.
  ///
  /// از پراکندگی طول چرخه‌های اخیر حساب می‌شه؛ چرخه‌های منظم بازه‌ی
  /// باریک‌تری دارن.
  final int predictionSpread;

  /// میزان اطمینان به پیش‌بینی.
  final PredictionConfidence confidence;

  /// نگرانی‌های قابل‌توجه درباره‌ی الگوی چرخه (خالی = چیزی دیده نشد).
  final List<CycleConcern> concerns;

  /// منفی یعنی پریود عقب افتاده.
  final int? daysUntilNextPeriod;

  final int? cycleDay;
  final CyclePhase? phase;
  final bool isPeriodToday;
  final bool isPeriodOngoing;

  final DateTime? nextOvulation;
  final DateTime? fertileStart;
  final DateTime? fertileEnd;

  /// شروع پریودهای پیش‌بینی‌شده‌ی آینده.
  final List<DateTime> upcomingPeriods;

  final Set<int> periodDaySet;
  final Set<int> predictedDaySet;
  final Set<int> fertileDaySet;
  final Set<int> ovulationDaySet;

  const CycleSnapshot({
    required this.today,
    required this.hasData,
    required this.periods,
    required this.cycles,
    required this.recentCycleLengths,
    required this.avgCycleLength,
    required this.avgPeriodLength,
    required this.lutealLength,
    this.lutealSource = LutealSource.profile,
    this.lutealSamples = const <int>[],
    this.bbtOvulations = const <BbtOvulation>[],
    this.bbtRefined = false,
    this.bbtReadingsThisCycle = 0,
    this.unusualCycleCount = 0,
    required this.minCycleLength,
    required this.maxCycleLength,
    required this.regularity,
    required this.lastPeriodStart,
    required this.nextPeriodStart,
    this.predictionSpread = CycleEngine.defaultSpread,
    this.confidence = PredictionConfidence.low,
    this.concerns = const <CycleConcern>[],
    required this.daysUntilNextPeriod,
    required this.cycleDay,
    required this.phase,
    required this.isPeriodToday,
    required this.isPeriodOngoing,
    required this.nextOvulation,
    required this.fertileStart,
    required this.fertileEnd,
    required this.upcomingPeriods,
    required this.periodDaySet,
    required this.predictedDaySet,
    required this.fertileDaySet,
    required this.ovulationDaySet,
  });

  factory CycleSnapshot.empty({
    required DateTime today,
    int cycleLength = 28,
    int periodLength = 5,
    int lutealLength = 14,
  }) {
    return CycleSnapshot(
      today: dayOnly(today),
      hasData: false,
      periods: const [],
      cycles: const [],
      recentCycleLengths: const [],
      avgCycleLength: cycleLength,
      avgPeriodLength: periodLength,
      lutealLength: lutealLength,
      minCycleLength: null,
      maxCycleLength: null,
      regularity: CycleRegularity.unknown,
      lastPeriodStart: null,
      nextPeriodStart: null,
      daysUntilNextPeriod: null,
      cycleDay: null,
      phase: null,
      isPeriodToday: false,
      isPeriodOngoing: false,
      nextOvulation: null,
      fertileStart: null,
      fertileEnd: null,
      upcomingPeriods: const [],
      periodDaySet: const <int>{},
      predictedDaySet: const <int>{},
      fertileDaySet: const <int>{},
      ovulationDaySet: const <int>{},
    );
  }
}
