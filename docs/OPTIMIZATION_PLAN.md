# Little Moon — نقشه‌ی جامع بهینه‌سازی، تمیزی و ضدّ تکرار

> تاریخ: ۲۲ نوامبر ۲۰۲۶ · پایه: `لیت.zip` (نسخه‌ی `1.2.0+2`) · بررسی یک‌باره‌ی کل پروژه
> ادامه‌ی `REFACTOR_PLAN.md` (فازهای ۱ تا ۴). این سند **فاز ۵ تا ۹** را تعریف می‌کند.

---

## ۰) این بررسی چی بود و چی نبود

**انجام شد:** خواندن ساختار و اسکن آماری کل `lib/` (۱۶۴ فایل، ۲۰۷ کلاس)، `test/`، `pubspec.yaml`، `pubspec.lock`، `analysis_options.yaml`، `tool/` و `tools/`، `assets/`، `l10n/` و مستندات.

**انجام نشد (چون Flutter/Dart و دستگاه در دسترس نبود):** اجرای `flutter analyze/test`، اندازه‌ی واقعی APK، زمان راه‌اندازی، زمان فریم و تعداد rebuild. هر جا در این سند «تخمین» آمده یعنی از روی کد حدس زده شده و **باید قبل از تصمیم اندازه‌گیری شود** (روش در `PERFORMANCE.md` و بخش ۹ همین سند).

---

## ۱) خلاصه‌ی اجرایی

### نقاط قوت فعلی (باید حفظ شوند)

- لایه‌بندی روشن (`core` / `data` / `domain` / `features` / `shared`) و تست معماری که از خراب شدنش جلوگیری می‌کند.
- موتور چرخه خالص و بدون Flutter است؛ ذخیره‌سازی یکپارچه (`PersistedRepository` + `DataSlice`)؛ پشتیبان و ریست از یک فهرست می‌خوانند.
- `TODO`: صفر · `// ignore`: صفر · `Opacity(` و `BackdropFilter`: صفر · `withOpacity` منسوخ: صفر · `Image.network`/وابستگی اینترنتی: ندارد.
- ARB پنج زبان با تست یکسان‌بودن کلیدها.

### ۱۰ یافته‌ی اصلی به ترتیب اثر

| # | یافته | اثر | زحمت |
|---|---|---|---|
| ۱ | **حدود ۱٫۸ مگابایت asset بی‌مصرف** داخل APK (`littlemoon_icon.png` ۱٫۲MB و `lmicon.jpg` هیچ‌جا استفاده نمی‌شوند؛ `littlemoon_icon_foreground.png` فقط برای ساخت آیکون لازم است) | حجم برنامه | کم |
| ۲ | لوگوی **۱۰۲۴×۱۰۲۴ (۱٫۲MB)** با اندازه‌ی ۶۴ تا ۹۶ پیکسل نمایش داده می‌شود و `cacheWidth` ندارد؛ بعد از decode حدود ۴MB رم می‌گیرد (۱۰۲۴×۱۰۲۴×۴) | رم و زمان باز شدن صفحه‌ی قفل/درباره | کم |
| ۳ | **قفل برنامه:** شمارنده‌ی تلاش‌های ناموفق فقط در حافظه است؛ با بستن و باز کردن برنامه صفر می‌شود (دور زدن محدودیت ۵ تلاش) | امنیت | متوسط |
| ۴ | **همه‌ی ثبت‌ها یک JSON واحد** در `SharedPreferences`؛ با هر نوشتن کل نقشه دوباره encode می‌شود و در شروع برنامه هم کامل decode می‌شود | مقیاس چندساله | متوسط تا زیاد |
| ۵ | **داده‌ی خراب بی‌صدا نادیده گرفته می‌شود** (`LocalStore.getJson` در خطا `null` می‌دهد) و ذخیره‌ی بعدی روی آن می‌نویسد | از دست رفتن داده | کم |
| ۶ | ۲۸ فایل بالای ۲۰۰ خط؛ ۱۴ فایل بین ۱۵۰ تا ۲۰۰ | خوانایی | متوسط |
| ۷ | تکرارهای باقی‌مانده: `SizedBox` ۲۵۶، `EdgeInsets` ۱۰۷، `Theme.of(context)` ۴۹، `SnackBar` ۲۱، `Duration(milliseconds:` ۲۴، رشته‌ی مسیر ۳۰ | تمیزی | کم |
| ۸ | **پراکندگی مخزن:** پوشه‌ی خالی `lib/database/` با فایل‌های قدیمی، `tool/` و `tools/` جدا، تست هم‌نام تکراری، `check.bat` که هر بار `flutter pub add` می‌زند | سردرگمی | خیلی کم |
| ۹ | ۸ وابستگی با `any`؛ ۹ `StateNotifier` (در Riverpod 3 به بسته‌ی legacy می‌روند) | پایداری بیلد، ارتقا | کم |
| ۱۰ | تست‌ها حدود ۱۱٪ حجم کد (۱٫۹k در برابر ۱۸٫۲k خط)؛ `widget_test.dart` فقط placeholder است؛ هیچ تست ویجتی/قفل/مسیر‌یابی نیست | اطمینان | متوسط |

