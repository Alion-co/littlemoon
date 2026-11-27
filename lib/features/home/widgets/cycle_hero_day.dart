import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/core/utils/haptics.dart';
import 'package:little_moon/domain/engine/cycle_models.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/animations/soft_motion.dart';

import 'hero_day_parts.dart';
import 'moon_art.dart';
import 'moon_info_card.dart';
import 'phase_layout.dart';

/// نمای روزِ کارت چرخه (تم روشن): ستون متن (روز و فاز، با فاصله) و ماه با
/// هاله‌ی نرم. لمس کارت توضیح پیش‌بینی رو باز می‌کنه. جمله‌ی زیرش فقط
/// وقتی [note] داده بشه (مثلاً تأخیر یا بی‌نظمی) میاد.
///
/// لمس خودِ ماه یک کارت کوچیک باز می‌کنه (فاصله تا پریود بعدی [status] و
/// بازه‌ی باروری [fertileText]). کشیدن انگشت روی مدار، روز و فاز اون نقطه
/// رو پیش‌نمایش می‌ده.
class HeroDayLayout extends StatefulWidget {
  final int currentDay;
  final String phaseText;
  final double cycleProgress;
  final CyclePhaseLayout layout;
  final CyclePhase phase;
  final String Function(CyclePhase phase) phaseLabel;
  final String status;
  final String? fertileText;
  final String? note;
  final VoidCallback? onInfoTap;

  const HeroDayLayout({
    super.key,
    required this.currentDay,
    required this.phaseText,
    required this.cycleProgress,
    required this.layout,
    required this.phase,
    required this.phaseLabel,
    required this.status,
    this.fertileText,
    this.note,
    this.onInfoTap,
  });

  @override
  State<HeroDayLayout> createState() => _HeroDayLayoutState();
}

class _HeroDayLayoutState extends State<HeroDayLayout> {
  bool _showMoonCard = false;

  /// کسر روی مدار وقتی کاربر داره می‌کشه، وگرنه `null`.
  double? _preview;

