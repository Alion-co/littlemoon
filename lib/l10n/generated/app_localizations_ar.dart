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
  String get dedication => 'هذا التطبيق مُهدى إلى قمري الصغير';

  @override
  String get editProfile => 'تعديل الملف';

  @override
  String get chooseAvatar => 'اختاري صورتكِ الرمزية';

  @override
  String get aboutDeveloper => 'عن المطوّر';

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
}