---

## ۲) اعداد پایه (برای مقایسه‌ی بعد از اجرا)

| معیار | الان | هدف |
|---|---|---|
| کد دستی `lib/` (بدون l10n تولیدشده) | ۱۸٬۱۹۲ خط · ۱۶۴ فایل | بدون افزایش خالص |
| `features` / `domain` / `shared` / `core` / `data` | ۹٬۸۵۶ / ۳٬۰۶۷ / ۲٬۵۸۸ / ۱٬۵۹۳ / ۹۱۶ | — |
| فایل بالای ۲۰۰ خط | ۲۸ | ≤ ۵ (با استثنای مستند) |
| فایل ۱۵۰ تا ۲۰۰ خط | ۱۴ | — |
| `Theme.of(context)` | ۴۹ | ۰ |
| `BorderRadius.circular(` مستقیم | ۹ | ۰ |
| `SizedBox(height/width: n)` | ۲۵۶ | ≈ ۰ (با `Gap`) |
| `Color(0x…)` خارج از تم | ≈ ۴۷ (`user_avatar` ۲۸، `widget_gallery*` ۷ و …) | ≈ ۰ |
| `showModalBottomSheet` / `showDialog` / `SnackBar` | ۷ / ۴ / ۲۱ | هر کدام ۱ تابع مشترک |
| `ref.watch(...select(` | ۹ از ۱۱۷ | همه‌ی watchهای پرتکرار |
| `StateNotifier` | ۹ | ۰ (`Notifier`) |
| `DateTime.now()` پراکنده | ۱۰ | ۱ (ساعت تزریق‌پذیر) |
| asset بسته‌بندی‌شده (`assets/images`) | ۳٫۱MB | < ۰٫۵MB |
| تست (خط) | ۱٬۹۲۸ | ≥ ۳٬۵۰۰ و پوشش مسیرهای حیاتی |

---

## ۳) فاز ۵ — پاکسازی مخزن و اسکریپت‌ها (کم‌ریسک، یک روز)

| # | کار | جزئیات |
|---|---|---|
| P5-1 | حذف پوشه‌ی `lib/database/` | سه فایل `app_localizations*.dart` قدیمی داخلش است؛ جایی import نمی‌شود (خروجی واقعی در `lib/l10n/generated`) |
| P5-2 | حذف `l10n/app_localizations*.dart` | سه فایل قدیمی (۱۹ سپتامبر) در پوشه‌ی ARB؛ خروجی `gen-l10n` نیستند |
| P5-3 | ادغام `tools/` در `tool/` | `check.bat` و `check_v1_1.bat` را به `tool/` ببر؛ نام `check_v1_1` را عمومی کن |
| P5-4 | اصلاح `check.bat` | الان هر اجرا `flutter pub add local_auth crypto …` می‌زند (تغییر ناخواسته‌ی `pubspec`). فقط `pub get` → `format --set-exit-if-changed` → `analyze` → `test`؛ آدرس mirror فقط اگر متغیر محیطی خالی بود |
| P5-5 | تست‌های تکراری | `test/cycle_engine_test.dart` (۷۳ خط) و `test/domain/cycle_engine_test.dart` (۲۳۰ خط) هم‌نام‌اند؛ ادغام در نسخه‌ی `domain/` |
| P5-6 | نام‌گذاری تست‌ها | `v1_1_features_test.dart` و `v1_2_features_test.dart` ← بر اساس موضوع (`backup_test`, `lock_test`, …) |
| P5-7 | `assets/icons/` خالی | از `pubspec.yaml` و دیسک حذف شود |
| P5-8 | ادغام مستندات | `CHANGES.md` + `CHANGES-12-15.md` ← یک `CHANGELOG.md`؛ `LITTLE_MOON.md`، `REFACTOR_PLAN.md`، `PERFORMANCE.md`، این سند ← `docs/` |
| P5-9 | پایان خط (CRLF/LF) | بیشتر فایل‌ها LF ولی `analysis_options.yaml`، `widget_test.dart`، `.gitignore`، `cycle_ring.dart` و … CRLF‌اند. یک `.gitattributes` با `* text=auto eol=lf` و یک‌بار `dart format` |
| P5-10 | `.gitignore` | مطمئن شو `.flutter-plugins-dependencies`، `little_moon.iml`، `tools/check_log.txt` ignore هستند |

**معیار پذیرش:** `flutter analyze` و `flutter test` سبز؛ `git status` بعد از `check.bat` تمیز.

---

## ۴) فاز ۶ — حجم، حافظه و asset

### ۴.۱ بسته‌بندی asset

