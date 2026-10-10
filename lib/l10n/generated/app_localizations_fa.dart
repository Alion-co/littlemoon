// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get homeGreeting => 'عصر بخیر';

  @override
  String dayOfCycle(int day) {
    return 'روز $day';
  }

  @override
  String get ofYourCycle => 'از چرخه شما';

  @override
  String get follicularPhase => 'فاز فولیکولی';

  @override
  String get lutealPhase => 'فاز لوتئال';

  @override
  String get menstrualPhase => 'فاز قاعدگی';

  @override
  String get ovulationPhase => 'فاز تخمک‌گذاری';

  @override
  String daysUntilPeriod(int days) {
    return '$days روز تا پریود بعدی';
  }

  @override
  String get cycleHealthy => 'چرخه شما در محدوده طبیعی خودش قرار دارد.';

  @override
  String get dailyCheckIn => 'ثبت حال روزانه';

  @override
  String get howAreYouFeeling => 'امروز حالت چطوره؟';

  @override
  String get flow => 'خونریزی';

  @override
  String get mood => 'خلق‌وخو';

  @override
  String get pain => 'درد';

  @override
  String get energy => 'انرژی';

  @override
  String get sleep => 'خواب';

  @override
  String get symptoms => 'علائم';

  @override
  String get todaysSummary => 'خلاصه امروز';

  @override
  String get logToday => 'ثبت\nامروز';

  @override
  String get good => 'خوب';

  @override
  String get medium => 'متوسط';

  @override
  String get mild => 'خفیف';

  @override
  String get yourCycleInsights => 'تحلیل چرخه‌ی تو';

  @override
  String get averageCycle => 'میانگین چرخه';

  @override
  String get recentPattern => 'الگوی اخیر';

  @override
  String get days => 'روز';

  @override
  String get home => 'خانه';

  @override
  String get calendar => 'تقویم';

  @override
  String get insights => 'تحلیل';

  @override
  String get health => 'سلامت';

  @override
  String get profile => 'پروفایل';

  @override
  String get month => 'ماه';

  @override
  String get week => 'هفته';

  @override
  String get period => 'پریود';

  @override
  String get fertile => 'باروری';

  @override
  String get ovulation => 'تخمک‌گذاری';

  @override
  String get periodDay => 'روز پریود';

  @override
  String get fertileWindow => 'بازه‌ی باروری';

  @override
  String get ovulationDay => 'روز تخمک‌گذاری';

  @override
  String get noDataLogged => 'داده‌ای ثبت نشده';

  @override
  String get logButton => 'ثبت';

  @override
  String get save => 'ذخیره';

  @override
  String get cancel => 'انصراف';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'ویرایش';

  @override
  String get clear => 'پاک کردن';

  @override
  String get ok => 'متوجه شدم';

  @override
  String get back => 'قبلی';

  @override
  String get next => 'بعدی';

  @override
  String get undo => 'لغو';

  @override
  String get today => 'امروز';

  @override
  String get notSet => 'ثبت نشده';

  @override
  String get notEnoughData => 'داده‌ی کافی نیست';

  @override
  String get invalidValue => 'این مقدار درست به نظر نمی‌رسه.';

  @override
  String get goodMorning => 'صبح بخیر';

  @override
  String get goodAfternoon => 'ظهر بخیر';

  @override
  String get goodNight => 'شب بخیر';

  @override
  String periodDayNumber(int day) {
    return 'روز $day پریود';
  }

  @override
  String periodLateBy(int days) {
    return 'پریود $days روز عقب افتاده';
  }

  @override
  String get periodLateOneDay => 'پریود ۱ روز عقب افتاده';

  @override
  String get periodExpectedToday => 'پریود امروز شروع می‌شه';

  @override
  String get periodExpectedTomorrow => 'پریود فردا شروع می‌شه';

  @override
  String get cycleLateNote =>
      'پریودت بیشتر از یک هفته عقب افتاده. اگه ادامه پیدا کرد، تست بارداری یا مشورت با پزشک رو در نظر بگیر.';

  @override
  String get cycleIrregularNote =>
      'طول چرخه‌های اخیرت با هم فرق داره، برای همین پیش‌بینی‌ها دقت کمتری دارن.';

  @override
  String get periodStartedToday => 'پریودم امروز شروع شد';

  @override
  String get periodContinuesToday => 'امروز هم پریودم';

  @override
  String get periodLoggedToday => 'پریود امروز ثبت شد';

  @override
  String get noCycleDataTitle => 'هنوز پریودی ثبت نشده';

  @override
  String get noCycleDataBody =>
      'روز اول آخرین پریودت رو ثبت کن تا Little Moon بتونه چرخه‌ات رو پیش‌بینی کنه.';

  @override
  String get logLastPeriod => 'ثبت آخرین پریود';

  @override
  String get predictionInfoTitle => 'این چطور حساب می‌شه؟';

  @override
  String get predictionInfoBody =>
      'پریود بعدی از روی میانگین طول چرخه‌های اخیری که ثبت کردی تخمین زده می‌شه. تخمک‌گذاری حدود ۱۴ روز قبل از پریود بعدی در نظر گرفته می‌شه و بازه‌ی باروری از ۵ روز قبل از تخمک‌گذاری تا ۱ روز بعدشه.\n\nهر چی پریودهای بیشتری ثبت کنی، پیش‌بینی دقیق‌تر می‌شه. این‌ها تخمین هستن — به‌عنوان روش پیشگیری از بارداری بهشون تکیه نکن.';

  @override
  String get reminders => 'یادآورها';

  @override
  String get noReminders => 'امروز یادآوری نداری.';

  @override
  String reminderPeriodSoon(int days) {
    return 'پریودت $days روز دیگه شروع می‌شه.';
  }

  @override
  String get reminderPeriodTomorrow => 'پریودت فردا شروع می‌شه.';

  @override
  String get reminderPeriodToday => 'پریودت امروز شروع می‌شه.';

  @override
  String get reminderFertileSoon => 'بازه‌ی باروری از فردا شروع می‌شه.';

  @override
  String get reminderFertileToday => 'الان در بازه‌ی باروری هستی.';

  @override
  String get reminderOvulationToday => 'امروز روز تخمینی تخمک‌گذاریه.';

  @override
  String get reminderLogToday => 'امروز هنوز چیزی ثبت نکردی.';

  @override
  String get remindersHint =>
      'یادآورهای چرخه ساعت ۹ صبح و یادآور ثبت روزانه ساعت ۹ شب به‌صورت نوتیفیکیشن گوشی میان. روی زنگوله‌ی صفحه‌ی خانه هم دیده می‌شن.';

  @override
  String get reminderPeriodSetting => 'نزدیک شدن پریود';

  @override
  String get reminderDaysBefore => 'چند روز قبل یادآوری بشه';

  @override
  String get reminderFertileSetting => 'بازه‌ی باروری';

  @override
  String get reminderOvulationSetting => 'روز تخمک‌گذاری';

  @override
  String get reminderLogSetting => 'ثبت روزانه';

  @override
  String get futureDayNotAllowed => 'فقط امروز و روزهای گذشته قابل ثبت هستن.';

  @override
  String get flowNone => 'بدون خونریزی';

  @override
  String get flowSpotting => 'لکه‌بینی';

  @override
  String get flowLight => 'کم';

  @override
  String get flowMedium => 'متوسط';

  @override
  String get flowHeavy => 'زیاد';

  @override
  String get moodHappy => 'شاد';

  @override
  String get moodCalm => 'آرام';

  @override
  String get moodSensitive => 'حساس';

  @override
  String get moodSad => 'غمگین';

  @override
  String get moodIrritable => 'کلافه';

  @override
  String get moodAnxious => 'مضطرب';

  @override
  String get painNone => 'بدون درد';

  @override
  String get painSevere => 'شدید';

  @override
  String get energyLow => 'کم';

  @override
  String get energyHigh => 'زیاد';

  @override
  String get symptomCramps => 'دل‌درد';

  @override
  String get symptomHeadache => 'سردرد';

  @override
  String get symptomBackPain => 'کمردرد';

  @override
  String get symptomBloating => 'نفخ';

  @override
  String get symptomBreastTenderness => 'حساسیت سینه';

  @override
  String get symptomAcne => 'جوش';

  @override
  String get symptomNausea => 'حالت تهوع';

  @override
  String get symptomFatigue => 'خستگی';

  @override
  String get symptomCravings => 'ویار';

  @override
  String get symptomInsomnia => 'بی‌خوابی';

  @override
  String get symptomDizziness => 'سرگیجه';

  @override
  String get symptomDischarge => 'ترشح';

  @override
  String get note => 'یادداشت';

  @override
  String get noteHint => 'هر چیزی که می‌خوای از امروز یادت بمونه…';

  @override
  String sleepHours(int hours) {
    return '$hours ساعت';
  }

  @override
  String sleepHoursMinutes(int hours, int minutes) {
    return '$hours ساعت و $minutes دقیقه';
  }

  @override
  String get predicted => 'پیش‌بینی';

  @override
  String get predictedPeriodDay => 'پریود پیش‌بینی‌شده';

  @override
  String cycleDayShort(int day) {
    return 'روز $day چرخه';
  }

  @override
  String get dataLogged => 'ثبت شده';

  @override
  String get insightsEmpty =>
      'وقتی اولین پریودت رو ثبت کنی، آمار و پیش‌بینی‌های چرخه‌ات اینجا نشون داده می‌شه.';

  @override
  String get averagePeriod => 'میانگین پریود';

  @override
  String get regularity => 'نظم چرخه';

  @override
  String get regular => 'منظم';

  @override
  String get irregular => 'نامنظم';

  @override
  String get cyclesTracked => 'چرخه‌های ثبت‌شده';

  @override
  String get predictions => 'پیش‌بینی‌ها';

  @override
  String get nextPeriod => 'پریود بعدی';

  @override
  String get followingPeriod => 'پریود بعدتر';

  @override
  String get cycleHistory => 'تاریخچه‌ی چرخه‌ها';

  @override
  String get historyEmpty =>
      'بعد از ثبت حداقل دو پریود، طول چرخه‌هات اینجا نشون داده می‌شه.';

  @override
  String get topSymptoms => 'علائم پرتکرار';

  @override
  String get last90Days => '۹۰ روز اخیر';

  @override
  String get noSymptomsLogged => 'هنوز علامتی ثبت نشده.';

  @override
  String get moodSummary => 'خلق‌وخو';

  @override
  String get noMoodLogged => 'هنوز خلق‌وخویی ثبت نشده.';

  @override
  String get medicalDisclaimer =>
      'پیش‌بینی‌ها تخمینی و بر اساس داده‌های ثبت‌شده‌ی خودت هستن. جای توصیه‌ی پزشکی رو نمی‌گیرن و نباید به‌عنوان روش پیشگیری از بارداری استفاده بشن.';

  @override
  String get yourBody => 'بدن تو';

  @override
  String get tipsForYou => 'توصیه‌های این فاز';

  @override
  String get todayTracking => 'امروز';

  @override
  String get water => 'آب';

  @override
  String glassesOfGoal(int count, int goal) {
    return '$count از $goal لیوان';
  }

  @override
  String get weight => 'وزن';

  @override
  String get weightHint => 'مثلاً 58.5';

  @override
  String get kg => 'کیلوگرم';

  @override
  String get bodyTemperature => 'دمای بدن';

  @override
  String get temperatureHint => 'مثلاً 36.6';

  @override
  String get tapToAdd => 'برای ثبت بزن';

  @override
  String get averageSleep7 => 'میانگین خواب (۷ روز)';

  @override
  String get pregnancyChanceToday => 'احتمال بارداری امروز';

  @override
  String get chanceLow => 'کم';

  @override
  String get chanceMedium => 'متوسط';

  @override
  String get chanceHigh => 'زیاد';

  @override
  String get aboutMenstrual =>
      'پریود شروع یک چرخه‌ی جدیده. دیواره‌ی رحم ریزش می‌کنه و طبیعیه که چند روزی انرژی کمتری داشته باشی.';

  @override
  String get aboutFollicular =>
      'بعد از پریود، استروژن بالا می‌ره و بدن برای آزاد کردن تخمک آماده می‌شه. بیشتر افراد توی این فاز پرانرژی‌تر و متمرکزترن.';

  @override
  String get aboutOvulation =>
      'حدود همین روزها تخمک آزاد می‌شه. این بارورترین بخش چرخه‌ست.';

  @override
  String get aboutLuteal =>
      'بعد از تخمک‌گذاری، پروژسترون بالا می‌ره. روزهای قبل از پریود ممکنه علائم PMS مثل نفخ، حساسیت سینه یا تغییر خلق‌وخو رو حس کنی.';

  @override
  String get aboutNoData =>
      'پریودت رو ثبت کن تا ببینی توی کدوم فاز چرخه هستی و توصیه‌های مناسبش رو بگیری.';

  @override
  String get tipMenstrual1 =>
      'هر وقت لازم بود استراحت کن. حرکت ملایم مثل پیاده‌روی یا کشش می‌تونه دل‌درد رو کم کنه.';

  @override
  String get tipMenstrual2 =>
      'کمپرس گرم روی پایین شکم می‌تونه درد رو کمتر کنه.';

  @override
  String get tipMenstrual3 =>
      'غذاهای آهن‌دار مثل عدس، اسفناج و گوشت قرمز، همراه با آب کافی، به بازیابی بدنت کمک می‌کنه.';

  @override
  String get tipFollicular1 =>
      'انرژی معمولاً توی این فاز بالا می‌ره؛ زمان خوبی برای ورزش‌های سنگین‌تره.';

  @override
  String get tipFollicular2 =>
      'زمان مناسبیه برای شروع برنامه‌های جدید یا کارهایی که تمرکز می‌خوان.';

  @override
  String get tipFollicular3 =>
      'وعده‌هات رو با پروتئین و سبزیجات تازه متعادل نگه دار.';

  @override
  String get tipOvulation1 => 'این روزها بارورترین زمان چرخه‌ست.';

  @override
  String get tipOvulation2 =>
      'درد خفیف یک‌طرفه‌ی پایین شکم یا ترشح شفاف‌تر حوالی تخمک‌گذاری معمولاً طبیعیه.';

  @override
  String get tipOvulation3 =>
      'انرژی و حال‌وهوا معمولاً در بهترین حالتشه؛ از فعال بودن لذت ببر.';

  @override
  String get tipLuteal1 =>
      'ممکنه علائم PMS مثل نفخ یا تغییر خلق‌وخو سراغت بیاد. با خودت مهربون باش.';

  @override
  String get tipLuteal2 =>
      'کم کردن نمک، کافئین و قند می‌تونه نفخ و کلافگی رو کمتر کنه.';

  @override
  String get tipLuteal3 =>
      'خواب کافی و ورزش سبک‌تر مثل یوگا یا پیاده‌روی رو در اولویت بذار.';

  @override
  String get tipGeneral1 =>
      'پریودت رو مرتب ثبت کن. بعد از چند چرخه پیش‌بینی‌ها دقیق‌تر می‌شن.';

  @override
  String get tipGeneral2 => 'آب کافی بخور و ساعت خوابت رو منظم نگه دار.';

  @override
  String get tipGeneral3 =>
      'اگه چرخه‌هات اغلب کوتاه‌تر از ۲۱ یا بلندتر از ۳۵ روزه، یا دردت شدیده، به پزشک مراجعه کن.';

  @override
  String get yourName => 'اسم تو';

  @override
  String get nameHint => 'چی صدات کنیم؟';

  @override
  String get noName => 'دوست عزیز';

  @override
  String trackingSince(String date) {
    return 'ثبت از $date';
  }

  @override
  String get daysLogged => 'روز ثبت‌شده';

  @override
  String get periodsLogged => 'پریود ثبت‌شده';

  @override
  String get cycleSettings => 'تنظیمات چرخه';

  @override
  String get cycleSettingsHint =>
      'تا وقتی چند چرخه ثبت نکردی، پیش‌بینی‌ها از این مقدارها استفاده می‌کنن.';

  @override
  String get cycleLength => 'طول چرخه';

  @override
  String get cycleLengthHint =>
      'از روز اول یک پریود تا روز اول پریود بعدی. معمولاً بین ۲۱ تا ۳۵ روز.';

  @override
  String get periodLength => 'طول پریود';

  @override
  String get periodLengthHint =>
      'خونریزی‌ات معمولاً چند روز طول می‌کشه. معمولاً بین ۳ تا ۷ روز.';

  @override
  String get lutealLength => 'طول فاز لوتئال';

  @override
  String get lutealLengthHint =>
      'فاصله‌ی تخمک‌گذاری تا پریود بعدی. اگه مقدار خودت رو نمی‌دونی روی ۱۴ بمونه.';

  @override
  String get privacyNote =>
      'همه‌چیز فقط روی همین دستگاه می‌مونه. Little Moon کاملاً آفلاین کار می‌کنه و داده‌هات رو هیچ‌جا نمی‌فرسته.';

  @override
  String get settings => 'تنظیمات';

  @override
  String get language => 'زبان';

  @override
  String get calendarType => 'تقویم';

  @override
  String get calendarJalali => 'شمسی';

  @override
  String get calendarGregorian => 'میلادی';

  @override
  String get theme => 'تم';

  @override
  String get themeMoon => 'ماه';

  @override
  String get themeSakura => 'شکوفه';

  @override
  String get themeLavender => 'اسطوخودوس';

  @override
  String get themeOcean => 'اقیانوس';

  @override
  String get themeMint => 'نعنا';

  @override
  String get themeSunset => 'غروب';

  @override
  String get themeMidnight => 'نیمه‌شب';

  @override
  String get themeNightRose => 'رز شب';

  @override
  String get dataAndBackup => 'داده‌ها و پشتیبان';

  @override
  String get backupHint =>
      'پشتیبان یک متن ساده‌ست که می‌تونی هر جا خواستی نگهش داری.';

  @override
  String get copyBackup => 'کپی پشتیبان در کلیپ‌بورد';

  @override
  String get backupCopied => 'پشتیبان کپی شد. یک جای امن ذخیره‌اش کن.';

  @override
  String get restoreBackup => 'بازگردانی از پشتیبان';

  @override
  String get restoreHint => 'متن پشتیبان رو اینجا جای‌گذاری کن';

  @override
  String get restoreInvalid => 'این متن یک پشتیبان معتبر Little Moon نیست.';

  @override
  String get restoreConfirm =>
      'همه‌ی داده‌های فعلی برنامه با این پشتیبان جایگزین می‌شن. ادامه بدم؟';

  @override
  String get restore => 'بازگردانی';

  @override
  String get restoreDone => 'پشتیبان بازگردانی شد.';

  @override
  String get deleteAllData => 'حذف همه‌ی داده‌ها';

  @override
  String get deleteAllConfirm =>
      'همه‌ی ثبت‌ها، پروفایل و تنظیماتت برای همیشه پاک می‌شن. این کار قابل برگشت نیست.';

  @override
  String get onboardingWelcomeTitle => 'خوش اومدی';

  @override
  String get onboardingWelcomeBody =>
      'Little Moon کمکت می‌کنه پریودت رو ثبت کنی و بدونی چی در پیشه. با چند سؤال کوتاه شروع می‌کنیم.';

  @override
  String get lastPeriodQuestion => 'آخرین پریودت کی شروع شد؟';

  @override
  String get lastPeriodHint =>
      'روز اول خونریزی رو انتخاب کن. بعداً هم می‌تونی عوضش کنی.';

  @override
  String get dontRemember => 'یادم نیست';

  @override
  String get periodLengthQuestion => 'پریودت معمولاً چند روز طول می‌کشه؟';

  @override
  String get cycleLengthQuestion => 'چرخه‌ات معمولاً چند روزه؟';

  @override
  String get getStarted => 'شروع';

  @override
  String get insightsTitle => 'تحلیل چرخه';

  @override
  String get dedication => 'این برنامه تقدیم می‌شه به ماه کوچولوی من';

  @override
  String get editProfile => 'ویرایش پروفایل';

  @override
  String get chooseAvatar => 'آواتارت رو انتخاب کن';

  @override
  String get aboutDeveloper => 'درباره‌ی سازنده';

  @override
  String get aboutAppBody =>
      'ماه کوچولو یک پلتفرم خصوصی، رایگان و آفلاین برای ثبت عادت ماهانه دختران و بانوان محترم است. چرخه ی ماهانه شما را از طریق اطلاعاتی که خودتان ثبت می کنید پیش بینی می کند و به شما نشان می دهد. تمام اطلاعات شما فقط داخل موبایل خودتان ذخیره می شود.';

  @override
  String appVersion(String version) {
    return 'نسخه $version';
  }

  @override
  String get developer => 'ساخته‌شده توسط';

  @override
  String get email => 'ایمیل';

  @override
  String get website => 'وب‌سایت';

  @override
  String get telegram => 'تلگرام';

  @override
  String get instagram => 'اینستاگرام';

  @override
  String get copied => 'کپی شد';

  @override
  String get madeWithLove => 'ساخته‌شده توسط شرکت ALION';
}
