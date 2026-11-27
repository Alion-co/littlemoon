import 'package:flutter/material.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/core/utils/haptics.dart';
import 'package:little_moon/core/utils/math_utils.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';

/// متن مقدار خواب (مثل «۷ ساعت و ۳۰ دقیقه»)؛ برای کنار برچسب فیلد.
class SleepValueLabel extends StatelessWidget {
  final int? minutes;
  final VoidCallback onClear;

  const SleepValueLabel({
    super.key,
    required this.minutes,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final value = minutes;
    if (value == null) {
      return Text(
        l10n.notSet,
        style: context.text.labelMedium?.copyWith(
          fontSize: 12,
          color: context.subtitle.withValues(alpha: 0.7),
        ),
      );
    }
    return GestureDetector(
      onTap: onClear,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.n(Labels.sleep(l10n, value)),
            style: context.text.labelLarge?.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: context.scheme.primary,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.close_rounded,
            size: 15,
            color: context.subtitle.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
  }
}

/// مدت خواب (گام‌های ۳۰ دقیقه‌ای، ۰ تا ۱۲ ساعت)؛ `null` یعنی ثبت نشده.
class SleepControl extends StatelessWidget {
  final int? minutes;
  final ValueChanged<int?> onChanged;

  const SleepControl({
    super.key,
    required this.minutes,
    required this.onChanged,
  });

  static const _tickHours = [0, 3, 6, 9, 12];

  @override
  Widget build(BuildContext context) {
    final primary = context.scheme.primary;
    final value = minutes;

    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 5,
            activeTrackColor: primary.withValues(alpha: value == null ? 0.25 : 0.8),
            inactiveTrackColor: primary.withValues(alpha: 0.14),
            thumbColor: primary,
            overlayColor: primary.withValues(alpha: 0.10),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
            thumbShape: const _RingThumbShape(),
            trackShape: const RoundedRectSliderTrackShape(),
            tickMarkShape: SliderTickMarkShape.noTickMark,
          ),
          child: Slider(
            value: clampDouble((value ?? 0) / 30, 0, 24),
            min: 0,
            max: 24,
            divisions: 24,
            onChanged: (v) {
              final next = v.round() * 30;
              if (next != value) Haptics.tap();
              onChanged(next);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final hour in _tickHours)
                Text(
                  context.n('$hour'),
                  style: context.text.labelSmall?.copyWith(
                    fontSize: 11,
                    color: context.subtitle.withValues(alpha: 0.75),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// دستگیره‌ی اسلایدر: دایره‌ی رنگی با حلقه‌ی سفید و سایه‌ی نرم.
class _RingThumbShape extends SliderComponentShape {
  const _RingThumbShape();

  static const _outer = 12.0;
  static const _inner = 8.5;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      const Size.fromRadius(_outer);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    canvas.drawCircle(
      center.translate(0, 1.5),
      _outer,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.14)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );
    canvas.drawCircle(center, _outer, Paint()..color = Colors.white);
    canvas.drawCircle(
      center,
      _inner,
      Paint()..color = sliderTheme.thumbColor ?? Colors.pink,
    );
  }
}