| فایل | اندازه | وضعیت | کار |
|---|---|---|---|
| `littlemoon_icon.png` | ۱٫۲MB (۱۲۵۴²) | در هیچ‌جا استفاده نمی‌شود | حذف |
| `lmicon.jpg` | ۱۷۱KB | در هیچ‌جا استفاده نمی‌شود | حذف |
| `littlemoon_icon_foreground.png` | ۴۱۱KB | فقط `flutter_launcher_icons` | انتقال به `design/` (خارج از `assets:`) |
| `littlemoon_icon_full.png` | ۱٫۲MB (۱۰۲۴²) | نمایش در ۶۴–۹۶px (۳ جا) | نسخه‌ی ۲۵۶px یا WebP برای runtime؛ نسخه‌ی کامل به `design/` |
| `alion_badge.png` | ۹۸KB (۲۵۶²) | نمایش در ۱۸ و ۶۴px | WebP یا ۱۲۸px |

- در `pubspec.yaml` به‌جای پوشه‌های کلی (`assets/images/` و `assets/images/logo/`) فقط فایل‌های لازم لیست شوند تا فایل طراحی دوباره وارد APK نشود.
- `flutter_launcher_icons` به مسیر جدید `design/…` اشاره کند.
- **تخمین صرفه‌جویی:** حدود ۱٫۸ تا ۲٫۷MB از حجم خام asset (باید با `flutter build apk --analyze-size` تأیید شود؛ PNG در APK زیاد فشرده نمی‌شود).

### ۴.۲ حافظه‌ی تصویر

- روی هر `Image.asset` (۵ مورد) `cacheWidth`/`cacheHeight` برابر ۲ تا ۳ برابر اندازه‌ی نمایش (برای تراکم پیکسل) بگذار، یا یک `MoonLogo` مشترک بساز که اندازه را بگیرد. بدون این، تصویر کامل ۱۰۲۴² decode می‌شود.
- `precacheImage` فقط برای لوگوی صفحه‌ی قفل اگر هنگام باز شدن لگ دیده شد.

### ۴.۳ حجم کد و وابستگی

- `flutter build apk --release --split-per-abi --analyze-size` را یک‌بار اجرا کن و جدول سه بسته‌ی بزرگ را ثبت کن (احتمالاً `pdf`، `printing`، `file_picker`؛ **تخمین است**).
- `pdf` + `printing` فقط برای گزارش پزشک‌اند. اگر سهمشان بزرگ بود، گزینه: فقط `pdf` + `share` بدون `printing`، یا اجرای ساخت PDF در `Isolate`/`compute` تا UI قفل نکند (الان `doctor_report.dart` ۳۳۸ خط است و در کل پروژه هیچ `Isolate`/`compute`ی نیست، پس PDF روی isolate اصلی ساخته می‌شود؛ **تأثیر واقعی را با DevTools بسنج**).
- فونت: ۴ وزن Vazirmatn ≈ ۴۹۲KB. اگر وزن ۶۰۰ و ۵۰۰ هر دو لازم نیستند، یکی حذف شود (حدود ۱۲۰KB). **اول بررسی کن کجا استفاده می‌شوند.**
- `cupertino_icons` در کد استفاده نشده (`CupertinoIcons` = ۰) ← از `pubspec.yaml` حذف شود (اگر جای دیگری به آن نیاز نیست).
- فعال بودن R8/shrink در `android/app/build.gradle` را بررسی کن (فولدر `android/` در zip نبود).

**معیار پذیرش:** جدول «قبل/بعد» حجم APK (به تفکیک ABI) و رم صفحه‌ی قفل در DevTools Memory.

---

## ۵) فاز ۷ — تکرار کد و طراحی سیستم UI

### ۵.۱ توکن‌های فاصله و اندازه

| الگو | تعداد | راه‌حل |
|---|---|---|
| `SizedBox(height: 12)` و مشابه | ۲۵۶ | `Gap.h4/h8/h12/h16/h24/h32` و `Gap.w8…` (ثابت `const`) در `core/constants/` |
| `EdgeInsets.*` | ۱۰۷ | `AppInsets.page`, `.card`, `.sheet`, `.chip` (فقط تکراری‌ها، نه همه) |
| `Duration(milliseconds: n)` | ۲۴ | `AppDurations.fast/medium/slow` |
| `BorderRadius.circular(n)` | ۹ | `AppRadius` |
| رشته‌ی مسیر `'/home'`… | ۳۰ | `AppRoutes.home` … (یک کلاس ثابت؛ هم `context.go` هم `GoRoute.path`) |

### ۵.۲ رنگ

- `Color(0x…)` در ۷ فایل تم تعریف پالت است ← **درست و بماند**.
- بیرون از `core/theme` و `core/constants` ≈ ۴۷ مورد: `user_avatar.dart` (۲۸ رنگ آواتار)، `widget_gallery*` (۷)، و ۱ یا ۲ مورد در `cycle_ring`، `week_strip`، `night_sky_background`، `phase_badge`، `day_kind_style`، `about_page`، `predictions_card`. آواتار را به `AvatarPalette` در `core/theme` ببر تا تم‌ها بتوانند آن را عوض کنند.
- `Colors.white` ۷۳ بار: بیشترِ آن متن روی گرادیان/هرو است. یک توکن `MoonColors.onHero` (یا `onAccent`) بساز تا تغییر تم شب/روز نیاز به جست‌وجوی ۷۳ جا نداشته باشد.
- `TextStyle(` مستقیم ۲۴ بار: به `context.text.*` یا توکن‌های `MoonText` ببر.

