import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/haptics.dart';

/// رنگ پس‌زمینه‌ی گزینه‌های انتخاب‌نشده: خاکستری خیلی ملایم، در هر تمی.
Color softFill(BuildContext context) =>
    context.scheme.onSurface.withValues(alpha: 0.045);

/// پوسته‌ی مشترک همه‌ی گزینه‌ها: انتخاب‌نشده = پر و بی‌حاشیه،
/// انتخاب‌شده = زمینه‌ی صورتی کم‌رنگ + حاشیه‌ی صورتی.
class _SoftSurface extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final BorderRadius radius;
  final EdgeInsetsGeometry padding;
  final double? height;
  final Widget child;

  const _SoftSurface({
    required this.selected,
    required this.onTap,
    required this.radius,
    required this.padding,
    required this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.scheme.primary;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Haptics.tap();
          onTap();
        },
        borderRadius: radius,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: selected ? primary.withValues(alpha: 0.10) : softFill(context),
            borderRadius: radius,
            // حاشیه همیشه هست (شفاف) تا با انتخاب، اندازه نپره
            border: Border.all(
              color: selected ? primary.withValues(alpha: 0.65) : Colors.transparent,
              width: 1.2,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// کپسول قابل انتخاب (برای علائم و گزینه‌های چندتایی که می‌شکنن).
class SoftChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const SoftChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.scheme.primary;
    return _SoftSurface(
      selected: selected,
      onTap: onTap,
      radius: AppRadius.br22,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(
        label,
        style: context.text.labelLarge?.copyWith(
          fontSize: 13,
          color: selected ? primary : context.scheme.onSurface,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    );
  }
}

/// ردیف گزینه‌های هم‌عرض (مثل انرژی، درد، خونریزی): هر گزینه یک کپسول.
class SoftSegment extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const SoftSegment({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.scheme.primary;
    return _SoftSurface(
      selected: selected,
      onTap: onTap,
      radius: AppRadius.br20,
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            maxLines: 1,
            style: context.text.labelLarge?.copyWith(
              fontSize: 13,
              color: selected ? primary : context.scheme.onSurface,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

/// کاشیِ بلند با آیکن بالا و نوشته پایین (برای خلق‌وخو).
class SoftTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const SoftTile({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.scheme.primary;
    return _SoftSurface(
      selected: selected,
      onTap: onTap,
      radius: AppRadius.br20,
      height: 78,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 26,
            color: selected
                ? primary
                : context.scheme.onSurface.withValues(alpha: 0.55),
          ),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              maxLines: 1,
              style: context.text.labelMedium?.copyWith(
                fontSize: 12,
                color: selected ? primary : context.scheme.onSurface,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
