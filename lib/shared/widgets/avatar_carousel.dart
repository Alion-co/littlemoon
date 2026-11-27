import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:little_moon/shared/animations/soft_motion.dart';
import 'package:little_moon/shared/widgets/user_avatar.dart';

/// ردیف افقیِ قطاری برای انتخاب آواتار (۰ = بدون آواتار، بعدش ۱ تا [avatarCount]).
///
/// کاربر باید بفهمه اون‌طرف هم آواتار هست، برای همین:
///  • لبه‌ای که هنوز آواتار داره محو می‌شه و آخرِ لیست که برسه محوی برمی‌گرده،
///  • یک فلش کوچیک کنار همون لبه آروم می‌رقصه تا کاربر اولین بار لمس کنه،
///  • بار اول، لیست یه‌کم خودش می‌ره جلو و برمی‌گرده («سرک کشیدن»).
/// با «کاهش حرکت» گوشی، فقط فلش ثابت می‌مونه. جهت لیست با RTL/LTR عوض می‌شه.
class AvatarCarousel extends StatefulWidget {
  final int selected;
  final ValueChanged<int> onChanged;

  /// شعاع هر آواتار.
  final double radius;

  /// رنگ حلقه‌ی انتخاب و فلش راهنما.
  final Color selectedColor;

  const AvatarCarousel({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.selectedColor,
    this.radius = 26,
  });

  @override
  State<AvatarCarousel> createState() => _AvatarCarouselState();
}

class _AvatarCarouselState extends State<AvatarCarousel> {
  static const _listPadding = 4.0;
  static const _gap = 8.0;
  // حاشیه‌ی داخلی (۳) + ضخامت حلقه (۲) در دو طرف
  static const _ring = 10.0;
  static const _edgeFade = 0.14;

  final _controller = ScrollController();
  Timer? _nudgeTimer;
  bool _atStart = true;
  bool _atEnd = false;
  bool _touched = false;

  double get _slot => widget.radius * 2 + _ring + _gap;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_controller.hasClients) return;
      _controller.jumpTo(_offsetFor(widget.selected));
      _onScroll();
      if (!reduceMotion(context) && _controller.position.pixels <= 2) {
        _nudgeTimer = Timer(const Duration(milliseconds: 700), _nudge);
      }
    });
  }

  @override
  void didUpdateWidget(AvatarCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected && _controller.hasClients) {
      final target = _offsetFor(widget.selected);
      if (reduceMotion(context)) {
        _controller.jumpTo(target);
      } else {
        _controller.animateTo(
          target,
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutCubic,
        );
      }
    }
  }

  @override
  void dispose() {
    _nudgeTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  /// جایی که آواتار [id] وسط ردیف بیفته (تا جایی که لیست اجازه بده).
  double _offsetFor(int id) {
    final position = _controller.position;
    final center = _listPadding + id * _slot + _slot / 2;
    return (center - position.viewportDimension / 2).clamp(
      0.0,
      position.maxScrollExtent,
    );
  }

  void _onScroll() {
    if (!_controller.hasClients) return;
    final position = _controller.position;
    final atStart = position.pixels <= 2;
    final atEnd = position.pixels >= position.maxScrollExtent - 2;
    if (atStart != _atStart || atEnd != _atEnd) {
      setState(() {
        _atStart = atStart;
        _atEnd = atEnd;
      });
    }
  }

  bool get _stopped => !mounted || _touched || !_controller.hasClients;

  /// سرک کشیدن: کمی می‌ره جلو و برمی‌گرده، مگه اینکه کاربر دست بزنه.
  Future<void> _nudge() async {
    if (_stopped) return;
    final peek = (_slot * 1.2).clamp(0.0, _controller.position.maxScrollExtent);
    await _controller.animateTo(
      peek,
      duration: const Duration(milliseconds: 520),
      curve: Curves.easeOutCubic,
    );
    if (_stopped) return;
    await Future<void>.delayed(const Duration(milliseconds: 180));
    if (_stopped) return;
    await _controller.animateTo(
      0,
      duration: const Duration(milliseconds: 620),
      curve: Curves.easeInOutCubic,
    );
  }

  Widget _item(int id) {
    final selected = id == widget.selected;
    return Center(
      child: Semantics(
        button: true,
        selected: selected,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (!selected) HapticFeedback.selectionClick();
            widget.onChanged(id);
          },
          child: AnimatedScale(
            scale: selected ? 1.06 : 1,
            duration: const Duration(milliseconds: 180),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? widget.selectedColor : Colors.transparent,
                  width: 2,
                ),
              ),
              child: UserAvatar(avatarId: id, radius: widget.radius),
            ),
          ),
        ),
      ),
    );
  }

  /// فلش راهنمای لبه‌ی پایانی.
  Widget _hint(bool rtl) {
    final arrow = Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.selectedColor.withValues(alpha: 0.18),
      ),
      // جهت رو خودمون تعیین می‌کنیم، نه آیکون
      child: Icon(
        rtl ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
        size: 20,
        color: widget.selectedColor,
        textDirection: TextDirection.ltr,
      ),
    );

    return Align(
      key: const ValueKey('hint'),
      alignment: AlignmentDirectional.centerEnd,
      child: reduceMotion(context)
          ? arrow
          : arrow
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .slideX(
                  begin: 0,
                  end: rtl ? -0.35 : 0.35,
                  duration: 700.ms,
                  curve: Curves.easeInOut,
                ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final direction = Directionality.of(context);
    final rtl = direction == TextDirection.rtl;
    final showHint = !_atEnd && !_touched;

    final list = ListView.builder(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      itemExtent: _slot,
      itemCount: avatarCount + 1,
      padding: const EdgeInsets.symmetric(horizontal: _listPadding),
      cacheExtent: _slot * 6,
      addAutomaticKeepAlives: false,
      itemBuilder: (context, index) => _item(index),
    );

    // لبه‌ای که هنوز آواتار داره آروم محو می‌شه
    final faded = TweenAnimationBuilder<double>(
      tween: Tween(end: _atStart ? 1 : 0),
      duration: const Duration(milliseconds: 220),
      builder: (context, startAlpha, child) => TweenAnimationBuilder<double>(
        tween: Tween(end: _atEnd ? 1 : 0),
        duration: const Duration(milliseconds: 220),
        builder: (context, endAlpha, child) => ShaderMask(
          blendMode: BlendMode.dstIn,
          shaderCallback: (rect) => LinearGradient(
            begin: AlignmentDirectional.centerStart,
            end: AlignmentDirectional.centerEnd,
            colors: [
              Colors.black.withValues(alpha: startAlpha),
              Colors.black,
              Colors.black,
              Colors.black.withValues(alpha: endAlpha),
            ],
            stops: const [0, _edgeFade, 1 - _edgeFade, 1],
          ).createShader(rect, textDirection: direction),
          child: child,
        ),
        child: child,
      ),
      child: list,
    );

    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) {
        if (!_touched) setState(() => _touched = true);
      },
      child: SizedBox(
        height: widget.radius * 2 + _ring + 8,
        child: Stack(
          children: [
            Positioned.fill(child: faded),
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: showHint
                      ? _hint(rtl)
                      : const SizedBox.shrink(key: ValueKey('no-hint')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