### ۵.۳ extensionها و ویجت‌های مشترک

| کار | جایگزین |
|---|---|
| `Theme.of(context)` ۴۹ بار | `context.theme` (از قبل `context.text/scheme/moon/subtitle` داری) |
| `MediaQuery.of(context)` ۳ بار | `MediaQuery.sizeOf/paddingOf/viewInsetsOf` (فقط وقتی همان مقدار عوض شد rebuild می‌شود) |
| `showModalBottomSheet` ۷ بار | `showMoonSheet<T>(context, builder:)` (شکل، حاشیه، `isScrollControlled`، `useSafeArea` یکسان) |
| `showDialog` ۴ بار | همه از `dialogs.dart` (الان بخشی مستقیم صدا زده می‌شود) |
| `SnackBar` ۲۱ بار | `context.showMoonSnack(text, {undo})` |
| `Navigator.of(context).pop(...)` ۱۶ بار | `context.pop(...)` (go_router) یا یک `context.closeSheet(value)` |
| رشته‌های `context.n(...)` ۴۵ بار | فقط اگر الگوی `l10n + digits` تکرار شد: `l10n.dayOfCycleN(...)` در یک helper |
| ۶۰ کلاس private (`_StatTile`, `_NightTile`, `_InsightCard`, `_SymptomChip`, `_SelectedDayCard`, `_SummaryItem`, `_DayItem`, `_NavItem`…) | آنهایی که در دو فایل مشابه‌اند به `shared/widgets` (نمونه‌اش `StatTile` قبلاً ساخته شد) |

### ۵.۴ یکدست‌سازی import

۹۵ import نسبی در برابر ۴۲۶ import بسته‌ای (`package:little_moon/…`). یکی را انتخاب کن (پیشنهاد: **بسته‌ای** چون اکثریت است) و قانون `always_use_package_imports` را فعال کن؛ یک‌بار با `dart fix --apply` درست می‌شود.

**معیار پذیرش:** تست «الگوهای ممنوع» (بخش ۹) با فهرست بالا سبز؛ عدد هر ردیف جدول بخش ۲ به هدف برسد.

---

## ۶) فاز ۸ — شکستن فایل‌های بزرگ (۲۸ فایل بالای ۲۰۰ خط)

قانون: هر کلاس یک کار؛ فایل ≤ ۲۰۰ خط؛ رفتار و ظاهر بدون تغییر؛ تست‌ها دست‌نخورده.

| فایل | خط | پیشنهاد تفکیک |
|---|---|---|
| `features/settings/widget_gallery.dart` | ۳۴۰ | صفحه + ۳ بخش؛ اگر فقط برای انتخاب ویجت خانه است، `previews`/`atoms` را همراه آن زیرپوشه‌ی `widget_gallery/` کن |
| `domain/services/doctor_report.dart` | ۳۳۸ | جمع‌آوری داده (`DoctorReportData`، خالص و قابل تست) ← ساخت PDF (`doctor_report_pdf.dart`) ← متن‌ها؛ **اجرا در `Isolate`/`compute`** |
| `core/localization/labels.dart` | ۳۲۹ | تفکیک: `phase_labels`, `symptom_labels`, `mood_labels`, `flow_labels`. به `shared/` یا `domain/` نزدیک‌تر است تا `core` (به `l10n` و `domain` وابسته است) |
| `shared/widgets/charts.dart` | ۳۲۷ | `line_chart.dart`, `bar_chart.dart`, `chart_painters.dart`؛ painterها جدا از ویجت‌ها |
| `shared/widgets/user_avatar.dart` | ۳۰۷ | ویجت ← `avatar_painters.dart` ← `avatar_palette.dart` |
| `features/calendar/calendar_views.dart` | ۳۰۴ | `month_view.dart`, `week_view.dart` (+ `year_view.dart` که جداست) |
| `features/settings/settings_widgets.dart` | ۲۹۵ | `SettingRow`, `SettingSwitch`, `SettingSection`… هر کدام در فایل خودش یا ادغام با `shared/widgets` |
| `features/about/about_page.dart` | ۲۸۶ | صفحه + `about_header`, `about_links`, `about_credits` |
| `domain/services/app_lock.dart` | ۲۸۵ | مدل/حالت (`AppLockState/Config`) ← منطق PIN (`pin_hasher.dart`، خالص) ← notifier ← `BiometricAuth` |
| `features/settings/appearance_settings_page.dart` | ۲۸۳ | بخش تم / زبان / حرکت |
| `features/home/home_page.dart` | ۲۸۳ | `HomeHeader`، `HomeBody`، `_greeting` به helper |
| `features/home/widgets/cycle_ring.dart` | ۲۸۱ | سه painter (`CycleRingPainter`, `OrbitRingPainter`, `NightRingPainter`) ← سه فایل |
| `features/home/widgets/today_summary_card.dart` | ۲۷۳ | هدر، ردیف شاخص‌ها، دکمه‌ها |
| `features/home/widgets/quick_log_card.dart` | ۲۵۹ | `QuickLogCard` + `quick_symptoms_provider` |
| `domain/engine/cycle_engine.dart` | ۲۵۵ | به‌اندازه‌ی کافی خوب (قبلاً شکسته شد)؛ فقط `compute` را به مراحل نام‌دار تقسیم کن |
| `features/symptoms/daily_log_sheet.dart` | ۲۴۸ | کنترلر state جدا (`DailyLogDraft`) |
| `features/settings/widget_gallery_previews.dart` | ۲۴۲ | همراه `widget_gallery` |
| `features/profile/profile_page.dart` | ۲۳۰ | کارت پروفایل، آمار، لینک‌ها |
| `features/calendar/calendar_page.dart` | ۲۲۸ | state انتخاب روز (`CalendarController`) |
| `domain/services/notification_planner.dart` | ۲۲۵ | planner خالص ← provider همگام‌سازی |
| `night_sky_background`, `pattern_finder`, `widget_gallery_atoms`, `cycle_hero_day`, `language_picker`, `data_settings_page`, `dialogs`, `app_calendar` | ۲۰۱–۲۱۸ | کمی بالای حد؛ تفکیک سبک یا استثنای موقت در تست اندازه |

