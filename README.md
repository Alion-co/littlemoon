<div align="center">

<img src="docs/readme/hero.png" alt="Little Moon | سایکل ماهانه خصوصی، رایگان و آفلاین">

</div>

<div dir="rtl">

Little Moon پریود بعدی، تخمک‌گذاری و روزهای باروری رو از روی ثبت‌های خودت پیش‌بینی می‌کنه
همه‌ی اطلاعات فقط روی گوشی خودت می‌مونه: بدون حساب کاربری، بدون سرور و بدون تبلیغ

## دریافت

</div>

<p align="center">
  <a href="https://cafebazaar.ir/app/ir.littlemoon"><img src="docs/buttons/bazaar.png" height="48" alt="دریافت از کافه‌بازار"></a>
  <a href="https://myket.ir/app/ir.littlemoon"><img src="docs/buttons/myket.png" height="48" alt="دریافت از مایکت"></a>
  <a href="https://github.com/Alion-co/littlemoon/releases/latest"><img src="docs/buttons/apk.png" height="48" alt="دانلود مستقیم APK"></a>
  <a href="https://alion-co.github.io/littlemoon/"><img src="docs/buttons/web.png" height="48" alt="نسخه‌ی وب"></a>
</p>

<div dir="rtl">

## نگاهی به اپ

</div>

<p align="center">
  <img src="docs/screenshots/home.jpg" width="150" alt="خانه">
  <img src="docs/screenshots/calendar.jpg" width="150" alt="تقویم">
  <img src="docs/screenshots/insights.jpg" width="150" alt="تحلیل">
  <img src="docs/screenshots/health.jpg" width="150" alt="سلامت">
  <img src="docs/screenshots/profile.jpg" width="150" alt="پروفایل">
</p>

<div dir="rtl">

## امکانات

</div>

<p align="center">
  <img src="docs/readme/feat.png" alt="پیش‌بینی چرخه، ثبت سریع روزانه، تقویم شمسی و میلادی، تحلیل و الگوها، سلامت و فاز، یادآور و ویجت، گزارش پزشک، قفل پین و اثرانگشت، پشتیبان‌گیری">
</p>

<div dir="rtl">

۵ زبان با پشتیبانی کامل راست‌به‌چپ (فارسی، English، العربية، Español، Türkçe) · ۸ تم روشن و تیره · تقویم شمسی و میلادی

</div>

<p align="center">
  <img src="docs/readme/disclaimer.png" width="262" alt="هشدار · Disclaimer: پیش‌بینی‌ها فقط تخمین‌ان، نه توصیه‌ی پزشکی و نه روش پیشگیری از بارداری">
  <a href="https://github.com/Alion-co/littlemoon/issues"><img src="docs/readme/contribute.png" width="262" alt="مشارکت · Contribute: Issues و Pull Request خوش‌آمده"></a>
  <img src="docs/readme/privacy.png" width="262" alt="حریم خصوصی · Privacy: همه‌ی داده‌ها فقط روی گوشی خودت می‌مونه">
</p>

<div dir="rtl">

<details>
<summary>برای توسعه‌دهنده‌ها</summary>

```bash
git clone https://github.com/Alion-co/littlemoon.git
cd littlemoon
flutter pub get
flutter run
```

به Flutter نسخه‌ی ۳.۳۸ یا بالاتر نیاز داره.

- [Flutter](https://flutter.dev) و Dart
- [Riverpod](https://riverpod.dev) برای مدیریت وضعیت و [go_router](https://pub.dev/packages/go_router) برای مسیریابی
- [shared_preferences](https://pub.dev/packages/shared_preferences) برای ذخیره‌ی محلی
- [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) برای یادآورهای آفلاین
- [local_auth](https://pub.dev/packages/local_auth) برای اثرانگشت و [home_widget](https://pub.dev/packages/home_widget) برای ویجت اندروید
- [pdf](https://pub.dev/packages/pdf) و [printing](https://pub.dev/packages/printing) برای گزارش پزشک

```
lib/
├── core/       # تم، بومی‌سازی، مسیریابی، ابزار تاریخ و تقویم
├── data/       # مدل‌ها، ذخیره‌ی محلی، repositoryها
├── domain/     # موتور چرخه، یادآورها، اعلان‌ها، پشتیبان‌گیری
├── features/   # خانه، تقویم، تحلیل، سلامت، پروفایل، تنظیمات، شروع، درباره
└── shared/     # ویجت‌های مشترک
```

</details>

## مجوز

Little Moon برای هر کاری که **غیرتجاری** باشه آزاده، با مجوز [PolyForm Noncommercial 1.0.0](https://polyformproject.org/licenses/noncommercial/1.0.0) (جزئیات در فایل [`LICENSE`](LICENSE))
فونت وزیرمتن جداگانه با مجوز SIL Open Font License 1.1 منتشر شده

</div>

<p align="center">
  <a href="https://instagram.com/alion.inc"><img src="docs/readme/credit.png" width="360" alt="Designed by ALION · Instagram"></a>
</p>

<details>
<summary>English</summary>

**Little Moon** is a private, free and fully offline monthly cycle tracker. It predicts your next period, ovulation and fertile window from what you log, and keeps everything on your phone: no account, no server, no ads. Five languages with full right-to-left support, Shamsi and Gregorian calendars, eight themes, PIN and fingerprint lock, backup files and a PDF report for your doctor.

Download from [Cafe Bazaar](https://cafebazaar.ir/app/ir.littlemoon), [Myket](https://myket.ir/app/ir.littlemoon) or the [latest release](https://github.com/Alion-co/littlemoon/releases/latest). Free for noncommercial use under the PolyForm Noncommercial License 1.0.0. Estimates only: not a medical device and not a method of contraception.

</details>
