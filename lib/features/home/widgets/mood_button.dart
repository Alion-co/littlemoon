import 'package:flutter/material.dart';
import 'package:little_moon/core/localization/labels.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/data/models/daily_log.dart';
import 'package:little_moon/shared/widgets/glass.dart';
import 'package:little_moon/shared/widgets/mood_style.dart';

/// دکمه‌ی گردِ حال در ثبت سریع: دایره‌ی پاستلی، آیکون، نقطه‌ی رنگی و لیبل.
/// اندازه‌ی دایره با عرض خانه تنظیم می‌شه، پس شش‌تا همیشه توی یک ردیف جا می‌شن.
class MoodButton extends StatelessWidget {
  final Mood mood;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const MoodButton({
    super.key,
    required this.mood,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  static const _maxCircle = 56.0;

  @override
  Widget build(BuildContext context) {
    final night = isNightTheme(context);
    final color = moodColor(mood);
    final ink = night ? Colors.white : context.scheme.onSurface;

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxCircle),
              child: FractionallySizedBox(
                widthFactor: 0.88,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color.withValues(
                            alpha: selected ? 0.30 : (night ? 0.20 : 0.14),
                          ),
                          border: Border.all(
                            color: selected ? color : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: FractionallySizedBox(
                          widthFactor: 0.52,
                          heightFactor: 0.52,
                          child: FittedBox(
                            child: Icon(
                              Labels.moodIcon(mood),
                              color: ink.withValues(alpha: 0.85),
                            ),
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        end: 2,
                        bottom: 2,
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                maxLines: 1,
                softWrap: false,
                style: context.text.labelMedium?.copyWith(
                  color: ink.withValues(alpha: selected ? 1 : 0.75),
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