**ترتیب پیشنهادی:** اول فایل‌های **خالص و قابل‌تست** (`doctor_report`, `app_lock`, `labels`, `notification_planner`) چون با تست‌های موجود/جدید امن‌اند؛ بعد painterها؛ در آخر صفحه‌ها.

---

## ۷) فاز ۹ — معماری، state و ذخیره‌سازی

### ۷.۱ Riverpod و state

| # | کار | چرا |
|---|---|---|
| P9-1 | `StateNotifier` ← `Notifier`/`AsyncNotifier` برای ۹ notifier | در Riverpod 3 `StateNotifier` به `flutter_riverpod/legacy.dart` می‌رود؛ الان `2.6.1` است. مهاجرت مرحله‌ای: اول `Logs`, `Profile`, `Settings`, `UnusualCycles` (همه‌ی `DataSlice`) |
| P9-2 | `select` در ویجت‌های `cycleProvider` | ۱۴ جا کل snapshot را می‌بینند. مثلاً `daily_tips_card` فقط فاز، `week_strip` فقط روزهای هفته. با `select` فقط وقتی همان فیلد عوض شد rebuild می‌شوند |
| P9-3 | `home_page` | `ref.watch(profileProvider)` کامل؛ فقط نام/آواتار را `select` کن |
| P9-4 | ساعت تزریق‌پذیر | `DateTime.now()` ۱۰ جا (`app_lock` ۴، `notification_*` ۲، `home_page`، `lock_screen`…). یک `clockProvider` (`DateTime Function()`) تا تست‌ها زمان را کنترل کنند و باگ نیمه‌شب/منطقه‌ی زمانی قابل بازتولید باشد |
| P9-5 | `StatefulWidget` ۱۵ و `setState` ۴۲ | بیشترشان قانونی‌اند (انیمیشن، کنترلر متن). فقط مواردی که state «دامنه» نگه می‌دارند (`daily_log_sheet`, `onboarding_page`, `calendar_page`) را به یک notifier/controller کوچک ببر تا تست‌پذیر شوند |
| P9-6 | موقعیت `labels.dart` | در `core` است ولی به `domain` و `l10n` وابسته است. به `shared/localization` (یا `domain`) ببر و قانون «core به domain/features وابسته نیست» را به تست معماری اضافه کن |
| P9-7 | `domain/services` | فایل‌های `doctor_report`، `backup_files`، `home_widget_sync`، `notification_service` به پلاگین/پلتفرم وابسته‌اند، نه دامنه. زیرپوشه‌ی `platform/` برای آن‌ها و ماندن منطق خالص در `domain` |

### ۷.۲ ذخیره‌سازی و مقیاس

**وضعیت:** همه‌ی ثبت‌ها یک رشته‌ی JSON در `SharedPreferences`.
- هر `save` (حتی با debounce ۶۰۰ms) کل نقشه را encode و می‌نویسد.
- در شروع برنامه `load()` کل را همزمان decode می‌کند (روی isolate اصلی).
- **تخمین (باید اندازه‌گیری شود):** حدود ۱۵۰ بایت برای هر روز ثبت‌شده → ۵ سال ≈ ۲۷۰KB؛ هنوز قابل‌تحمل ولی رشد خطی دارد و `SharedPreferences` برای مقدارهای بزرگ طراحی نشده.

