import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/themes/moon_colors.dart';
import 'package:little_moon/l10n/generated/app_localizations.dart';
import 'package:little_moon/shared/widgets/glass.dart';
import 'package:little_moon/shared/widgets/user_avatar.dart';

class AppHeader extends StatelessWidget {
  final String userName;
  final String dateText;

  /// اگه داده نشه از متن پیش‌فرض خوش‌آمد استفاده می‌شه.
  final String? greeting;

  /// نقطه‌ی قرمز روی زنگوله وقتی یادآور تازه‌ای هست.
  final bool hasReminders;

  /// شناسه‌ی آواتار کاربر (۰ = آیکون ساده).
  final int avatar;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;

  const AppHeader({
    super.key,
    required this.userName,
    required this.dateText,
    this.greeting,
    this.hasReminders = false,
    this.avatar = 0,
    this.onNotificationTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moon = theme.extension<MoonColors>()!;
    final l10n = AppLocalizations.of(context)!;

    // تم شب: تاریخ با رنگ یاسی روشن روی آسمان
    final dateColor = isNightTheme(context)
        ? (Color.lerp(theme.colorScheme.secondary, Colors.white, 0.35) ??
            moon.subtitle)
        : moon.subtitle;

    final separator =
        (l10n.localeName == 'fa' || l10n.localeName == 'ar') ? '،' : ',';
    final hello = greeting ?? l10n.homeGreeting;
    final title = userName.trim().isEmpty
        ? hello
        : '$hello$separator ${userName.trim()}';

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                dateText,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: dateColor,
                ),
              ),
            ],
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              onPressed: onNotificationTap,
              icon: Icon(
                hasReminders
                    ? Icons.notifications_active_outlined
                    : Icons.notifications_none_rounded,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
              ),
            ),
            if (hasReminders)
              PositionedDirectional(
                top: 10,
                end: 10,
                child: IgnorePointer(
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.scaffoldBackgroundColor,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 2),
        GestureDetector(
          onTap: onProfileTap,
          child: UserAvatar(avatarId: avatar, radius: 20),
        ),
      ],
    );
  }
}
