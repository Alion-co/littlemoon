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
  String get onboardingHello => 'Hello!';

  @override
  String get onboardingWelcomeLine => 'Welcome to Little Moon';

  @override
  String get onboardingTagline =>
      'Your everyday companion for managing your cycle and feeling better';

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
  String get dedication => 'Dedicated to my little moon';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get chooseAvatar => 'Choose your avatar';

  @override
  String get aboutDeveloper => 'About Little Moon';

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

  @override
  String get appTitle => 'Little Moon';

  @override
  String dateRange(String start, String end) {
    return '$start – $end';
  }

  @override
  String get privacySection => 'Privacy';

  @override
  String get appLock => 'App lock';

  @override
  String get appLockHint => 'Protect the app with a PIN or your fingerprint.';

  @override
  String get appLockOn => 'App lock is on.';

  @override
  String get useBiometric => 'Unlock with fingerprint';

  @override
  String get changePin => 'Change PIN';

  @override
  String get pinChanged => 'PIN changed.';

  @override
  String get enterPin => 'Enter your PIN';

  @override
  String get newPin => 'Choose a 4-digit PIN';

  @override
  String get confirmPin => 'Enter the PIN again';

  @override
  String get pinMismatch => 'The PINs didn\'t match. Try again.';

  @override
  String get wrongPin => 'Wrong PIN';

  @override
  String tooManyAttempts(int seconds) {
    return 'Too many attempts. Wait $seconds seconds.';
  }

  @override
  String get unlockReason => 'Unlock Little Moon';

  @override
  String get forgotPin => 'I forgot my PIN';

  @override
  String get forgotPinBody =>
      'The PIN can\'t be recovered because no data ever leaves your phone. You can erase all data and start over; if you saved a backup, you can restore it afterwards.';

  @override
  String get resetApp => 'Erase and start over';

  @override
  String get discreetNotifications => 'Discreet notifications';

  @override
  String get discreetNotificationsHint =>
      'Reminders and the widget use neutral text that says nothing about your cycle, and are hidden on the lock screen.';

  @override
  String get discreetTitle => 'Reminder';

  @override
  String get discreetCycleBody => 'You have a new reminder.';

  @override
  String get discreetLogBody => 'Your note for today is waiting.';

  @override
  String get discreetPillBody => 'It\'s time for your daily reminder.';

  @override
  String get pillReminder => 'Pill reminder';

  @override
  String get pillReminderTime => 'Pill reminder time';

  @override
  String get reminderPill => 'Time to take your pill.';

  @override
  String get widgetTitle => 'Home screen widget';

  @override
  String get widgetHint =>
      'Long-press an empty spot on your home screen, tap Widgets and add Little Moon. With discreet notifications on, the widget only shows the day number.';

  @override
  String get doctorReport => 'Report for your doctor';

  @override
  String get doctorReportHint =>
      'A PDF summary of your cycles, symptoms and mood, made right on this phone.';

  @override
  String get reportTitle => 'Menstrual cycle report';

  @override
  String reportGenerated(String date) {
    return 'Prepared on $date';
  }

  @override
  String reportWindow(int days, int logged) {
    return 'Symptom statistics cover the last $days days ($logged days logged)';
  }

  @override
  String get reportSummary => 'Summary';

  @override
  String get reportCycleRange => 'Shortest and longest cycle';

  @override
  String reportMinMax(int min, int max) {
    return '$min to $max days';
  }

  @override
  String get reportLastPeriod => 'Last period started';

  @override
  String get reportStart => 'Start date';

  @override
  String get reportInProgress => 'Current';

  @override
  String get reportUnitsNote =>
      'All values are in days. * means a period was probably not logged in this cycle, so it is left out of the averages.';

  @override
  String reportTimes(int count) {
    return '$count times';
  }

  @override
  String get reportPainDays => 'Days with moderate or severe pain';

  @override
  String get reportFooter =>
      'Made with Little Moon, based on data logged by the user';

  @override
  String get reportFailed => 'Couldn\'t create the report. Please try again.';

  @override
  String get year => 'Year';

  @override
  String get quickLog => 'Quick log';

  @override
  String get quickLogHint => 'Saved with one tap';

  @override
  String get detailedLog => 'Detailed log';

  @override
  String get saveBackupFile => 'Save backup to a file';

  @override
  String get restoreBackupFile => 'Restore from a backup file';

  @override
  String get backupFileSaved => 'Backup file saved.';

  @override
  String get backupFileFailed =>
      'Couldn\'t save the file, so the backup text was copied to the clipboard.';

  @override
  String reminderLate(int days) {
    return 'Your period is $days days late. If it has started, log it to keep predictions accurate.';
  }

  @override
  String get lateReminderSetting => 'Late period';

  @override
  String get autoNightTheme => 'Automatic night theme';

  @override
  String get autoNightThemeHint =>
      'Uses a night theme when your phone is in dark mode.';

  @override
  String get patternsTitle => 'Your patterns';

  @override
  String get patternsSubtitle => 'Things that repeat across your cycles';

  @override
  String get patternsEmpty =>
      'No repeating patterns yet. The more cycles you log symptoms and mood for, the more patterns will show up here.';

  @override
  String get patternsNote =>
      'Worked out on this phone from your own logs only. Not a medical diagnosis.';

  @override
  String get patternPain => 'Moderate or severe pain';

  @override
  String get patternDayBefore => 'Usually the day before your period';

  @override
  String patternDaysBefore(int days) {
    return 'Usually about $days days before your period';
  }

  @override
  String patternDuring(int day) {
    return 'Usually on day $day of your period';
  }

  @override
  String patternSeen(int cycles) {
    return 'in $cycles cycles';
  }

  @override
  String get charts => 'Charts';

  @override
  String get chartsHint =>
      'Tap or drag across a chart to see each day\'s value.';

  @override
  String get chartNotEnoughData => 'This chart needs at least two entries.';

  @override
  String get chartCycleSubtitle =>
      'Last 12 cycles; the dashed line is the average';

  @override
  String chartLastDays(int days) {
    return 'Last $days days';
  }

  @override
  String chartSleepSubtitle(int days) {
    return 'Hours of sleep over the last $days days';
  }

  @override
  String get aboutTagline => 'Your gentle cycle companion';

  @override
  String get aboutMeta => 'Free & open source · Fully offline';

  @override
  String get rateOnMyket => 'Rate on Myket';

  @override
  String get rateOnBazaar => 'Rate on Bazaar';

  @override
  String get developerRole => 'Maker of this app';

  @override
  String get contactCall => 'Call';

  @override
  String get settingsAppearance => 'Appearance & language';

  @override
  String remindersOnCount(int count) {
    return '$count reminders on';
  }

  @override
  String get appLockStatusOn => 'App lock on';

  @override
  String get appLockStatusOff => 'App lock off';

  @override
  String get settingsDataSubtitle => 'Backup, restore and delete data';

  @override
  String get cycleRemindersGroup => 'Cycle';

  @override
  String get dailyRemindersGroup => 'Daily';

  @override
  String get notificationsCaption => 'Notifications';

  @override
  String get backupFileCaption => 'Backup file';

  @override
  String get backupTextCaption => 'Transfer as text';

  @override
  String get dataLocalNote =>
      'All your data and files are only available on your device and are never sent to any server.';

  @override
  String get widgetDayLabel => 'cycle day';

  @override
  String get widgetSizeWide => 'Slim · 5×1';

  @override
  String get widgetSizeSquare => 'Small · 2×2';

  @override
  String get widgetSizeMedium => 'Medium · 3×2';

  @override
  String get addWidget => 'Add';

  @override
  String get widgetPinFailed =>
      'Couldn\'t add the widget. Add it from your home screen\'s widgets.';

  @override
  String get careMenstrual =>
      'Rest a little; your body is doing big work 🌙|A warm herbal tea can help today ☕|Be extra gentle with yourself today 💗|Drink enough water and sleep a bit more 💧|A warm compress can ease cramps 🌸';

  @override
  String get careFollicular =>
      'Your energy is coming back; time for fresh starts ✨|A great day to move and exercise 🏃‍♀️|Write your ideas down; your mind is sharp 📝|Like the moon, you grow fuller every day 🌒';

  @override
  String get careOvulation =>
      'You\'re shining brighter than ever today ✨|Celebrate your confidence 💫|A lovely time to see your friends 🌸|Your energy is at its peak; enjoy it ☀️';

  @override
  String get careLuteal =>
      'Feeling a bit low is completely normal 🌙|Go easy on salt and caffeine; your body will thank you 🍵|A gentle walk can lift your mood 🍃|Enough sleep is the best gift to yourself 😴';

  @override
  String get careDiscreet =>
      'Be kind to yourself today 💗|Have a glass of water 💧|Take a deep breath 🍃|You are wonderful ✨';

  @override
  String get widgetChooseHint => 'Pick one and add it to your home screen.';

  @override
  String addWidgetToHome(String name) {
    return 'Add the $name widget';
  }

  @override
  String get widgetPinNotShown => 'Didn\'t see the add-widget window?';

  @override
  String get widgetHelp => 'Help';

  @override
  String get widgetHelpTitle => 'Widget not added?';

  @override
  String get widgetHelpBody =>
      'Some phones, such as Xiaomi and Poco, only add widgets after you allow it:\n\n1. Long-press the Little Moon icon and tap App info.\n2. Open Other permissions.\n3. Set Home screen shortcuts to Allow.\n4. Come back and tap the add button again.\n\nAlternatively, long-press an empty spot on your home screen, tap Widgets and find Little Moon.';

  @override
  String get widgetSizeLarge => 'Large · 5×4';

  @override
  String get careGeneral =>
      'Every day is a new chance to be kinder to yourself.|Listen to your body; it speaks to you every day.|You don\'t have to be strong every day; being honest with yourself is enough.|Rest is part of your growth journey, too.|You are worthy in every phase of your cycle.|Treat yourself today the way you would treat your best friend.|You don\'t have to figure everything out today.|Your body deserves care, not criticism.|Give yourself permission to slow down.|You don\'t have to shine every day; your presence is enough.|One deep breath, one peaceful moment, one fresh start.|Your feelings aren\'t your enemy; listen to them with kindness.|You are more than what you accomplish today.|Every small step you take for yourself matters.|Work with your body instead of fighting it.|You don\'t have to be the perfect version of yourself today.|You are allowed to feel hopeful and tired at the same time.|Every cycle is a chance to understand yourself a little better.|Self-kindness is a powerful habit.|Be proud of your progress, even when it\'s slow.|If you need rest today, listen to yourself.|A calm, nourishing meal is also an act of self-love.|Drink some water and give yourself a few moments.|A little gentle stretching can be an invitation to relax.|Enough sleep is a gift you give your future self.|You don\'t need a big reason to give yourself a moment of calm.|A warm shower can be a moment just for you.|If your body moves more slowly today, be gentle with it.|Setting boundaries is a form of self-care, too.|Give yourself permission to ask for help.|Do one small thing today that brings you peace.|Your body has real needs; honor them.|Self-care doesn\'t have to be complicated or expensive.|Ask yourself today: What do I really need?|A few screen-free minutes are a gift to your mind.|Make a promise to judge yourself a little less today.|When you\'re tired, you don\'t need to justify resting.|Focus on being real rather than perfect.|You deserve love and respect today, too.|Appreciate your body for all it does for you.|You don\'t have to change every feeling immediately.|Leave a little space for yourself today.|You can be strong and still need support.|Your body isn\'t a project to fix; it\'s a companion to cherish.|You don\'t have to fight your body to deserve love.|Every month is a new chance to understand yourself, not judge yourself.|Your body doesn\'t have to look like anyone else\'s.|Your worth isn\'t measured by numbers on a calendar or scale.|Get curious about your body instead of blaming it.|Every day doesn\'t have to look like yesterday.|Your body deserves your patience.|Changes in your energy are part of being human; meet yourself where you are.|You don\'t have to maximize every single day.|You are allowed to adapt your plans to your needs.|Trust yourself; you know your own experience best.|Every feeling you have deserves attention.|You don\'t have to apologize for needing rest.|Your body isn\'t the enemy of your plans; it has information for you.|Self-awareness begins with noticing the little things.|Follow your own path instead of comparing yourself.|You don\'t have to feel the same every day.|Your body deserves respect, even on hard days.|Speak to yourself more gently; your inner words matter.|You don\'t need to have all the answers today.|Give yourself time to grow, change, and begin again.|You deserve the peace you create for others.|Sometimes the best thing to do is less.|Each time you listen to a need, you grow closer to yourself.|Your body works with you; show it gratitude.|You don\'t have to minimize your pain or tiredness.|Self-care means taking your own needs seriously.|You can begin again, even with one small step.|Taking a break doesn\'t mean you\'ve failed.|Let your body have its own rhythm.|Your peace is part of your success, too.|A healthy boundary can protect your energy today.|You don\'t have to be available to everyone all the time.|A quiet moment can be self-care, too.|Support yourself today instead of pushing yourself harder.|You can be proud of yourself even if no one notices.|A day doesn\'t have to be productive to be valuable.|Instead of punishing yourself, ask what might help you.|Your body deserves the attention you give your tasks.|Instead of asking why you\'re not your usual self, ask what you need now.|One hard day is not your whole story.|Give yourself room to feel without judgment.|You don\'t have to prove your struggle to deserve support.|Remind yourself: having needs is part of being human.|Moving more slowly is still moving forward.|You can be committed to your goals and still prioritize rest.|Thank your body for being with you through every day.|You don\'t have to act on every feeling; sometimes noticing it is enough.|Listening to yourself helps you make more mindful choices.|Offer yourself support instead of blame.|You can reset your day; you don\'t have to stick rigidly to the plan.|Every cycle has its own story; observe it with curiosity.|Track your changes to better understand your own patterns.|Your cycle doesn\'t have to be like anyone else\'s.|The better you know yourself, the more fitting your care can be.|Your body isn\'t a one-size-fits-all calendar; learn your own patterns.|If your cycle pattern changes, notice it with curiosity rather than blame.|Cycle tracking is for understanding yourself, not limiting yourself.|Your body may have different needs throughout the month.|Observing without judgment is the beginning of better care.|Pay attention to your body\'s signals rather than relying on certainty.|Every month is a chance to learn something new about yourself.|Remember that everyone\'s cycle experience can be different.|Note your body\'s signals; understanding them can bring peace of mind.|Your cycle is part of your experience, not your entire identity.|Every day is a chance to begin again.|Everything doesn\'t have to be perfect for you to have a good day.|You are stronger than your hardest days make you feel.|Trust your path, even when the next step isn\'t clear.|Every time you keep going, you learn something about yourself.|Be proud of yourself for how far you\'ve come.|You don\'t have to move at anyone else\'s pace.|Hope can be quiet and gentle, too.|Remind yourself that small beginnings matter, too.|You can change your plan and still stay true to your goal.|Every day is a new chance to choose kindness.|You deserve the same support you give to others.|When the path gets hard, be on your own team.|Not every change has to happen all at once.|Small steps can help you build a kinder life for yourself.|Every day doesn\'t need a grand beginning; sometimes one breath is enough.|Give yourself time to find hope again today.|You can be learning and progressing at the same time.|Focus on the next step instead of rushing.|You don\'t have to prove anything to be worthy.|Sometimes progress means realizing what no longer works for you.|Allow yourself to redefine what success means to you.|Every mindful step brings you closer to yourself.|Today, accompany yourself instead of competing with yesterday\'s you.|You can pause, breathe, and choose again.|You can be kind to yourself even on uncertain days.|Begin today with one kind intention for yourself.|You deserve a peaceful and kind relationship with yourself.|Each time you respect yourself, your boundaries become clearer.|You can make time for yourself without guilt.|Remind yourself: I\'m learning, not falling behind.|Today, you can make one small choice in favor of your peace.|You don\'t have to control everything to feel safe.|Every day is a chance to practice patience with yourself.|Remember that your needs matter.|You can be kind and still stand firm.|Today, you may need more support rather than more effort.|Every day is a chance to choose yourself without dismissing others.|You deserve care that stays with you on hard days, too.|Get to know your body with curiosity, not fear.|If you have a concerning symptom or severe pain, seeking professional help is an act of care.';

  @override
  String get careGeneralDiscreet =>
      'Every day is a new chance to be kinder to yourself.|Listen to your body; it speaks to you every day.|You don\'t have to be strong every day; being honest with yourself is enough.|Rest is part of your growth journey, too.|Treat yourself today the way you would treat your best friend.|You don\'t have to figure everything out today.|Your body deserves care, not criticism.|Give yourself permission to slow down.|You don\'t have to shine every day; your presence is enough.|One deep breath, one peaceful moment, one fresh start.|Your feelings aren\'t your enemy; listen to them with kindness.|You are more than what you accomplish today.|Every small step you take for yourself matters.|Work with your body instead of fighting it.|You don\'t have to be the perfect version of yourself today.|You are allowed to feel hopeful and tired at the same time.|Be proud of your progress, even when it\'s slow.|If you need rest today, listen to yourself.|A calm, nourishing meal is also an act of self-love.|Drink some water and give yourself a few moments.|A little gentle stretching can be an invitation to relax.|Enough sleep is a gift you give your future self.|You don\'t need a big reason to give yourself a moment of calm.|A warm shower can be a moment just for you.|If your body moves more slowly today, be gentle with it.|Setting boundaries is a form of self-care, too.|Give yourself permission to ask for help.|Do one small thing today that brings you peace.|Your body has real needs; honor them.|Self-care doesn\'t have to be complicated or expensive.|Ask yourself today: What do I really need?|A few screen-free minutes are a gift to your mind.|Make a promise to judge yourself a little less today.|When you\'re tired, you don\'t need to justify resting.|Focus on being real rather than perfect.|You deserve love and respect today, too.|Appreciate your body for all it does for you.|You don\'t have to change every feeling immediately.|Leave a little space for yourself today.|You can be strong and still need support.|You don\'t have to fight your body to deserve love.|Every month is a new chance to understand yourself, not judge yourself.|Your body doesn\'t have to look like anyone else\'s.|Your worth isn\'t measured by numbers on a calendar or scale.|Get curious about your body instead of blaming it.|Every day doesn\'t have to look like yesterday.|Your body deserves your patience.|Changes in your energy are part of being human; meet yourself where you are.|You don\'t have to maximize every single day.|You are allowed to adapt your plans to your needs.|Trust yourself; you know your own experience best.|Every feeling you have deserves attention.|You don\'t have to apologize for needing rest.|Your body isn\'t the enemy of your plans; it has information for you.|Self-awareness begins with noticing the little things.|Follow your own path instead of comparing yourself.|You don\'t have to feel the same every day.|Your body deserves respect, even on hard days.|Speak to yourself more gently; your inner words matter.|You don\'t need to have all the answers today.|Give yourself time to grow, change, and begin again.|You deserve the peace you create for others.|Sometimes the best thing to do is less.|Each time you listen to a need, you grow closer to yourself.|Your body works with you; show it gratitude.|You don\'t have to minimize your pain or tiredness.|Self-care means taking your own needs seriously.|You can begin again, even with one small step.|Taking a break doesn\'t mean you\'ve failed.|Let your body have its own rhythm.|Your peace is part of your success, too.|A healthy boundary can protect your energy today.|You don\'t have to be available to everyone all the time.|A quiet moment can be self-care, too.|Support yourself today instead of pushing yourself harder.|You can be proud of yourself even if no one notices.|A day doesn\'t have to be productive to be valuable.|Instead of punishing yourself, ask what might help you.|Your body deserves the attention you give your tasks.|One hard day is not your whole story.|Give yourself room to feel without judgment.|You don\'t have to prove your struggle to deserve support.|Remind yourself: having needs is part of being human.|Moving more slowly is still moving forward.|You can be committed to your goals and still prioritize rest.|Thank your body for being with you through every day.|You don\'t have to act on every feeling; sometimes noticing it is enough.|Listening to yourself helps you make more mindful choices.|Offer yourself support instead of blame.|You can reset your day; you don\'t have to stick rigidly to the plan.|Track your changes to better understand your own patterns.|The better you know yourself, the more fitting your care can be.|Your body isn\'t a one-size-fits-all calendar; learn your own patterns.|Your body may have different needs throughout the month.|Observing without judgment is the beginning of better care.|Pay attention to your body\'s signals rather than relying on certainty.|Every month is a chance to learn something new about yourself.|Note your body\'s signals; understanding them can bring peace of mind.|Every day is a chance to begin again.|Everything doesn\'t have to be perfect for you to have a good day.|You are stronger than your hardest days make you feel.|Trust your path, even when the next step isn\'t clear.|Every time you keep going, you learn something about yourself.|Be proud of yourself for how far you\'ve come.|You don\'t have to move at anyone else\'s pace.|Hope can be quiet and gentle, too.|Remind yourself that small beginnings matter, too.|You can change your plan and still stay true to your goal.|Every day is a new chance to choose kindness.|You deserve the same support you give to others.|When the path gets hard, be on your own team.|Not every change has to happen all at once.|Small steps can help you build a kinder life for yourself.|Every day doesn\'t need a grand beginning; sometimes one breath is enough.|Give yourself time to find hope again today.|You can be learning and progressing at the same time.|Focus on the next step instead of rushing.|You don\'t have to prove anything to be worthy.|Sometimes progress means realizing what no longer works for you.|Allow yourself to redefine what success means to you.|Every mindful step brings you closer to yourself.|Today, accompany yourself instead of competing with yesterday\'s you.|You can pause, breathe, and choose again.|You can be kind to yourself even on uncertain days.|Begin today with one kind intention for yourself.|You deserve a peaceful and kind relationship with yourself.|Each time you respect yourself, your boundaries become clearer.|You can make time for yourself without guilt.|Remind yourself: I\'m learning, not falling behind.|Today, you can make one small choice in favor of your peace.|You don\'t have to control everything to feel safe.|Every day is a chance to practice patience with yourself.|Remember that your needs matter.|You can be kind and still stand firm.|Today, you may need more support rather than more effort.|Every day is a chance to choose yourself without dismissing others.|You deserve care that stays with you on hard days, too.|Get to know your body with curiosity, not fear.|If you have a concerning symptom or severe pain, seeking professional help is an act of care.';

  @override
  String get cycleLateWithinRangeNote =>
      'Your period is a little late, but that is still within the normal variation of your cycles.';

  @override
  String get cycleLateMildNote =>
      'Your period is later than your usual range. Stress, travel, illness or poor sleep can shift a cycle. If it keeps being late, consider a pregnancy test or talking to a doctor.';

  @override
  String get cycleShortNote =>
      'Your cycles are usually shorter than 21 days. If this is new for you, it is worth mentioning to a doctor.';

  @override
  String get cycleLongNote =>
      'Your cycles are usually longer than 35 days. If this is new for you, it is worth mentioning to a doctor.';

  @override
  String get cycleMissedLogNote =>
      'One of your cycles looks unusually long, so you may have missed logging a period. Adding it will make predictions more accurate.';

  @override
  String get predictionConfidenceLow =>
      'Prediction confidence: low. Log a few more cycles to improve it.';

  @override
  String get predictionConfidenceMedium => 'Prediction confidence: medium.';

  @override
  String get predictionConfidenceHigh =>
      'Prediction confidence: high. Your recent cycles are very consistent.';

  @override
  String reminderPatternSoon(String what) {
    return 'Heads-up: around this time in your cycle you often notice: $what. Be kind to yourself.';
  }

  @override
  String get hapticsTitle => 'Haptic feedback';

  @override
  String get hapticsHint =>
      'Gentle vibrations when you tap, save or log something';

  @override
  String get dailyTipsTitle => 'Tips for today';

  @override
  String get tipCategoryNutrition => 'Nutrition';

  @override
  String get tipCategoryMovement => 'Movement';

  @override
  String get tipCategoryRest => 'Rest';

  @override
  String get tipsTapHint => 'Tap a tip to see another one.';

  @override
  String get tipNutritionMenstrual =>
      'Iron-rich foods like lentils, spinach or beans can help replace what you lose 🥬|Warm soups and herbal teas can feel soothing today 🍵|Keep a water bottle close; staying hydrated can ease bloating 💧';

  @override
  String get tipMovementMenstrual =>
      'Gentle stretching or a slow walk is plenty today 🚶‍♀️|Light yoga can ease tension in your back and hips 🧘‍♀️|Listen to your body: it is okay to skip an intense workout 💗';

  @override
  String get tipRestMenstrual =>
      'Try an earlier bedtime tonight; your body is working hard 😴|A warm compress on your lower belly can be comforting 🌸|Give yourself permission to slow down today 🌙';

  @override
  String get tipNutritionFollicular =>
      'Fresh vegetables, fruit and whole grains suit your rising energy 🥗|Add some protein to your meals to feel full and steady 🍳|Try a new healthy recipe; you may have energy to cook 🍲';

  @override
  String get tipMovementFollicular =>
      'Your energy is climbing: a good time for cardio or strength training 🏃‍♀️|Try something new, like a class, a hike or a dance 💃|Warm up well, then you can gradually push a little harder 💪';

  @override
  String get tipRestFollicular =>
      'Keep a steady sleep schedule to hold on to your energy ⏰|A short walk outside in daylight can lift your mood ☀️|Plan your week now while your mind feels sharp 📝';

  @override
  String get tipNutritionOvulation =>
      'Colorful fruits and vegetables are a lovely way to eat today 🍓|Drink plenty of water; you might feel warmer than usual 💧|Fiber-rich foods like oats and beans keep digestion comfortable 🥣';

  @override
  String get tipMovementOvulation =>
      'Energy is often at its peak: enjoy a workout you love ⚡|A good day for group activities or a fun outdoor walk 🌿|Warm up and stretch well to protect your joints 🧘‍♀️';

  @override
  String get tipRestOvulation =>
      'Plan time with people you enjoy; you may feel more social 💬|Even on high-energy days, wind down before bed 🌙|Take a few quiet minutes to recharge between activities 🍃';

  @override
  String get tipNutritionLuteal =>
      'Complex carbs like oats and sweet potato can steady your mood 🍠|Go easy on salt and caffeine if you feel bloated or tense 🍵|Nuts, seeds and a little dark chocolate can be a satisfying snack 🍫';

  @override
  String get tipMovementLuteal =>
      'A gentle walk, yoga or swimming can lift your mood 🏊‍♀️|Lower the intensity if you feel tired; moving gently still counts 🍃|Stretching before bed can ease tension 🧘‍♀️';

  @override
  String get tipRestLuteal =>
      'Early nights help; your body may need more sleep now 😴|Be kind to yourself if your mood dips; it is common before a period 💗|Try a few slow breaths or a warm shower to unwind 🛁';

  @override
  String get unusualCycle => 'Unusual cycle';

  @override
  String get unusualCycleHint =>
      'If illness, travel, stress or medication threw this cycle off, mark it so it\'s left out of your averages and predictions.';

  @override
  String get unusualCycleUndoHint =>
      'This cycle is marked unusual and isn\'t used for predictions. Switch it back to normal?';

  @override
  String get markUnusual => 'Mark';

  @override
  String get unmarkUnusual => 'Unmark';

  @override
  String get historyTapHint => 'Tap a cycle to mark it as unusual.';

  @override
  String get unusualCyclesCount => 'Unusual cycles';

  @override
  String get bbtLearningTitle => 'Learning from basal temperature';

  @override
  String get lutealPersonal => 'Personal luteal phase';

  @override
  String get lutealDefault => 'Luteal phase (default)';

  @override
  String get lutealLearnedHint =>
      'Learned from cycles where ovulation was confirmed by temperature.';

  @override
  String get lutealNeedMore =>
      'Log your temperature each morning before getting up for a few cycles and the app will learn your own luteal phase.';

  @override
  String get bbtThisCycle => 'Ovulation by temperature';

  @override
  String get bbtNoShift => 'No temperature shift yet';

  @override
  String get bbtRefinedNote => 'Next period prediction refined by temperature';

  @override
  String get bbtTip =>
      'To confirm ovulation, log your temperature every morning before getting out of bed.';

  @override
  String get logHeroTitle => 'How are you today?';

  @override
  String get logHeroSubtitle => 'Take a few minutes for yourself';

  @override
  String get logSectionGeneral => 'General';

  @override
  String get logSectionPhysical => 'Body';

  @override
  String get logSectionNote => 'Daily note';
}