| # | کار | جزئیات |
|---|---|---|
| P9-8 | **اندازه‌گیری** | یک بنچمارک در `test/`: ۵ سال × ۳۶۵ ثبت؛ زمان `load()` و `encode()`. اگر `load` > ۵۰ms یا نوشتن > ۲۰ms شد، P9-9 |
| P9-9 | تکه‌تکه کردن بر اساس ماه | کلید `daily_logs_v2:2026-11`؛ فقط ماهِ تغییرکرده دوباره نوشته شود. `PersistedRepository` یک حالت «چندکلیدی» بگیرد. مهاجرت از v1 با `migrate` (از قبل آماده است) |
| P9-10 | (اگر پرس‌وجو لازم شد) SQLite | `drift`/`sqflite` فقط وقتی جست‌وجوی تاریخچه/آمار سنگین‌تر شد؛ الان لازم نیست |
| P9-11 | **داده‌ی خراب** | `getJson` الان `null` می‌دهد و ذخیره‌ی بعدی روی آن می‌نویسد. قبل از رونویسی، رشته‌ی خراب را در کلید `<key>.corrupt` نگه دار و یک پیام «داده‌ی قبلی خوانده نشد، نسخه‌ی کپی شد» نشان بده |
| P9-12 | **نوشتن‌های عقب‌افتاده** | `flushAll` در `paused/inactive/detached` می‌زنیم؛ اگر پروسه کشته شود ≤ ۶۰۰ms آخر از دست می‌رود. اگر مهم شد: `saveDelay` کمتر یا `Timer` کوتاه‌تر برای ثبت‌های «پریود/دما» |
| P9-13 | پشتیبان خودکار | نسخه‌ی گردشی (مثلاً ۳ تا) در `getApplicationDocumentsDirectory` هر هفته؛ بدون اینترنت |
| P9-14 | تست مهاجرت | هر بار `schemaVersion` بالا رفت، یک فایل نمونه‌ی نسخه‌ی قبل در `test/fixtures/` و تست رفت‌وبرگشت |

---

## ۸) امنیت و حریم خصوصی

برنامه کاملاً آفلاین است؛ پس تمرکز روی «کسی که گوشی را در دست دارد»، «پشتیبان» و «اعلان‌های قفل صفحه» است.

| # | یافته | شدت | راه‌حل |
|---|---|---|---|
| S-1 | `_failedAttempts` فقط در حافظه (`app_lock.dart` خط ۱۳۰)؛ `blockedUntil` هم در `state` است و persist نمی‌شود. با kill و اجرای دوباره، محدودیت ۵ تلاش/۳۰ ثانیه صفر می‌شود | بالا | شمارنده و `blockedUntil` را در `AppLockConfig` ذخیره کن؛ پس از هر دور، مدت قفل را افزایشی کن (۳۰s ← ۲m ← ۱۰m …) |
| S-2 | PIN ۴ رقمی = ۱۰٬۰۰۰ حالت؛ هش ۵٬۰۰۰ دور SHA-256 با نمک در `SharedPreferences` | متوسط | PBKDF2/Argon2 با دور بیشتر یا ذخیره‌ی هش در `flutter_secure_storage` (Android Keystore). **توجه:** هیچ هشی PIN ۴ رقمی را در برابر حمله‌ی آفلاین بی‌دفاع نمی‌کند؛ Keystore و جلوگیری از backup دست‌کم دسترسی را سخت می‌کند |
| S-3 | مقایسه‌ی هش با `==` | کم | مقایسه‌ی ثابت‌زمان (تابع کوچک) |
| S-4 | `android:allowBackup` | باید بررسی شود (فولدر `android/` در zip نبود) | اگر `true` است، داده‌ی `SharedPreferences` وارد Google Backup می‌شود؛ `false` یا `dataExtractionRules` برای کلیدهای قفل/داده |
| S-5 | محتوای اعلان روی صفحه‌ی قفل گوشی | متوسط | گزینه‌ی «اعلان‌ها با متن خنثی» (مثلاً «یادآوری Little Moon») و `VISIBILITY_PRIVATE` برای اعلان‌ها |
| S-6 | نمایش در «برنامه‌های اخیر» (recents) | متوسط | `FLAG_SECURE` وقتی قفل فعال است، یا پوشش خالی هنگام `inactive` |
| S-7 | فایل پشتیبان JSON متن ساده است | متوسط | گزینه‌ی رمزگذاری با رمز کاربر (AES-GCM از `cryptography`)؛ هشدار هنگام ذخیره‌ی بدون رمز |
| S-8 | `debugPrint` خطاها (۱۱ مورد) | کم | بدون داده‌ی کاربر است؛ ولی یک `AppLog` (فقط در debug) بگذار تا بعداً داده‌ی حساس وارد لاگ نشود |

---

## ۹) پایداری، کیفیت و فرایند

### ۹.۱ خطا و crash

- ۱۴ `catch` در `lib/`؛ بیشترشان `debugPrint` می‌کنند. چهار `catch (_)` بی‌صدا هستند: `about_page` (با کپی لینک fallback دارد) و `home_widget_sync.canPin` (`false` برمی‌گرداند) **قابل‌قبول‌اند**؛ ولی `local_store.getJson` (خطر رونویسی داده‌ی خراب، P9-11) و `backup_service.decode` (فقط `null`؛ بهتر است دلیل خطا برگردد تا UI پیام دقیق‌تری بدهد) باید اصلاح شوند.
- **هندلر سراسری:** `FlutterError.onError` و `PlatformDispatcher.instance.onError` در `main()` که خطا را در یک فایل لاگ محلی (آخرین ۵۰ خط) بنویسد و در تنظیمات «گزارش مشکل» بتواند کپی کند. بدون اینترنت و بدون ارسال خودکار.

