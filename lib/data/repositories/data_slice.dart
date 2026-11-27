/// یک تکه از داده‌ی کاربر که در پشتیبان‌گیری، بازیابی و «حذف همه‌ی داده‌ها»
/// شرکت می‌کنه. هر notifier داده‌دار این رابط رو پیاده می‌کنه و در
/// `dataSlicesProvider` (لایه‌ی domain) ثبت می‌شه؛ داده‌ی جدید فقط همین
/// دو جا رو لازم داره.
abstract interface class DataSlice {
  /// کلید این تکه در فایل پشتیبان.
  String get backupKey;

  /// آیا [raw] (مقدار این کلید در پشتیبان) برای بازیابی قابل قبوله؟
  /// `false` یعنی کل پشتیبان نامعتبره. پیش‌فرض‌ها: همه‌چیز قبوله.
  bool acceptsBackup(Object? raw);

  /// مقدار فعلی به شکل JSON برای نوشتن در پشتیبان.
  Object? exportBackup();

  /// جایگزینی داده با مقدار پشتیبان؛ برای کلید گمشده [raw] برابر `null` است.
  Future<void> importBackup(Object? raw);

  /// برگرداندن به حالت اولیه.
  Future<void> reset();
}
