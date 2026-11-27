import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/domain/engine/health_summary.dart';
import 'package:little_moon/domain/engine/symptom_stats.dart';

import 'cycle_providers.dart';

/// آخرین وزن و دما + میانگین خواب ۷ روز اخیر (صفحه‌ی سلامت).
final healthSummaryProvider = Provider<HealthSummary>((ref) {
  return HealthSummary.from(
    ref.watch(logsProvider).values,
    ref.watch(todayProvider),
  );
});

/// شمارش علائم و خلق‌وخو در ۹۰ روز اخیر (بینش‌ها و ثبت سریع).
final symptomStatsProvider = Provider<SymptomStats>((ref) {
  return SymptomStats.from(
    ref.watch(logsProvider).values,
    ref.watch(todayProvider),
  );
});
