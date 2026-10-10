// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homeGreeting => 'Good evening';

  @override
  String dayOfCycle(int day) {
    return 'Day $day';
  }

  @override
  String get ofYourCycle => 'of your cycle';

  @override
  String get follicularPhase => 'Follicular Phase';

  @override
  String get lutealPhase => 'Luteal Phase';

  @override
  String get menstrualPhase => 'Menstrual Phase';

  @override
  String get ovulationPhase => 'Ovulation Phase';

  @override
  String daysUntilPeriod(int days) {
    return '$days days until next period';
  }

  @override
  String get cycleHealthy => 'Your cycle is currently within your usual range.';

  @override
  String get dailyCheckIn => 'Daily check-in';

  @override
  String get howAreYouFeeling => 'How are you feeling today?';

  @override
  String get flow => 'Flow';

  @override
  String get mood => 'Mood';

  @override
  String get pain => 'Pain';

  @override
  String get energy => 'Energy';

  @override
  String get sleep => 'Sleep';

  @override
  String get symptoms => 'Symptoms';

  @override
  String get todaysSummary => 'Today\'s Summary';

  @override
  String get logToday => 'Log\ntoday';

  @override
  String get good => 'Good';

  @override
  String get medium => 'Medium';

  @override
  String get mild => 'Mild';

  @override
  String get yourCycleInsights => 'Your cycle insights';

  @override
  String get averageCycle => 'Average cycle';

  @override
  String get recentPattern => 'Recent pattern';

  @override
  String get days => 'days';

  @override
  String get home => 'Home';

  @override
  String get calendar => 'Calendar';

  @override
  String get insights => 'Insights';

  @override
  String get health => 'Health';

  @override
  String get profile => 'Profile';

  @override
  String get month => 'Month';

  @override
  String get week => 'Week';

  @override
  String get period => 'Period';

  @override
  String get fertile => 'Fertile';

  @override
  String get ovulation => 'Ovulation';

  @override
  String get periodDay => 'Period day';

  @override
  String get fertileWindow => 'Fertile window';

  @override
  String get ovulationDay => 'Ovulation day';

  @override
  String get noDataLogged => 'No data logged';

  @override
  String get logButton => 'Log';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get clear => 'Clear';

  @override
  String get ok => 'Got it';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get undo => 'Undo';

  @override
  String get today => 'Today';

  @override
  String get notSet => 'Not set';

  @override
  String get notEnoughData => 'Not enough data';

  @override
  String get invalidValue => 'That value does not look right.';

  @override
  String get goodMorning => 'Good morning';

  @override
  String get goodAfternoon => 'Good afternoon';

  @override
  String get goodNight => 'Good night';

  @override
  String periodDayNumber(int day) {
    return 'Day $day of your period';
  }

  @override
  String periodLateBy(int days) {
    return 'Period is $days days late';
  }

  @override
  String get periodLateOneDay => 'Period is 1 day late';

  @override
  String get periodExpectedToday => 'Your period is expected today';

  @override
  String get periodExpectedTomorrow => 'Your period is expected tomorrow';

  @override
  String get cycleLateNote =>
      'Your period is more than a week late. If this continues, consider a pregnancy test or talking to a doctor.';

  @override
  String get cycleIrregularNote =>
      'Your recent cycles vary in length, so predictions are less precise.';

  @override
  String get periodStartedToday => 'My period started today';

  @override
  String get periodContinuesToday => 'I still have my period today';

  @override
  String get periodLoggedToday => 'Period logged for today';

  @override
  String get noCycleDataTitle => 'No period logged yet';

  @override
  String get noCycleDataBody =>
      'Log the first day of your last period so Little Moon can start predicting your cycle.';

  @override
  String get logLastPeriod => 'Log my last period';

  @override
  String get predictionInfoTitle => 'How is this calculated?';

  @override
  String get predictionInfoBody =>
      'Your next period is estimated from the average length of your recent logged cycles. Ovulation is estimated about 14 days before the next period, and the fertile window runs from 5 days before ovulation to 1 day after.\n\nThe more periods you log, the more accurate this gets. These are estimates — do not use them as contraception.';

  @override
  String get reminders => 'Reminders';

  @override
  String get noReminders => 'Nothing to remind you of today.';

  @override
  String reminderPeriodSoon(int days) {
    return 'Your period is expected in $days days.';
  }

  @override
  String get reminderPeriodTomorrow => 'Your period is expected tomorrow.';

  @override
  String get reminderPeriodToday => 'Your period is expected today.';

  @override
  String get reminderFertileSoon => 'Your fertile window starts tomorrow.';

  @override
  String get reminderFertileToday => 'You are in your fertile window.';

  @override
  String get reminderOvulationToday => 'Today is your estimated ovulation day.';

  @override
  String get reminderLogToday => 'You have not logged anything today.';

  @override
  String get remindersHint =>
      'You get a phone notification at 9:00 for cycle reminders and at 21:00 for the daily log. They also appear on the home screen bell.';

  @override
  String get reminderPeriodSetting => 'Upcoming period';

  @override
  String get reminderDaysBefore => 'Remind me before';

  @override
  String get reminderFertileSetting => 'Fertile window';

  @override
  String get reminderOvulationSetting => 'Ovulation day';

  @override
  String get reminderLogSetting => 'Daily log';

  @override
  String get futureDayNotAllowed => 'You can only log today or past days.';

  @override
  String get flowNone => 'None';

  @override
  String get flowSpotting => 'Spotting';

  @override
  String get flowLight => 'Light';

  @override
  String get flowMedium => 'Medium';

  @override
  String get flowHeavy => 'Heavy';

  @override
  String get moodHappy => 'Happy';

  @override
  String get moodCalm => 'Calm';

  @override
  String get moodSensitive => 'Sensitive';

  @override
  String get moodSad => 'Sad';

  @override
  String get moodIrritable => 'Irritable';

  @override
  String get moodAnxious => 'Anxious';

  @override
  String get painNone => 'No pain';

  @override
  String get painSevere => 'Severe';

  @override
  String get energyLow => 'Low';

  @override
  String get energyHigh => 'High';

  @override
  String get symptomCramps => 'Cramps';

  @override
  String get symptomHeadache => 'Headache';

  @override
  String get symptomBackPain => 'Back pain';

  @override
  String get symptomBloating => 'Bloating';

  @override
  String get symptomBreastTenderness => 'Breast tenderness';

  @override
  String get symptomAcne => 'Acne';

  @override
  String get symptomNausea => 'Nausea';

  @override
  String get symptomFatigue => 'Fatigue';

  @override
  String get symptomCravings => 'Cravings';

  @override
  String get symptomInsomnia => 'Insomnia';

  @override
  String get symptomDizziness => 'Dizziness';

  @override
  String get symptomDischarge => 'Discharge';

  @override
  String get note => 'Note';

  @override
  String get noteHint => 'Anything you want to remember about today…';

  @override
  String sleepHours(int hours) {
    return '${hours}h';
  }

  @override
  String sleepHoursMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String get predicted => 'Predicted';

  @override
  String get predictedPeriodDay => 'Predicted period';

  @override
  String cycleDayShort(int day) {
    return 'Cycle day $day';
  }

  @override
  String get dataLogged => 'Logged';

  @override
  String get insightsEmpty =>
      'Once you log your first period, your cycle statistics and predictions will show up here.';

  @override
  String get averagePeriod => 'Average period';

  @override
  String get regularity => 'Regularity';

  @override
  String get regular => 'Regular';

  @override
  String get irregular => 'Irregular';

  @override
  String get cyclesTracked => 'Cycles tracked';

  @override
  String get predictions => 'Predictions';

  @override
  String get nextPeriod => 'Next period';

  @override
  String get followingPeriod => 'Following period';

  @override
  String get cycleHistory => 'Cycle history';

  @override
  String get historyEmpty =>
      'Your cycle lengths will appear here after you log at least two periods.';

  @override
  String get topSymptoms => 'Most frequent symptoms';

  @override
  String get last90Days => 'Last 90 days';

  @override
  String get noSymptomsLogged => 'No symptoms logged yet.';

  @override
  String get moodSummary => 'Mood';

  @override
  String get noMoodLogged => 'No mood logged yet.';

  @override
  String get medicalDisclaimer =>
      'Predictions are estimates based on what you log. They are not medical advice and should not be used as contraception.';

  @override
  String get yourBody => 'Your body';

  @override
  String get tipsForYou => 'Tips for this phase';

  @override
  String get todayTracking => 'Today';

  @override
  String get water => 'Water';

  @override
  String glassesOfGoal(int count, int goal) {
    return '$count of $goal glasses';
  }

  @override
  String get weight => 'Weight';

  @override
  String get weightHint => 'e.g. 58.5';

  @override
  String get kg => 'kg';

  @override
  String get bodyTemperature => 'Body temperature';

  @override
  String get temperatureHint => 'e.g. 36.6';

  @override
  String get tapToAdd => 'Tap to add';

  @override
  String get averageSleep7 => 'Average sleep (7 days)';

  @override
  String get pregnancyChanceToday => 'Chance of pregnancy today';

  @override
  String get chanceLow => 'Low';

  @override
  String get chanceMedium => 'Medium';

  @override
  String get chanceHigh => 'High';

  @override
  String get aboutMenstrual =>
      'Your period marks the start of a new cycle. The lining of the uterus is shed, and it is normal to feel lower on energy for a few days.';

  @override
  String get aboutFollicular =>
      'After your period, estrogen rises and your body prepares to release an egg. Most people feel more energetic and focused in this phase.';

  @override
  String get aboutOvulation =>
      'An egg is released around now. This is the most fertile part of your cycle.';

  @override
  String get aboutLuteal =>
      'After ovulation, progesterone rises. In the days before your period you may notice PMS symptoms such as bloating, tender breasts or mood changes.';

  @override
  String get aboutNoData =>
      'Log your period to see which phase of your cycle you are in and get tips that fit it.';

  @override
  String get tipMenstrual1 =>
      'Rest when you need to. Gentle movement such as walking or stretching can ease cramps.';

  @override
  String get tipMenstrual2 =>
      'A warm compress on your lower belly may help with pain.';

  @override
  String get tipMenstrual3 =>
      'Iron-rich foods like lentils, spinach and red meat, plus enough water, help you recover.';

  @override
  String get tipFollicular1 =>
      'Energy usually rises in this phase, so it is a good time for more intense exercise.';

  @override
  String get tipFollicular2 =>
      'A good time to start new plans or tasks that need focus.';

  @override
  String get tipFollicular3 =>
      'Keep your meals balanced with protein and fresh vegetables.';

  @override
  String get tipOvulation1 => 'This is the most fertile time of your cycle.';

  @override
  String get tipOvulation2 =>
      'Mild one-sided lower belly pain or clearer discharge is usually normal around ovulation.';

  @override
  String get tipOvulation3 =>
      'Energy and mood are often at their best, so enjoy being active.';

  @override
  String get tipLuteal1 =>
      'PMS symptoms such as bloating or mood changes may show up. Go easy on yourself.';

  @override
  String get tipLuteal2 =>
      'Cutting back on salt, caffeine and sugar can ease bloating and irritability.';

  @override
  String get tipLuteal3 =>
      'Prioritise sleep and lighter exercise such as yoga or walking.';

  @override
  String get tipGeneral1 =>
      'Log your period regularly. Predictions get more accurate after a few cycles.';

  @override
  String get tipGeneral2 =>
      'Drink enough water and keep a steady sleep schedule.';

  @override
  String get tipGeneral3 =>
      'See a doctor if your cycles are often shorter than 21 or longer than 35 days, or if the pain is severe.';

  @override
  String get yourName => 'Your name';

  @override
  String get nameHint => 'What should we call you?';

  @override
  String get noName => 'Dear friend';

  @override
  String trackingSince(String date) {
    return 'Tracking since $date';
  }

  @override
  String get daysLogged => 'Days logged';

  @override
  String get periodsLogged => 'Periods logged';

  @override
  String get cycleSettings => 'Cycle settings';

  @override
  String get cycleSettingsHint =>
      'Used for predictions until you have logged a few cycles.';

  @override
  String get cycleLength => 'Cycle length';

  @override
  String get cycleLengthHint =>
      'From the first day of one period to the first day of the next. Usually 21 to 35 days.';

  @override
  String get periodLength => 'Period length';

  @override
  String get periodLengthHint =>
      'How many days your bleeding usually lasts. Usually 3 to 7 days.';

  @override
  String get lutealLength => 'Luteal phase length';

  @override
  String get lutealLengthHint =>
      'Days between ovulation and your next period. Leave it at 14 unless you know yours.';

  @override
  String get privacyNote =>
      'Everything stays on this device. Little Moon works fully offline and never sends your data anywhere.';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get calendarType => 'Calendar';

  @override
  String get calendarJalali => 'Solar Hijri (Shamsi)';

  @override
  String get calendarGregorian => 'Gregorian';

  @override
  String get theme => 'Theme';

  @override
  String get themeMoon => 'Moon';

  @override
  String get themeSakura => 'Sakura';

  @override
  String get themeLavender => 'Lavender';

  @override
  String get themeOcean => 'Ocean';

  @override
  String get themeMint => 'Mint';

  @override
  String get themeSunset => 'Sunset';

  @override
  String get themeMidnight => 'Midnight';

  @override
  String get themeNightRose => 'Night rose';

  @override
  String get dataAndBackup => 'Data and backup';

  @override
  String get backupHint =>
      'Your backup is plain text that you can keep anywhere you like.';

  @override
  String get copyBackup => 'Copy backup to clipboard';

  @override
  String get backupCopied => 'Backup copied. Paste it somewhere safe.';

  @override
  String get restoreBackup => 'Restore from backup';

  @override
  String get restoreHint => 'Paste your backup text here';

  @override
  String get restoreInvalid => 'This is not a valid Little Moon backup.';

  @override
  String get restoreConfirm =>
      'This replaces everything currently in the app with the backup. Continue?';

  @override
  String get restore => 'Restore';

  @override
  String get restoreDone => 'Backup restored.';

  @override
  String get deleteAllData => 'Delete all data';

  @override
  String get deleteAllConfirm =>
      'All your logs, profile and settings will be permanently deleted. This cannot be undone.';

  @override
  String get onboardingWelcomeTitle => 'Welcome';

  @override
  String get onboardingWelcomeBody =>
      'Little Moon helps you track your period and know what is coming next. A few quick questions to get started.';

  @override
  String get lastPeriodQuestion => 'When did your last period start?';

  @override
  String get lastPeriodHint =>
      'Pick the first day of bleeding. You can change it later.';

  @override
  String get dontRemember => 'I do not remember';

  @override
  String get periodLengthQuestion => 'How long does your period usually last?';

  @override
  String get cycleLengthQuestion => 'How long is your cycle usually?';

  @override
  String get getStarted => 'Get started';

  @override
  String get insightsTitle => 'Cycle insights';

  @override
  String get dedication => 'This app is dedicated to my little moon';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get chooseAvatar => 'Choose your avatar';

  @override
  String get aboutDeveloper => 'About the developer';

  @override
  String get aboutAppBody =>
      'Little Moon is a private, free and offline platform for girls and women to track their periods. It predicts your monthly cycle from the information you log yourself and shows it to you. All your data is stored only on your own phone.';

  @override
  String appVersion(String version) {
    return 'Version $version';
  }

  @override
  String get developer => 'Made by';

  @override
  String get email => 'Email';

  @override
  String get website => 'Website';

  @override
  String get telegram => 'Telegram';

  @override
  String get instagram => 'Instagram';

  @override
  String get copied => 'Copied';

  @override
  String get madeWithLove => 'Made by ALION';
}
