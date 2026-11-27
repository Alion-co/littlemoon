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
    return '$days روز تا عادت ماهانه‌ی بعدی';
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
  String get period => 'عادت ماهانه';

  @override
  String get fertile => 'باروری';

  @override
  String get ovulation => 'تخمک‌گذاری';

  @override
  String get periodDay => 'روز عادت ماهانه';

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
    return 'روز $day عادت ماهانه';
  }

  @override
  String periodLateBy(int days) {
    return 'عادت ماهانه $days روز عقب افتاده';
  }

  @override
  String get periodLateOneDay => 'عادت ماهانه ۱ روز عقب افتاده';

  @override
  String get periodExpectedToday => 'عادت ماهانه امروز شروع می‌شه';

  @override
  String get periodExpectedTomorrow => 'عادت ماهانه فردا شروع می‌شه';

  @override
  String get cycleLateNote =>
      'عادت ماهانه‌ات بیشتر از یک هفته عقب افتاده. اگه ادامه پیدا کرد، تست بارداری یا مشورت با پزشک رو در نظر بگیر.';

  @override
  String get cycleIrregularNote =>
      'طول چرخه‌های اخیرت با هم فرق داره، برای همین پیش‌بینی‌ها دقت کمتری دارن.';

  @override
  String get periodStartedToday => 'عادت ماهانه‌ام امروز شروع شد';

  @override
  String get periodContinuesToday => 'امروز هم در عادت ماهانه هستم';

  @override
  String get periodLoggedToday => 'عادت ماهانه‌ی امروز ثبت شد';

  @override
  String get noCycleDataTitle => 'هنوز عادت ماهانه‌ای ثبت نشده';

  @override
  String get noCycleDataBody =>
      'روز اول آخرین عادت ماهانه‌ات رو ثبت کن تا ماه کوچولو بتونه چرخه‌ات رو پیش‌بینی کنه.';

  @override
  String get logLastPeriod => 'ثبت آخرین عادت ماهانه';

  @override
  String get predictionInfoTitle => 'این چطور حساب می‌شه؟';

  @override
  String get predictionInfoBody =>
      'عادت ماهانه‌ی بعدی از روی میانگین طول چرخه‌های اخیری که ثبت کردی تخمین زده می‌شه. تخمک‌گذاری حدود ۱۴ روز قبل از عادت ماهانه‌ی بعدی در نظر گرفته می‌شه و بازه‌ی باروری از ۵ روز قبل از تخمک‌گذاری تا ۱ روز بعدشه.\n\nهر چی چرخه‌های بیشتری ثبت کنی، پیش‌بینی دقیق‌تر می‌شه. این‌ها تخمین هستن — به‌عنوان روش پیشگیری از بارداری بهشون تکیه نکن.';

  @override
  String get reminders => 'یادآورها';

  @override
  String get noReminders => 'امروز یادآوری نداری.';

  @override
  String reminderPeriodSoon(int days) {
    return 'عادت ماهانه‌ات $days روز دیگه شروع می‌شه.';
  }

  @override
  String get reminderPeriodTomorrow => 'عادت ماهانه‌ات فردا شروع می‌شه.';

  @override
  String get reminderPeriodToday => 'عادت ماهانه‌ات امروز شروع می‌شه.';

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
  String get reminderPeriodSetting => 'نزدیک شدن عادت ماهانه';

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
  String get predictedPeriodDay => 'عادت ماهانه‌ی پیش‌بینی‌شده';

  @override
  String cycleDayShort(int day) {
    return 'روز $day چرخه';
  }

  @override
  String get dataLogged => 'ثبت شده';

  @override
  String get insightsEmpty =>
      'وقتی اولین عادت ماهانه‌ات رو ثبت کنی، آمار و پیش‌بینی‌های چرخه‌ات اینجا نشون داده می‌شه.';

  @override
  String get averagePeriod => 'میانگین عادت ماهانه';

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
  String get nextPeriod => 'عادت ماهانه‌ی بعدی';

  @override
  String get followingPeriod => 'عادت ماهانه‌ی بعدتر';

  @override
  String get cycleHistory => 'تاریخچه‌ی چرخه‌ها';

  @override
  String get historyEmpty =>
      'بعد از ثبت حداقل دو عادت ماهانه، طول چرخه‌هات اینجا نشون داده می‌شه.';

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
      'عادت ماهانه شروع یک چرخه‌ی جدیده. دیواره‌ی رحم ریزش می‌کنه و طبیعیه که چند روزی انرژی کمتری داشته باشی.';

  @override
  String get aboutFollicular =>
      'بعد از عادت ماهانه، استروژن بالا می‌ره و بدن برای آزاد کردن تخمک آماده می‌شه. بیشتر افراد توی این فاز پرانرژی‌تر و متمرکزترن.';

  @override
  String get aboutOvulation =>
      'حدود همین روزها تخمک آزاد می‌شه. این بارورترین بخش چرخه‌ست.';

  @override
  String get aboutLuteal =>
      'بعد از تخمک‌گذاری، پروژسترون بالا می‌ره. روزهای قبل از عادت ماهانه ممکنه علائم PMS مثل نفخ، حساسیت سینه یا تغییر خلق‌وخو رو حس کنی.';

  @override
  String get aboutNoData =>
      'عادت ماهانه‌ات رو ثبت کن تا ببینی توی کدوم فاز چرخه هستی و توصیه‌های مناسبش رو بگیری.';

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
      'عادت ماهانه‌ات رو مرتب ثبت کن. بعد از چند چرخه پیش‌بینی‌ها دقیق‌تر می‌شن.';

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
  String get periodsLogged => 'عادت ماهانه‌ی ثبت‌شده';

  @override
  String get cycleSettings => 'تنظیمات چرخه';

  @override
  String get cycleSettingsHint =>
      'تا وقتی چند چرخه ثبت نکردی، پیش‌بینی‌ها از این مقدارها استفاده می‌کنن.';

  @override
  String get cycleLength => 'طول چرخه';

  @override
  String get cycleLengthHint =>
      'از روز اول یک عادت ماهانه تا روز اول عادت ماهانه‌ی بعدی. معمولاً بین ۲۱ تا ۳۵ روز.';

  @override
  String get periodLength => 'طول عادت ماهانه';

  @override
  String get periodLengthHint =>
      'خونریزی‌ات معمولاً چند روز طول می‌کشه. معمولاً بین ۳ تا ۷ روز.';

  @override
  String get lutealLength => 'طول فاز لوتئال';

  @override
  String get lutealLengthHint =>
      'فاصله‌ی تخمک‌گذاری تا عادت ماهانه‌ی بعدی. اگه مقدار خودت رو نمی‌دونی روی ۱۴ بمونه.';

  @override
  String get privacyNote =>
      'همه‌چیز فقط روی همین دستگاه می‌مونه. ماه کوچولو کاملاً آفلاین کار می‌کنه و داده‌هات رو هیچ‌جا نمی‌فرسته.';

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
  String get restoreInvalid => 'این متن یک پشتیبان معتبر ماه کوچولو نیست.';

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
      'ماه کوچولو کمکت می‌کنه عادت ماهانه‌ات رو ثبت کنی و بدونی چی در پیشه. با چند سؤال کوتاه شروع می‌کنیم.';

  @override
  String get onboardingHello => 'سلام!';

  @override
  String get onboardingWelcomeLine => 'به Little Moon خوش اومدی';

  @override
  String get onboardingTagline =>
      'همراه همیشگی تو برای مدیریت دوره و حال خوب‌تر';

  @override
  String get lastPeriodQuestion => 'آخرین عادت ماهانه‌ات کی شروع شد؟';

  @override
  String get lastPeriodHint =>
      'روز اول خونریزی رو انتخاب کن. بعداً هم می‌تونی عوضش کنی.';

  @override
  String get dontRemember => 'یادم نیست';

  @override
  String get periodLengthQuestion =>
      'عادت ماهانه‌ات معمولاً چند روز طول می‌کشه؟';

  @override
  String get cycleLengthQuestion => 'چرخه‌ات معمولاً چند روزه؟';

  @override
  String get getStarted => 'شروع';

  @override
  String get insightsTitle => 'تحلیل چرخه';

  @override
  String get dedication => 'تقدیم به ماه کوچولو';

  @override
  String get editProfile => 'ویرایش پروفایل';

  @override
  String get chooseAvatar => 'آواتارت رو انتخاب کن';

  @override
  String get aboutDeveloper => 'درباره‌ی ماه کوچولو';

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

  @override
  String get appTitle => 'ماه کوچولو';

  @override
  String dateRange(String start, String end) {
    return '$start تا $end';
  }

  @override
  String get privacySection => 'حریم خصوصی';

  @override
  String get appLock => 'قفل برنامه';

  @override
  String get appLockHint => 'با رمز عددی یا اثر انگشت از برنامه محافظت کن.';

  @override
  String get appLockOn => 'قفل برنامه فعال شد.';

  @override
  String get useBiometric => 'باز کردن با اثر انگشت';

  @override
  String get changePin => 'تغییر رمز';

  @override
  String get pinChanged => 'رمز عوض شد.';

  @override
  String get enterPin => 'رمزت رو وارد کن';

  @override
  String get newPin => 'یک رمز ۴ رقمی انتخاب کن';

  @override
  String get confirmPin => 'رمز رو دوباره وارد کن';

  @override
  String get pinMismatch => 'دو رمز یکی نبودن. دوباره امتحان کن.';

  @override
  String get wrongPin => 'رمز اشتباهه';

  @override
  String tooManyAttempts(int seconds) {
    return 'چند بار اشتباه زدی. $seconds ثانیه صبر کن.';
  }

  @override
  String get unlockReason => 'برای باز کردن ماه کوچولو';

  @override
  String get forgotPin => 'رمز رو فراموش کردم';

  @override
  String get forgotPinBody =>
      'رمز قابل بازیابی نیست، چون هیچ داده‌ای از گوشی بیرون نمی‌ره. می‌تونی همه‌ی داده‌ها رو پاک کنی و از اول شروع کنی؛ اگه قبلاً پشتیبان گرفتی، بعداً می‌تونی بازگردانیش کنی.';

  @override
  String get resetApp => 'پاک کردن و شروع دوباره';

  @override
  String get discreetNotifications => 'نوتیفیکیشن مخفی';

  @override
  String get discreetNotificationsHint =>
      'متن یادآورها و ویجت خنثی می‌شه و چیزی درباره‌ی چرخه نشون نمی‌ده. روی صفحه‌ی قفل گوشی هم دیده نمی‌شن.';

  @override
  String get discreetTitle => 'یادآوری';

  @override
  String get discreetCycleBody => 'یک یادآوری تازه داری.';

  @override
  String get discreetLogBody => 'یادداشت امروزت منتظره.';

  @override
  String get discreetPillBody => 'وقت یادآوری روزانه‌ات رسیده.';

  @override
  String get pillReminder => 'یادآور قرص';

  @override
  String get pillReminderTime => 'ساعت یادآور قرص';

  @override
  String get reminderPill => 'وقت خوردن قرصته.';

  @override
  String get widgetTitle => 'ویجت صفحه‌ی اصلی';

  @override
  String get widgetHint =>
      'روی جای خالی صفحه‌ی اصلی گوشی انگشتت رو نگه دار، «ویجت‌ها» رو بزن و ماه کوچولو رو اضافه کن. با روشن کردن نوتیفیکیشن مخفی، ویجت هم فقط شماره‌ی روز رو نشون می‌ده.';

  @override
  String get doctorReport => 'گزارش برای پزشک';

  @override
  String get doctorReportHint =>
      'خلاصه‌ی چرخه‌ها، علائم و خلق‌وخو به‌صورت PDF؛ روی همین گوشی ساخته می‌شه.';

  @override
  String get reportTitle => 'گزارش چرخه‌ی عادت ماهانه';

  @override
  String reportGenerated(String date) {
    return 'تاریخ تهیه: $date';
  }

  @override
  String reportWindow(int days, int logged) {
    return 'آمار علائم بر اساس $days روز اخیر ($logged روز ثبت‌شده)';
  }

  @override
  String get reportSummary => 'خلاصه';

  @override
  String get reportCycleRange => 'کوتاه‌ترین و بلندترین چرخه';

  @override
  String reportMinMax(int min, int max) {
    return '$min تا $max روز';
  }

  @override
  String get reportLastPeriod => 'شروع آخرین عادت ماهانه';

  @override
  String get reportStart => 'تاریخ شروع';

  @override
  String get reportInProgress => 'چرخه‌ی فعلی';

  @override
  String get reportUnitsNote =>
      'همه‌ی مقدارها به روز هستن. * یعنی احتمالاً یک عادت ماهانه در این چرخه ثبت نشده و در میانگین حساب نشده.';

  @override
  String reportTimes(int count) {
    return '$count بار';
  }

  @override
  String get reportPainDays => 'روزهای همراه با درد متوسط یا شدید';

  @override
  String get reportFooter =>
      'تهیه‌شده با ماه کوچولو — بر اساس داده‌هایی که خود کاربر ثبت کرده';

  @override
  String get reportFailed => 'ساختن گزارش ممکن نشد. دوباره امتحان کن.';

  @override
  String get year => 'سال';

  @override
  String get quickLog => 'ثبت سریع';

  @override
  String get quickLogHint => 'با یک لمس ذخیره می‌شه';

  @override
  String get detailedLog => 'ثبت دقیق';

  @override
  String get saveBackupFile => 'ذخیره‌ی پشتیبان در فایل';

  @override
  String get restoreBackupFile => 'بازگردانی از فایل پشتیبان';

  @override
  String get backupFileSaved => 'فایل پشتیبان ذخیره شد.';

  @override
  String get backupFileFailed =>
      'ذخیره‌ی فایل ممکن نشد؛ متن پشتیبان در کلیپ‌بورد کپی شد.';

  @override
  String reminderLate(int days) {
    return 'عادت ماهانه‌ات $days روز عقب افتاده. اگه شروع شده، ثبتش کن تا پیش‌بینی‌ها درست بمونن.';
  }

  @override
  String get lateReminderSetting => 'تأخیر عادت ماهانه';

  @override
  String get autoNightTheme => 'تم شب خودکار';

  @override
  String get autoNightThemeHint =>
      'وقتی گوشی روی حالت تیره‌ست، تم شب نشون داده می‌شه.';

  @override
  String get patternsTitle => 'الگوهای تو';

  @override
  String get patternsSubtitle => 'چیزهایی که در چند چرخه تکرار شدن';

  @override
  String get patternsEmpty =>
      'هنوز الگوی تکراری پیدا نشده. هر چی علائم و حالت رو در چرخه‌های بیشتری ثبت کنی، الگوهات اینجا نشون داده می‌شن.';

  @override
  String get patternsNote =>
      'فقط از روی ثبت‌های خودت و روی همین گوشی حساب می‌شه؛ تشخیص پزشکی نیست.';

  @override
  String get patternPain => 'درد متوسط یا شدید';

  @override
  String get patternDayBefore => 'معمولاً یک روز قبل از عادت ماهانه';

  @override
  String patternDaysBefore(int days) {
    return 'معمولاً حدود $days روز قبل از عادت ماهانه';
  }

  @override
  String patternDuring(int day) {
    return 'معمولاً روز $day عادت ماهانه';
  }

  @override
  String patternSeen(int cycles) {
    return 'در $cycles چرخه';
  }

  @override
  String get charts => 'نمودارها';

  @override
  String get chartsHint =>
      'روی هر نمودار بزن یا انگشتت رو بکش تا مقدار هر روز رو ببینی.';

  @override
  String get chartNotEnoughData => 'برای این نمودار حداقل دو ثبت لازمه.';

  @override
  String get chartCycleSubtitle => '۱۲ چرخه‌ی اخیر؛ خط‌چین میانگینه';

  @override
  String chartLastDays(int days) {
    return '$days روز اخیر';
  }

  @override
  String chartSleepSubtitle(int days) {
    return 'ساعت خواب در $days روز اخیر';
  }

  @override
  String get aboutTagline => 'همراه مهربان چرخه‌ی ماهانه‌ی تو';

  @override
  String get aboutMeta => 'رایگان و متن‌باز · کاملاً آفلاین';

  @override
  String get rateOnMyket => 'امتیاز در مایکت';

  @override
  String get rateOnBazaar => 'امتیاز در بازار';

  @override
  String get developerRole => 'سازنده‌ی این برنامه';

  @override
  String get contactCall => 'تماس';

  @override
  String get settingsAppearance => 'ظاهر و زبان';

  @override
  String remindersOnCount(int count) {
    return '$count یادآور روشن';
  }

  @override
  String get appLockStatusOn => 'قفل برنامه روشن';

  @override
  String get appLockStatusOff => 'قفل برنامه خاموش';

  @override
  String get settingsDataSubtitle => 'پشتیبان، بازگردانی و حذف داده‌ها';

  @override
  String get cycleRemindersGroup => 'چرخه';

  @override
  String get dailyRemindersGroup => 'روزانه';

  @override
  String get notificationsCaption => 'نوتیفیکیشن‌ها';

  @override
  String get backupFileCaption => 'فایل پشتیبان';

  @override
  String get backupTextCaption => 'انتقال با متن';

  @override
  String get dataLocalNote =>
      'تمام داده‌ها و فایل‌ها فقط در دستگاه تو قابل دسترسه و به هیچ سروری منتقل نمی‌شه.';

  @override
  String get widgetDayLabel => 'روز چرخه';

  @override
  String get widgetSizeWide => 'باریک · ۵×۱';

  @override
  String get widgetSizeSquare => 'کوچک · ۲×۲';

  @override
  String get widgetSizeMedium => 'متوسط · ۳×۲';

  @override
  String get addWidget => 'افزودن';

  @override
  String get widgetPinFailed =>
      'افزودن ویجت ممکن نشد. از بخش ویجت‌های صفحه‌ی اصلی گوشی اضافه‌اش کن.';

  @override
  String get careMenstrual =>
      'به خودت استراحت بده؛ بدنت داره کار بزرگی می‌کنه 🌙|یه دمنوش گرم حالت رو بهتر می‌کنه ☕|امروز با خودت مهربون‌تر باش 💗|آب کافی بنوش و کمی بیشتر بخواب 💧|کمپرس گرم روی شکم دردت رو کم می‌کنه 🌸';

  @override
  String get careFollicular =>
      'انرژیت داره برمی‌گرده؛ وقت شروع‌های تازه‌ست ✨|امروز روز خوبیه برای ورزش و حرکت 🏃‍♀️|ایده‌هات رو بنویس؛ ذهنت پرانرژیه 📝|مثل ماه، هر روز کامل‌تر می‌شی 🌒';

  @override
  String get careOvulation =>
      'امروز درخشان‌تر از همیشه‌ای ✨|اعتمادبه‌نفست رو جشن بگیر 💫|وقت خوبیه برای دیدن دوستات 🌸|انرژیت در اوجه؛ ازش لذت ببر ☀️';

  @override
  String get careLuteal =>
      'اگه کمی بی‌حوصله‌ای، کاملاً طبیعیه 🌙|نمک و کافئین رو کمتر کن؛ بدنت ممنونت می‌شه 🍵|یه پیاده‌روی آروم حالت رو بهتر می‌کنه 🍃|خواب کافی بهترین هدیه به خودته 😴';

  @override
  String get careDiscreet =>
      'امروز با خودت مهربون باش 💗|یه لیوان آب بنوش 💧|یه نفس عمیق بکش 🍃|تو فوق‌العاده‌ای ✨';

  @override
  String get widgetChooseHint =>
      'یکی رو انتخاب کن و به صفحه‌ی اصلی گوشی اضافه‌اش کن.';

  @override
  String addWidgetToHome(String name) {
    return 'افزودن ویجت $name';
  }

  @override
  String get widgetPinNotShown => 'پنجره‌ی افزودن ویجت باز نشد؟';

  @override
  String get widgetHelp => 'راهنما';

  @override
  String get widgetHelpTitle => 'ویجت اضافه نمی‌شه؟';

  @override
  String get widgetHelpBody =>
      'بعضی گوشی‌ها، مثل شیائومی و پوکو، تا اجازه ندی ویجت رو اضافه نمی‌کنن:\n\n۱. انگشتت رو روی آیکون ماه کوچولو نگه دار و «اطلاعات برنامه» رو بزن.\n۲. «مجوزهای دیگر» (Other permissions) رو باز کن.\n۳. «میانبرهای صفحه‌ی اصلی» (Home screen shortcuts) رو روی «اجازه» بذار.\n۴. برگرد و دوباره دکمه‌ی افزودن رو بزن.\n\nراه دیگه: روی جای خالی صفحه‌ی اصلی انگشتت رو نگه دار، «ویجت‌ها» رو بزن و ماه کوچولو رو پیدا کن.';

  @override
  String get widgetSizeLarge => 'بزرگ · ۵×۴';

  @override
  String get careGeneral =>
      'هر روز فرصتی تازه است تا با خودت مهربان‌تر باشی.|بدنت را بشنو؛ او هر روز با تو حرف می‌زند.|لازم نیست هر روز قوی باشی؛ کافی است با خودت صادق باشی.|استراحت هم بخشی از مسیر رشد توست.|تو در هر مرحله از چرخه‌ات ارزشمند هستی.|امروز با خودت همان‌طور رفتار کن که با بهترین دوستت رفتار می‌کنی.|لازم نیست همه‌چیز را همین امروز حل کنی.|بدن تو سزاوار مراقبت است، نه انتقاد.|به خودت اجازه بده آهسته‌تر پیش بروی.|تو مجبور نیستی هر روز بدرخشی؛ حضور تو کافی است.|یک نفس عمیق؛ یک لحظه آرامش؛ یک شروع تازه.|احساساتت دشمن تو نیستند؛ با مهربانی به آن‌ها گوش بده.|تو بیشتر از کارهایی هستی که امروز انجام می‌دهی.|هر قدم کوچکی که برای خودت برمی‌داری اهمیت دارد.|با بدن خود همکاری کن، نه اینکه با آن بجنگی.|امروز لازم نیست نسخه کامل خودت باشی.|تو حق داری هم‌زمان امیدوار و خسته باشی.|هر چرخه فرصتی برای شناخت بیشتر خودت است.|مهربانی با خودت یک عادت قدرتمند است.|به پیشرفتت افتخار کن، حتی اگر آهسته باشد.|اگر امروز به استراحت نیاز داری، به خودت گوش بده.|یک وعده غذایی آرام و مغذی هم نوعی عشق به خود است.|آب بنوش و چند لحظه به خودت فرصت بده.|کمی کشش ملایم می‌تواند دعوتی برای آرامش باشد.|خواب کافی هدیه‌ای است که به فردای خودت می‌دهی.|برای آرام شدن لازم نیست دلیل بزرگی داشته باشی.|یک دوش گرم می‌تواند لحظه‌ای فقط برای تو باشد.|اگر بدنت کندتر حرکت می‌کند، با او مهربان باش.|مرز گذاشتن هم نوعی مراقبت از خود است.|به خودت اجازه بده کمک بخواهی.|امروز یک کار کوچک انجام بده که به تو آرامش می‌دهد.|بدن تو نیازهای واقعی دارد؛ به آن‌ها احترام بگذار.|مراقبت از خود لازم نیست پیچیده یا پرهزینه باشد.|امروز از خودت بپرس: واقعاً به چه چیزی نیاز دارم؟|چند دقیقه دور از صفحه‌نمایش، هدیه‌ای به ذهنت بده.|با خودت قرار بگذار که امروز کمتر قضاوت کنی.|وقتی خسته‌ای، استراحت را لازم نیست توجیه کنی.|به جای کامل بودن، به واقعی بودن فکر کن.|امروز هم شایسته عشق و احترام هستی.|بدنت را بابت آنچه برایت انجام می‌دهد، تحسین کن.|قرار نیست هر احساسی را فوراً تغییر بدهی.|امروز کمی فضا برای خودت نگه دار.|تو می‌توانی هم قوی باشی و هم به حمایت نیاز داشته باشی.|بدن تو پروژه‌ای برای اصلاح کردن نیست؛ همراهی برای دوست داشتن است.|لازم نیست با بدنت بجنگی تا لایق عشق باشی.|هر ماه فرصتی تازه برای شناختن خودت است، نه قضاوت کردن خودت.|بدن تو لازم نیست شبیه هیچ بدن دیگری باشد.|ارزش تو با عددهای تقویم یا ترازو تعیین نمی‌شود.|به جای سرزنش بدن، کنجکاوانه آن را بشناس.|هر روز لازم نیست شبیه دیروز باشد.|بدن تو سزاوار صبر توست.|تغییر انرژی تو بخشی از تجربه انسانی است؛ با خودت همراه شو.|لازم نیست از هر روزت بیشترین بهره را ببری.|تو اجازه داری برنامه‌هایت را با نیازهایت هماهنگ کنی.|به خودت اعتماد کن؛ تو بهتر از هر کسی تجربه‌ات را می‌شناسی.|هر احساسی که داری، سزاوار توجه است.|لازم نیست برای نیاز داشتن به استراحت عذرخواهی کنی.|بدنت دشمن برنامه‌هایت نیست؛ اطلاعاتی برایت دارد.|خودشناسی از توجه به جزئیات کوچک شروع می‌شود.|به جای مقایسه، مسیر خودت را دنبال کن.|تو مجبور نیستی هر روز یکسان احساس کنی.|بدن تو شایسته احترام است، حتی در روزهای سخت.|با خودت نرم‌تر حرف بزن؛ کلمات درونی‌ات اهمیت دارند.|امروز لازم نیست همه جواب‌ها را بدانی.|به خودت فرصت بده تا رشد کنی، تغییر کنی و دوباره شروع کنی.|تو سزاوار آرامشی هستی که برای دیگران فراهم می‌کنی.|گاهی بهترین کار، کمتر انجام دادن است.|هر بار که به نیازت گوش می‌دهی، به خودت نزدیک‌تر می‌شوی.|بدن تو با تو همکاری می‌کند؛ قدردانش باش.|تو لازم نیست درد یا خستگی‌ات را کوچک بشماری.|مراقبت از خود یعنی جدی گرفتن نیازهای خودت.|تو می‌توانی دوباره شروع کنی، حتی از یک قدم کوچک.|هر بار که به خودت استراحت می‌دهی، شکست نخورده‌ای.|به بدنت اجازه بده ریتم خودش را داشته باشد.|آرامش تو هم بخشی از موفقیت توست.|امروز یک مرز سالم می‌تواند از انرژی تو محافظت کند.|تو مجبور نیستی برای همه در دسترس باشی.|یک لحظه سکوت هم می‌تواند مراقبت باشد.|امروز به جای فشار آوردن، از خودت حمایت کن.|تو می‌توانی به خودت افتخار کنی، حتی اگر کسی متوجه نشود.|هر روز لازم نیست پربازده باشد تا ارزشمند باشد.|به جای تنبیه خودت، کنجکاوانه بپرس چه چیزی کمکت می‌کند.|بدنت سزاوار توجهی است که به کارهایت می‌دهی.|از خودت نپرس چرا مثل همیشه نیستی؛ بپرس الان چه نیازی داری.|یک روز سخت، تمام داستان تو نیست.|به خودت فرصت بده احساساتت را بدون قضاوت تجربه کنی.|تو لازم نیست رنجت را ثابت کنی تا حمایت بگیری.|به خودت یادآوری کن: نیاز داشتن، انسانی بودن است.|آرام‌تر رفتن هم نوعی پیشرفت است.|تو می‌توانی هم به هدف‌هایت متعهد باشی و هم به استراحتت.|از بدن خود بابت همراهی‌اش در تمام روزها تشکر کن.|لازم نیست با همه احساساتت کاری انجام بدهی؛ گاهی فقط آن‌ها را ببین.|وقتی به خودت گوش می‌دهی، انتخاب‌های آگاهانه‌تری می‌کنی.|به جای سرزنش، به خودت حمایت هدیه بده.|تو می‌توانی روزت را دوباره تنظیم کنی؛ لازم نیست به برنامه بچسبی.|هر چرخه داستان خودش را دارد؛ با کنجکاوی آن را دنبال کن.|تغییراتت را ثبت کن تا الگوهای شخصی خودت را بهتر بشناسی.|چرخه تو شبیه هیچ‌کس دیگری لازم نیست باشد.|هرچه بیشتر خودت را بشناسی، مراقبت مناسب‌تری انتخاب می‌کنی.|بدن تو یک تقویم دقیق و یکسان برای همه نیست؛ الگوهای خودت را بشناس.|اگر الگوی چرخه‌ات تغییر کرد، با کنجکاوی و بدون سرزنش آن را بررسی کن.|ردیابی چرخه برای شناخت توست، نه برای محدود کردن تو.|بدن تو در طول ماه ممکن است نیازهای متفاوتی داشته باشد.|مشاهده بدون قضاوت، شروعی برای مراقبت بهتر است.|به جای پیش‌بینی قطعی، به نشانه‌های بدن خود توجه کن.|هر ماه فرصتی است برای یادگیری چیزی تازه درباره خودت.|به یاد داشته باش که تجربه هر فرد از چرخه متفاوت است.|نشانه‌های بدنت را یادداشت کن؛ دانستن می‌تواند آرامش‌بخش باشد.|چرخه‌ات بخشی از تجربه توست، نه تمام هویت تو.|هر روز فرصتی برای شروع دوباره است.|امروز لازم نیست همه‌چیز عالی باشد تا روز خوبی داشته باشی.|تو قوی‌تر از آنی هستی که روزهای سخت به تو القا می‌کنند.|به مسیرت اعتماد کن، حتی وقتی قدم بعدی روشن نیست.|هر بار که ادامه می‌دهی، چیزی درباره خودت می‌آموزی.|به خودت افتخار کن که تا اینجا آمده‌ای.|تو لازم نیست با سرعت دیگران حرکت کنی.|امید می‌تواند آرام و بی‌صدا هم وجود داشته باشد.|به خودت یادآوری کن که شروع‌های کوچک هم ارزش دارند.|تو می‌توانی برنامه‌ات را تغییر بدهی و همچنان به هدفت وفادار بمانی.|هر روز یک فرصت تازه برای انتخاب مهربانی است.|تو سزاوار همان حمایتی هستی که به دیگران می‌دهی.|وقتی مسیر دشوار می‌شود، با خودت هم‌تیمی باش.|لازم نیست همه تغییرها یک‌باره اتفاق بیفتند.|تو می‌توانی با قدم‌های کوچک، زندگی مهربان‌تری برای خودت بسازی.|هر روز لازم نیست شروعی بزرگ باشد؛ گاهی فقط یک نفس کافی است.|امروز به خودت فرصت بده تا دوباره امید را پیدا کنی.|تو می‌توانی هم‌زمان در حال یادگیری و در حال پیشرفت باشی.|به جای عجله، به قدم بعدی توجه کن.|تو برای ارزشمند بودن نیازی به اثبات چیزی نداری.|گاهی پیشرفت یعنی فهمیدن اینکه چه چیزی دیگر برایت مناسب نیست.|به خودت اجازه بده از نو تعریف کنی موفقیت برایت یعنی چه.|هر قدمی که با آگاهی برمی‌داری، تو را به خودت نزدیک‌تر می‌کند.|امروز به جای رقابت با دیروز، با خودت همراه شو.|تو می‌توانی مکث کنی، نفس بکشی و دوباره انتخاب کنی.|حتی در روزهای مبهم هم می‌توانی با خودت مهربان باشی.|امروز را با یک نیت مهربانانه برای خودت شروع کن.|تو شایسته رابطه‌ای آرام و مهربان با خودت هستی.|هر بار که به خودت احترام می‌گذاری، مرزهایت روشن‌تر می‌شوند.|تو می‌توانی بدون احساس گناه به خودت زمان بدهی.|به خودت یادآوری کن: من در حال یادگیری‌ام، نه عقب ماندن.|امروز می‌توانی یک انتخاب کوچک به نفع آرامشت انجام بدهی.|تو لازم نیست همه‌چیز را کنترل کنی تا احساس امنیت کنی.|هر روز فرصتی برای تمرین صبر با خودت است.|به یاد داشته باش که نیازهایت مهم هستند.|تو می‌توانی مهربان باشی و همچنان محکم بایستی.|امروز لازم نیست بیشتر تلاش کنی؛ شاید لازم باشد بیشتر حمایت شوی.|هر روز فرصتی است برای انتخاب خودت، بدون کنار گذاشتن دیگران.|تو سزاوار مراقبتی هستی که در روزهای سخت هم ادامه پیدا کند.|بدنت را با کنجکاوی بشناس، نه با ترس.|اگر نشانه‌ای نگران‌کننده یا درد شدیدی داری، کمک حرفه‌ای گرفتن نشانه مراقبت است.';

  @override
  String get careGeneralDiscreet =>
      'هر روز فرصتی تازه است تا با خودت مهربان‌تر باشی.|بدنت را بشنو؛ او هر روز با تو حرف می‌زند.|لازم نیست هر روز قوی باشی؛ کافی است با خودت صادق باشی.|استراحت هم بخشی از مسیر رشد توست.|امروز با خودت همان‌طور رفتار کن که با بهترین دوستت رفتار می‌کنی.|لازم نیست همه‌چیز را همین امروز حل کنی.|بدن تو سزاوار مراقبت است، نه انتقاد.|به خودت اجازه بده آهسته‌تر پیش بروی.|تو مجبور نیستی هر روز بدرخشی؛ حضور تو کافی است.|یک نفس عمیق؛ یک لحظه آرامش؛ یک شروع تازه.|احساساتت دشمن تو نیستند؛ با مهربانی به آن‌ها گوش بده.|تو بیشتر از کارهایی هستی که امروز انجام می‌دهی.|هر قدم کوچکی که برای خودت برمی‌داری اهمیت دارد.|با بدن خود همکاری کن، نه اینکه با آن بجنگی.|امروز لازم نیست نسخه کامل خودت باشی.|تو حق داری هم‌زمان امیدوار و خسته باشی.|به پیشرفتت افتخار کن، حتی اگر آهسته باشد.|اگر امروز به استراحت نیاز داری، به خودت گوش بده.|یک وعده غذایی آرام و مغذی هم نوعی عشق به خود است.|آب بنوش و چند لحظه به خودت فرصت بده.|کمی کشش ملایم می‌تواند دعوتی برای آرامش باشد.|خواب کافی هدیه‌ای است که به فردای خودت می‌دهی.|برای آرام شدن لازم نیست دلیل بزرگی داشته باشی.|یک دوش گرم می‌تواند لحظه‌ای فقط برای تو باشد.|اگر بدنت کندتر حرکت می‌کند، با او مهربان باش.|مرز گذاشتن هم نوعی مراقبت از خود است.|به خودت اجازه بده کمک بخواهی.|امروز یک کار کوچک انجام بده که به تو آرامش می‌دهد.|بدن تو نیازهای واقعی دارد؛ به آن‌ها احترام بگذار.|مراقبت از خود لازم نیست پیچیده یا پرهزینه باشد.|امروز از خودت بپرس: واقعاً به چه چیزی نیاز دارم؟|چند دقیقه دور از صفحه‌نمایش، هدیه‌ای به ذهنت بده.|با خودت قرار بگذار که امروز کمتر قضاوت کنی.|وقتی خسته‌ای، استراحت را لازم نیست توجیه کنی.|به جای کامل بودن، به واقعی بودن فکر کن.|امروز هم شایسته عشق و احترام هستی.|بدنت را بابت آنچه برایت انجام می‌دهد، تحسین کن.|قرار نیست هر احساسی را فوراً تغییر بدهی.|امروز کمی فضا برای خودت نگه دار.|تو می‌توانی هم قوی باشی و هم به حمایت نیاز داشته باشی.|لازم نیست با بدنت بجنگی تا لایق عشق باشی.|هر ماه فرصتی تازه برای شناختن خودت است، نه قضاوت کردن خودت.|بدن تو لازم نیست شبیه هیچ بدن دیگری باشد.|ارزش تو با عددهای تقویم یا ترازو تعیین نمی‌شود.|به جای سرزنش بدن، کنجکاوانه آن را بشناس.|هر روز لازم نیست شبیه دیروز باشد.|بدن تو سزاوار صبر توست.|تغییر انرژی تو بخشی از تجربه انسانی است؛ با خودت همراه شو.|لازم نیست از هر روزت بیشترین بهره را ببری.|تو اجازه داری برنامه‌هایت را با نیازهایت هماهنگ کنی.|به خودت اعتماد کن؛ تو بهتر از هر کسی تجربه‌ات را می‌شناسی.|هر احساسی که داری، سزاوار توجه است.|لازم نیست برای نیاز داشتن به استراحت عذرخواهی کنی.|بدنت دشمن برنامه‌هایت نیست؛ اطلاعاتی برایت دارد.|خودشناسی از توجه به جزئیات کوچک شروع می‌شود.|به جای مقایسه، مسیر خودت را دنبال کن.|تو مجبور نیستی هر روز یکسان احساس کنی.|بدن تو شایسته احترام است، حتی در روزهای سخت.|با خودت نرم‌تر حرف بزن؛ کلمات درونی‌ات اهمیت دارند.|امروز لازم نیست همه جواب‌ها را بدانی.|به خودت فرصت بده تا رشد کنی، تغییر کنی و دوباره شروع کنی.|تو سزاوار آرامشی هستی که برای دیگران فراهم می‌کنی.|گاهی بهترین کار، کمتر انجام دادن است.|هر بار که به نیازت گوش می‌دهی، به خودت نزدیک‌تر می‌شوی.|بدن تو با تو همکاری می‌کند؛ قدردانش باش.|تو لازم نیست درد یا خستگی‌ات را کوچک بشماری.|مراقبت از خود یعنی جدی گرفتن نیازهای خودت.|تو می‌توانی دوباره شروع کنی، حتی از یک قدم کوچک.|هر بار که به خودت استراحت می‌دهی، شکست نخورده‌ای.|به بدنت اجازه بده ریتم خودش را داشته باشد.|آرامش تو هم بخشی از موفقیت توست.|امروز یک مرز سالم می‌تواند از انرژی تو محافظت کند.|تو مجبور نیستی برای همه در دسترس باشی.|یک لحظه سکوت هم می‌تواند مراقبت باشد.|امروز به جای فشار آوردن، از خودت حمایت کن.|تو می‌توانی به خودت افتخار کنی، حتی اگر کسی متوجه نشود.|هر روز لازم نیست پربازده باشد تا ارزشمند باشد.|به جای تنبیه خودت، کنجکاوانه بپرس چه چیزی کمکت می‌کند.|بدنت سزاوار توجهی است که به کارهایت می‌دهی.|یک روز سخت، تمام داستان تو نیست.|به خودت فرصت بده احساساتت را بدون قضاوت تجربه کنی.|تو لازم نیست رنجت را ثابت کنی تا حمایت بگیری.|به خودت یادآوری کن: نیاز داشتن، انسانی بودن است.|آرام‌تر رفتن هم نوعی پیشرفت است.|تو می‌توانی هم به هدف‌هایت متعهد باشی و هم به استراحتت.|از بدن خود بابت همراهی‌اش در تمام روزها تشکر کن.|لازم نیست با همه احساساتت کاری انجام بدهی؛ گاهی فقط آن‌ها را ببین.|وقتی به خودت گوش می‌دهی، انتخاب‌های آگاهانه‌تری می‌کنی.|به جای سرزنش، به خودت حمایت هدیه بده.|تو می‌توانی روزت را دوباره تنظیم کنی؛ لازم نیست به برنامه بچسبی.|تغییراتت را ثبت کن تا الگوهای شخصی خودت را بهتر بشناسی.|هرچه بیشتر خودت را بشناسی، مراقبت مناسب‌تری انتخاب می‌کنی.|بدن تو یک تقویم دقیق و یکسان برای همه نیست؛ الگوهای خودت را بشناس.|بدن تو در طول ماه ممکن است نیازهای متفاوتی داشته باشد.|مشاهده بدون قضاوت، شروعی برای مراقبت بهتر است.|به جای پیش‌بینی قطعی، به نشانه‌های بدن خود توجه کن.|هر ماه فرصتی است برای یادگیری چیزی تازه درباره خودت.|نشانه‌های بدنت را یادداشت کن؛ دانستن می‌تواند آرامش‌بخش باشد.|هر روز فرصتی برای شروع دوباره است.|امروز لازم نیست همه‌چیز عالی باشد تا روز خوبی داشته باشی.|تو قوی‌تر از آنی هستی که روزهای سخت به تو القا می‌کنند.|به مسیرت اعتماد کن، حتی وقتی قدم بعدی روشن نیست.|هر بار که ادامه می‌دهی، چیزی درباره خودت می‌آموزی.|به خودت افتخار کن که تا اینجا آمده‌ای.|تو لازم نیست با سرعت دیگران حرکت کنی.|امید می‌تواند آرام و بی‌صدا هم وجود داشته باشد.|به خودت یادآوری کن که شروع‌های کوچک هم ارزش دارند.|تو می‌توانی برنامه‌ات را تغییر بدهی و همچنان به هدفت وفادار بمانی.|هر روز یک فرصت تازه برای انتخاب مهربانی است.|تو سزاوار همان حمایتی هستی که به دیگران می‌دهی.|وقتی مسیر دشوار می‌شود، با خودت هم‌تیمی باش.|لازم نیست همه تغییرها یک‌باره اتفاق بیفتند.|تو می‌توانی با قدم‌های کوچک، زندگی مهربان‌تری برای خودت بسازی.|هر روز لازم نیست شروعی بزرگ باشد؛ گاهی فقط یک نفس کافی است.|امروز به خودت فرصت بده تا دوباره امید را پیدا کنی.|تو می‌توانی هم‌زمان در حال یادگیری و در حال پیشرفت باشی.|به جای عجله، به قدم بعدی توجه کن.|تو برای ارزشمند بودن نیازی به اثبات چیزی نداری.|گاهی پیشرفت یعنی فهمیدن اینکه چه چیزی دیگر برایت مناسب نیست.|به خودت اجازه بده از نو تعریف کنی موفقیت برایت یعنی چه.|هر قدمی که با آگاهی برمی‌داری، تو را به خودت نزدیک‌تر می‌کند.|امروز به جای رقابت با دیروز، با خودت همراه شو.|تو می‌توانی مکث کنی، نفس بکشی و دوباره انتخاب کنی.|حتی در روزهای مبهم هم می‌توانی با خودت مهربان باشی.|امروز را با یک نیت مهربانانه برای خودت شروع کن.|تو شایسته رابطه‌ای آرام و مهربان با خودت هستی.|هر بار که به خودت احترام می‌گذاری، مرزهایت روشن‌تر می‌شوند.|تو می‌توانی بدون احساس گناه به خودت زمان بدهی.|به خودت یادآوری کن: من در حال یادگیری‌ام، نه عقب ماندن.|امروز می‌توانی یک انتخاب کوچک به نفع آرامشت انجام بدهی.|تو لازم نیست همه‌چیز را کنترل کنی تا احساس امنیت کنی.|هر روز فرصتی برای تمرین صبر با خودت است.|به یاد داشته باش که نیازهایت مهم هستند.|تو می‌توانی مهربان باشی و همچنان محکم بایستی.|امروز لازم نیست بیشتر تلاش کنی؛ شاید لازم باشد بیشتر حمایت شوی.|هر روز فرصتی است برای انتخاب خودت، بدون کنار گذاشتن دیگران.|تو سزاوار مراقبتی هستی که در روزهای سخت هم ادامه پیدا کند.|بدنت را با کنجکاوی بشناس، نه با ترس.|اگر نشانه‌ای نگران‌کننده یا درد شدیدی داری، کمک حرفه‌ای گرفتن نشانه مراقبت است.';

  @override
  String get cycleLateWithinRangeNote =>
      'عادت ماهانه‌ات کمی دیر کرده، ولی هنوز توی نوسان معمولِ چرخه‌هات هست.';

  @override
  String get cycleLateMildNote =>
      'عادت ماهانه‌ات از بازه‌ی معمولت دیرتر شده. استرس، سفر، بیماری یا کم‌خوابی می‌تونه چرخه رو جابه‌جا کنه. اگه ادامه پیدا کرد، تست بارداری یا مشورت با پزشک رو در نظر بگیر.';

  @override
  String get cycleShortNote =>
      'چرخه‌هات معمولاً کوتاه‌تر از ۲۱ روزه. اگه این برات تازگی داره، خوبه به پزشک بگی.';

  @override
  String get cycleLongNote =>
      'چرخه‌هات معمولاً بلندتر از ۳۵ روزه. اگه این برات تازگی داره، خوبه به پزشک بگی.';

  @override
  String get cycleMissedLogNote =>
      'یکی از چرخه‌هات خیلی طولانی به نظر می‌رسه، شاید ثبت یک عادت ماهانه از قلم افتاده. با اضافه کردنش پیش‌بینی‌ها دقیق‌تر می‌شن.';

  @override
  String get predictionConfidenceLow =>
      'اطمینان پیش‌بینی: کم. چند چرخه‌ی دیگه ثبت کن تا بهتر بشه.';

  @override
  String get predictionConfidenceMedium => 'اطمینان پیش‌بینی: متوسط.';

  @override
  String get predictionConfidenceHigh =>
      'اطمینان پیش‌بینی: زیاد. چرخه‌های اخیرت خیلی منظم بوده.';

  @override
  String reminderPatternSoon(String what) {
    return 'یادآوری: همین حوالی از چرخه‌ات معمولاً این‌ها رو حس می‌کنی: $what. مراقب خودت باش.';
  }

  @override
  String get hapticsTitle => 'لرزش لمسی';

  @override
  String get hapticsHint => 'لرزش ملایم هنگام لمس، ذخیره و ثبت';

  @override
  String get dailyTipsTitle => 'پیشنهادهای امروز';

  @override
  String get tipCategoryNutrition => 'تغذیه';

  @override
  String get tipCategoryMovement => 'حرکت';

  @override
  String get tipCategoryRest => 'استراحت';

  @override
  String get tipsTapHint => 'روی هر پیشنهاد بزن تا یکی دیگه ببینی.';

  @override
  String get tipNutritionMenstrual =>
      'غذاهای آهن‌دار مثل عدس، اسفناج و لوبیا می‌تونن کمبود آهن رو جبران کنن 🥬|سوپ گرم و دمنوش‌های گیاهی امروز آرامش‌بخش‌ان 🍵|بطری آب رو نزدیک خودت بذار؛ آب کافی می‌تونه نفخ رو کمتر کنه 💧';

  @override
  String get tipMovementMenstrual =>
      'امروز کشش ملایم یا یک پیاده‌روی آروم کافیه 🚶‍♀️|یوگای سبک می‌تونه گرفتگی کمر و لگن رو کمتر کنه 🧘‍♀️|به بدنت گوش بده؛ اشکالی نداره تمرین سنگین رو رد کنی 💗';

  @override
  String get tipRestMenstrual =>
      'امشب زودتر بخواب؛ بدنت داره سخت کار می‌کنه 😴|یک کیسه‌ی آب گرم روی زیرشکم می‌تونه آرامش بده 🌸|امروز به خودت اجازه بده آروم‌تر پیش بری 🌙';

  @override
  String get tipNutritionFollicular =>
      'سبزی و میوه‌ی تازه و غلات کامل با انرژی در حال افزایشت جور هستن 🥗|به وعده‌هات پروتئین اضافه کن تا سیر و پرانرژی بمونی 🍳|یک دستور غذایی سالم جدید امتحان کن؛ شاید حوصله‌ی آشپزی داشته باشی 🍲';

  @override
  String get tipMovementFollicular =>
      'انرژی‌ات داره بالا می‌ره؛ وقت خوبی برای کاردیو یا تمرین قدرتیه 🏃‍♀️|یک چیز تازه امتحان کن؛ کلاس، کوه‌پیمایی یا رقص 💃|خوب گرم کن، بعد می‌تونی کم‌کم کمی سخت‌تر تمرین کنی 💪';

  @override
  String get tipRestFollicular =>
      'خواب منظم داشته باش تا انرژی‌ات حفظ بشه ⏰|یک پیاده‌روی کوتاه زیر نور روز می‌تونه حالت رو بهتر کنه ☀️|الان که ذهنت تیزه، هفته‌ات رو برنامه‌ریزی کن 📝';

  @override
  String get tipNutritionOvulation =>
      'میوه و سبزی رنگارنگ امروز انتخاب قشنگیه 🍓|آب زیاد بخور؛ ممکنه گرم‌تر از همیشه باشی 💧|غذاهای پرفیبر مثل جو دوسر و لوبیا هضم رو راحت نگه می‌دارن 🥣';

  @override
  String get tipMovementOvulation =>
      'انرژی معمولاً در اوجه؛ از تمرینی که دوست داری لذت ببر ⚡|روز خوبی برای فعالیت گروهی یا یک پیاده‌روی دلچسب بیرونه 🌿|خوب گرم کن و بکش تا مفاصلت در امان بمونن 🧘‍♀️';

  @override
  String get tipRestOvulation =>
      'با آدم‌هایی که دوستشون داری وقت بگذرون؛ شاید اجتماعی‌تر باشی 💬|حتی تو روزهای پرانرژی، قبل از خواب آروم بگیر 🌙|بین کارها چند دقیقه ساکت بنشین و دوباره شارژ شو 🍃';

  @override
  String get tipNutritionLuteal =>
      'کربوهیدرات‌های کامل مثل جو دوسر و سیب‌زمینی شیرین می‌تونن حال‌وهوات رو متعادل کنن 🍠|اگه نفخ یا تنش داری، نمک و کافئین رو کمتر کن 🍵|آجیل، دانه‌ها و کمی شکلات تلخ می‌تونه میان‌وعده‌ی دلچسبی باشه 🍫';

  @override
  String get tipMovementLuteal =>
      'پیاده‌روی ملایم، یوگا یا شنا می‌تونه حالت رو بهتر کنه 🏊‍♀️|اگه خسته‌ای شدت رو کم کن؛ حرکت ملایم هم حساب می‌شه 🍃|کشش قبل از خواب می‌تونه تنش رو کم کنه 🧘‍♀️';

  @override
  String get tipRestLuteal =>
      'زود خوابیدن کمک می‌کنه؛ شاید بدنت الان خواب بیشتری بخواد 😴|اگه حالت پایین اومد با خودت مهربون باش؛ قبل از پریود شایعه 💗|چند نفس آهسته یا یک دوش گرم برای آروم شدن امتحان کن 🛁';

  @override
  String get unusualCycle => 'چرخه‌ی غیرعادی';

  @override
  String get unusualCycleHint =>
      'اگه این چرخه به‌خاطر بیماری، سفر، استرس یا دارو بی‌نظم شده، علامتش بزن تا در میانگین و پیش‌بینی حساب نشه.';

  @override
  String get unusualCycleUndoHint =>
      'این چرخه الان «غیرعادی» علامت خورده و در پیش‌بینی حساب نمی‌شه. برگردونم به حالت عادی؟';

  @override
  String get markUnusual => 'علامت بزن';

  @override
  String get unmarkUnusual => 'برگردون';

  @override
  String get historyTapHint =>
      'روی هر چرخه بزن تا اگه غیرعادی بود علامتش بزنی.';

  @override
  String get unusualCyclesCount => 'چرخه‌های غیرعادی';

  @override
  String get bbtLearningTitle => 'یادگیری از دمای پایه';

  @override
  String get lutealPersonal => 'فاز لوتئال شخصی';

  @override
  String get lutealDefault => 'فاز لوتئال (پیش‌فرض)';

  @override
  String get lutealLearnedHint =>
      'از چرخه‌هایی که تخمک‌گذاری‌شون با دما تأیید شد یاد گرفته شده.';

  @override
  String get lutealNeedMore =>
      'اگه چند چرخه هر صبح قبل از بلند شدن از تخت دما ثبت کنی، اپ فاز لوتئال خودت رو یاد می‌گیره.';

  @override
  String get bbtThisCycle => 'تخمک‌گذاری با دما';

  @override
  String get bbtNoShift => 'هنوز جهش دما دیده نشد';

  @override
  String get bbtRefinedNote => 'پیش‌بینی پریود بعدی با دما اصلاح شد';

  @override
  String get bbtTip =>
      'برای تأیید تخمک‌گذاری، دما رو هر صبح قبل از بلند شدن از تخت ثبت کن.';

  @override
  String get logHeroTitle => 'حال امروزت چطوره؟';

  @override
  String get logHeroSubtitle => 'چند دقیقه برای خودت وقت بذار';

  @override
  String get logSectionGeneral => 'وضعیت عمومی';

  @override
  String get logSectionPhysical => 'وضعیت جسمانی';

  @override
  String get logSectionNote => 'یادداشت روزانه';
}
