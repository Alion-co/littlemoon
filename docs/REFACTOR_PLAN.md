# Little Moon — برنامه‌ی سبک‌سازی، معماری و سرعت

> هدف: کد سبک‌تر، بدون فایل‌های غول‌پیکر، بدون تکرار، و برنامه‌ی سریع‌تر.
> تاریخ: ۲۱ نوامبر ۲۰۲۶

---

## ۱) وضعیت فعلی (اندازه‌گیری از روی کد)

| مشاهده | عدد / نمونه |
|---|---|
| حجم کد دستی (بدون l10n تولیدشده) | حدود ۱۷٬۰۰۰ خط (`features` ≈ ۹٬۹۰۰) |
| `theme.extension<MoonColors>()` | ۴۶ بار تکرار |
| `final subtitleColor = ...` | ۲۳ بار تکرار |
| `BorderRadius.circular(...)` مستقیم | ۸۱ بار (با وجود `AppRadius`) |
| ویجت‌های کوچیک مشابه | `_StatTile`، `_MeasureTile`، `_InfoRow`، `_CountTile`، `_CountBar`، `_SettingRow`، `_NightTile` |
| صفحه/ویجتی که `cycleProvider` رو می‌بینه | ۱۴ |
| `ref.watch(logsProvider)` (کل ثبت‌ها) | ۹ جا |
| ذخیره‌ی ثبت‌ها | با هر تغییر، کل JSON دوباره نوشته می‌شه |

**بزرگ‌ترین فایل‌ها:** `cycle_engine.dart` (~۷۵۰) · `insights_cards.dart` (~۴۶۰) · `daily_log_sheet.dart` (~۴۳۰) · `health_page.dart` (~۴۳۰) · `cycle_hero_card.dart` (~۴۰۰) · `onboarding_page.dart` (~۴۰۰) · `lock_screen.dart` (~۴۰۰)

---

## ۲) اصل‌ها

- هر مرحله **یک zip کوچیک و مستقل** است.
- بعد از هر مرحله `flutter analyze` تمیز و `flutter test` پاس باشه.
- رفتار و ظاهر برنامه عوض نمی‌شه، مگر اینکه خود مرحله بگه.
- هیچ فایلی بیشتر از **حدود ۲۰۰ خط** نشه و هر کلاس **یک کار** داشته باشه.
- اگه مرحله‌ای تعداد خط‌ها رو کم نکرده باشه، ناقصه.

---

## ۳) فاز ۱ — ابزارهای مشترک (پایان تکرار)

| # | کار | خروجی |
|---|---|---|
| P1-1 | extension روی `BuildContext`: `context.moon`، `context.subtitle`، `context.text`؛ جایگزینی ۴۶+۲۳ تکرار. `BorderRadius.circular(n)` → `AppRadius` | چند صد خط کمتر، ظاهر بدون تغییر |
| P1-2 | ویجت‌های مشترک در `shared/widgets`: `StatTile` (جای `_StatTile`/`_MeasureTile`/`_CountTile`)، `InfoRow` و `SettingRow` (ردیف لیبل و مقدار)، `BarRow` (جای `_CountBar` و میله‌های تاریخچه) | یک ویجت به‌جای چندتا |

## ۴) فاز ۲ — شکستن فایل‌های بزرگ

| # | کار |
|---|---|
| P2-1 | `cycle_engine.dart` → مدل‌ها · تشخیص دوره/چرخه · لوتئال و BBT · ساخت snapshot (تست‌ها بدون تغییر) |
| P2-2 | `insights_cards.dart` → یک فایل برای هر کارت (پیش‌بینی، تاریخچه، یادگیری BBT، ...) |
| P2-3 | `HealthPage.build` → ویجت‌های کوچیک (کارت فاز، آب، وزن/دما، خواب) |
| P2-4 | `_DailyLogSheetState` → بخش‌ها (خلق‌وخو، علائم، درد، یادداشت) |
| P2-5 | بعدی‌ها: `cycle_hero_card`، `onboarding_page`، `lock_screen`، `charts_page` |

## ۵) فاز ۳ — معماری ضدّ تکرار

