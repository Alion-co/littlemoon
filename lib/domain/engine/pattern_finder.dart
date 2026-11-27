import '../../core/utils/day_utils.dart';
import '../../data/models/daily_log.dart';
import 'cycle_engine.dart';

/// چیزی که الگو درباره‌اش پیدا شده.
enum PatternSubject { symptom, mood, pain }

/// زمان تکرار الگو نسبت به عادت ماهانه.
enum PatternTiming {
  /// چند روز قبل از شروع عادت ماهانه‌ی بعدی (فاز لوتئال / PMS)
  beforePeriod,

  /// در روزهای عادت ماهانه
  duringPeriod,
}

/// یک الگوی تکراری در ثبت‌های خود کاربر، مثل «سردرد، معمولاً ۲ روز قبل
/// از عادت ماهانه».
class PersonalPattern {
  final PatternSubject subject;

  /// شناسه‌ی علامت ([SymptomIds]) یا اسم [Mood]؛ برای درد خالیه.
  final String id;
  final PatternTiming timing;

  /// برای [PatternTiming.beforePeriod]: چند روز قبل؛
  /// برای [PatternTiming.duringPeriod]: روز چندم عادت ماهانه.
  final int day;

  /// چند بار در این زمان ثبت شده.
  final int count;

  /// در چند چرخه‌ی مختلف دیده شده.
  final int cycles;

  const PersonalPattern({
    required this.subject,
    required this.id,
    required this.timing,
    required this.day,
    required this.count,
    required this.cycles,
  });

  Mood? get mood {
    for (final value in Mood.values) {
      if (value.name == id) return value;
    }
    return null;
  }
}

/// الگوهای شخصی رو از روی ثبت‌های روزانه و چرخه‌های ثبت‌شده پیدا می‌کنه.
///
/// یک الگو وقتی گزارش می‌شه که:
///  • حداقل [minOccurrences] بار در همون زمان چرخه ثبت شده باشه،
///  • در حداقل [minCycles] چرخه‌ی مختلف دیده شده باشه،
///  • و حداقل [minShare] از کل دفعات اون مورد در همین زمان بوده باشه.
/// این شرط‌ها نمی‌ذارن یک اتفاق تصادفی «الگو» حساب بشه.
abstract final class PatternFinder {
  static const minOccurrences = 3;
  static const minCycles = 2;
  static const minShare = 0.6;

  /// تا این تعداد روز قبل از عادت ماهانه «قبل از عادت» حساب می‌شه.
  static const premenstrualWindow = 10;

  /// فقط ثبت‌های یک سال اخیر بررسی می‌شن.
  static const lookbackDays = 365;

  static const maxPatterns = 6;

  /// برای هشدار زودهنگام، الگو باید حداقل در این تعداد چرخه دیده شده
  /// باشه (قوی‌تر از شرط نمایش در «الگوهای تو»).
  static const warningMinCycles = 3;

  /// هشدار زودهنگام این‌قدر روز قبل از زمان معمولِ الگو میاد.
  static const warningLeadDays = 1;

  /// الگوهایی که به‌اندازه‌ی کافی قوی‌ان تا قبلش هشدار بدیم: فقط «قبل از
  /// عادت ماهانه»، دیده‌شده در [warningMinCycles] چرخه یا بیشتر.
  static List<PersonalPattern> warnable(Iterable<PersonalPattern> patterns) {
    return [
      for (final pattern in patterns)
        if (pattern.timing == PatternTiming.beforePeriod &&
            pattern.day >= 1 &&
            pattern.cycles >= warningMinCycles)
          pattern,
    ];
  }