### ۹.۲ تحلیل ایستا (`analysis_options.yaml`)

الان فقط `flutter_lints` پیش‌فرض است. افزودن:

```yaml
analyzer:
  language:
    strict-casts: true
    strict-inference: true
    strict-raw-types: true
  errors:
    unused_import: error
    unused_local_variable: error

linter:
  rules:
    - always_use_package_imports
    - prefer_final_locals
    - prefer_final_in_for_each
    - unawaited_futures
    - avoid_dynamic_calls
    - always_declare_return_types
    - sort_constructors_first
    - use_super_parameters
    - prefer_const_declarations
    - directives_ordering
```

اول با `info`، بعد از رفع، به `error` ارتقا بده. `dynamic` الان ۲۲ بار در کد است (بیشتر JSON)؛ `strict-raw-types` آن‌ها را نشان می‌دهد.

### ۹.۳ تست

| حوزه | وضعیت | هدف |
|---|---|---|
| موتور چرخه، الگوها، پشتیبان، ذخیره، لایه‌ها، ARB | هست | حفظ |
| **قفل برنامه** (۵ تلاش، مسدودی، grace، بیومتریک) | ندارد | تست واحد روی `PinHasher` و notifier با `clockProvider` ساختگی |
| **مسیر‌یابی/redirect** (onboarding ← home، قفل) | ندارد | تست `GoRouter` |
| **ویجت‌های کلیدی** (home، تقویم، لاگ روزانه) | `widget_test.dart` فقط placeholder | ۵ تست smoke با `ProviderScope` و `LocalStore` ساختگی |
| **golden** (۲ تم × ۲ زبان RTL/LTR برای ۳ صفحه) | ندارد | برای جلوگیری از شکستن RTL |
| **بنچمارک ذخیره‌سازی** (P9-8) | ندارد | یک تست غیر‌CI |
| پوشش | اندازه‌گیری نمی‌شود | `flutter test --coverage` و گزارش lcov؛ هدف ۷۰٪ برای `domain`/`data` |

### ۹.۴ ممنوعیت‌های خودکار (تست‌های نگهبان)

دو تست ساده‌ی `dart:io` (مثل `architecture_test.dart`):

1. **`file_size_test.dart`** — هیچ فایل `lib/` (به‌جز `l10n/generated`) بیش از **۲۵۰ خط** نباشد؛ فهرست استثناها با تاریخ و دلیل. هر فاز استثناها را کم می‌کند.
2. **`forbidden_patterns_test.dart`** — در `lib/` (خارج از `core/theme`) نباشد: `Theme.of(context)`، `BorderRadius.circular(`، `Color(0x` ، `Navigator.of(context).pop` (بعد از P5)، `DateTime.now()` (به‌جز `clock.dart`)، `showModalBottomSheet(` (به‌جز `moon_sheet.dart`)، `debugPrint(` (به‌جز `app_log.dart`).

اینها قانون را «خودکار» می‌کنند، نه «به‌یاد سپردنی».

### ۹.۵ CI و فرایند

- یک workflow ساده (GitHub Actions یا اسکریپت محلی `tool/check`): `pub get` ← `dart format --set-exit-if-changed .` ← `flutter analyze` ← `flutter test --coverage`.
- **بودجه‌ی حجم:** یک مرحله‌ی دستی/CI که `flutter build apk --analyze-size` را اجرا و اگر APK `arm64` از مقدار ثبت‌شده بیشتر شد، هشدار بدهد.
- `pubspec.yaml`: `dart tool/pin_deps.dart --apply` برای ۷ بسته از ۸ `any` (به‌جز `intl`)؛ سپس هر ماه `flutter pub outdated`.
- نسخه‌دهی: `version:` + `CHANGELOG.md` در یک مرحله‌ی انتشار؛ تگ git.

### ۹.۶ i18n و RTL

- متن‌های انگلیسی خام در `Text('…')`: ۰ ✔. ۲۱ رشته‌ی فارسی/عربی در کد همگی نام زبان، ارقام یا ماه‌های تقویم‌اند ✔ (قابل‌قبول؛ ماه‌های شمسی بهتر است از `intl`/ARB بیایند).
- **بازبینی RTL:** `Alignment.centerLeft/Right` (۱۲)، `TextAlign.left/right` (۳) را یکی‌یکی بررسی کن؛ اگر جهت‌دار است باید `AlignmentDirectional.centerStart/End` و `TextAlign.start/end` باشد. `EdgeInsetsDirectional` ۷ بار و `EdgeInsets.only(left/right)` صفر بار ✔.
- تست golden (بخش ۹.۳) روی `fa` و `en` همین را تضمین می‌کند.

---