| # | کار | چرا |
|---|---|---|
| P3-1 | **محاسبه از UI بیرون:** آخرین دما، میانگین خواب، شمارش علائم → providerهای جدا (`healthSummaryProvider`، `symptomStatsProvider`) | صفحه فقط نمایش بده؛ محاسبه تکرار و دوباره‌کاری نشه |
| P3-2 | **ذخیره‌سازی یکپارچه:** کلاس پایه‌ی repository با encode/decode و نسخه‌ی ساختار؛ هر repository خودش رو برای **پشتیبان و ریست ثبت می‌کنه** | داده‌ی جدید (مثل `unusualCycles`) دیگه سه جا دستی عوض نمی‌شه |
| P3-3 | **قانون لایه‌ها:** `features` ← `domain`/`shared` · `domain` ← `data` · `domain/engine` بدون Flutter؛ یک تست ایمپورت‌ها رو چک کنه | معماری با زمان خراب نشه |
| P3-4 | **ترجمه‌ها:** یک مسیر ثابت برای `arb_additions` و `l10n` (جلوگیری از مشکل مسیر که پیش اومد) | رشته‌های جدید بدون دردسر merge بشن |

## ۶) فاز ۴ — سرعت

| # | کار | اثر |
|---|---|---|
| P4-1 | **providerهای ریزتر:** `cycleProvider` فقط به روزهای پریود، دماها و چرخه‌های غیرعادی وابسته باشه؛ در صفحه‌ها `ref.watch(x.select(...))` | ثبت آب/وزن/یادداشت دیگه موتور چرخه رو از نو اجرا نمی‌کنه |
| P4-2 | **ذخیره‌ی سبک:** نوشتن با debounce و یک‌بار بعد از چند تغییر پشت‌هم | کم‌شدن I/O و مصرف باتری |
| P4-3 | **رندر:** `const` برای ویجت‌های ثابت · `RepaintBoundary` دور انیمیشن‌های سنگین (حلقه‌ی چرخه، آسمان شب) · `ListView.builder`/slivers برای لیست‌های بلند | فریم روان‌تر |
| P4-4 | **اندازه‌گیری:** `flutter run --profile` + DevTools، قبل و بعد (تعداد rebuild و زمان فریم) | اثبات واقعی بهبود |

---

## ۷) ترتیب پیشنهادی

1. فاز ۱ (ریسک کم، بیشترین کاهش خط)
2. فاز ۲
3. P4-1 (سریع‌ترین بهبود سرعت)
4. بقیه‌ی فاز ۳ و ۴

## ۸) پیش‌نیاز شروع

- `lib.zip` **نسخه‌ی فعلی خودت** (بعد از همه‌ی اصلاح‌ها)، به‌همراه `test/`، `pubspec.yaml` و `l10n.yaml`
- نتیجه‌ی `flutter analyze` و `flutter test` به‌عنوان خط پایه
- قبل از هر zip: commit

## ۹) پیشرفت

| مرحله | وضعیت |
|---|---|
| P1-1 | ✅ |
| P1-2 | ✅ |
| P2-1 | 🟨 کد نوشته شد؛ `flutter analyze` و `flutter test` هنوز اجرا نشده |
| P2-2 | 🟨 همان |
| P2-3 | 🟨 همان |
| P2-4 | 🟨 همان |
| P2-5 | 🟨 `cycle_hero_card`، `onboarding_page`، `lock_screen`، `charts_page` شکسته شد؛ همان |
| P3-1 | 🟨 `HealthSummary` و `SymptomStats` به `domain/engine` رفتن (بدون Flutter)؛ `healthSummaryProvider` و `symptomStatsProvider` در `domain/services/stats_providers.dart`؛ صفحه‌ی سلامت، بینش‌ها و ثبت سریع فقط می‌خونن. `flutter analyze` و `flutter test` هنوز اجرا نشده |
| P3-2 | 🟨 `PersistedRepository<T>` (encode/decode، نسخه‌ی ساختار `<key>.schema`، `migrate`) + رابط `DataSlice`؛ پشتیبان، بازیابی و ریست از `dataSlicesProvider` می‌خونن (`BackupData` حذف شد). همان |
| P3-3 | 🟨 `test/architecture_test.dart`؛ `floating_navbar.dart` از `features/home/widgets` به `shared/widgets` رفت. همان |
| P3-4 | 🟨 مسیر ثابت `arb_additions/` در ریشه (`lib/arb_additions` حذف شد)؛ `tool/merge_arb.dart` فقط همین مسیر رو می‌شناسه؛ `test/l10n/arb_paths_test.dart`. همان |
| P4-1 | 🟨 `cycleProvider` فقط به `CycleInputs` (روزهای پریود + دماها)، طول‌های پروفایل و چرخه‌های غیرعادی وابسته‌ست؛ `patternsProvider` فقط به `PatternInputs`؛ `select` در صفحه‌های تقویم و پروفایل و برای `loggedToday`. `flutter analyze` و `flutter test` هنوز اجرا نشده |
| P4-2 | 🟨 `PersistedRepository.saveDelay` + `flush`/`flushAll`؛ ثبت‌های روزانه با debounce ۶۰۰ms نوشته می‌شن و موقع رفتن به پس‌زمینه، بازیابی و ریست فوراً. تست‌ها هنوز اجرا نشده |
| P4-3 | 🟨 `RepaintBoundary` داخل `Breathing` (انیمیشن بی‌پایان حلقه‌ی چرخه)؛ `const`ها و `ListView`ها از قبل درست بودن |
| P4-4 | 🟨 ابزار: `ProviderStats` (`--dart-define=PROVIDER_STATS=true`) و `PERFORMANCE.md`؛ عددهای قبل/بعد باید روی گوشی گرفته بشه |

