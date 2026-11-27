import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/localization/calendar_provider.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/data/models/user_profile.dart';
import 'package:little_moon/data/repositories/log_repository.dart';
import 'package:little_moon/data/repositories/profile_repository.dart';
import 'package:little_moon/domain/services/cycle_providers.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';

import 'steps/last_period_step.dart';
import 'steps/length_step.dart';
import 'steps/name_step.dart';
import 'steps/onboarding_chrome.dart';
import 'steps/welcome_step.dart';

/// راه‌اندازی اولیه: خوش‌آمد ← اسم (و آواتار و زبان) ← آخرین پریود ←
/// طول پریود ← طول چرخه.
class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  // صفحه‌ی خوش‌آمد (۰) جزو نوار پیشرفت نیست؛ بقیه ۴ مرحله‌ان.
  static const _pageCount = 5;
  static const _periodLengthPage = 3;

  final _pageController = PageController();
  final _nameController = TextEditingController();

  int _page = 0;
  int _avatar = 0;
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
    _avatar = profile.avatar;
    _periodLength = profile.periodLength;
    _cycleLength = profile.cycleLength;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _goTo(int page) {
    FocusScope.of(context).unfocus();
    setState(() => _page = page);
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> _finish() async {
    if (_saving) return;
    setState(() => _saving = true);

    final today = ref.read(todayProvider);
    final lastPeriod = _lastPeriod;

    await ref
        .read(profileProvider.notifier)
        .save(
          ref
              .read(profileProvider)
              .copyWith(
                name: _nameController.text.trim(),
                avatar: _avatar,
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
    final l10n = AppLocalizations.of(context)!;

    final calendar = ref.watch(appCalendarProvider);
    final today = ref.watch(todayProvider);
    final isWelcome = _page == 0;
    final isLast = _page == _pageCount - 1;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: OnboardingBackground(
        child: SafeArea(
          child: Column(
            children: [
              if (!isWelcome)
                OnboardingTopBar(
                  stepCount: _pageCount - 1,
                  current: _page - 1,
                  onBack: () => _goTo(_page - 1),
                ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const WelcomeStep(),
                    NameStep(
                      nameController: _nameController,
                      avatar: _avatar,
                      onAvatarChanged: (id) => setState(() => _avatar = id),
                    ),
                    LastPeriodStep(
                      calendar: calendar,
                      today: today,
                      anchor: _pickerAnchor ?? _lastPeriod ?? today,
                      selected: _lastPeriod,
                      onAnchorChanged: (date) =>
                          setState(() => _pickerAnchor = date),
                      onSelected: (date) => setState(() => _lastPeriod = date),
                      onDontRemember: () {
                        setState(() => _lastPeriod = null);
                        _goTo(_periodLengthPage);
                      },
                    ),
                    LengthStep(
                      title: l10n.periodLengthQuestion,
                      hint: l10n.periodLengthHint,
                      value: _periodLength,
                      min: UserProfile.minPeriodLength,
                      max: UserProfile.maxPeriodLength,
                      onChanged: (value) =>
                          setState(() => _periodLength = value),
                    ),
                    LengthStep(
                      title: l10n.cycleLengthQuestion,
                      hint: l10n.cycleLengthHint,
                      value: _cycleLength,
                      min: UserProfile.minCycleLength,
                      max: UserProfile.maxCycleLength,
                      onChanged: (value) =>
                          setState(() => _cycleLength = value),
                      footer: Text(
                        l10n.medicalDisclaimer,
                        textAlign: TextAlign.center,
                        style: context.text.bodySmall?.copyWith(
                          color: context.subtitle,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              OnboardingPillButton(
                label: isWelcome || isLast ? l10n.getStarted : l10n.next,
                busy: _saving,
                onPressed: isLast ? _finish : () => _goTo(_page + 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
