part of 'charts.dart';

/// تبدیل مقدار و اندیس به مختصات داخل ناحیه‌ی نمودار.
class _Scale {
  final Rect plot;
  final double low;
  final double high;
  final int count;

  const _Scale(this.plot, this.low, this.high, this.count);

  double y(double value) =>
      plot.bottom - (value - low) / (high - low) * plot.height;

  double x(int index) => count == 1
      ? plot.center.dx
      : plot.left + index / (count - 1) * plot.width;

  /// مرکز ستون i وقتی نمودار ستونیه.
  double barCenter(int index) => plot.left + plot.width / count * (index + 0.5);
}

class _ChartPainter extends CustomPainter {
  final List<ChartPoint> points;
  final Color color;
  final Color gridColor;
  final TextStyle labelStyle;
  final Color surface;
  final String Function(double) formatValue;
  final String Function(DateTime) formatDate;
  final double? reference;
  final bool bars;
  final int? selected;
  final TextDirection textDirection;

  _ChartPainter({
    required this.points,
    required this.color,
    required this.gridColor,
    required this.labelStyle,
    required this.surface,
    required this.formatValue,
    required this.formatDate,
    required this.reference,
    required this.bars,
    required this.selected,
    required this.textDirection,
  });

  static const _leftGutter = 38.0;
  static const _bottomGutter = 20.0;
  static const _topPad = 8.0;

  static Rect plotRect(Size size) => Rect.fromLTRB(
    _leftGutter,
    _topPad,
    size.width - 6,
    size.height - _bottomGutter,
  );

  void _text(Canvas canvas, String text, Offset at, {TextAlign? align}) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: labelStyle),
      textDirection: textDirection,
      maxLines: 1,
    )..layout();
    var dx = at.dx;
    if (align == TextAlign.right) dx -= painter.width;
    if (align == TextAlign.center) dx -= painter.width / 2;
    painter.paint(canvas, Offset(dx, at.dy - painter.height / 2));
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;
    final plot = plotRect(size);
    final scale = _scaleFor(plot);

    _drawGrid(canvas, scale);
    _drawReference(canvas, scale);
    if (bars) {
      _drawBars(canvas, scale);
    } else {
      _drawLine(canvas, scale);
    }
    _drawSelection(canvas, scale);
    _drawDates(canvas, plot);
  }

  /// بازه‌ی محور عمودی از روی داده، خط مرجع و حالت ستونی.
  _Scale _scaleFor(Rect plot) {
    var minValue = points.map((p) => p.value).reduce(math.min);
    var maxValue = points.map((p) => p.value).reduce(math.max);
    final ref = reference;
    if (ref != null) {
      minValue = math.min(minValue, ref);
      maxValue = math.max(maxValue, ref);
    }
    if (bars) minValue = math.min(0, minValue);
    if (maxValue - minValue < 1e-6) {
      maxValue += 1;
      minValue -= bars ? 0 : 1;
    }
    final padding = bars ? 0.0 : (maxValue - minValue) * 0.12;
    return _Scale(plot, minValue - padding, maxValue + padding, points.length);
  }

  /// سه خط راهنمای کم‌رنگ با برچسب مقدار.
  void _drawGrid(Canvas canvas, _Scale s) {
    final grid = Paint()
      ..color = gridColor
      ..strokeWidth = 1;
    for (var i = 0; i <= 2; i++) {
      final value = s.low + (s.high - s.low) * i / 2;
      final dy = s.y(value);
      canvas.drawLine(Offset(s.plot.left, dy), Offset(s.plot.right, dy), grid);
      _text(
        canvas,
        formatValue(value),
        Offset(s.plot.left - 6, dy),
        align: TextAlign.right,
      );
    }
  }

  /// خط‌چین مرجع (مثلاً میانگین).
  void _drawReference(Canvas canvas, _Scale s) {
    final ref = reference;
    if (ref == null) return;
    final dy = s.y(ref);
    final dash = Paint()
      ..color = color.withValues(alpha: 0.55)
      ..strokeWidth = 1.2;
    for (var dx = s.plot.left; dx < s.plot.right; dx += 8) {
      canvas.drawLine(
        Offset(dx, dy),
        Offset(math.min(dx + 4, s.plot.right), dy),
        dash,
      );
    }
  }

  void _drawBars(Canvas canvas, _Scale s) {
    final slot = s.plot.width / points.length;
    final width = math.min(22.0, slot - 4);
    for (var i = 0; i < points.length; i++) {
      final cx = s.plot.left + slot * (i + 0.5);
      final top = s.y(points[i].value);
      final rect = RRect.fromRectAndCorners(
        Rect.fromLTRB(cx - width / 2, top, cx + width / 2, s.plot.bottom),
        topLeft: const Radius.circular(4),
        topRight: const Radius.circular(4),
      );
      canvas.drawRRect(
        rect,
        Paint()..color = color.withValues(alpha: selected == i ? 1 : 0.7),
      );
    }
  }

  void _drawLine(Canvas canvas, _Scale s) {
    final line = Path();
    for (var i = 0; i < points.length; i++) {
      final offset = Offset(s.x(i), s.y(points[i].value));
      if (i == 0) {
        line.moveTo(offset.dx, offset.dy);
      } else {
        line.lineTo(offset.dx, offset.dy);
      }
    }
    canvas.drawPath(
      line,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round,
    );
    // نقطه‌ها فقط وقتی داده کمه کشیده می‌شن تا نمودار شلوغ نشه
    if (points.length <= 40) {
      for (var i = 0; i < points.length; i++) {
        final center = Offset(s.x(i), s.y(points[i].value));
        canvas.drawCircle(center, 4, Paint()..color = surface);
        canvas.drawCircle(center, 3, Paint()..color = color);
      }
    }
  }

  /// خط عمودی و نقطه‌ی بزرگ‌تر برای مقدار انتخاب‌شده.
  void _drawSelection(Canvas canvas, _Scale s) {
    final index = selected;
    if (index == null || index >= points.length) return;
    final cx = bars ? s.barCenter(index) : s.x(index);
    canvas.drawLine(
      Offset(cx, s.plot.top),
      Offset(cx, s.plot.bottom),
      Paint()
        ..color = color.withValues(alpha: 0.35)
        ..strokeWidth = 1,
    );
    if (!bars) {
      final center = Offset(cx, s.y(points[index].value));
      canvas.drawCircle(center, 6, Paint()..color = surface);
      canvas.drawCircle(center, 4.5, Paint()..color = color);
    }
  }

  /// محور زمان: اولین و آخرین تاریخ.
  void _drawDates(Canvas canvas, Rect plot) {
    final labelY = plot.bottom + _bottomGutter / 2 + 2;
    _text(canvas, formatDate(points.first.date), Offset(plot.left, labelY));
    if (points.length > 1) {
      _text(
        canvas,
        formatDate(points.last.date),
        Offset(plot.right, labelY),
        align: TextAlign.right,
      );
    }
  }

  @override
  bool shouldRepaint(_ChartPainter old) =>
      old.points != points ||
      old.selected != selected ||
      old.color != color ||
      old.reference != reference;
}
