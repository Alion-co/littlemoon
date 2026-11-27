// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get homeGreeting => 'مساء الخير';

  @override
  String dayOfCycle(int day) {
    return 'اليوم $day';
  }

  @override
  String get ofYourCycle => 'من دورتكِ';

  @override
  String get follicularPhase => 'الطور الجريبي';

  @override
  String get lutealPhase => 'الطور الأصفري';

  @override
  String get menstrualPhase => 'طور الحيض';

  @override
  String get ovulationPhase => 'طور الإباضة';

  @override
  String daysUntilPeriod(int days) {
    return '$days يومًا حتى الدورة القادمة';
  }

  @override
  String get cycleHealthy => 'دورتكِ حاليًا ضمن نطاقها المعتاد.';

  @override
  String get dailyCheckIn => 'التسجيل اليومي';

  @override
  String get howAreYouFeeling => 'كيف تشعرين اليوم؟';

  @override
  String get flow => 'النزيف';

  @override
  String get mood => 'المزاج';

  @override
  String get pain => 'الألم';

  @override
  String get energy => 'الطاقة';

  @override
  String get sleep => 'النوم';

  @override
  String get symptoms => 'الأعراض';

  @override
  String get todaysSummary => 'ملخص اليوم';

  @override
  String get logToday => 'سجّلي\nاليوم';

  @override
  String get good => 'جيد';

  @override
  String get medium => 'متوسط';

  @override
  String get mild => 'خفيف';

  @override
  String get yourCycleInsights => 'إحصاءات دورتكِ';

  @override
  String get averageCycle => 'متوسط الدورة';

  @override
  String get recentPattern => 'النمط الأخير';

  @override
  String get days => 'يوم';

  @override
  String get home => 'الرئيسية';

  @override
  String get calendar => 'التقويم';

  @override
  String get insights => 'الإحصاءات';

  @override
  String get health => 'الصحة';

  @override
  String get profile => 'الملف';

  @override
  String get month => 'شهر';

  @override
  String get week => 'أسبوع';

  @override
  String get period => 'الدورة';

  @override
  String get fertile => 'الخصوبة';

  @override
  String get ovulation => 'الإباضة';

  @override
  String get periodDay => 'يوم دورة';

  @override
  String get fertileWindow => 'فترة الخصوبة';

  @override
  String get ovulationDay => 'يوم الإباضة';

  @override
  String get noDataLogged => 'لا توجد بيانات مسجّلة';

  @override
  String get logButton => 'تسجيل';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get clear => 'مسح';

  @override
  String get ok => 'فهمت';

  @override
  String get back => 'السابق';

  @override
  String get next => 'التالي';

  @override
  String get undo => 'تراجع';

  @override
  String get today => 'اليوم';

  @override
  String get notSet => 'غير مسجّل';

  @override
  String get notEnoughData => 'البيانات غير كافية';

  @override
  String get invalidValue => 'هذه القيمة لا تبدو صحيحة.';

  @override
  String get goodMorning => 'صباح الخير';

  @override
  String get goodAfternoon => 'طاب يومكِ';

  @override
  String get goodNight => 'طابت ليلتكِ';

  @override
  String periodDayNumber(int day) {
    return 'اليوم $day من الدورة';
  }

  @override
  String periodLateBy(int days) {
    return 'تأخرت الدورة $days أيام';
  }

  @override
  String get periodLateOneDay => 'تأخرت الدورة يومًا واحدًا';

  @override
  String get periodExpectedToday => 'من المتوقع أن تبدأ دورتكِ اليوم';

  @override
  String get periodExpectedTomorrow => 'من المتوقع أن تبدأ دورتكِ غدًا';

  @override
  String get cycleLateNote =>
      'تأخرت دورتكِ أكثر من أسبوع. إذا استمر ذلك، فكّري في إجراء اختبار حمل أو استشارة الطبيب.';

  @override
  String get cycleIrregularNote =>
      'تتفاوت أطوال دوراتكِ الأخيرة، لذلك التوقعات أقل دقة.';

  @override
  String get periodStartedToday => 'بدأت دورتي اليوم';

  @override
  String get periodContinuesToday => 'ما زالت دورتي مستمرة اليوم';

  @override
  String get periodLoggedToday => 'تم تسجيل الدورة لليوم';

  @override
  String get noCycleDataTitle => 'لم تُسجَّل أي دورة بعد';

  @override
  String get noCycleDataBody =>
      'سجّلي أول يوم من آخر دورة لكِ ليبدأ Little Moon بتوقّع دورتكِ.';

  @override
  String get logLastPeriod => 'تسجيل آخر دورة';

  @override
  String get predictionInfoTitle => 'كيف يُحسب هذا؟';

  @override
  String get predictionInfoBody =>
      'تُقدَّر دورتكِ القادمة من متوسط طول دوراتكِ الأخيرة المسجّلة. وتُقدَّر الإباضة بنحو 14 يومًا قبل الدورة القادمة، وتمتد فترة الخصوبة من 5 أيام قبل الإباضة إلى يوم واحد بعدها.\n\nكلما سجّلتِ دورات أكثر أصبح التوقّع أدق. هذه تقديرات فقط — لا تعتمدي عليها كوسيلة لمنع الحمل.';

  @override
  String get reminders => 'التذكيرات';

  @override
  String get noReminders => 'لا توجد تذكيرات اليوم.';

  @override
  String reminderPeriodSoon(int days) {
    return 'من المتوقع أن تبدأ دورتكِ بعد $days أيام.';
  }

  @override
  String get reminderPeriodTomorrow => 'من المتوقع أن تبدأ دورتكِ غدًا.';

  @override
  String get reminderPeriodToday => 'من المتوقع أن تبدأ دورتكِ اليوم.';

  @override
  String get reminderFertileSoon => 'تبدأ فترة الخصوبة غدًا.';

  @override
  String get reminderFertileToday => 'أنتِ الآن في فترة الخصوبة.';

  @override
  String get reminderOvulationToday => 'اليوم هو يوم الإباضة المتوقع.';

  @override
  String get reminderLogToday => 'لم تسجّلي شيئًا اليوم بعد.';

  @override
  String get remindersHint =>
      'تصلكِ إشعارات على الهاتف الساعة 9:00 لتذكيرات الدورة والساعة 21:00 للتسجيل اليومي. وتظهر أيضًا على جرس الصفحة الرئيسية.';

  @override
  String get reminderPeriodSetting => 'اقتراب الدورة';

  @override
  String get reminderDaysBefore => 'ذكّريني قبل';

  @override
  String get reminderFertileSetting => 'فترة الخصوبة';

  @override
  String get reminderOvulationSetting => 'يوم الإباضة';

  @override
  String get reminderLogSetting => 'التسجيل اليومي';

  @override
  String get futureDayNotAllowed => 'يمكنكِ تسجيل اليوم أو الأيام الماضية فقط.';

  @override
  String get flowNone => 'لا يوجد';

  @override
  String get flowSpotting => 'تنقيط';

  @override
  String get flowLight => 'خفيف';

  @override
  String get flowMedium => 'متوسط';

  @override
  String get flowHeavy => 'غزير';

  @override
  String get moodHappy => 'سعيدة';

  @override
  String get moodCalm => 'هادئة';

  @override
  String get moodSensitive => 'حسّاسة';

  @override
  String get moodSad => 'حزينة';

  @override
  String get moodIrritable => 'منزعجة';

  @override
  String get moodAnxious => 'قلقة';

  @override
  String get painNone => 'بلا ألم';

  @override
  String get painSevere => 'شديد';

  @override
  String get energyLow => 'منخفضة';

  @override
  String get energyHigh => 'عالية';

  @override
  String get symptomCramps => 'تقلصات';

  @override
  String get symptomHeadache => 'صداع';

  @override
  String get symptomBackPain => 'ألم الظهر';

  @override
  String get symptomBloating => 'انتفاخ';

  @override
  String get symptomBreastTenderness => 'ألم الثدي';

  @override
  String get symptomAcne => 'حب الشباب';

  @override
  String get symptomNausea => 'غثيان';

  @override
  String get symptomFatigue => 'إرهاق';

  @override
  String get symptomCravings => 'اشتهاء الطعام';

  @override
  String get symptomInsomnia => 'أرق';

  @override
  String get symptomDizziness => 'دوخة';

  @override
  String get symptomDischarge => 'إفرازات';

  @override
  String get note => 'ملاحظة';

  @override
  String get noteHint => 'أي شيء تودّين تذكّره عن اليوم…';

  @override
  String sleepHours(int hours) {
    return '$hours س';
  }

  @override
  String sleepHoursMinutes(int hours, int minutes) {
    return '$hours س $minutes د';
  }

  @override
  String get predicted => 'متوقَّع';

  @override
  String get predictedPeriodDay => 'دورة متوقعة';

  @override
  String cycleDayShort(int day) {
    return 'اليوم $day من الدورة الشهرية';
  }

  @override
  String get dataLogged => 'مسجَّل';

  @override
  String get insightsEmpty =>
      'بعد تسجيل أول دورة لكِ ستظهر هنا إحصاءات دورتكِ وتوقعاتها.';

  @override
  String get averagePeriod => 'متوسط مدة الدورة';

  @override
  String get regularity => 'الانتظام';

  @override
  String get regular => 'منتظمة';

  @override
  String get irregular => 'غير منتظمة';

  @override
  String get cyclesTracked => 'الدورات المسجّلة';

  @override
  String get predictions => 'التوقعات';

  @override
  String get nextPeriod => 'الدورة القادمة';

  @override
  String get followingPeriod => 'الدورة التي تليها';

  @override
  String get cycleHistory => 'سجل الدورات';

  @override
  String get historyEmpty =>
      'ستظهر أطوال دوراتكِ هنا بعد تسجيل دورتين على الأقل.';

  @override
  String get topSymptoms => 'الأعراض الأكثر تكرارًا';

  @override
  String get last90Days => 'آخر 90 يومًا';

  @override
  String get noSymptomsLogged => 'لم تُسجَّل أي أعراض بعد.';

  @override
  String get moodSummary => 'المزاج';

  @override
  String get noMoodLogged => 'لم يُسجَّل أي مزاج بعد.';

  @override
  String get medicalDisclaimer =>
      'التوقعات تقديرية ومبنية على ما تسجّلينه. لا تُعدّ نصيحة طبية ولا يجوز استخدامها كوسيلة لمنع الحمل.';

  @override
  String get yourBody => 'جسمكِ';

  @override
  String get tipsForYou => 'نصائح لهذا الطور';

  @override
  String get todayTracking => 'اليوم';

  @override
  String get water => 'الماء';

  @override
  String glassesOfGoal(int count, int goal) {
    return '$count من $goal أكواب';
  }

  @override
  String get weight => 'الوزن';

  @override
  String get weightHint => 'مثال: 58.5';

  @override
  String get kg => 'كغ';

  @override
  String get bodyTemperature => 'حرارة الجسم';

  @override
  String get temperatureHint => 'مثال: 36.6';

  @override
  String get tapToAdd => 'اضغطي للإضافة';

  @override
  String get averageSleep7 => 'متوسط النوم (7 أيام)';

  @override
  String get pregnancyChanceToday => 'احتمال الحمل اليوم';

  @override
  String get chanceLow => 'منخفض';

  @override
  String get chanceMedium => 'متوسط';

  @override
  String get chanceHigh => 'مرتفع';

  @override
  String get aboutMenstrual =>
      'الدورة هي بداية دورة شهرية جديدة. تنسلخ بطانة الرحم، ومن الطبيعي أن تشعري بطاقة أقل لبضعة أيام.';

  @override
  String get aboutFollicular =>
      'بعد الدورة يرتفع الإستروجين ويستعد الجسم لإطلاق بويضة. تشعر معظم النساء بطاقة وتركيز أكبر في هذا الطور.';

  @override
  String get aboutOvulation =>
      'تُطلق البويضة في هذه الأيام تقريبًا. هذا أكثر أوقات دورتكِ خصوبة.';

  @override
  String get aboutLuteal =>
      'بعد الإباضة يرتفع البروجسترون. في الأيام التي تسبق الدورة قد تلاحظين أعراض ما قبل الحيض مثل الانتفاخ وألم الثدي أو تقلب المزاج.';

  @override
  String get aboutNoData =>
      'سجّلي دورتكِ لتعرفي في أي طور أنتِ وتحصلي على نصائح تناسبه.';

  @override
  String get tipMenstrual1 =>
      'استريحي متى احتجتِ. الحركة الخفيفة كالمشي أو التمدد قد تخفف التقلصات.';

  @override
  String get tipMenstrual2 =>
      'كمّادة دافئة على أسفل البطن قد تساعد في تخفيف الألم.';

  @override
  String get tipMenstrual3 =>
      'الأطعمة الغنية بالحديد مثل العدس والسبانخ واللحم الأحمر مع شرب ماء كافٍ تساعدكِ على التعافي.';

  @override
  String get tipFollicular1 =>
      'ترتفع الطاقة عادة في هذا الطور، فهو وقت مناسب للتمارين الأشد.';

  @override
  String get tipFollicular2 =>
      'وقت مناسب لبدء خطط جديدة أو مهام تحتاج إلى تركيز.';

  @override
  String get tipFollicular3 =>
      'حافظي على توازن وجباتكِ بالبروتين والخضار الطازجة.';

  @override
  String get tipOvulation1 => 'هذا أكثر أوقات دورتكِ خصوبة.';

  @override
  String get tipOvulation2 =>
      'ألم خفيف في جانب واحد من أسفل البطن أو إفرازات أكثر شفافية أمر طبيعي غالبًا حول الإباضة.';

  @override
  String get tipOvulation3 =>
      'الطاقة والمزاج غالبًا في أفضل حالاتهما، فاستمتعي بالنشاط.';

  @override
  String get tipLuteal1 =>
      'قد تظهر أعراض ما قبل الحيض مثل الانتفاخ أو تقلب المزاج. كوني لطيفة مع نفسكِ.';

  @override
  String get tipLuteal2 =>
      'تقليل الملح والكافيين والسكر قد يخفف الانتفاخ والانزعاج.';

  @override
  String get tipLuteal3 =>
      'اجعلي النوم والتمارين الخفيفة مثل اليوغا أو المشي أولوية.';

  @override
  String get tipGeneral1 =>
      'سجّلي دورتكِ بانتظام. تصبح التوقعات أدق بعد بضع دورات.';

  @override
  String get tipGeneral2 => 'اشربي ماءً كافيًا وحافظي على مواعيد نوم منتظمة.';

  @override
  String get tipGeneral3 =>
      'راجعي الطبيب إذا كانت دوراتكِ غالبًا أقصر من 21 يومًا أو أطول من 35 يومًا، أو إذا كان الألم شديدًا.';

  @override
  String get yourName => 'اسمكِ';

  @override
  String get nameHint => 'بماذا نناديكِ؟';

  @override
  String get noName => 'صديقتنا العزيزة';

  @override
  String trackingSince(String date) {
    return 'التسجيل منذ $date';
  }

  @override
  String get daysLogged => 'أيام مسجّلة';

  @override
  String get periodsLogged => 'دورات مسجّلة';

  @override
  String get cycleSettings => 'إعدادات الدورة';

  @override
  String get cycleSettingsHint => 'تُستخدم للتوقعات إلى أن تسجّلي بضع دورات.';

  @override
  String get cycleLength => 'طول الدورة الشهرية';

  @override
  String get cycleLengthHint =>
      'من أول يوم في الدورة إلى أول يوم في الدورة التالية. عادة من 21 إلى 35 يومًا.';

  @override
  String get periodLength => 'مدة الحيض';

  @override
  String get periodLengthHint =>
      'عدد الأيام التي يستمر فيها النزيف عادة. غالبًا من 3 إلى 7 أيام.';

  @override
  String get lutealLength => 'طول الطور الأصفري';

  @override
  String get lutealLengthHint =>
      'الأيام بين الإباضة ودورتكِ التالية. اتركيه 14 إن لم تعرفي قيمتكِ.';

  @override
  String get privacyNote =>
      'كل شيء يبقى على هذا الجهاز. يعمل Little Moon دون اتصال تمامًا ولا يرسل بياناتكِ إلى أي مكان.';

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String get calendarType => 'التقويم';

  @override
  String get calendarJalali => 'هجري شمسي';

  @override
  String get calendarGregorian => 'ميلادي';

  @override
  String get theme => 'المظهر';

  @override
  String get themeMoon => 'القمر';

  @override
  String get themeSakura => 'ساكورا';

  @override
  String get themeLavender => 'الخزامى';

  @override
  String get themeOcean => 'المحيط';

  @override
  String get themeMint => 'النعناع';

  @override
  String get themeSunset => 'الغروب';

  @override
  String get themeMidnight => 'منتصف الليل';

  @override
  String get themeNightRose => 'وردة الليل';

  @override
  String get dataAndBackup => 'البيانات والنسخ الاحتياطي';

  @override
  String get backupHint => 'النسخة الاحتياطية نص عادي يمكنكِ حفظه أينما شئتِ.';

  @override
  String get copyBackup => 'نسخ النسخة الاحتياطية إلى الحافظة';

  @override
  String get backupCopied => 'تم نسخ النسخة الاحتياطية. الصقيها في مكان آمن.';

  @override
  String get restoreBackup => 'الاستعادة من نسخة احتياطية';

  @override
  String get restoreHint => 'الصقي نص النسخة الاحتياطية هنا';

  @override
  String get restoreInvalid => 'هذه ليست نسخة احتياطية صالحة لـ Little Moon.';

  @override
  String get restoreConfirm =>
      'سيُستبدل كل ما في التطبيق حاليًا بالنسخة الاحتياطية. هل تريدين المتابعة؟';

  @override
  String get restore => 'استعادة';

  @override
  String get restoreDone => 'تمت استعادة النسخة الاحتياطية.';

  @override
  String get deleteAllData => 'حذف كل البيانات';

  @override
  String get deleteAllConfirm =>
      'ستُحذف كل تسجيلاتكِ وملفكِ وإعداداتكِ نهائيًا. لا يمكن التراجع عن هذا.';

  @override
  String get onboardingWelcomeTitle => 'أهلًا بكِ';

  @override
  String get onboardingWelcomeBody =>
      'يساعدكِ Little Moon على تسجيل دورتكِ ومعرفة ما هو قادم. بضعة أسئلة سريعة للبدء.';

  @override
  String get onboardingHello => 'مرحباً!';

  @override
  String get onboardingWelcomeLine => 'أهلاً بك في Little Moon';

  @override
  String get onboardingTagline => 'رفيقتك الدائمة لإدارة دورتك وتحسين حالك';

  @override
  String get lastPeriodQuestion => 'متى بدأت آخر دورة لكِ؟';

  @override
  String get lastPeriodHint =>
      'اختاري أول يوم من النزيف. يمكنكِ تغييره لاحقًا.';

  @override
  String get dontRemember => 'لا أتذكر';

  @override
  String get periodLengthQuestion => 'كم يومًا تستمر دورتكِ عادة؟';

  @override
  String get cycleLengthQuestion => 'كم يومًا تستمر دورتكِ الشهرية عادة؟';

  @override
  String get getStarted => 'ابدئي';

  @override
  String get insightsTitle => 'تحليل الدورة';

  @override
  String get dedication => 'إهداء إلى قمري الصغير';

  @override
  String get editProfile => 'تعديل الملف';

  @override
  String get chooseAvatar => 'اختاري صورتكِ الرمزية';

  @override
  String get aboutDeveloper => 'حول Little Moon';

  @override
  String get aboutAppBody =>
      'Little Moon منصة خاصة ومجانية تعمل دون اتصال لتسجيل الدورة الشهرية للفتيات والسيدات. تتوقّع دورتكِ الشهرية من المعلومات التي تسجّلينها بنفسكِ وتعرضها لكِ. تُحفظ جميع بياناتكِ داخل هاتفكِ فقط.';

  @override
  String appVersion(String version) {
    return 'الإصدار $version';
  }

  @override
  String get developer => 'من تطوير';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get website => 'الموقع';

  @override
  String get telegram => 'تيليغرام';

  @override
  String get instagram => 'إنستغرام';

  @override
  String get copied => 'تم النسخ';

  @override
  String get madeWithLove => 'من تطوير شركة ALION';

  @override
  String get appTitle => 'Little Moon';

  @override
  String dateRange(String start, String end) {
    return '$start إلى $end';
  }

  @override
  String get privacySection => 'الخصوصية';

  @override
  String get appLock => 'قفل التطبيق';

  @override
  String get appLockHint => 'احمِ التطبيق برمز أو ببصمة إصبعك.';

  @override
  String get appLockOn => 'تم تفعيل قفل التطبيق.';

  @override
  String get useBiometric => 'الفتح بالبصمة';

  @override
  String get changePin => 'تغيير الرمز';

  @override
  String get pinChanged => 'تم تغيير الرمز.';

  @override
  String get enterPin => 'أدخلي الرمز';

  @override
  String get newPin => 'اختاري رمزًا من 4 أرقام';

  @override
  String get confirmPin => 'أدخلي الرمز مرة أخرى';

  @override
  String get pinMismatch => 'الرمزان غير متطابقين. حاولي مرة أخرى.';

  @override
  String get wrongPin => 'رمز غير صحيح';

  @override
  String tooManyAttempts(int seconds) {
    return 'محاولات كثيرة. انتظري $seconds ثانية.';
  }

  @override
  String get unlockReason => 'لفتح Little Moon';

  @override
  String get forgotPin => 'نسيت الرمز';

  @override
  String get forgotPinBody =>
      'لا يمكن استعادة الرمز لأن البيانات لا تغادر هاتفك أبدًا. يمكنك حذف كل البيانات والبدء من جديد، وإذا كانت لديك نسخة احتياطية يمكنك استعادتها بعد ذلك.';

  @override
  String get resetApp => 'حذف والبدء من جديد';

  @override
  String get discreetNotifications => 'إشعارات متحفّظة';

  @override
  String get discreetNotificationsHint =>
      'تستخدم التذكيرات والأداة نصًا محايدًا لا يكشف شيئًا عن دورتك، ولا تظهر على شاشة القفل.';

  @override
  String get discreetTitle => 'تذكير';

  @override
  String get discreetCycleBody => 'لديك تذكير جديد.';

  @override
  String get discreetLogBody => 'ملاحظتك لليوم بانتظارك.';

  @override
  String get discreetPillBody => 'حان وقت تذكيرك اليومي.';

  @override
  String get pillReminder => 'تذكير الحبوب';

  @override
  String get pillReminderTime => 'وقت تذكير الحبوب';

  @override
  String get reminderPill => 'حان وقت تناول حبتك.';

  @override
  String get widgetTitle => 'أداة الشاشة الرئيسية';

  @override
  String get widgetHint =>
      'اضغطي مطولًا على مكان فارغ في الشاشة الرئيسية، ثم «الأدوات» وأضيفي Little Moon. مع الإشعارات المتحفّظة تعرض الأداة رقم اليوم فقط.';

  @override
  String get doctorReport => 'تقرير للطبيب';

  @override
  String get doctorReportHint =>
      'ملخص PDF لدوراتك وأعراضك ومزاجك، يُنشأ على هذا الهاتف.';

  @override
  String get reportTitle => 'تقرير الدورة الشهرية';

  @override
  String reportGenerated(String date) {
    return 'تاريخ الإعداد: $date';
  }

  @override
  String reportWindow(int days, int logged) {
    return 'إحصاءات الأعراض لآخر $days يومًا ($logged يومًا مسجلًا)';
  }

  @override
  String get reportSummary => 'ملخص';

  @override
  String get reportCycleRange => 'أقصر وأطول دورة';

  @override
  String reportMinMax(int min, int max) {
    return '$min إلى $max يومًا';
  }

  @override
  String get reportLastPeriod => 'بداية آخر دورة';

  @override
  String get reportStart => 'تاريخ البدء';

  @override
  String get reportInProgress => 'الحالية';

  @override
  String get reportUnitsNote =>
      'كل القيم بالأيام. * تعني أن دورة لم تُسجّل غالبًا في هذه الفترة، لذلك لم تُحسب في المتوسط.';

  @override
  String reportTimes(int count) {
    return '$count مرات';
  }

  @override
  String get reportPainDays => 'أيام الألم المتوسط أو الشديد';

  @override
  String get reportFooter =>
      'أُعدّ باستخدام Little Moon اعتمادًا على بيانات سجّلتها المستخدمة';

  @override
  String get reportFailed => 'تعذّر إنشاء التقرير. حاولي مرة أخرى.';

  @override
  String get year => 'سنة';

  @override
  String get quickLog => 'تسجيل سريع';

  @override
  String get quickLogHint => 'يُحفظ بلمسة واحدة';

  @override
  String get detailedLog => 'تسجيل مفصّل';

  @override
  String get saveBackupFile => 'حفظ نسخة احتياطية في ملف';

  @override
  String get restoreBackupFile => 'الاستعادة من ملف احتياطي';

  @override
  String get backupFileSaved => 'تم حفظ ملف النسخة الاحتياطية.';

  @override
  String get backupFileFailed =>
      'تعذّر حفظ الملف، فنُسخ نص النسخة الاحتياطية إلى الحافظة.';

  @override
  String reminderLate(int days) {
    return 'تأخرت دورتك $days أيام. إذا بدأت، سجّليها لتبقى التوقعات دقيقة.';
  }

  @override
  String get lateReminderSetting => 'تأخر الدورة';

  @override
  String get autoNightTheme => 'سمة ليلية تلقائية';

  @override
  String get autoNightThemeHint =>
      'تُستخدم سمة ليلية عندما يكون الهاتف في الوضع الداكن.';

  @override
  String get patternsTitle => 'أنماطك';

  @override
  String get patternsSubtitle => 'أمور تتكرر عبر دوراتك';

  @override
  String get patternsEmpty =>
      'لا توجد أنماط متكررة بعد. كلما سجّلتِ الأعراض والمزاج في دورات أكثر، ظهرت أنماطك هنا.';

  @override
  String get patternsNote =>
      'تُحسب على هذا الهاتف من سجلاتك فقط، وليست تشخيصًا طبيًا.';

  @override
  String get patternPain => 'ألم متوسط أو شديد';

  @override
  String get patternDayBefore => 'عادةً قبل الدورة بيوم';

  @override
  String patternDaysBefore(int days) {
    return 'عادةً قبل الدورة بنحو $days أيام';
  }

  @override
  String patternDuring(int day) {
    return 'عادةً في اليوم $day من الدورة';
  }

  @override
  String patternSeen(int cycles) {
    return 'في $cycles دورات';
  }

  @override
  String get charts => 'الرسوم البيانية';

  @override
  String get chartsHint => 'المسي الرسم أو اسحبي عليه لرؤية قيمة كل يوم.';

  @override
  String get chartNotEnoughData => 'يحتاج هذا الرسم إلى إدخالين على الأقل.';

  @override
  String get chartCycleSubtitle => 'آخر 12 دورة؛ الخط المتقطع هو المتوسط';

  @override
  String chartLastDays(int days) {
    return 'آخر $days يومًا';
  }

  @override
  String chartSleepSubtitle(int days) {
    return 'ساعات النوم في آخر $days يومًا';
  }

  @override
  String get aboutTagline => 'رفيقتك اللطيفة في دورتك الشهرية';

  @override
  String get aboutMeta => 'مجاني ومفتوح المصدر · يعمل دون إنترنت';

  @override
  String get rateOnMyket => 'قيّمي في Myket';

  @override
  String get rateOnBazaar => 'قيّمي في Bazaar';

  @override
  String get developerRole => 'صانع هذا التطبيق';

  @override
  String get contactCall => 'اتصال';

  @override
  String get settingsAppearance => 'المظهر واللغة';

  @override
  String remindersOnCount(int count) {
    return '$count تذكيرات مفعّلة';
  }

  @override
  String get appLockStatusOn => 'قفل التطبيق مفعّل';

  @override
  String get appLockStatusOff => 'قفل التطبيق متوقف';

  @override
  String get settingsDataSubtitle => 'النسخ الاحتياطي والاستعادة والحذف';

  @override
  String get cycleRemindersGroup => 'الدورة';

  @override
  String get dailyRemindersGroup => 'يومي';

  @override
  String get notificationsCaption => 'الإشعارات';

  @override
  String get backupFileCaption => 'ملف النسخة الاحتياطية';

  @override
  String get backupTextCaption => 'النقل كنص';

  @override
  String get dataLocalNote =>
      'كل بياناتك وملفاتك متاحة على جهازك فقط ولا تُرسل إلى أي خادم.';

  @override
  String get widgetDayLabel => 'يوم الدورة';

  @override
  String get widgetSizeWide => 'شريط · 5×1';

  @override
  String get widgetSizeSquare => 'صغيرة · 2×2';

  @override
  String get widgetSizeMedium => 'متوسطة · 3×2';

  @override
  String get addWidget => 'إضافة';

  @override
  String get widgetPinFailed =>
      'تعذّرت إضافة الأداة. أضيفيها من أدوات الشاشة الرئيسية.';

  @override
  String get careMenstrual =>
      'خذي قسطًا من الراحة؛ جسمك يقوم بعمل كبير 🌙|كوب شاي أعشاب دافئ سيريحك ☕|كوني ألطف مع نفسك اليوم 💗|اشربي ماءً كافيًا ونامي أكثر قليلًا 💧|الكمادات الدافئة تخفف التقلصات 🌸';

  @override
  String get careFollicular =>
      'طاقتك تعود؛ وقت البدايات الجديدة ✨|يوم رائع للحركة والرياضة 🏃‍♀️|دوّني أفكارك؛ ذهنك متقد 📝|مثل القمر، تكتملين كل يوم 🌒';

  @override
  String get careOvulation =>
      'أنتِ متألقة اليوم أكثر من أي وقت ✨|احتفلي بثقتك بنفسك 💫|وقت جميل للقاء صديقاتك 🌸|طاقتك في أوجها؛ استمتعي بها ☀️';

  @override
  String get careLuteal =>
      'الشعور ببعض الضيق طبيعي تمامًا 🌙|قللي الملح والكافيين؛ سيشكرك جسمك 🍵|نزهة هادئة ستحسّن مزاجك 🍃|النوم الكافي أجمل هدية لنفسك 😴';

  @override
  String get careDiscreet =>
      'كوني لطيفة مع نفسك اليوم 💗|اشربي كوبًا من الماء 💧|خذي نفسًا عميقًا 🍃|أنتِ رائعة ✨';

  @override
  String get widgetChooseHint => 'اختاري واحدة وأضيفيها إلى الشاشة الرئيسية.';

  @override
  String addWidgetToHome(String name) {
    return 'إضافة أداة $name';
  }

  @override
  String get widgetPinNotShown => 'ألم تظهر نافذة إضافة الأداة؟';

  @override
  String get widgetHelp => 'مساعدة';

  @override
  String get widgetHelpTitle => 'لم تُضف الأداة؟';

  @override
  String get widgetHelpBody =>
      'بعض الهواتف مثل شاومي وبوكو لا تضيف الأدوات إلا بعد السماح بذلك:\n\n1. اضغطي مطولًا على أيقونة التطبيق واختاري «معلومات التطبيق».\n2. افتحي «أذونات أخرى».\n3. اسمحي بـ«اختصارات الشاشة الرئيسية».\n4. ارجعي واضغطي زر الإضافة مرة أخرى.\n\nأو اضغطي مطولًا على مكان فارغ في الشاشة الرئيسية، ثم «الأدوات» وابحثي عن Little Moon.';

  @override
  String get widgetSizeLarge => 'كبيرة · 5×4';

  @override
  String get careGeneral =>
      'كل يوم فرصة جديدة لتكوني أكثر لطفًا مع نفسكِ.|أنصتي إلى جسدكِ؛ فهو يحدّثكِ كل يوم.|لستِ مضطرةً إلى القوة كل يوم؛ يكفي أن تكوني صادقة مع نفسكِ.|الراحة أيضًا جزء من رحلة نموكِ.|أنتِ جديرة بالتقدير في كل مرحلة من دورتكِ.|عاملي نفسكِ اليوم كما تعاملين أعزّ صديقاتكِ.|ليس عليكِ حلّ كل شيء اليوم.|جسدكِ يستحق العناية لا الانتقاد.|امنحي نفسكِ الإذن بالتقدّم على مهل.|لستِ مضطرةً إلى التألّق كل يوم؛ وجودكِ كافٍ.|نَفَس عميق، ولحظة هدوء، وبداية جديدة.|مشاعركِ ليست عدوّتكِ؛ أصغي إليها بلطف.|أنتِ أكثر من كل ما تنجزينه اليوم.|كل خطوة صغيرة تخطينها من أجل نفسكِ لها قيمة.|تعاوني مع جسدكِ بدلًا من محاربته.|ليس عليكِ أن تكوني نسختكِ المثالية اليوم.|من حقكِ أن تشعري بالأمل والتعب في الوقت نفسه.|كل دورة فرصة لتتعرّفي إلى نفسكِ أكثر.|الرفق بالنفس عادة قوية.|افتخري بتقدّمكِ، حتى لو كان بطيئًا.|إذا كنتِ بحاجة إلى الراحة اليوم، فأصغي إلى نفسكِ.|وجبة هادئة ومغذّية هي أيضًا شكل من أشكال حب الذات.|اشربي الماء وامنحي نفسكِ بضع لحظات.|قد تكون تمارين التمدد اللطيفة دعوة إلى الاسترخاء.|النوم الكافي هدية تقدّمينها لنفسكِ غدًا.|لا تحتاجين إلى سبب كبير لتمنحي نفسكِ لحظة هدوء.|قد يكون الاستحمام بماء دافئ لحظة تخصّكِ وحدكِ.|إذا كان جسدكِ يتحرّك ببطء اليوم، فارفقي به.|وضع الحدود شكل من أشكال العناية بالنفس أيضًا.|امنحي نفسكِ الإذن بطلب المساعدة.|افعلي اليوم شيئًا صغيرًا يمنحكِ الطمأنينة.|لجسدكِ احتياجات حقيقية؛ احترميها.|لا يجب أن تكون العناية بالنفس معقّدة أو مكلفة.|اسألي نفسكِ اليوم: ماذا أحتاج حقًا؟|بضع دقائق بعيدًا عن الشاشة هدية لعقلكِ.|عاهدي نفسكِ اليوم على أن تقلّلي من الحكم على ذاتكِ.|عندما تتعبين، لستِ مطالبة بتبرير راحتكِ.|ركّزي على أن تكوني على طبيعتكِ بدلًا من السعي إلى الكمال.|أنتِ تستحقين الحب والاحترام اليوم أيضًا.|قدّري جسدكِ لما يفعله من أجلكِ.|لستِ مضطرة إلى تغيير كل شعور فورًا.|اتركي لنفسكِ مساحة صغيرة اليوم.|يمكنكِ أن تكوني قوية وأن تحتاجي إلى الدعم في الوقت نفسه.|جسدكِ ليس مشروعًا لإصلاحه، بل رفيق يستحق الحب.|لستِ مضطرة إلى محاربة جسدكِ لتستحقي الحب.|كل شهر فرصة جديدة لتفهمي نفسكِ، لا لتحكمي عليها.|ليس على جسدكِ أن يشبه أي جسد آخر.|قيمتكِ لا تحددها الأرقام على التقويم أو الميزان.|تعرّفي إلى جسدكِ بفضول بدلًا من لومه.|ليس من الضروري أن يشبه كل يوم اليوم الذي سبقه.|جسدكِ يستحق صبركِ.|تغيّر طاقتكِ جزء من التجربة الإنسانية؛ تقبّلي نفسكِ كما أنتِ.|لستِ مضطرة إلى استغلال كل يوم إلى أقصى حد.|يحقّ لكِ تعديل خططكِ بما يناسب احتياجاتكِ.|ثقي بنفسكِ؛ فأنتِ الأدرى بتجربتكِ.|كل شعور تمرّين به يستحق الاهتمام.|لستِ مضطرة إلى الاعتذار لأنكِ تحتاجين إلى الراحة.|جسدكِ ليس عدوّ خططكِ؛ بل يحمل لكِ إشارات تستحق الإصغاء.|يبدأ الوعي بالذات من ملاحظة التفاصيل الصغيرة.|اتبعي طريقكِ بدلًا من مقارنة نفسكِ بالآخرين.|لستِ مضطرة إلى الشعور بالطريقة نفسها كل يوم.|جسدكِ يستحق الاحترام حتى في الأيام الصعبة.|تحدّثي إلى نفسكِ بلطف أكبر؛ فكلماتكِ الداخلية مهمة.|ليس عليكِ معرفة كل الإجابات اليوم.|امنحي نفسكِ وقتًا لتنمي وتتغيّري وتبدئي من جديد.|أنتِ تستحقين الطمأنينة التي تمنحينها للآخرين.|أحيانًا يكون أفضل ما يمكنكِ فعله هو تقليل ما تفعلينه.|كلما أصغيتِ إلى احتياجكِ، اقتربتِ أكثر من نفسكِ.|جسدكِ يعمل معكِ؛ عبّري له عن امتنانكِ.|لستِ مضطرة إلى التقليل من ألمكِ أو تعبكِ.|العناية بالنفس تعني أخذ احتياجاتكِ على محمل الجد.|يمكنكِ البدء من جديد، ولو بخطوة صغيرة.|حين تمنحين نفسكِ استراحة، فهذا لا يعني أنكِ فشلتِ.|اسمحي لجسدكِ أن يسير بإيقاعه الخاص.|طمأنينتكِ جزء من نجاحكِ أيضًا.|قد يحمي وضع حدّ صحي طاقتكِ اليوم.|لستِ مضطرة إلى أن تكوني متاحة للجميع طوال الوقت.|قد تكون لحظة صمت قصيرة شكلًا من العناية بالنفس.|ساندي نفسكِ اليوم بدلًا من الضغط عليها.|يمكنكِ أن تفخري بنفسكِ حتى لو لم يلاحظ أحد ذلك.|ليس من الضروري أن يكون اليوم مليئًا بالإنجاز ليكون ذا قيمة.|بدلًا من معاقبة نفسكِ، اسألي بفضول عمّا قد يساعدكِ.|جسدكِ يستحق الاهتمام الذي تمنحينه لأعمالكِ.|بدلًا من سؤال نفسكِ لماذا لستِ كعادتكِ، اسألي عمّا تحتاجينه الآن.|يوم صعب واحد لا يمثّل قصتكِ كلها.|امنحي نفسكِ مساحة لتعيشي مشاعركِ دون أحكام.|لستِ مطالبة بإثبات معاناتكِ كي تستحقي الدعم.|ذكّري نفسكِ بأن الاحتياج جزء من كونكِ إنسانة.|التقدّم ببطء يظل تقدّمًا.|يمكنكِ الالتزام بأهدافكِ مع إعطاء الراحة حقّها.|اشكري جسدكِ لأنه يرافقكِ في كل يوم.|لستِ مضطرة إلى فعل شيء تجاه كل شعور؛ أحيانًا يكفي أن تلاحظيه.|حين تصغين إلى نفسكِ، تتخذين خيارات أكثر وعيًا.|امنحي نفسكِ الدعم بدلًا من اللوم.|يمكنكِ إعادة ترتيب يومكِ؛ لستِ مضطرة إلى الالتزام بالخطة بحذافيرها.|لكل دورة قصتها الخاصة؛ تابعيها بفضول.|دوّني تغيّراتكِ لتتعرّفي إلى أنماطكِ الشخصية بشكل أفضل.|ليس من الضروري أن تشبه دورتكِ دورة أي شخص آخر.|كلما عرفتِ نفسكِ أكثر، أصبح اختيار العناية المناسبة أسهل.|جسدكِ ليس تقويمًا موحّدًا يناسب الجميع؛ تعرّفي إلى أنماطكِ الخاصة.|إذا تغيّر نمط دورتكِ، فلاحظيه بفضول دون لوم.|تتبّع الدورة وسيلة لفهم نفسكِ، لا لتقييدها.|قد تختلف احتياجات جسدكِ خلال الشهر.|الملاحظة دون أحكام بداية لعناية أفضل.|انتبهي إلى إشارات جسدكِ بدلًا من الاعتماد على التوقعات القطعية.|كل شهر فرصة لتتعلّمي شيئًا جديدًا عن نفسكِ.|تذكّري أن تجربة الدورة تختلف من شخص إلى آخر.|دوّني إشارات جسدكِ؛ ففهمها قد يمنحكِ الطمأنينة.|دورتكِ جزء من تجربتكِ، وليست هويتكِ كلها.|كل يوم فرصة للبدء من جديد.|ليس من الضروري أن يكون كل شيء مثاليًا لتحظي بيوم جميل.|أنتِ أقوى مما تجعلكِ الأيام الصعبة تشعرين.|ثقي بمساركِ حتى عندما لا تكون الخطوة التالية واضحة.|في كل مرة تواصلين فيها، تتعلّمين شيئًا عن نفسكِ.|افتخري بنفسكِ لأنكِ وصلتِ إلى هنا.|لستِ مضطرة إلى السير بسرعة الآخرين.|يمكن للأمل أن يكون هادئًا ورقيقًا أيضًا.|ذكّري نفسكِ بأن البدايات الصغيرة لها قيمة أيضًا.|يمكنكِ تغيير خطتكِ مع البقاء وفية لهدفكِ.|كل يوم فرصة جديدة لاختيار اللطف.|أنتِ تستحقين الدعم نفسه الذي تمنحينه للآخرين.|عندما يصبح الطريق صعبًا، كوني في صفّ نفسكِ.|ليس من الضروري أن تحدث كل التغييرات دفعة واحدة.|يمكنكِ بخطوات صغيرة أن تبني لنفسكِ حياة أكثر لطفًا.|ليس كل يوم بحاجة إلى بداية كبيرة؛ أحيانًا يكفي نَفَس واحد.|امنحي نفسكِ وقتًا لتجدي الأمل من جديد اليوم.|يمكنكِ أن تتعلّمي وتتقدّمي في الوقت نفسه.|ركّزي على الخطوة التالية بدلًا من التسرّع.|لستِ بحاجة إلى إثبات أي شيء لتكوني جديرة بالتقدير.|أحيانًا يعني التقدّم أن تدركي ما لم يعد مناسبًا لكِ.|امنحي نفسكِ الإذن بإعادة تعريف معنى النجاح بالنسبة لكِ.|كل خطوة واعية تقرّبكِ من نفسكِ.|اليوم، رافقي نفسكِ بدلًا من منافسة نسخة الأمس منكِ.|يمكنكِ التوقّف قليلًا والتنفس والاختيار من جديد.|يمكنكِ أن تكوني لطيفة مع نفسكِ حتى في الأيام الغامضة.|ابدئي يومكِ بنيّة لطيفة تجاه نفسكِ.|أنتِ تستحقين علاقة هادئة ولطيفة مع نفسكِ.|كلما احترمتِ نفسكِ، أصبحت حدودكِ أوضح.|يمكنكِ تخصيص وقت لنفسكِ دون الشعور بالذنب.|ذكّري نفسكِ: أنا أتعلّم، ولستُ متأخرة.|يمكنكِ اليوم اتخاذ خيار صغير من أجل راحتكِ.|لستِ مضطرة إلى السيطرة على كل شيء لتشعري بالأمان.|كل يوم فرصة للتدرّب على الصبر مع نفسكِ.|تذكّري أن احتياجاتكِ مهمة.|يمكنكِ أن تكوني لطيفة وحازمة في الوقت نفسه.|قد تحتاجين اليوم إلى مزيد من الدعم بدلًا من مزيد من الجهد.|كل يوم فرصة لاختيار نفسكِ دون إقصاء الآخرين.|أنتِ تستحقين عناية ترافقكِ حتى في الأيام الصعبة.|تعرّفي إلى جسدكِ بفضول لا بخوف.|إذا ظهرت عليكِ أعراض مقلقة أو ألم شديد، فطلب المساعدة الطبية شكل من أشكال العناية بالنفس.';

  @override
  String get careGeneralDiscreet =>
      'كل يوم فرصة جديدة لتكوني أكثر لطفًا مع نفسكِ.|أنصتي إلى جسدكِ؛ فهو يحدّثكِ كل يوم.|لستِ مضطرةً إلى القوة كل يوم؛ يكفي أن تكوني صادقة مع نفسكِ.|الراحة أيضًا جزء من رحلة نموكِ.|عاملي نفسكِ اليوم كما تعاملين أعزّ صديقاتكِ.|ليس عليكِ حلّ كل شيء اليوم.|جسدكِ يستحق العناية لا الانتقاد.|امنحي نفسكِ الإذن بالتقدّم على مهل.|لستِ مضطرةً إلى التألّق كل يوم؛ وجودكِ كافٍ.|نَفَس عميق، ولحظة هدوء، وبداية جديدة.|مشاعركِ ليست عدوّتكِ؛ أصغي إليها بلطف.|أنتِ أكثر من كل ما تنجزينه اليوم.|كل خطوة صغيرة تخطينها من أجل نفسكِ لها قيمة.|تعاوني مع جسدكِ بدلًا من محاربته.|ليس عليكِ أن تكوني نسختكِ المثالية اليوم.|من حقكِ أن تشعري بالأمل والتعب في الوقت نفسه.|افتخري بتقدّمكِ، حتى لو كان بطيئًا.|إذا كنتِ بحاجة إلى الراحة اليوم، فأصغي إلى نفسكِ.|وجبة هادئة ومغذّية هي أيضًا شكل من أشكال حب الذات.|اشربي الماء وامنحي نفسكِ بضع لحظات.|قد تكون تمارين التمدد اللطيفة دعوة إلى الاسترخاء.|النوم الكافي هدية تقدّمينها لنفسكِ غدًا.|لا تحتاجين إلى سبب كبير لتمنحي نفسكِ لحظة هدوء.|قد يكون الاستحمام بماء دافئ لحظة تخصّكِ وحدكِ.|إذا كان جسدكِ يتحرّك ببطء اليوم، فارفقي به.|وضع الحدود شكل من أشكال العناية بالنفس أيضًا.|امنحي نفسكِ الإذن بطلب المساعدة.|افعلي اليوم شيئًا صغيرًا يمنحكِ الطمأنينة.|لجسدكِ احتياجات حقيقية؛ احترميها.|لا يجب أن تكون العناية بالنفس معقّدة أو مكلفة.|اسألي نفسكِ اليوم: ماذا أحتاج حقًا؟|بضع دقائق بعيدًا عن الشاشة هدية لعقلكِ.|عاهدي نفسكِ اليوم على أن تقلّلي من الحكم على ذاتكِ.|عندما تتعبين، لستِ مطالبة بتبرير راحتكِ.|ركّزي على أن تكوني على طبيعتكِ بدلًا من السعي إلى الكمال.|أنتِ تستحقين الحب والاحترام اليوم أيضًا.|قدّري جسدكِ لما يفعله من أجلكِ.|لستِ مضطرة إلى تغيير كل شعور فورًا.|اتركي لنفسكِ مساحة صغيرة اليوم.|يمكنكِ أن تكوني قوية وأن تحتاجي إلى الدعم في الوقت نفسه.|لستِ مضطرة إلى محاربة جسدكِ لتستحقي الحب.|كل شهر فرصة جديدة لتفهمي نفسكِ، لا لتحكمي عليها.|ليس على جسدكِ أن يشبه أي جسد آخر.|قيمتكِ لا تحددها الأرقام على التقويم أو الميزان.|تعرّفي إلى جسدكِ بفضول بدلًا من لومه.|ليس من الضروري أن يشبه كل يوم اليوم الذي سبقه.|جسدكِ يستحق صبركِ.|تغيّر طاقتكِ جزء من التجربة الإنسانية؛ تقبّلي نفسكِ كما أنتِ.|لستِ مضطرة إلى استغلال كل يوم إلى أقصى حد.|يحقّ لكِ تعديل خططكِ بما يناسب احتياجاتكِ.|ثقي بنفسكِ؛ فأنتِ الأدرى بتجربتكِ.|كل شعور تمرّين به يستحق الاهتمام.|لستِ مضطرة إلى الاعتذار لأنكِ تحتاجين إلى الراحة.|جسدكِ ليس عدوّ خططكِ؛ بل يحمل لكِ إشارات تستحق الإصغاء.|يبدأ الوعي بالذات من ملاحظة التفاصيل الصغيرة.|اتبعي طريقكِ بدلًا من مقارنة نفسكِ بالآخرين.|لستِ مضطرة إلى الشعور بالطريقة نفسها كل يوم.|جسدكِ يستحق الاحترام حتى في الأيام الصعبة.|تحدّثي إلى نفسكِ بلطف أكبر؛ فكلماتكِ الداخلية مهمة.|ليس عليكِ معرفة كل الإجابات اليوم.|امنحي نفسكِ وقتًا لتنمي وتتغيّري وتبدئي من جديد.|أنتِ تستحقين الطمأنينة التي تمنحينها للآخرين.|أحيانًا يكون أفضل ما يمكنكِ فعله هو تقليل ما تفعلينه.|كلما أصغيتِ إلى احتياجكِ، اقتربتِ أكثر من نفسكِ.|جسدكِ يعمل معكِ؛ عبّري له عن امتنانكِ.|لستِ مضطرة إلى التقليل من ألمكِ أو تعبكِ.|العناية بالنفس تعني أخذ احتياجاتكِ على محمل الجد.|يمكنكِ البدء من جديد، ولو بخطوة صغيرة.|حين تمنحين نفسكِ استراحة، فهذا لا يعني أنكِ فشلتِ.|اسمحي لجسدكِ أن يسير بإيقاعه الخاص.|طمأنينتكِ جزء من نجاحكِ أيضًا.|قد يحمي وضع حدّ صحي طاقتكِ اليوم.|لستِ مضطرة إلى أن تكوني متاحة للجميع طوال الوقت.|قد تكون لحظة صمت قصيرة شكلًا من العناية بالنفس.|ساندي نفسكِ اليوم بدلًا من الضغط عليها.|يمكنكِ أن تفخري بنفسكِ حتى لو لم يلاحظ أحد ذلك.|ليس من الضروري أن يكون اليوم مليئًا بالإنجاز ليكون ذا قيمة.|بدلًا من معاقبة نفسكِ، اسألي بفضول عمّا قد يساعدكِ.|جسدكِ يستحق الاهتمام الذي تمنحينه لأعمالكِ.|يوم صعب واحد لا يمثّل قصتكِ كلها.|امنحي نفسكِ مساحة لتعيشي مشاعركِ دون أحكام.|لستِ مطالبة بإثبات معاناتكِ كي تستحقي الدعم.|ذكّري نفسكِ بأن الاحتياج جزء من كونكِ إنسانة.|التقدّم ببطء يظل تقدّمًا.|يمكنكِ الالتزام بأهدافكِ مع إعطاء الراحة حقّها.|اشكري جسدكِ لأنه يرافقكِ في كل يوم.|لستِ مضطرة إلى فعل شيء تجاه كل شعور؛ أحيانًا يكفي أن تلاحظيه.|حين تصغين إلى نفسكِ، تتخذين خيارات أكثر وعيًا.|امنحي نفسكِ الدعم بدلًا من اللوم.|يمكنكِ إعادة ترتيب يومكِ؛ لستِ مضطرة إلى الالتزام بالخطة بحذافيرها.|دوّني تغيّراتكِ لتتعرّفي إلى أنماطكِ الشخصية بشكل أفضل.|كلما عرفتِ نفسكِ أكثر، أصبح اختيار العناية المناسبة أسهل.|جسدكِ ليس تقويمًا موحّدًا يناسب الجميع؛ تعرّفي إلى أنماطكِ الخاصة.|قد تختلف احتياجات جسدكِ خلال الشهر.|الملاحظة دون أحكام بداية لعناية أفضل.|انتبهي إلى إشارات جسدكِ بدلًا من الاعتماد على التوقعات القطعية.|كل شهر فرصة لتتعلّمي شيئًا جديدًا عن نفسكِ.|دوّني إشارات جسدكِ؛ ففهمها قد يمنحكِ الطمأنينة.|كل يوم فرصة للبدء من جديد.|ليس من الضروري أن يكون كل شيء مثاليًا لتحظي بيوم جميل.|أنتِ أقوى مما تجعلكِ الأيام الصعبة تشعرين.|ثقي بمساركِ حتى عندما لا تكون الخطوة التالية واضحة.|في كل مرة تواصلين فيها، تتعلّمين شيئًا عن نفسكِ.|افتخري بنفسكِ لأنكِ وصلتِ إلى هنا.|لستِ مضطرة إلى السير بسرعة الآخرين.|يمكن للأمل أن يكون هادئًا ورقيقًا أيضًا.|ذكّري نفسكِ بأن البدايات الصغيرة لها قيمة أيضًا.|يمكنكِ تغيير خطتكِ مع البقاء وفية لهدفكِ.|كل يوم فرصة جديدة لاختيار اللطف.|أنتِ تستحقين الدعم نفسه الذي تمنحينه للآخرين.|عندما يصبح الطريق صعبًا، كوني في صفّ نفسكِ.|ليس من الضروري أن تحدث كل التغييرات دفعة واحدة.|يمكنكِ بخطوات صغيرة أن تبني لنفسكِ حياة أكثر لطفًا.|ليس كل يوم بحاجة إلى بداية كبيرة؛ أحيانًا يكفي نَفَس واحد.|امنحي نفسكِ وقتًا لتجدي الأمل من جديد اليوم.|يمكنكِ أن تتعلّمي وتتقدّمي في الوقت نفسه.|ركّزي على الخطوة التالية بدلًا من التسرّع.|لستِ بحاجة إلى إثبات أي شيء لتكوني جديرة بالتقدير.|أحيانًا يعني التقدّم أن تدركي ما لم يعد مناسبًا لكِ.|امنحي نفسكِ الإذن بإعادة تعريف معنى النجاح بالنسبة لكِ.|كل خطوة واعية تقرّبكِ من نفسكِ.|اليوم، رافقي نفسكِ بدلًا من منافسة نسخة الأمس منكِ.|يمكنكِ التوقّف قليلًا والتنفس والاختيار من جديد.|يمكنكِ أن تكوني لطيفة مع نفسكِ حتى في الأيام الغامضة.|ابدئي يومكِ بنيّة لطيفة تجاه نفسكِ.|أنتِ تستحقين علاقة هادئة ولطيفة مع نفسكِ.|كلما احترمتِ نفسكِ، أصبحت حدودكِ أوضح.|يمكنكِ تخصيص وقت لنفسكِ دون الشعور بالذنب.|ذكّري نفسكِ: أنا أتعلّم، ولستُ متأخرة.|يمكنكِ اليوم اتخاذ خيار صغير من أجل راحتكِ.|لستِ مضطرة إلى السيطرة على كل شيء لتشعري بالأمان.|كل يوم فرصة للتدرّب على الصبر مع نفسكِ.|تذكّري أن احتياجاتكِ مهمة.|يمكنكِ أن تكوني لطيفة وحازمة في الوقت نفسه.|قد تحتاجين اليوم إلى مزيد من الدعم بدلًا من مزيد من الجهد.|كل يوم فرصة لاختيار نفسكِ دون إقصاء الآخرين.|أنتِ تستحقين عناية ترافقكِ حتى في الأيام الصعبة.|تعرّفي إلى جسدكِ بفضول لا بخوف.|إذا ظهرت عليكِ أعراض مقلقة أو ألم شديد، فطلب المساعدة الطبية شكل من أشكال العناية بالنفس.';

  @override
  String get cycleLateWithinRangeNote =>
      'تأخرت دورتكِ قليلًا، لكنها ما زالت ضمن التذبذب الطبيعي لدوراتكِ.';

  @override
  String get cycleLateMildNote =>
      'دورتكِ متأخرة عن نطاقكِ المعتاد. قد يؤثر التوتر أو السفر أو المرض أو قلة النوم على موعد الدورة. إذا استمر التأخر، ففكّري في إجراء اختبار حمل أو استشارة الطبيب.';

  @override
  String get cycleShortNote =>
      'دوراتكِ عادةً أقصر من 21 يومًا. إذا كان هذا جديدًا عليكِ، فمن المفيد إخبار الطبيب.';

  @override
  String get cycleLongNote =>
      'دوراتكِ عادةً أطول من 35 يومًا. إذا كان هذا جديدًا عليكِ، فمن المفيد إخبار الطبيب.';

  @override
  String get cycleMissedLogNote =>
      'إحدى دوراتكِ تبدو طويلة جدًا، وربما نسيتِ تسجيل دورة شهرية. إضافتها تجعل التوقعات أدق.';

  @override
  String get predictionConfidenceLow =>
      'ثقة التوقع: منخفضة. سجّلي بضع دورات أخرى لتحسينها.';

  @override
  String get predictionConfidenceMedium => 'ثقة التوقع: متوسطة.';

  @override
  String get predictionConfidenceHigh =>
      'ثقة التوقع: عالية. دوراتكِ الأخيرة منتظمة جدًا.';

  @override
  String reminderPatternSoon(String what) {
    return 'تنبيه: في هذا الوقت من دورتكِ غالبًا ما تلاحظين: $what. اعتني بنفسكِ.';
  }

  @override
  String get hapticsTitle => 'الاهتزاز اللمسي';

  @override
  String get hapticsHint => 'اهتزازات خفيفة عند اللمس والحفظ والتسجيل';

  @override
  String get dailyTipsTitle => 'نصائح اليوم';

  @override
  String get tipCategoryNutrition => 'التغذية';

  @override
  String get tipCategoryMovement => 'الحركة';

  @override
  String get tipCategoryRest => 'الراحة';

  @override
  String get tipsTapHint => 'اضغطي على أي نصيحة لرؤية نصيحة أخرى.';

  @override
  String get tipNutritionMenstrual =>
      'الأطعمة الغنية بالحديد مثل العدس والسبانخ والفاصولياء تساعد على تعويض ما تفقدينه 🥬|الشوربة الدافئة والأعشاب المنقوعة مريحة اليوم 🍵|أبقي زجاجة الماء قريبة؛ شرب الماء الكافي قد يخفف الانتفاخ 💧';

  @override
  String get tipMovementMenstrual =>
      'تمارين التمدد الخفيفة أو المشي البطيء تكفي اليوم 🚶‍♀️|اليوغا الخفيفة قد تخفف التوتر في الظهر والحوض 🧘‍♀️|أصغي لجسمكِ؛ لا بأس بتخطي التمرين الشاق 💗';

  @override
  String get tipRestMenstrual =>
      'جرّبي النوم مبكرًا الليلة؛ جسمكِ يعمل بجهد كبير 😴|كمادة دافئة على أسفل البطن قد تمنحكِ الراحة 🌸|اسمحي لنفسكِ بأن تبطئي اليوم 🌙';

  @override
  String get tipNutritionFollicular =>
      'الخضار والفواكه الطازجة والحبوب الكاملة تناسب طاقتكِ المتزايدة 🥗|أضيفي بعض البروتين إلى وجباتكِ لتشعري بالشبع والثبات 🍳|جرّبي وصفة صحية جديدة؛ ربما لديكِ طاقة للطبخ 🍲';

  @override
  String get tipMovementFollicular =>
      'طاقتكِ في ازدياد: وقت جيد للكارديو أو تمارين القوة 🏃‍♀️|جرّبي شيئًا جديدًا مثل حصة رياضية أو نزهة جبلية أو الرقص 💃|سخّني جسمكِ جيدًا ثم زيدي الجهد تدريجيًا 💪';

  @override
  String get tipRestFollicular =>
      'حافظي على موعد نوم ثابت للاحتفاظ بطاقتكِ ⏰|المشي القصير في ضوء النهار قد يحسّن مزاجكِ ☀️|خططي لأسبوعكِ الآن بينما ذهنكِ صافٍ 📝';

  @override
  String get tipNutritionOvulation =>
      'الفواكه والخضار الملونة اختيار جميل لوجباتكِ اليوم 🍓|اشربي الكثير من الماء؛ قد تشعرين بحرارة أكثر من المعتاد 💧|الأطعمة الغنية بالألياف مثل الشوفان والفاصولياء تُريح الهضم 🥣';

  @override
  String get tipMovementOvulation =>
      'غالبًا تكون الطاقة في ذروتها: استمتعي بتمرين تحبينه ⚡|يوم مناسب للأنشطة الجماعية أو نزهة ممتعة في الخارج 🌿|سخّني جيدًا وتمددي لحماية مفاصلكِ 🧘‍♀️';

  @override
  String get tipRestOvulation =>
      'خصصي وقتًا مع من تحبين؛ ربما تشعرين بميل أكبر للتواصل 💬|حتى في الأيام النشيطة، اهدئي قبل النوم 🌙|خذي بضع دقائق هادئة لإعادة الشحن بين الأنشطة 🍃';

  @override
  String get tipNutritionLuteal =>
      'الكربوهيدرات المعقدة مثل الشوفان والبطاطا الحلوة قد تثبّت مزاجكِ 🍠|خففي الملح والكافيين إن شعرتِ بالانتفاخ أو التوتر 🍵|المكسرات والبذور وقليل من الشوكولاتة الداكنة وجبة خفيفة مُرضية 🍫';

  @override
  String get tipMovementLuteal =>
      'المشي الهادئ أو اليوغا أو السباحة قد ترفع مزاجكِ 🏊‍♀️|خففي الشدة إذا شعرتِ بالتعب؛ الحركة الخفيفة لها قيمتها أيضًا 🍃|التمدد قبل النوم قد يخفف التوتر 🧘‍♀️';

  @override
  String get tipRestLuteal =>
      'النوم المبكر يفيد؛ قد يحتاج جسمكِ لنوم أكثر الآن 😴|كوني لطيفة مع نفسكِ إذا تراجع مزاجكِ؛ هذا شائع قبل الدورة 💗|جرّبي بضعة أنفاس بطيئة أو دشًّا دافئًا للاسترخاء 🛁';

  @override
  String get unusualCycle => 'دورة غير معتادة';

  @override
  String get unusualCycleHint =>
      'إذا اختلّت هذه الدورة بسبب مرض أو سفر أو توتر أو دواء، فعلّمها لتُستبعد من المتوسطات والتوقعات.';

  @override
  String get unusualCycleUndoHint =>
      'هذه الدورة معلّمة كغير معتادة ولا تُستخدم في التوقعات. هل تريدين إعادتها إلى الوضع العادي؟';

  @override
  String get markUnusual => 'تعليم';

  @override
  String get unmarkUnusual => 'إلغاء التعليم';

  @override
  String get historyTapHint => 'اضغطي على أي دورة لتعليمها كغير معتادة.';

  @override
  String get unusualCyclesCount => 'الدورات غير المعتادة';

  @override
  String get bbtLearningTitle => 'التعلّم من درجة حرارة الجسم القاعدية';

  @override
  String get lutealPersonal => 'طور الجسم الأصفر الشخصي';

  @override
  String get lutealDefault => 'طور الجسم الأصفر (افتراضي)';

  @override
  String get lutealLearnedHint =>
      'تم تعلّمه من دورات تأكّد فيها الإباضة بدرجة الحرارة.';

  @override
  String get lutealNeedMore =>
      'سجّلي حرارتك كل صباح قبل النهوض من السرير لبضع دورات وسيتعلّم التطبيق طور الجسم الأصفر الخاص بك.';

  @override
  String get bbtThisCycle => 'الإباضة حسب الحرارة';

  @override
  String get bbtNoShift => 'لم يظهر ارتفاع في الحرارة بعد';

  @override
  String get bbtRefinedNote => 'تم تحسين توقع الدورة القادمة بالحرارة';

  @override
  String get bbtTip =>
      'لتأكيد الإباضة، سجّلي حرارتك كل صباح قبل النهوض من السرير.';

  @override
  String get logHeroTitle => 'كيف حالكِ اليوم؟';

  @override
  String get logHeroSubtitle => 'خذي بضع دقائق لنفسكِ';

  @override
  String get logSectionGeneral => 'الحالة العامة';

  @override
  String get logSectionPhysical => 'الحالة الجسدية';

  @override
  String get logSectionNote => 'ملاحظة اليوم';
}
