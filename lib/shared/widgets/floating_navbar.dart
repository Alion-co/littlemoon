import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:little_moon/core/constants/app_radius.dart';
import 'package:little_moon/core/theme/theme_context.dart';
import 'package:little_moon/core/utils/haptics.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/glass.dart';

/// ترتیب این لیست باید دقیقاً با ترتیب آیتم‌های نوار پایین یکی باشه
/// (خانه وسطه؛ پروفایل از آواتار صفحه‌ی خانه باز می‌شه)
const List<String> _navPaths = [
  '/calendar',
  '/insights',
  '/home',
  '/health',
  '/settings',
];

class FloatingNavbar extends StatelessWidget {
  /// شماره‌ی تب فعال؛ با -1 هیچ تبی انتخاب‌شده نشون داده نمی‌شه
  /// (مثل صفحه‌ی پروفایل که دیگه تب نیست).
  final int currentIndex;

  /// اگه پاس ندی، خودش با GoRouter مسیر رو عوض می‌کنه.
  /// اگه بخوای رفتار سفارشی داشته باشی، می‌تونی onTap بدی.
  final ValueChanged<int>? onTap;

  const FloatingNavbar({super.key, required this.currentIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    final night = isNightTheme(context);

    final subtitleColor = night
        ? Colors.white.withValues(alpha: 0.85)
        : context.subtitle;

    // تم شب: انتخاب‌شده با رنگ یاسی و متن سفید
    final selectedColor = night ? Colors.white : context.scheme.primary;
    final selectedBackground = night
        ? context.scheme.secondary.withValues(alpha: 0.38)
        : context.scheme.primary.withValues(alpha: 0.12);

    final items = [
      _NavItem(
        icon: Icons.calendar_month_outlined,
        selectedIcon: Icons.calendar_month_rounded,
        label: l10n?.calendar ?? 'Calendar',
        index: 0,
      ),
      _NavItem(
        icon: Icons.explore_outlined,
        selectedIcon: Icons.explore_rounded,
        label: l10n?.insights ?? 'Insights',
        index: 1,
      ),
      // خانه وسط نوار
      _NavItem(
        icon: Icons.home_outlined,
        selectedIcon: Icons.home_rounded,
        label: l10n?.home ?? 'Home',
        index: 2,
      ),
      _NavItem(
        icon: Icons.favorite_border_rounded,
        selectedIcon: Icons.favorite_rounded,
        label: l10n?.health ?? 'Health',
        index: 3,
      ),
      _NavItem(
        icon: Icons.settings_outlined,
        selectedIcon: Icons.settings_rounded,
        label: l10n?.settings ?? 'Settings',
        index: 4,
      ),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: night
          ? homeCardDecoration(context, radius: 28)
          : BoxDecoration(
              color: context.scheme.surface,
              borderRadius: AppRadius.br28,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: theme.dividerColor.withValues(alpha: 0.4),
              ),
            ),
      child: Row(
        children: items.map((item) {
          final isSelected = item.index == currentIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                // اگه قبلاً روی همین تب هستیم، کاری نکن
                if (item.index == currentIndex) return;
                Haptics.tap();

                if (onTap != null) {
                  onTap!(item.index);
                } else {
                  context.go(_navPaths[item.index]);
                }
              },
              behavior: HitTestBehavior.opaque,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? selectedBackground : Colors.transparent,
                    borderRadius: AppRadius.br18,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSelected ? item.selectedIcon : item.icon,
                        size: 24,
                        color: isSelected ? selectedColor : subtitleColor,
                      ),
                      const SizedBox(height: 4),
                      // روی صفحه‌های باریک متن کوچک می‌شه، نمی‌شکنه
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          item.label,
                          maxLines: 1,
                          style: context.text.labelSmall?.copyWith(
                            color: isSelected ? selectedColor : subtitleColor,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final int index;

  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.index,
  });
}
