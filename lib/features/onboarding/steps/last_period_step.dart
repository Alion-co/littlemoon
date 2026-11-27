import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/month_grid.dart';
import 'package:little_moon/shared/widgets/month_navigator.dart';

import 'onboarding_palette.dart';
import 'onboarding_step.dart';

/// مرحله‌ی ۲: تاریخ آخرین پریود (یا «یادم نیست»).
class LastPeriodStep extends StatelessWidget {
  final AppCalendar calendar;
  final DateTime today;
  final DateTime anchor;
  final DateTime? selected;
  final ValueChanged<DateTime> onAnchorChanged;
  final ValueChanged<DateTime> onSelected;
  final VoidCallback onDontRemember;

  const LastPeriodStep({
    super.key,
    required this.calendar,
    required this.today,
    required this.anchor,
    required this.selected,
    required this.onAnchorChanged,
    required this.onSelected,
    required this.onDontRemember,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final month = calendar.monthOf(anchor);
    final nextMonthStart = calendar.firstDayOf(calendar.next(month));
    final canGoNext = !nextMonthStart.isAfter(today);

    return OnboardingStep(
      children: [
        OnboardingHeading(
          title: l10n.lastPeriodQuestion,
          body: l10n.lastPeriodHint,
        ),
        const SizedBox(height: 16),
        _GlassCard(
          child: Column(
            children: [
              MonthNavigator(
                label: calendar.monthYear(month),
                onPrevious: () => onAnchorChanged(
                  calendar.firstDayOf(calendar.previous(month)),
                ),
                onNext: canGoNext
                    ? () => onAnchorChanged(nextMonthStart)
                    : null,
              ),
              const SizedBox(height: 8),
              MonthGrid(
                calendar: calendar,
                month: month,
                today: today,
                selectedDate: selected,
                maxDate: today,
                kindOf: (_) => DayKind.none,
                onSelect: onSelected,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: TextButton(
            onPressed: onDontRemember,
            style: TextButton.styleFrom(
              foregroundColor: OnboardingPalette.of(context).deep,
            ),
            child: Text(l10n.dontRemember),
          ),
        ),
      ],
    );
  }
}

/// کارت شیشه‌ای دور تقویم، مثل طرح.
class _GlassCard extends StatelessWidget {
  final Widget child;

  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final p = OnboardingPalette.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      decoration: BoxDecoration(
        color: p.glassFill,
        borderRadius: AppRadius.br24,
        border: Border.all(color: p.glassBorder, width: 0.8),
      ),
      child: child,
    );
  }
}
