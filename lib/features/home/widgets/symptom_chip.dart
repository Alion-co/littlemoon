import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/shared/widgets/glass.dart';

/// چیپ علامتِ ثبت سریع. عرضش از والد می‌آد (داخل `Expanded`) و متن اگه
/// بلند باشه کوچک می‌شه، پس همه‌ی چیپ‌ها همیشه توی یک ردیف می‌مونن.
class SymptomChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const SymptomChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final night = isNightTheme(context);
    final accent = night ? context.scheme.secondary : context.scheme.primary;
    final ink = night ? Colors.white : context.scheme.onSurface;

    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 11),
          decoration: BoxDecoration(
            color: selected
                ? accent.withValues(alpha: night ? 0.30 : 0.14)
                : Colors.transparent,
            borderRadius: AppRadius.br20,
            border: Border.all(
              color: selected ? accent : accent.withValues(alpha: 0.22),
              width: selected ? 1.4 : 1,
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              maxLines: 1,
              softWrap: false,
              style: context.text.labelMedium?.copyWith(
                color: selected && !night ? accent : ink,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