  static List<PersonalPattern> find({
    required CycleSnapshot cycle,
    required Iterable<DailyLog> logs,
    required DateTime today,
  }) {
    final periods = cycle.periods;
    if (periods.length < 2) return const [];

    final buckets = <String, _Bucket>{};

    void record(PatternSubject subject, String id, DateTime date) {
      final position = _position(periods, date);
      if (position == null) return;
      final key = '${subject.name}:$id';
      final bucket = buckets.putIfAbsent(
        key,
        () => _Bucket(subject: subject, id: id),
      );
      bucket.total++;
      final timing = position.timing;
      if (timing == null) return;
      bucket.values[timing]!.add(position.day);
      bucket.cycles[timing]!.add(position.cycleIndex);
    }

    for (final log in logs) {
      final age = daysBetween(log.date, today);
      if (age < 0 || age > lookbackDays) continue;

      for (final id in log.symptoms) {
        record(PatternSubject.symptom, id, log.date);
      }
      final mood = log.mood;
      if (mood != null) record(PatternSubject.mood, mood.name, log.date);
      final pain = log.pain;
      if (pain != null && pain >= 2) record(PatternSubject.pain, '', log.date);
    }

    final patterns = <PersonalPattern>[];
    for (final bucket in buckets.values) {
      for (final timing in PatternTiming.values) {
        final values = bucket.values[timing]!;
        final cycles = bucket.cycles[timing]!.length;
        if (values.length < minOccurrences) continue;
        if (cycles < minCycles) continue;
        if (values.length / bucket.total < minShare) continue;
        patterns.add(
          PersonalPattern(
            subject: bucket.subject,
            id: bucket.id,
            timing: timing,
            day: _median(values),
            count: values.length,
            cycles: cycles,
          ),
        );
      }
    }

    patterns.sort((a, b) {
      final byCycles = b.cycles.compareTo(a.cycles);
      return byCycles != 0 ? byCycles : b.count.compareTo(a.count);
    });
    return patterns.take(maxPatterns).toList();
  }

  /// جایگاه یک روز نسبت به عادت ماهانه.
  static _Position? _position(List<PeriodRange> periods, DateTime date) {
    final day = dayOnly(date);
    var owner = -1;
    for (var i = 0; i < periods.length; i++) {
      if (!periods[i].start.isAfter(day)) owner = i;
    }

    // روزهای قبل از اولین عادت ماهانه‌ی ثبت‌شده: فقط «قبل از» معنی داره
    if (owner < 0) {
      final before = daysBetween(day, periods.first.start);
      if (before >= 1 && before <= premenstrualWindow) {
        return _Position(PatternTiming.beforePeriod, before, 0);
      }
      return null;
    }

    final period = periods[owner];
    final cycleDay = daysBetween(period.start, day) + 1;
    // یک روز بعد از آخرین روز خونریزی هنوز جزو «روزهای عادت» حساب می‌شه
    if (cycleDay <= period.length + 1) {
      return _Position(PatternTiming.duringPeriod, cycleDay, owner);
    }

    // «قبل از عادت» فقط وقتی معنی داره که عادت بعدی واقعاً ثبت شده باشه
    if (owner + 1 < periods.length) {
      final before = daysBetween(day, periods[owner + 1].start);
      if (before >= 1 && before <= premenstrualWindow) {
        return _Position(PatternTiming.beforePeriod, before, owner + 1);
      }
    }
    return const _Position(null, 0, -1);
  }

  static int _median(List<int> values) {
    final sorted = [...values]..sort();
    return sorted[sorted.length ~/ 2];
  }
}

class _Position {
  final PatternTiming? timing;
  final int day;

  /// شماره‌ی عادت ماهانه‌ای که این روز بهش مربوطه (برای شمردن چرخه‌ها).
  final int cycleIndex;

  const _Position(this.timing, this.day, this.cycleIndex);
}

class _Bucket {
  final PatternSubject subject;
  final String id;
  int total = 0;
  final Map<PatternTiming, List<int>> values = {
    for (final timing in PatternTiming.values) timing: <int>[],
  };
  final Map<PatternTiming, Set<int>> cycles = {
    for (final timing in PatternTiming.values) timing: <int>{},
  };

  _Bucket({required this.subject, required this.id});
}