## ۱۰) نقشه‌ی راه و ترتیب اجرا

| فاز | محتوا | زحمت | ریسک | وابستگی |
|---|---|---|---|---|
| **۵** | پاکسازی مخزن (P5-1…10) | ۰٫۵ روز | خیلی کم | — |
| **۶** | asset و حافظه‌ی تصویر | ۰٫۵–۱ روز | کم | ۵ |
| **۷-الف** | تست‌های نگهبان (`file_size`, `forbidden_patterns`) **قبل** از تکرارزدایی | ۰٫۵ روز | کم | ۵ |
| **۷-ب** | تکرارزدایی (Gap، AppInsets، `showMoonSheet`، `AppRoutes`، `context.theme`…) | ۱–۲ روز | کم | ۷-الف |
| **S** | امنیت S-1، S-3، S-6 (سریع‌ها) | ۱ روز | متوسط | ساعت تزریق‌پذیر (P9-4) |
| **۸** | شکستن فایل‌های بزرگ | ۳–۵ روز (تدریجی) | متوسط | ۷-الف |
| **۹-الف** | `select` (P9-2/3) و `clockProvider` (P9-4) | ۱ روز | کم | — |
| **۹-ب** | `Notifier` مهاجرت (P9-1) | ۱–۲ روز | متوسط | تست‌های ذخیره |
| **۹-ج** | بنچمارک ذخیره‌سازی ← (در صورت لزوم) تکه‌تکه کردن ماه‌به‌ماه | ۱–۳ روز | متوسط | P9-8 |
| **Q** | تست‌های قفل/مسیر/ویجت/golden + lint سخت‌گیرانه | ۲–۳ روز | کم | ۹-الف |

**قاعده‌ی هر مرحله:** یک zip کوچک؛ `flutter analyze` و `flutter test` سبز؛ commit قبل و بعد؛ جدول پیشرفت در `REFACTOR_PLAN.md` به‌روز شود.

---

## ۱۱) اندازه‌گیری (تکمیل P4-4)

برای هر فاز یک ردیف در `PERFORMANCE.md`:

| معیار | ابزار |
|---|---|
| حجم APK/ABI | `flutter build apk --release --split-per-abi --analyze-size` |
| زمان شروع سرد | `flutter run --profile --trace-startup` (`timeToFirstFrameMicros`) |
| رم صفحه‌ی قفل/درباره | DevTools ← Memory |
| زمان فریم صفحه‌ی اصلی | DevTools ← Performance (۳۰ ثانیه) |
| تعداد به‌روزرسانی provider | `--dart-define=PROVIDER_STATS=true` |
| زمان `load()`/`save()` ثبت‌ها | بنچمارک P9-8 |
| تعداد rebuild | DevTools ← Track widget rebuilds |

---

## ۱۲) تعریف «تمام شد»

- [ ] `flutter analyze`: صفر مورد (با lintهای سخت‌گیرانه‌ی بخش ۹.۲)
- [ ] `flutter test`: سبز، شامل تست‌های نگهبان و تست قفل
- [ ] هیچ فایل `lib/` بالای ۲۵۰ خط؛ استثناهای مستند ≤ ۵
- [ ] اعداد جدول بخش ۲ به هدف رسیده‌اند
- [ ] حجم asset < ۰٫۵MB و حجم APK قبل/بعد ثبت شده
- [ ] محدودیت تلاش قفل با kill برنامه دور زده نمی‌شود
- [ ] داده‌ی خراب بی‌صدا رونویسی نمی‌شود
- [ ] جدول بخش ۱۱ برای هر فاز پر شده و در `docs/` است

---

## ۱۳) پیوست — فهرست سریع «کجا چی هست»

- **تکرار `Theme.of(context)`:** `grep -rn "Theme.of(context)" lib`
- **رنگ خارج از تم:** `shared/widgets/user_avatar.dart` (۲۸)، `features/settings/widget_gallery*.dart` (۷)
- **`any` در `pubspec.yaml`:** `intl`, `local_auth`, `crypto`, `home_widget`, `pdf`, `printing`, `file_picker`, `url_launcher`
- **`StateNotifier` (۹ تا):** `LogsNotifier`, `UnusualCyclesNotifier`, `ProfileNotifier`, `SettingsNotifier`, `AppLockNotifier`, `ThemeNotifier`, `AutoNightThemeNotifier`, `LocaleNotifier`, `HapticsNotifier`
- **`DateTime.now()`:** `app_lock.dart` (۴)، `notification_service.dart`، `notification_planner.dart`، `home_page.dart`، `lock_screen.dart`، `data_settings_page.dart`، `cycle_providers.dart` (`todayProvider`)
- **catch بی‌صدا که باید اصلاح شود:** `local_store.dart:28`، `backup_service.dart:45` (دو مورد دیگر، `about_page.dart:36` و `home_widget_sync.dart:142`، fallback دارند و قابل‌قبول‌اند)
- **asset بی‌مصرف:** `assets/images/logo/littlemoon_icon.png`، `assets/images/logo/lmicon.jpg`
