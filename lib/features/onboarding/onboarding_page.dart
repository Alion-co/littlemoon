import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/localization/calendar_provider.dart';
import 'package:little_moon/core/theme/themes/moon_colors.dart';
import 'package:little_moon/core/utils/app_calendar.dart';
import 'package:little_moon/data/models/user_profile.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/data/repositories/profile_repository.dart';
import 'package:little_moon/domain/engine/cycle_engine.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/month_grid.dart';
import 'package:little_moon/shared/widgets/month_navigator.dart';
import 'package:little_moon/shared/widgets/number_stepper.dart';
import 'package:little_moon/shared/widgets/language_picker.dart';

/// راه‌اندازی اولیه: اسم، آخرین پریود، طول پریود و طول چرخه.
class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  static const _stepCount = 4;

  final _pageController = PageController();
  final _nameController = TextEditingController();

  int _step = 0;
  DateTime? _lastPeriod;
  DateTime? _pickerAnchor;
  int _periodLength = 5;
  int _cycleLength = 28;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider);
    _nameController.text = profile.name;
    _periodLength = profile.periodLength;
    _cycleLength = profile.cycleLength;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _goTo(int step) {
    FocusScope.of(context).unfocus();
    setState(() => _step = step);
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> _finish() async {
    if (_saving) return;
    setState(() => _saving = true);

    final today = ref.read(todayProvider);
    final lastPeriod = _lastPeriod;

    await ref.read(profileProvider.notifier).save(
          UserProfile(
            name: _nameController.text.trim(),
            cycleLength: _cycleLength,
            periodLength: _periodLength,
            onboardingDone: true,
          ),
        );

    if (lastPeriod != null) {
      await ref
          .read(logsProvider.notifier)
          .markPeriod(lastPeriod, _periodLength, notAfter: today);
    }

    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>();
    final l10n = AppLocalizations.of(context)!;
    final subtitleColor = moon?.subtitle ?? theme.colorScheme.onSurfaceVariant;

    final calendar = ref.watch(appCalendarProvider);
    final today = ref.watch(todayProvider);
    final isLast = _step == _stepCount - 1;

    Widget heading(String title, String body) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: subtitleColor,
              height: 1.6,
            ),
          ),
        ],
      );
    }

    Widget page(List<Widget> children) {
      return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ---------- نوار پیشرفت ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 4),
              child: Row(
                children: [
                  for (var i = 0; i < _stepCount; i++)
                    Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        height: 5,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: i <= _step
                              ? theme.colorScheme.primary
                              : theme.dividerColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // ---------- ۱) خوش‌آمد ----------
                  page([
                    const SizedBox(height: 12),
                    Text(
                      'Little Moon',
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    heading(l10n.onboardingWelcomeTitle, l10n.onboardingWelcomeBody),
                    const SizedBox(height: 28),
                    Text(
                      l10n.language,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const LanguagePicker(),
                    const SizedBox(height: 24),
                    Text(
                      l10n.yourName,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _nameController,
                      maxLength: 30,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: l10n.nameHint,
                        counterText: '',
                        filled: true,
                        fillColor: theme.colorScheme.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: theme.dividerColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: theme.dividerColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.shield_outlined,
                          size: 16,
                          color: subtitleColor,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.privacyNote,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: subtitleColor,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),

                  // ---------- ۲) آخرین پریود ----------
                  page([
                    heading(l10n.lastPeriodQuestion, l10n.lastPeriodHint),
                    const SizedBox(height: 16),
                    _LastPeriodPicker(
                      calendar: calendar,
                      today: today,
                      anchor: _pickerAnchor ?? _lastPeriod ?? today,
                      selected: _lastPeriod,
                      onAnchorChanged: (date) =>
                          setState(() => _pickerAnchor = date),
                      onSelected: (date) =>
                          setState(() => _lastPeriod = date),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          setState(() => _lastPeriod = null);
                          _goTo(2);
                        },
                        child: Text(l10n.dontRemember),
                      ),
                    ),
                  ]),

                  // ---------- ۳) طول پریود ----------
                  page([
                    heading(l10n.periodLengthQuestion, l10n.periodLengthHint),
                    const SizedBox(height: 48),
                    Center(
                      child: NumberStepper(
                        value: _periodLength,
                        min: UserProfile.minPeriodLength,
                        max: UserProfile.maxPeriodLength,
                        unit: l10n.days,
                        onChanged: (value) =>
                            setState(() => _periodLength = value),
                      ),
                    ),
                  ]),

                  // ---------- ۴) طول چرخه ----------
                  page([
                    heading(l10n.cycleLengthQuestion, l10n.cycleLengthHint),
                    const SizedBox(height: 48),
                    Center(
                      child: NumberStepper(
                        value: _cycleLength,
                        min: UserProfile.minCycleLength,
                        max: UserProfile.maxCycleLength,
                        unit: l10n.days,
                        onChanged: (value) =>
                            setState(() => _cycleLength = value),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      l10n.medicalDisclaimer,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: subtitleColor,
                        height: 1.6,
                      ),
                    ),
                  ]),
                ],
              ),
            ),

            // ---------- دکمه‌ها ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
              child: Row(
                children: [
                  if (_step > 0)
                    TextButton(
                      onPressed: () => _goTo(_step - 1),
                      child: Text(l10n.back),
                    ),
                  const Spacer(),
                  SizedBox(
                    height: 52,
                    child: FilledButton(
                      onPressed: _saving
                          ? null
                          : (isLast ? _finish : () => _goTo(_step + 1)),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Text(
                        isLast ? l10n.getStarted : l10n.next,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LastPeriodPicker extends StatelessWidget {
  final AppCalendar calendar;
  final DateTime today;
  final DateTime anchor;
  final DateTime? selected;
  final ValueChanged<DateTime> onAnchorChanged;
  final ValueChanged<DateTime> onSelected;

  const _LastPeriodPicker({
    required this.calendar,
    required this.today,
    required this.anchor,
    required this.selected,
    required this.onAnchorChanged,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final month = calendar.monthOf(anchor);
    final nextMonthStart = calendar.firstDayOf(calendar.next(month));
    final canGoNext = !nextMonthStart.isAfter(today);

    return Column(
      children: [
        MonthNavigator(
          label: calendar.monthYear(month),
          onPrevious: () =>
              onAnchorChanged(calendar.firstDayOf(calendar.previous(month))),
          onNext: canGoNext ? () => onAnchorChanged(nextMonthStart) : null,
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
    );
  }
}
