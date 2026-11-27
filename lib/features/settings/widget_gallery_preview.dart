part of 'widget_gallery.dart';

/// پیش‌نمایش ویجت ۲×۲ (همون طراحی ویجت اندروید) با رنگ تم فعلی:
/// تم تیره کارت شبِ هیرو، تم روشن کارت روزِ هیرو.
class _SquarePreview extends StatelessWidget {
  final _WidgetData data;

  const _SquarePreview({required this.data});

  @override
  Widget build(BuildContext context) => isNightTheme(context)
      ? _NightPreview(data: data)
      : _DayPreview(data: data);
}

/// کارت شب: شیشه‌ی نیمه‌شفاف روی آسمان تم، با کادر حلقه‌ی ۸۷٫۵٪ (۲۲۴ از
/// ۲۵۶) و حلقه و متن‌هایی که روی بوم ۲۲۴ پیکسلیِ هیرو کشیده و کوچیک می‌شن.
class _NightPreview extends StatelessWidget {
  final _WidgetData data;

  const _NightPreview({required this.data});

  @override
  Widget build(BuildContext context) {
    final bg = context.theme.scaffoldBackgroundColor;
    final heroStart = context.moon?.heroStart ?? context.scheme.surface;

    return Container(
      decoration: BoxDecoration(
        borderRadius: AppRadius.br28,
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [heroStart, Color.lerp(heroStart, bg, 0.6)!, bg],
        ),
      ),
      foregroundDecoration: BoxDecoration(
        borderRadius: AppRadius.br28,
        color: Colors.white.withValues(alpha: 0.07),
      ),
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.875,
          heightFactor: 0.875,
          child: FittedBox(child: _HeroRing(data: data)),
        ),
      ),
    );
  }
}

/// حلقه‌ی هیرو شب با متن‌های داخلش، عیناً مثل `HeroNightLayout` (بدون حرکت).
class _HeroRing extends StatelessWidget {
  final _WidgetData data;

  const _HeroRing({required this.data});

  @override
  Widget build(BuildContext context) {
    final phase = data.phase;
    final phaseColor = data.phaseColor;
    final status = data.status;

    return SizedBox(
      width: 224,
      height: 224,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: NightRingPainter(
              progress: data.progress,
              startColor: context.scheme.secondary,
              endColor: context.scheme.primary,
              layout: data.layout,
            ),
          ),
          CustomPaint(
            painter: NightKnobPainter(
              progress: data.progress,
              phase: data.ringPhase,
              clock: kAlwaysDismissedAnimation,
              motion: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.day,
                  style: context.text.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 1.1,
                  ),
                ),
                if (phase != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (phaseColor != null) ...[
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: phaseColor,
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                      Flexible(
                        child: Text(
                          phase,
                          textAlign: TextAlign.center,
                          style: context.text.titleSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                if (status != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    status,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: context.text.labelSmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.78),
                      height: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// کارت روز: گرادیان heroStart → heroEnd تم، ماه با مدار و ستاره‌ها، «روز |
/// فاز»، نوار فازها و وضعیت؛ همان اجزای `HeroDayLayout` در یک مربع.
class _DayPreview extends StatelessWidget {
  final _WidgetData data;

  const _DayPreview({required this.data});

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    final moon = context.moon!;
    final deepEnd = Color.lerp(moon.heroEnd, scheme.primary, 0.14)!;
    final rtl = Directionality.of(context) == TextDirection.rtl;
    final phase = data.phase;
    final phaseColor = data.phaseColor;
    final status = data.status;

    return LayoutBuilder(
      builder: (context, box) {
        final side = box.maxWidth;
        return Container(
          padding: EdgeInsets.all(side * 0.075),
          decoration: BoxDecoration(
            borderRadius: AppRadius.br24,
            border: Border.all(
              color: context.theme.dividerColor.withValues(alpha: 0.5),
            ),
            gradient: LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
              colors: [moon.heroStart, moon.heroEnd, deepEnd],
              stops: const [0.0, 0.55, 1.0],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: FittedBox(child: _DayMoon(data: data)),
              ),
              // «روز ۱۴ | فاز»؛ بدون فاز (حالت مخفی یا بدون داده) فقط یک متن
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text.rich(
                  TextSpan(
                    children: [
                      if (phaseColor != null) ...[
                        TextSpan(
                          text: data.day,
                          style: TextStyle(color: scheme.onSurface),
                        ),
                        TextSpan(
                          text: '  |  ',
                          style: TextStyle(
                            color: context.subtitle.withValues(alpha: 0.45),
                          ),
                        ),
                        TextSpan(
                          text: phase,
                          style: TextStyle(
                            // رنگ فاز روی زمینه‌ی روشن کمی تیره‌تر
                            color: Color.lerp(phaseColor, Colors.black, 0.28),
                          ),
                        ),
                      ] else
                        TextSpan(
                          text: phase ?? data.day,
                          style: TextStyle(color: scheme.onSurface),
                        ),
                    ],
                  ),
                  maxLines: 1,
                  style: context.text.titleSmall?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
              ),
              if (phaseColor != null) ...[
                const SizedBox(height: 5),
                AspectRatio(
                  aspectRatio: 200 / 16,
                  child: FittedBox(
                    child: SizedBox(
                      width: 200,
                      height: 16,
                      child: CustomPaint(
                        painter: PhaseBarPainter(
                          progress: data.progress,
                          layout: data.layout,
                          phase: data.ringPhase,
                          rtl: rtl,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              if (status != null && phaseColor != null) ...[
                const SizedBox(height: 2),
                Text(
                  status,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.labelSmall?.copyWith(
                    fontSize: (side * 0.062).clamp(8.5, 14.0),
                    color: context.subtitle,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

/// ماه هیرو روز روی بوم ۱۰۰×۱۰۰ (ماه ۷۶ + هاله‌ی نرم)، همان `MoonArt` بدون حرکت.
class _DayMoon extends StatelessWidget {
  final _WidgetData data;

  const _DayMoon({required this.data});

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    return Container(
      width: 100,
      height: 100,
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
      child: SizedBox.square(
        dimension: 76,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: MoonCrescentPainter(
                progress: data.progress,
                startColor: scheme.primary,
                endColor: scheme.secondary,
                layout: data.layout,
                phase: data.ringPhase,
              ),
            ),
            CustomPaint(
              painter: MoonSkyPainter(
                progress: data.progress,
                startColor: scheme.primary,
                clock: kAlwaysDismissedAnimation,
                motion: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
