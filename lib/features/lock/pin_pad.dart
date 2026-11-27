import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/digits.dart';
import 'package:little_moon/domain/services/app_lock.dart';

/// صفحه‌کلید عددی برای وارد کردن رمز.
///
/// به‌جای کیبورد گوشی استفاده می‌شه تا جای رمز روی صفحه ثابت و
/// قابل پیش‌بینی باشه و رمز داخل هیچ فیلد متنی‌ای نمونه.
class PinPad extends StatefulWidget {
  /// وقتی هر [appLockPinLength] رقم وارد شد صدا زده می‌شه. اگه `false`
  /// برگردونه، نقطه‌ها می‌لرزن و پاک می‌شن.
  final bool Function(String pin) onCompleted;

  /// دکمه‌ی اختیاری گوشه‌ی پایین (مثلاً اثر انگشت).
  final Widget? extraKey;

  final bool enabled;

  /// رنگ متن و نقطه‌ها؛ پیش‌فرض رنگ متن تم.
  final Color? color;

  const PinPad({
    super.key,
    required this.onCompleted,
    this.extraKey,
    this.enabled = true,
    this.color,
  });

  @override
  State<PinPad> createState() => _PinPadState();
}

class _PinPadState extends State<PinPad> with SingleTickerProviderStateMixin {
  String _pin = '';

  late final AnimationController _shake = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 380),
  );

  @override
  void dispose() {
    _shake.dispose();
    super.dispose();
  }

  void _press(int digit) {
    if (!widget.enabled || _pin.length >= appLockPinLength) return;
    HapticFeedback.selectionClick();
    setState(() => _pin += '$digit');

    if (_pin.length == appLockPinLength) {
      final pin = _pin;
      // یک فریم صبر می‌کنیم تا نقطه‌ی آخر هم پر دیده بشه
      Future<void>.delayed(const Duration(milliseconds: 120), () {
        if (!mounted) return;
        final ok = widget.onCompleted(pin);
        if (!mounted) return;
        if (!ok) {
          HapticFeedback.vibrate();
          _shake.forward(from: 0);
        }
        setState(() => _pin = '');
      });
    }
  }

  void _backspace() {
    if (_pin.isEmpty) return;
    HapticFeedback.selectionClick();
    setState(() => _pin = _pin.substring(0, _pin.length - 1));
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? context.scheme.onSurface;
    final accent = context.scheme.primary;

    Widget key(Widget child, VoidCallback? onTap, {String? semantics}) {
      return Semantics(
        button: true,
        label: semantics,
        child: InkResponse(
          onTap: widget.enabled ? onTap : null,
          radius: 38,
          child: SizedBox(width: 72, height: 64, child: Center(child: child)),
        ),
      );
    }

    Widget digit(int value) => key(
      Text(
        context.n(value),
        style: context.text.headlineSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
      () => _press(value),
      semantics: '$value',
    );

    Widget row(List<Widget> children) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );

    final dots = AnimatedBuilder(
      animation: _shake,
      builder: (context, child) {
        // لرزش افقی کوتاه برای رمز اشتباه
        final t = _shake.value;
        final offset = t == 0 ? 0.0 : 10 * (1 - t) * _wave(t);
        return Transform.translate(offset: Offset(offset, 0), child: child);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < appLockPinLength; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              margin: const EdgeInsets.symmetric(horizontal: 9),
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i < _pin.length ? accent : Colors.transparent,
                border: Border.all(
                  color: i < _pin.length
                      ? accent
                      : color.withValues(alpha: 0.5),
                  width: 1.6,
                ),
              ),
            ),
        ],
      ),
    );

    // صفحه‌کلید عددی همیشه چپ‌به‌راست چیده می‌شه (مثل شماره‌گیر گوشی)
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          dots,
          const SizedBox(height: 28),
          row([digit(1), digit(2), digit(3)]),
          row([digit(4), digit(5), digit(6)]),
          row([digit(7), digit(8), digit(9)]),
          row([
            widget.extraKey ?? const SizedBox(width: 72, height: 64),
            digit(0),
            key(
              Icon(Icons.backspace_outlined, color: color, size: 22),
              _backspace,
              semantics: MaterialLocalizations.of(context).deleteButtonTooltip,
            ),
          ]),
        ],
      ),
    );
  }

  static double _wave(double t) {
    // سه رفت‌وبرگشت در طول انیمیشن
    const cycles = 3;
    final x = (t * cycles * 2) % 2;
    return x < 1 ? (x * 2 - 1) : (3 - x * 2);
  }
}
