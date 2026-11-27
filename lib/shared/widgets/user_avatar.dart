import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_assets.dart';
import 'package:little_moon/core/theme/theme_context.dart';

/// تعداد آواتارهای آماده. شناسه‌ی ۰ یعنی «بدون آواتار» (آیکون ساده).
const int avatarCount = AppAssets.avatarCount;

/// آواتار کاربر. اگه [avatarId] صفر یا نامعتبر باشه، آیکون ساده نشون می‌ده.
class UserAvatar extends StatelessWidget {
  final int avatarId;
  final double radius;

  const UserAvatar({super.key, required this.avatarId, this.radius = 20});

  Widget _placeholder(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: context.moon?.avatarBackground,
      child: Icon(
        Icons.person_rounded,
        color: context.moon?.avatarIcon,
        size: radius * 1.1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (avatarId < 1 || avatarId > avatarCount) return _placeholder(context);

    final size = radius * 2;
    // فقط به اندازه‌ی نمایش توی حافظه باز می‌شه (فایل اصلی ۲۵۶ پیکسله)
    final pixels = (size * MediaQuery.devicePixelRatioOf(context))
        .round()
        .clamp(1, 256);

    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: Image.asset(
          AppAssets.avatar(avatarId),
          fit: BoxFit.cover,
          cacheWidth: pixels,
          filterQuality: FilterQuality.medium,
          gaplessPlayback: true,
          excludeFromSemantics: true,
          errorBuilder: (context, error, stackTrace) => _placeholder(context),
        ),
      ),
    );
  }
}
