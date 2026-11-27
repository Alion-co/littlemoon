import 'dart:math' as math;

import '../../core/utils/math_utils.dart';
import 'cycle_engine.dart';

/// آمار خالص روی طول چرخه‌ها: میانگین وزن‌دار، پراکندگی، اطمینان، نگرانی‌ها.
abstract final class CycleStats {
  /// پراکندگی (انحراف معیار وزن‌دار) طول چرخه‌ها، گرد و محدودشده به
  /// [CycleEngine.minSpread]..[CycleEngine.maxSpread]. چرخه‌های جدیدتر
  /// وزن بیشتری دارن.
  static int spreadOf(List<int> lengths) {
    if (lengths.length < 2) return CycleEngine.defaultSpread;
    final mean = weightedMean(lengths);
    var squares = 0.0;
    var totalWeight = 0;
    for (var i = 0; i < lengths.length; i++) {
      final weight = i + 1;
      final diff = lengths[i] - mean;
      squares += weight * diff * diff;
      totalWeight += weight;
    }
    final deviation = math.sqrt(squares / totalWeight);
    return clampInt(
      deviation.round(),
      CycleEngine.minSpread,
      CycleEngine.maxSpread,
    );
  }

  /// اطمینان به پیش‌بینی: کم‌بودن داده یا پراکندگی زیاد → کم؛
  /// ۴ چرخه‌ی یکنواخت یا بیشتر → زیاد.
  static PredictionConfidence confidenceOf(List<int> lengths, int spread) {
    if (lengths.length < 3 || spread >= 5) return PredictionConfidence.low;
    if (lengths.length >= 4 && spread <= 2) return PredictionConfidence.high;
    return PredictionConfidence.medium;
  }

  /// نگرانی‌های قابل‌توجه از روی چرخه‌های ثبت‌شده.
  static List<CycleConcern> concernsOf({
    required List<CycleRecord> cycles,
    required List<int> recent,
    required int avgCycle,
    required CycleRegularity regularity,
    required int cycleDay,
  }) {
    final concerns = <CycleConcern>[];
    if (recent.length >= 2) {
      if (avgCycle < CycleEngine.shortCycleDays) {
        concerns.add(CycleConcern.shortCycles);
      }
      if (avgCycle > CycleEngine.longCycleDays) {
        concerns.add(CycleConcern.longCycles);
      }
    }

    // چرخه‌ی خیلی طولانی در ۳ چرخه‌ی آخر، یا چرخه‌ی فعلی که از حد گذشته
    final lastCycles = cycles.length > 3
        ? cycles.sublist(cycles.length - 3)
        : cycles;
    final hasTooLong = lastCycles.any(
      (c) => c.length > CycleEngine.maxValidCycle && !c.excluded,
    );
    if (hasTooLong || cycleDay > CycleEngine.maxValidCycle) {
      concerns.add(CycleConcern.possibleMissedLog);
    }

    if (regularity == CycleRegularity.irregular) {
      concerns.add(CycleConcern.highVariation);
    }
    return concerns;
  }

  /// نظم چرخه از روی طول چرخه‌های اخیر.
  static CycleRegularity regularityOf(int? minCycle, int? maxCycle, int count) {
    if (count < 2 || minCycle == null || maxCycle == null) {
      return CycleRegularity.unknown;
    }
    return (maxCycle - minCycle) <= CycleEngine.regularSpread
        ? CycleRegularity.regular
        : CycleRegularity.irregular;
  }

  static List<int> lastN(List<int> values, int count) =>
      values.length > count ? values.sublist(values.length - count) : values;

  /// میانگین مقادیر واقعی؛ تا وقتی کمتر از ۳ نمونه داریم، با مقدار
  /// پیش‌فرضِ کاربر ترکیب می‌شه تا یک چرخه‌ی غیرعادی پیش‌بینی رو خراب نکنه.
  /// از ۳ نمونه به بعد، میانگین «وزن‌دار» حساب می‌شه ([weightedMean]).
  static int blend(List<int> values, int fallback) {
    if (values.isEmpty) return fallback;
    if (values.length >= 3) return weightedMean(values).round();
    var sum = 0;
    for (final value in values) {
      sum += value;
    }
    return ((sum + fallback * (3 - values.length)) / 3).round();
  }

  /// میانگین وزن‌دار: مقادیر از قدیمی به جدید مرتب‌ان و وزن‌شون ۱، ۲، ۳، …
  /// پس چرخه‌ی جدیدتر روی پیش‌بینی اثر بیشتری داره.
  static double weightedMean(List<int> values) {
    var weighted = 0.0;
    var totalWeight = 0;
    for (var i = 0; i < values.length; i++) {
      final weight = i + 1;
      weighted += values[i] * weight;
      totalWeight += weight;
    }
    return weighted / totalWeight;
  }
}