### فاز ۵ و ۶ (از `OPTIMIZATION_PLAN.md`)

| مرحله | وضعیت |
|---|---|
| P5-1 | ✅ `lib/database/` توی zip نبود (از قبل پاک شده) |
| P5-2 | ✅ `l10n/app_localizations*.dart` توی zip نبود (از قبل پاک شده) |
| P5-3 | ✅ `tools/` توی zip نبود؛ همه‌چیز توی `tool/` |
| P5-4 | 🟨 `tool/check.bat` بازنویسی شد: `pub get` ← `format` (بدون نوشتن) ← `analyze` ← `test`، توقف در اولین خطا، بدون `pub add`. اجرا نشده |
| P5-5 | 🟨 `test/cycle_engine_test.dart` حذف شد؛ گروه «حداقل داده» به `test/domain/cycle_engine_test.dart` و تست `JalaliDate` به `test/core/jalali_test.dart` رفت |
| P5-6 | 🟨 `v1_1_features_test` و `v1_2_features_test` بر اساس موضوع شکسته شدن (`app_lock`، `notification_planner`، `doctor_report`، `home_widget`، `prediction_range`، `personal_patterns`، `settings_model`، `daily_log`، `backup`)؛ داده‌ی نمونه‌ی مشترک: `test/helpers/cycle_fixtures.dart`؛ `bbt_and_luteal_test` رفت زیر `test/domain/`. اجرا نشده |
| P5-7 | 🟨 `assets/icons` توی zip و `pubspec` نبود؛ اسکریپت asset اگر خالی باشه پاکش می‌کنه |
| P5-8 | ✅ `CHANGELOG.md` (ریشه) ← ادغام `CHANGES*.md`؛ بقیه‌ی مستندات توی `docs/` |
| P5-9 | 🟨 `.gitattributes` (`eol=lf`؛ `.bat/.ps1` با CRLF)؛ ۱۹ فایل از CRLF به LF رفت. **یک‌بار `dart format` بزن و جدا commit کن** |
| P5-10 | ✅ `.gitignore`: `tool/check_log.txt`، `pubspec.yaml.bak`؛ `*.iml` و `.flutter-plugins-dependencies` از قبل بودن |
| P6-1 | 🟨 `pubspec.yaml` فقط دو فایل لازم رو لیست می‌کنه؛ آیکون launcher به `design/` اشاره می‌کنه؛ `assets/` توی zip نبود، پس **فایل‌ها هنوز باید با `tool/prepare_assets.ps1` جابه‌جا و کوچک بشن** |
| P6-2 | 🟨 `MoonLogo` و `AlionBadge` (`shared/widgets/moon_logo.dart`) با `cacheWidth`؛ ۵ `Image.asset` جایگزین شد. رم هنوز اندازه‌گیری نشده |
| P6-3 | 🟨 `cupertino_icons` حذف شد (توی کد استفاده نمی‌شد)؛ `flutter pub get` لازمه تا `pubspec.lock` هم به‌روز شه. `AppAssets` برای مسیرها؛ `test/assets_test.dart` نگهبانشه |
| P6-4 | ⬜ نیاز به اندازه‌گیری روی بیلد واقعی: `--analyze-size`، R8 (`android/` توی zip نبود)، سهم `pdf`/`printing`. وزن‌های فونت: ۵۰۰ و ۶۰۰ هر دو توی کد استفاده می‌شن ← هر ۴ فایل می‌مونه |

