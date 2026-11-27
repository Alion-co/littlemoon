import 'package:flutter/material.dart';
import 'package:little_moon/core/constants/app_assets.dart';

/// آیکون برنامه با گوشه‌ی گرد. اگر [borderRadius] داده نشه، گردی متناسب با
/// اندازه‌ست (۲۸٪).
class MoonLogo extends StatelessWidget {
  const MoonLogo({required this.size, this.borderRadius, this.fit, super.key});

  final double size;
  final BorderRadius? borderRadius;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          borderRadius ?? BorderRadius.all(Radius.circular(size * 0.28)),
      child: _SizedAsset(AppAssets.logo, size: size, fit: fit),
    );
  }
}

/// ماه شیشه‌ایِ بدون پس‌زمینه (شفاف)؛ بدون گوشه‌ی گرد.
class MoonEmblem extends StatelessWidget {
  const MoonEmblem({required this.size, super.key});

  final double size;

  @override
  Widget build(BuildContext context) =>
      _SizedAsset(AppAssets.moonEmblem, size: size, fit: BoxFit.contain);
}

/// نشان سازنده (بدون برش؛ خود تصویر گرده). برای برش دایره‌ای دورش `ClipOval`
/// بذار.
class AlionBadge extends StatelessWidget {
  const AlionBadge({required this.size, super.key});

  final double size;

  @override
  Widget build(BuildContext context) =>
      _SizedAsset(AppAssets.alionBadge, size: size);
}

/// تصویر مربعی که فقط به اندازه‌ی نمایشش (ضربدر تراکم پیکسل صفحه) decode
/// می‌شه، نه با اندازه‌ی کامل فایل. بدون `cacheWidth` یک PNG ۱۰۲۴×۱۰۲۴ حدود
/// ۴ مگابایت رم می‌گرفت.
class _SizedAsset extends StatelessWidget {
  const _SizedAsset(this.path, {required this.size, this.fit});

  final String path;
  final double size;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    return Image.asset(
      path,
      width: size,
      height: size,
      fit: fit,
      cacheWidth: (size * pixelRatio).ceil(),
      filterQuality: FilterQuality.medium,
    );
  }
}
