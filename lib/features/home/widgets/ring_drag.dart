import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

/// کشیدن انگشت روی حلقه‌ی چرخه. فقط لمسی که روی خودِ حلقه شروع بشه
/// (با [innerReach] / [outerReach] از خط حلقه) گرفته می‌شه؛ بقیه‌ی صفحه و
/// اسکرول دست‌نخورده می‌مونه.
///
/// - کشیدن: [onFraction] با جای انگشت روی حلقه (۰ تا ۱، ساعت‌گرد از بالا)
///   و در پایان [onEnd].
/// - لمس ساده (بدون حرکت): [onTap].
class RingDragDetector extends StatelessWidget {
  final Widget child;

  /// فاصله‌ی خط حلقه از لبه‌ی کادر.
  final double ringInset;

  /// چقدر داخل و بیرون از خط حلقه هم لمس حساب بشه.
  final double innerReach;
  final double outerReach;

  final ValueChanged<double> onFraction;
  final VoidCallback onEnd;
  final VoidCallback? onTap;

  const RingDragDetector({
    super.key,
    required this.child,
    required this.ringInset,
    required this.innerReach,
    required this.outerReach,
    required this.onFraction,
    required this.onEnd,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final center = Offset(constraints.maxWidth / 2, constraints.maxHeight / 2);
        final radius =
            math.min(constraints.maxWidth, constraints.maxHeight) / 2 - ringInset;

        return RawGestureDetector(
          behavior: HitTestBehavior.translucent,
          gestures: <Type, GestureRecognizerFactory>{
            _RingRecognizer:
                GestureRecognizerFactoryWithHandlers<_RingRecognizer>(
                  _RingRecognizer.new,
                  (recognizer) {
                    recognizer
                      ..center = center
                      ..minRadius = radius - innerReach
                      ..maxRadius = radius + outerReach
                      ..onFraction = onFraction
                      ..onEnd = onEnd
                      ..onTap = onTap;
                  },
                ),
          },
          child: child,
        );
      },
    );
  }
}

class _RingRecognizer extends OneSequenceGestureRecognizer {
  Offset center = Offset.zero;
  double minRadius = 0;
  double maxRadius = 0;
  ValueChanged<double>? onFraction;
  VoidCallback? onEnd;
  VoidCallback? onTap;

  Offset? _down;
  bool _moved = false;

  @override
  void addAllowedPointer(PointerDownEvent event) {
    final distance = (event.localPosition - center).distance;
    if (distance < minRadius || distance > maxRadius) return;

    startTrackingPointer(event.pointer, event.transform);
    // لمسِ روی حلقه همون لحظه مال ماست (اسکرول صفحه وسط کشیدن دخالت نکنه)
    resolve(GestureDisposition.accepted);
    _down = event.localPosition;
    _moved = false;
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerMoveEvent) {
      final start = _down;
      if (start == null) return;
      if (!_moved && (event.localPosition - start).distance > 8) _moved = true;
      if (_moved) onFraction?.call(_fractionOf(event.localPosition));
    } else if (event is PointerUpEvent) {
      final moved = _moved;
      stopTrackingPointer(event.pointer);
      if (moved) {
        onEnd?.call();
      } else {
        onTap?.call();
      }
    } else if (event is PointerCancelEvent) {
      final moved = _moved;
      stopTrackingPointer(event.pointer);
      if (moved) onEnd?.call();
    }
  }

  double _fractionOf(Offset point) {
    final v = point - center;
    const twoPi = math.pi * 2;
    var angle = (math.atan2(v.dy, v.dx) + math.pi / 2) % twoPi;
    if (angle < 0) angle += twoPi;
    return angle / twoPi;
  }

  @override
  void didStopTrackingLastPointer(int pointer) {
    _down = null;
    _moved = false;
  }

  @override
  String get debugDescription => 'ringDrag';
}
