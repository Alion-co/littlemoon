/// مسیر asset‌ها؛ فقط همین‌جا نوشته می‌شن و `pubspec.yaml` همین‌ها رو لیست می‌کنه
/// (`test/assets_test.dart` هماهنگی‌شون رو چک می‌کنه).
///
/// فایل‌های طراحی (نسخه‌ی کامل آیکون، لایه‌ی foreground) داخل `design/` هستن،
/// نه اینجا، تا وارد APK نشن.
abstract final class AppAssets {
  /// لوگوی برنامه برای نمایش روی صفحه (۲۵۶×۲۵۶؛ بزرگ‌ترین نمایش ۹۶ پیکسله).
  static const logo = 'assets/images/logo/littlemoon_icon_full.png';

  /// ماه شیشه‌ای با حلقه‌ی رزگلد (پس‌زمینه‌ی شفاف، ۴۸۰×۴۸۰)؛ برای راه‌اندازی.
  static const moonEmblem = 'assets/images/logo/moon_emblem.png';

  /// نشان سازنده (۱۲۸×۱۲۸؛ بزرگ‌ترین نمایش ۶۴ پیکسله).
  static const alionBadge = 'assets/images/logo/alion_badge.png';

  /// تعداد آواتارهای آماده؛ شناسه‌ها از ۱ تا همین عددن (۰ = بدون آواتار).
  static const avatarCount = 32;

  /// مسیر آواتار شماره‌ی [id] (۱ تا [avatarCount]؛ WebP، ۲۵۶×۲۵۶).
  /// فایل‌ها یکی‌یکی توی `pubspec.yaml` لیست شدن.
  static String avatar(int id) =>
      'assets/avatars/avatar_${id.toString().padLeft(2, '0')}.webp';

  static const fontRegular = 'assets/fonts/Vazirmatn-Regular.ttf';
  static const fontMedium = 'assets/fonts/Vazirmatn-Medium.ttf';
  static const fontSemiBold = 'assets/fonts/Vazirmatn-SemiBold.ttf';
  static const fontBold = 'assets/fonts/Vazirmatn-Bold.ttf';
}