  void _toggleMoonCard() {
    Haptics.success();
    setState(() => _showMoonCard = !_showMoonCard);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = context.scheme;
    final moon = context.moon!;
    final noteText = widget.note;

    final preview = _preview;
    final currentDay = preview == null
        ? widget.currentDay
        : widget.layout.dayAt(preview);
    final phaseText = preview == null
        ? widget.phaseText
        : widget.phaseLabel(widget.layout.phaseAt(preview));

    final shownPhase = preview == null
        ? widget.phase
        : widget.layout.phaseAt(preview);
    // رنگ فاز برای متن روی زمینه‌ی روشن کمی تیره‌تر می‌شه تا خوانا بمونه
    final phaseColor = Color.lerp(
      CyclePhaseLayout.colorOf(shownPhase),
      Colors.black,
      0.28,
    )!;

    // ماه روی گوشی‌های باریک کوچک‌تر می‌شه تا جای متن تنگ نشه
    final moonSize = (MediaQuery.sizeOf(context).width * 0.22)
        .clamp(72.0, 88.0)
        .toDouble();

    // سمتِ ماه کمی عمیق‌تر تا ماه از زمینه جدا بشه
    final deepEnd = Color.lerp(moon.heroEnd, scheme.primary, 0.14)!;

    return GestureDetector(
      onTap: widget.onInfoTap,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.fromSTEB(22, 16, 12, 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [moon.heroStart, moon.heroEnd, deepEnd],
                stops: const [0.0, 0.55, 1.0],
              ),
              borderRadius: AppRadius.br24,
              border: Border.all(
                color: context.theme.dividerColor.withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // «روز ۱۴ · فاز تخمک‌گذاری»
                          SoftSwitcher(
                            child: FittedBox(
                              key: ValueKey('$currentDay-$shownPhase'),
                              fit: BoxFit.scaleDown,
                              alignment: AlignmentDirectional.centerStart,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: context.n(
                                        l10n.dayOfCycle(currentDay),
                                      ),
                                      style: TextStyle(
                                        color: scheme.onSurface,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    // خط عمودی باریک به‌جای نقطه
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 9,
                                        ),
                                        child: Container(
                                          width: 1.5,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            color: context.subtitle.withValues(
                                              alpha: 0.45,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: phaseText,
                                      style: TextStyle(
                                        color: phaseColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                maxLines: 1,
                                style: context.text.titleLarge?.copyWith(
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // نوار فازها با نقطه‌ی امروز (پیش‌نمایشِ کشیدن را هم نشان می‌دهد)
                          AnimatedProgress(
                            value: preview ?? widget.cycleProgress,
                            duration: preview != null
                                ? Duration.zero
                                : const Duration(milliseconds: 1200),
                            builder: (context, value) => SizedBox(
                              height: 16,
                              width: double.infinity,
                              child: CustomPaint(
                                painter: PhaseBarPainter(
                                  progress: value,
                                  layout: widget.layout,
                                  phase: shownPhase,
                                  rtl: Directionality.of(context) ==
                                      TextDirection.rtl,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.status,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.text.bodyMedium?.copyWith(
                              color: context.subtitle,
                            ),
                          ),
                          if (noteText != null && preview == null) ...[
                            const SizedBox(height: 10),
                            HeroNote(text: noteText),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // هاله‌ی نرم و کمی پررنگ‌تر پشت ماه
                    Container(
                      width: moonSize + 24,
                      height: moonSize + 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            scheme.primary.withValues(alpha: 0.22),
                            scheme.primary.withValues(alpha: 0),
                          ],
                        ),
                      ),
                      child: MoonArt(
                        size: moonSize,
                        progress: widget.cycleProgress,
                        startColor: scheme.primary,
                        endColor: scheme.secondary,
                        layout: widget.layout,
                        phase: widget.phase,
                        onTap: _toggleMoonCard,
                        onPreview: (value) => setState(() => _preview = value),
                      ),
                    ),
                  ],
                ),
                AnimatedSize(
                  duration: reduceMotion(context)
                      ? Duration.zero
                      : const Duration(milliseconds: 260),
                  curve: Curves.easeOutCubic,
                  alignment: Alignment.topCenter,
                  child: _showMoonCard
                      ? Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: 10,
                            end: 10,
                          ),
                          child: MoonInfoCard(
                            status: widget.status,
                            fertileText: widget.fertileText,
                            onTap: _toggleMoonCard,
                          ),
                        )
                      : const SizedBox(width: double.infinity),
                ),
              ],
            ),
          ),
          // برق ملایمی که هر چند ثانیه روی کارت می‌کشه
          const Positioned.fill(
            child: IgnorePointer(
              child: ClipRRect(borderRadius: AppRadius.br24, child: _CardShimmer()),
            ),
          ),
        ],
      ),
    );
  }
}

/// برقِ ملایم: هر ~۹ ثانیه یک نوار نور مورب از کنار کارت رد می‌شه. با
/// «کاهش حرکت» خاموشه.
class _CardShimmer extends StatefulWidget {
  const _CardShimmer();

  @override
  State<_CardShimmer> createState() => _CardShimmerState();
}

class _CardShimmerState extends State<_CardShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 9),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (reduceMotion(context)) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ShimmerPainter(
        clock: _controller,
        motion: !reduceMotion(context),
        rtl: Directionality.of(context) == TextDirection.rtl,
      ),
    );
  }
}

class _ShimmerPainter extends CustomPainter {
  final Animation<double> clock;
  final bool motion;
  final bool rtl;

  _ShimmerPainter({
    required this.clock,
    required this.motion,
    required this.rtl,
  }) : super(repaint: clock);

  // بخشی از دور که نوار نور در جریانه (حدود ۱٫۴ ثانیه)
  static const _from = 0.78;
  static const _to = 0.94;

