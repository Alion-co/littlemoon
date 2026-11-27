import 'package:flutter/material.dart';
import 'package:little_moon/core/theme/theme_context.dart';

/// هدر صفحه‌ها: عنوان وسط‌چین، دکمه‌ی برگشت به سبک iOS در ابتدا
/// و یک اکشن اختیاری در انتها.
class PageHeader extends StatelessWidget {
  final String title;

  /// اگه داده بشه دکمه‌ی برگشت نشون داده می‌شه.
  final VoidCallback? onBack;
  final Widget? trailing;

  const PageHeader({
    super.key,
    required this.title,
    this.onBack,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final back = onBack;
    final action = trailing;

    return SizedBox(
      // تمام‌عرض، وگرنه داخل ستونِ چپ‌چین/راست‌چین عنوان وسط نمی‌افته
      width: double.infinity,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Padding(
            // جا برای دکمه‌های دو طرف تا عنوان دقیقاً وسط بمونه
            padding: const EdgeInsets.symmetric(horizontal: 64),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: context.text.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.scheme.onSurface,
              ),
            ),
          ),
          if (back != null)
            PositionedDirectional(
              start: -8,
              child: IconButton(
                onPressed: back,
                // این آیکون خودش در راست‌به‌چپ قرینه می‌شه
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                color: context.scheme.onSurface,
              ),
            ),
          if (action != null) PositionedDirectional(end: -8, child: action),
        ],
      ),
    );
  }
}
