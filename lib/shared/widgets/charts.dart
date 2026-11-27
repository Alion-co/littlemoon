import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/theme_context.dart';

part 'chart_painter.dart';

/// یک نقطه‌ی نمودار: برچسب (معمولاً تاریخ) + مقدار.
class ChartPoint {
  final DateTime date;
  final double value;

  /// متن کامل این نقطه برای وقتی که لمس می‌شه، مثل «۲۵ مهر · ۵۸٫۵ کیلوگرم».
  final String label;

  const ChartPoint(this.date, this.value, this.label);
}

/// نمودار خطی ساده و سبک برای یک سری داده (وزن، خواب، دما).
///
/// بدون کتابخونه‌ی جانبی: خط ۲ پیکسلی، نقطه‌های کوچک، سه خط راهنمای
/// کم‌رنگ و برچسب کمینه/بیشینه. با لمس هر جای نمودار نزدیک‌ترین نقطه
/// انتخاب و مقدارش بالای نمودار نوشته می‌شه.
class SimpleLineChart extends StatefulWidget {
  final List<ChartPoint> points;
  final Color color;

  /// متن محورها (مثلاً عدد با رقم فارسی).
  final String Function(double value) formatValue;
  final String Function(DateTime date) formatDate;

  /// خط افقی مرجع اختیاری (مثلاً میانگین).
  final double? reference;

  /// ستونی به‌جای خط (برای طول چرخه‌ها).
  final bool bars;

  final double height;

  const SimpleLineChart({
    super.key,
    required this.points,
    required this.color,
    required this.formatValue,
    required this.formatDate,
    this.reference,
    this.bars = false,
    this.height = 160,
  });

  @override
  State<SimpleLineChart> createState() => _SimpleLineChartState();
}

class _SimpleLineChartState extends State<SimpleLineChart> {
  int? _selected;

  @override
  void didUpdateWidget(SimpleLineChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.points.length != widget.points.length) _selected = null;
  }

  void _select(Offset position, Size size) {
    final count = widget.points.length;
    if (count == 0) return;
    final plot = _ChartPainter.plotRect(size);
    final t = ((position.dx - plot.left) / plot.width).clamp(0.0, 1.0);
    final index = count == 1 ? 0 : (t * (count - 1)).round();
    setState(() => _selected = index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = context.subtitle;
    final points = widget.points;
    final selected = _selected;

    final caption = selected != null && selected < points.length
        ? points[selected].label
        : (points.isEmpty ? '' : points.last.label);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // مقدار نقطه‌ی انتخاب‌شده (پیش‌فرض: آخرین مقدار)
        Text(
          caption,
          style: context.text.bodySmall?.copyWith(
            color: context.scheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        // محور زمان همیشه چپ‌به‌راست (قدیمی → جدید)
        Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            height: widget.height,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final size = Size(constraints.maxWidth, widget.height);
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: (d) => _select(d.localPosition, size),
                  onHorizontalDragUpdate: (d) => _select(d.localPosition, size),
                  child: CustomPaint(
                    size: size,
                    painter: _ChartPainter(
                      points: points,
                      color: widget.color,
                      gridColor: theme.dividerColor.withValues(alpha: 0.7),
                      labelStyle: context.text.labelSmall!.copyWith(
                        color: muted,
                        fontSize: 10,
                      ),
                      surface: context.scheme.surface,
                      formatValue: widget.formatValue,
                      formatDate: widget.formatDate,
                      reference: widget.reference,
                      bars: widget.bars,
                      selected: selected,
                      textDirection: Directionality.of(context),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
