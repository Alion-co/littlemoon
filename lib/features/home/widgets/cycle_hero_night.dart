import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/core/utils/haptics.dart';
import 'package:little_moon/domain/engine/cycle_models.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/animations/soft_motion.dart';
import 'package:little_moon/shared/widgets/glass.dart';

import 'cycle_ring.dart';
import 'moon_info_card.dart';
import 'phase_layout.dart';
import 'ring_drag.dart';

/// نمای شبِ کارت چرخه (تم شب): متن‌ها داخل حلقه‌ی شب.
///
/// لمس حلقه کارت کوچیک «فاصله تا پریود بعدی و بازه‌ی باروری» رو باز می‌کنه.
/// کشیدن انگشت روی حلقه، روز و فاز اون نقطه رو پیش‌نمایش می‌ده. ذرات ریز و
/// هاله‌ی ماه کوچک با یک AnimationController مشترک حرکت می‌کنن.
class HeroNightLayout extends StatefulWidget {
  final int currentDay;
  final String phaseText;
  final String status;
  final double cycleProgress;
  final CyclePhaseLayout layout;
  final CyclePhase phase;
  final String Function(CyclePhase phase) phaseLabel;
  final String? fertileText;
  final String? note;
  final VoidCallback? onInfoTap;

  const HeroNightLayout({
    super.key,
    required this.currentDay,
    required this.phaseText,
    required this.status,
    required this.cycleProgress,
    required this.layout,
    required this.phase,
    required this.phaseLabel,
    this.fertileText,
    this.note,
    this.onInfoTap,
  });

  @override
  State<HeroNightLayout> createState() => _HeroNightLayoutState();
}

class _HeroNightLayoutState extends State<HeroNightLayout>
    with SingleTickerProviderStateMixin {
  late final AnimationController _clock = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 20),
  );

  bool _showCard = false;
  double? _drag;
  CyclePhase? _dragPhase;
  Duration _settle = const Duration(milliseconds: 1100);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (reduceMotion(context)) {
      _clock.stop();
    } else if (!_clock.isAnimating) {
      _clock.repeat();
    }
  }

  @override
  void dispose() {
    _clock.dispose();
    super.dispose();
  }

  void _toggleCard() {
    Haptics.success();
    setState(() => _showCard = !_showCard);
  }

  void _onDrag(double fraction) {
    final phase = widget.layout.phaseAt(fraction);
    if (_dragPhase != null && _dragPhase != phase) Haptics.tap();
    _dragPhase = phase;
    setState(() => _drag = fraction);
  }

  void _onDragEnd() {
    _dragPhase = null;
    setState(() {
      _drag = null;
      _settle = const Duration(milliseconds: 700);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final moon = context.moon!;
    final noteText = widget.note;
    final soft = Colors.white.withValues(alpha: 0.78);
    final motion = !reduceMotion(context);

    final drag = _drag;
    final shown = drag ?? widget.cycleProgress;
    final day = drag == null ? widget.currentDay : widget.layout.dayAt(drag);
    final phase = drag == null ? widget.phase : widget.layout.phaseAt(drag);
    final phaseText = drag == null
        ? widget.phaseText
        : widget.phaseLabel(phase);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
      decoration: homeCardDecoration(context, radius: 28),
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 224, maxHeight: 224),
            child: AspectRatio(
              aspectRatio: 1,
              child: RingDragDetector(
                ringInset: 14,
                innerReach: 24,
                outerReach: 24,
                onFraction: _onDrag,
                onEnd: _onDragEnd,
                onTap: _toggleCard,
                child: Breathing(
                  scale: 1.02,
                  child: AnimatedProgress(
                    value: shown,
                    duration: drag != null ? Duration.zero : _settle,
                    builder: (context, progress) => Stack(
                      fit: StackFit.expand,
                      children: [
                        RepaintBoundary(
                          child: CustomPaint(
                            painter: NightRingPainter(
                              progress: progress,
                              startColor: context.scheme.secondary,
                              endColor: context.scheme.primary,
                              layout: widget.layout,
                            ),
                          ),
                        ),
                        CustomPaint(
                          painter: NightKnobPainter(
                            progress: progress,
                            phase: phase,
                            clock: _clock,
                            motion: motion,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 34),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SoftSwitcher(
                                alignment: Alignment.center,
                                child: Text(
                                  context.n(l10n.dayOfCycle(day)),
                                  key: ValueKey(day),
                                  style: context.text.headlineMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    height: 1.1,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SoftSwitcher(
                                alignment: Alignment.center,
                                child: Row(
                                  key: ValueKey(phaseText),
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: CyclePhaseLayout.colorOf(phase),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Flexible(
                                      child: Text(
                                        phaseText,
                                        textAlign: TextAlign.center,
                                        style: context.text.titleSmall
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 2),
                              GestureDetector(
                                onTap: widget.onInfoTap,
                                behavior: HitTestBehavior.opaque,
                                child: Text(
                                  widget.status,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: context.text.labelSmall?.copyWith(
                                    color: soft,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedSize(
            duration: reduceMotion(context)
                ? Duration.zero
                : const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: _showCard
                ? Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: MoonInfoCard(
                      dark: true,
                      status: widget.status,
                      fertileText: widget.fertileText,
                      onTap: _toggleCard,
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
          if (noteText != null) ...[
            const SizedBox(height: 10),
            Text(
              noteText,
              textAlign: TextAlign.center,
              style: context.text.bodySmall?.copyWith(color: moon.subtitle),
            ),
          ],
        ],
      ),
    );
  }
}