  @override
  void paint(Canvas canvas, Size size) {
    final t = clock.value;
    if (!motion || t < _from || t > _to) return;

    var u = Curves.easeInOut.transform((t - _from) / (_to - _from));
    if (rtl) u = 1 - u;
    final band = size.width * 0.35;
    final x = -band + (size.width + band) * u;
    final rect = Rect.fromLTWH(x, 0, band, size.height);

    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: const Alignment(-1, -0.4),
          end: const Alignment(1, 0.4),
          colors: [
            Colors.white.withValues(alpha: 0),
            Colors.white.withValues(alpha: 0.30),
            Colors.white.withValues(alpha: 0),
          ],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(_ShimmerPainter old) =>
      old.motion != motion || old.rtl != rtl;
}


/// نوار باریک فازها: چهار تکه به رنگ فازها، بخش گذشته پررنگ، ستاره‌ی طلایی روی
/// روز تخمک‌گذاری و نقطه‌ی امروز.
class PhaseBarPainter extends CustomPainter {
  final double progress;
  final CyclePhaseLayout layout;
  final CyclePhase phase;
  final bool rtl;

  const PhaseBarPainter({
    required this.progress,
    required this.layout,
    required this.phase,
    required this.rtl,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const pad = 6.0; // جا برای نقطه‌ی دو سر
    const track = 5.0;
    final w = size.width - pad * 2;
    final cy = size.height / 2;
    final p = progress.clamp(0.0, 1.0);

    double x(double f) => rtl ? pad + w * (1 - f) : pad + w * f;

    final edges = [0.0, ...layout.boundaries, 1.0];
    const phases = [
      CyclePhase.menstrual,
      CyclePhase.follicular,
      CyclePhase.ovulation,
      CyclePhase.luteal,
    ];

    for (var i = 0; i < 4; i++) {
      final a = edges[i];
      final b = edges[i + 1];
      final color = CyclePhaseLayout.colorOf(phases[i]);

      // تکه‌ی کامل کم‌رنگ
      final full = _segment(x(a), x(b), cy, track);
      canvas.drawRRect(full, Paint()..color = color.withValues(alpha: 0.28));

      // بخش گذشته‌ی همین تکه، پررنگ
      if (p > a) {
        final end = p < b ? p : b;
        canvas.drawRRect(
          _segment(x(a), x(end), cy, track),
          Paint()..color = color,
        );
      }
    }

    // ستاره‌ی روز تخمک‌گذاری
    canvas.drawPath(
      sparklePath(
        Offset(x(layout.ovulationFraction), cy - 7.5),
        3.6,
      ),
      Paint()..color = CyclePhaseLayout.colorOf(CyclePhase.ovulation),
    );

    // نقطه‌ی امروز
    final dot = Offset(x(p), cy);
    canvas.drawCircle(
      dot,
      7.5,
      Paint()
        ..shader = RadialGradient(
          colors: [
            CyclePhaseLayout.colorOf(phase).withValues(alpha: 0.40),
            CyclePhaseLayout.colorOf(phase).withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: dot, radius: 7.5)),
    );
    canvas.drawCircle(dot, 5, Paint()..color = Colors.white);
    canvas.drawCircle(
      dot,
      3.2,
      Paint()..color = CyclePhaseLayout.colorOf(phase),
    );
  }

  /// تکه‌ای بین دو x (ترتیب مهم نیست) با گوشه‌ی گرد.
  RRect _segment(double x1, double x2, double cy, double height) {
    final left = x1 < x2 ? x1 : x2;
    final right = x1 < x2 ? x2 : x1;
    // فاصله‌ی ریز بین تکه‌ها
    final rect = Rect.fromLTRB(left + 1, cy - height / 2, right - 1, cy + height / 2);
    return RRect.fromRectAndRadius(
      rect.width < 0 ? Rect.fromLTRB(left, rect.top, left, rect.bottom) : rect,
      Radius.circular(height / 2),
    );
  }

  @override
  bool shouldRepaint(PhaseBarPainter old) =>
      old.progress != progress ||
      old.layout != layout ||
      old.phase != phase ||
      old.rtl != rtl;
}
