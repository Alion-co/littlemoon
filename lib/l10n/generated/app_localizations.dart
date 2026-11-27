import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('tr'),
  ];

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get homeGreeting;

  /// No description provided for @dayOfCycle.
  ///
  /// In en, this message translates to:
  /// **'Day {day}'**
  String dayOfCycle(int day);

  /// No description provided for @ofYourCycle.
  ///
  /// In en, this message translates to:
  /// **'of your cycle'**
  String get ofYourCycle;

  /// No description provided for @follicularPhase.
  ///
  /// In en, this message translates to:
  /// **'Follicular Phase'**
  String get follicularPhase;

  /// No description provided for @lutealPhase.
  ///
  /// In en, this message translates to:
  /// **'Luteal Phase'**
  String get lutealPhase;

  /// No description provided for @menstrualPhase.
  ///
  /// In en, this message translates to:
  /// **'Menstrual Phase'**
  String get menstrualPhase;

  /// No description provided for @ovulationPhase.
  ///
  /// In en, this message translates to:
  /// **'Ovulation Phase'**
  String get ovulationPhase;

  /// No description provided for @daysUntilPeriod.
  ///
  /// In en, this message translates to:
  /// **'{days} days until next period'**
  String daysUntilPeriod(int days);

  /// No description provided for @cycleHealthy.
  ///
  /// In en, this message translates to:
  /// **'Your cycle is currently within your usual range.'**
  String get cycleHealthy;

  /// No description provided for @dailyCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Daily check-in'**
  String get dailyCheckIn;

  /// No description provided for @howAreYouFeeling.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling today?'**
  String get howAreYouFeeling;

  /// No description provided for @flow.
  ///
  /// In en, this message translates to:
  /// **'Flow'**
  String get flow;

  /// No description provided for @mood.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get mood;

  /// No description provided for @pain.
  ///
  /// In en, this message translates to:
  /// **'Pain'**
  String get pain;

  /// No description provided for @energy.
  ///
  /// In en, this message translates to:
  /// **'Energy'**
  String get energy;

  /// No description provided for @sleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get sleep;

  /// No description provided for @symptoms.
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get symptoms;

  /// No description provided for @todaysSummary.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Summary'**
  String get todaysSummary;

  /// No description provided for @logToday.
  ///
  /// In en, this message translates to:
  /// **'Log\ntoday'**
  String get logToday;

  /// No description provided for @good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @mild.
  ///
  /// In en, this message translates to:
  /// **'Mild'**
  String get mild;

  /// No description provided for @yourCycleInsights.
  ///
  /// In en, this message translates to:
  /// **'Your cycle insights'**
  String get yourCycleInsights;

  /// No description provided for @averageCycle.
  ///
  /// In en, this message translates to:
  /// **'Average cycle'**
  String get averageCycle;

  /// No description provided for @recentPattern.
  ///
  /// In en, this message translates to:
  /// **'Recent pattern'**
  String get recentPattern;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @insights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insights;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Toggle label for monthly calendar view
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// Toggle label for weekly calendar view
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// Legend/status label for a period day
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get period;

  /// Legend label for the fertile window
  ///
  /// In en, this message translates to:
  /// **'Fertile'**
  String get fertile;

  /// Legend label for ovulation day
  ///
  /// In en, this message translates to:
  /// **'Ovulation'**
  String get ovulation;

  /// Status text shown when the selected day is a period day
  ///
  /// In en, this message translates to:
  /// **'Period day'**
  String get periodDay;

  /// Status text shown when the selected day is in the fertile window
  ///
  /// In en, this message translates to:
  /// **'Fertile window'**
  String get fertileWindow;

  /// Status text shown when the selected day is the ovulation day
  ///
  /// In en, this message translates to:
  /// **'Ovulation day'**
  String get ovulationDay;

  /// Status text shown when there is no data for the selected day
  ///
  /// In en, this message translates to:
  /// **'No data logged'**
  String get noDataLogged;

  /// Short button label to log data for a day
  ///
  /// In en, this message translates to:
  /// **'Log'**
  String get logButton;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get ok;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @notEnoughData.
  ///
  /// In en, this message translates to:
  /// **'Not enough data'**
  String get notEnoughData;

  /// No description provided for @invalidValue.
  ///
  /// In en, this message translates to:
  /// **'That value does not look right.'**
  String get invalidValue;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodNight.
  ///
  /// In en, this message translates to:
  /// **'Good night'**
  String get goodNight;

  /// No description provided for @periodDayNumber.
  ///
  /// In en, this message translates to:
  /// **'Day {day} of your period'**
  String periodDayNumber(int day);

  /// No description provided for @periodLateBy.
  ///
  /// In en, this message translates to:
  /// **'Period is {days} days late'**
  String periodLateBy(int days);

  /// No description provided for @periodLateOneDay.
  ///
  /// In en, this message translates to:
  /// **'Period is 1 day late'**
  String get periodLateOneDay;

  /// No description provided for @periodExpectedToday.
  ///
  /// In en, this message translates to:
  /// **'Your period is expected today'**
  String get periodExpectedToday;

  /// No description provided for @periodExpectedTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Your period is expected tomorrow'**
  String get periodExpectedTomorrow;

  /// No description provided for @cycleLateNote.
  ///
  /// In en, this message translates to:
  /// **'Your period is more than a week late. If this continues, consider a pregnancy test or talking to a doctor.'**
  String get cycleLateNote;

  /// No description provided for @cycleIrregularNote.
  ///
  /// In en, this message translates to:
  /// **'Your recent cycles vary in length, so predictions are less precise.'**
  String get cycleIrregularNote;

  /// No description provided for @periodStartedToday.
  ///
  /// In en, this message translates to:
  /// **'My period started today'**
  String get periodStartedToday;

  /// No description provided for @periodContinuesToday.
  ///
  /// In en, this message translates to:
  /// **'I still have my period today'**
  String get periodContinuesToday;

  /// No description provided for @periodLoggedToday.
  ///
  /// In en, this message translates to:
  /// **'Period logged for today'**
  String get periodLoggedToday;

  /// No description provided for @noCycleDataTitle.
  ///
  /// In en, this message translates to:
  /// **'No period logged yet'**
  String get noCycleDataTitle;

  /// No description provided for @noCycleDataBody.
  ///
  /// In en, this message translates to:
  /// **'Log the first day of your last period so Little Moon can start predicting your cycle.'**
  String get noCycleDataBody;

  /// No description provided for @logLastPeriod.
  ///
  /// In en, this message translates to:
  /// **'Log my last period'**
  String get logLastPeriod;

  /// No description provided for @predictionInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'How is this calculated?'**
  String get predictionInfoTitle;

  /// No description provided for @predictionInfoBody.
  ///
  /// In en, this message translates to:
  /// **'Your next period is estimated from the average length of your recent logged cycles. Ovulation is estimated about 14 days before the next period, and the fertile window runs from 5 days before ovulation to 1 day after.\n\nThe more periods you log, the more accurate this gets. These are estimates — do not use them as contraception.'**
  String get predictionInfoBody;

  /// No description provided for @reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders;

  /// No description provided for @noReminders.
  ///
  /// In en, this message translates to:
  /// **'Nothing to remind you of today.'**
  String get noReminders;

  /// No description provided for @reminderPeriodSoon.
  ///
  /// In en, this message translates to:
  /// **'Your period is expected in {days} days.'**
  String reminderPeriodSoon(int days);

  /// No description provided for @reminderPeriodTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Your period is expected tomorrow.'**
  String get reminderPeriodTomorrow;

  /// No description provided for @reminderPeriodToday.
  ///
  /// In en, this message translates to:
  /// **'Your period is expected today.'**
  String get reminderPeriodToday;

  /// No description provided for @reminderFertileSoon.
  ///
  /// In en, this message translates to:
  /// **'Your fertile window starts tomorrow.'**
  String get reminderFertileSoon;

  /// No description provided for @reminderFertileToday.
  ///
  /// In en, this message translates to:
  /// **'You are in your fertile window.'**
  String get reminderFertileToday;

  /// No description provided for @reminderOvulationToday.
  ///
  /// In en, this message translates to:
  /// **'Today is your estimated ovulation day.'**
  String get reminderOvulationToday;

  /// No description provided for @reminderLogToday.
  ///
  /// In en, this message translates to:
  /// **'You have not logged anything today.'**
  String get reminderLogToday;

  /// No description provided for @remindersHint.
  ///
  /// In en, this message translates to:
  /// **'You get a phone notification at 9:00 for cycle reminders and at 21:00 for the daily log. They also appear on the home screen bell.'**
  String get remindersHint;

  /// No description provided for @reminderPeriodSetting.
  ///
  /// In en, this message translates to:
  /// **'Upcoming period'**
  String get reminderPeriodSetting;

  /// No description provided for @reminderDaysBefore.
  ///
  /// In en, this message translates to:
  /// **'Remind me before'**
  String get reminderDaysBefore;

  /// No description provided for @reminderFertileSetting.
  ///
  /// In en, this message translates to:
  /// **'Fertile window'**
  String get reminderFertileSetting;

  /// No description provided for @reminderOvulationSetting.
  ///
  /// In en, this message translates to:
  /// **'Ovulation day'**
  String get reminderOvulationSetting;

  /// No description provided for @reminderLogSetting.
  ///
  /// In en, this message translates to:
  /// **'Daily log'**
  String get reminderLogSetting;

  /// No description provided for @futureDayNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'You can only log today or past days.'**
  String get futureDayNotAllowed;

  /// No description provided for @flowNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get flowNone;

  /// No description provided for @flowSpotting.
  ///
  /// In en, this message translates to:
  /// **'Spotting'**
  String get flowSpotting;

  /// No description provided for @flowLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get flowLight;

  /// No description provided for @flowMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get flowMedium;

  /// No description provided for @flowHeavy.
  ///
  /// In en, this message translates to:
  /// **'Heavy'**
  String get flowHeavy;

  /// No description provided for @moodHappy.
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get moodHappy;

  /// No description provided for @moodCalm.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get moodCalm;

  /// No description provided for @moodSensitive.
  ///
  /// In en, this message translates to:
  /// **'Sensitive'**
  String get moodSensitive;

  /// No description provided for @moodSad.
  ///
  /// In en, this message translates to:
  /// **'Sad'**
  String get moodSad;

  /// No description provided for @moodIrritable.
  ///
  /// In en, this message translates to:
  /// **'Irritable'**
  String get moodIrritable;

  /// No description provided for @moodAnxious.
  ///
  /// In en, this message translates to:
  /// **'Anxious'**
  String get moodAnxious;

  /// No description provided for @painNone.
  ///
  /// In en, this message translates to:
  /// **'No pain'**
  String get painNone;

  /// No description provided for @painSevere.
  ///
  /// In en, this message translates to:
  /// **'Severe'**
  String get painSevere;

  /// No description provided for @energyLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get energyLow;

  /// No description provided for @energyHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get energyHigh;

  /// No description provided for @symptomCramps.
  ///
  /// In en, this message translates to:
  /// **'Cramps'**
  String get symptomCramps;

  /// No description provided for @symptomHeadache.
  ///
  /// In en, this message translates to:
  /// **'Headache'**
  String get symptomHeadache;

  /// No description provided for @symptomBackPain.
  ///
  /// In en, this message translates to:
  /// **'Back pain'**
  String get symptomBackPain;

  /// No description provided for @symptomBloating.
  ///
  /// In en, this message translates to:
  /// **'Bloating'**
  String get symptomBloating;

  /// No description provided for @symptomBreastTenderness.
  ///
  /// In en, this message translates to:
  /// **'Breast tenderness'**
  String get symptomBreastTenderness;

  /// No description provided for @symptomAcne.
  ///
  /// In en, this message translates to:
  /// **'Acne'**
  String get symptomAcne;

  /// No description provided for @symptomNausea.
  ///
  /// In en, this message translates to:
  /// **'Nausea'**
  String get symptomNausea;

  /// No description provided for @symptomFatigue.
  ///
  /// In en, this message translates to:
  /// **'Fatigue'**
  String get symptomFatigue;

  /// No description provided for @symptomCravings.
  ///
  /// In en, this message translates to:
  /// **'Cravings'**
  String get symptomCravings;

  /// No description provided for @symptomInsomnia.
  ///
  /// In en, this message translates to:
  /// **'Insomnia'**
  String get symptomInsomnia;

  /// No description provided for @symptomDizziness.
  ///
  /// In en, this message translates to:
  /// **'Dizziness'**
  String get symptomDizziness;

  /// No description provided for @symptomDischarge.
  ///
  /// In en, this message translates to:
  /// **'Discharge'**
  String get symptomDischarge;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'Anything you want to remember about today…'**
  String get noteHint;

  /// No description provided for @sleepHours.
  ///
  /// In en, this message translates to:
  /// **'{hours}h'**
  String sleepHours(int hours);

  /// No description provided for @sleepHoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String sleepHoursMinutes(int hours, int minutes);

  /// No description provided for @predicted.
  ///
  /// In en, this message translates to:
  /// **'Predicted'**
  String get predicted;

  /// No description provided for @predictedPeriodDay.
  ///
  /// In en, this message translates to:
  /// **'Predicted period'**
  String get predictedPeriodDay;

  /// No description provided for @cycleDayShort.
  ///
  /// In en, this message translates to:
  /// **'Cycle day {day}'**
  String cycleDayShort(int day);

  /// No description provided for @dataLogged.
  ///
  /// In en, this message translates to:
  /// **'Logged'**
  String get dataLogged;

  /// No description provided for @insightsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Once you log your first period, your cycle statistics and predictions will show up here.'**
  String get insightsEmpty;

  /// No description provided for @averagePeriod.
  ///
  /// In en, this message translates to:
  /// **'Average period'**
  String get averagePeriod;

  /// No description provided for @regularity.
  ///
  /// In en, this message translates to:
  /// **'Regularity'**
  String get regularity;

  /// No description provided for @regular.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get regular;

  /// No description provided for @irregular.
  ///
  /// In en, this message translates to:
  /// **'Irregular'**
  String get irregular;

  /// No description provided for @cyclesTracked.
  ///
  /// In en, this message translates to:
  /// **'Cycles tracked'**
  String get cyclesTracked;

  /// No description provided for @predictions.
  ///
  /// In en, this message translates to:
  /// **'Predictions'**
  String get predictions;

  /// No description provided for @nextPeriod.
  ///
  /// In en, this message translates to:
  /// **'Next period'**
  String get nextPeriod;

  /// No description provided for @followingPeriod.
  ///
  /// In en, this message translates to:
  /// **'Following period'**
  String get followingPeriod;

  /// No description provided for @cycleHistory.
  ///
  /// In en, this message translates to:
  /// **'Cycle history'**
  String get cycleHistory;

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cycle lengths will appear here after you log at least two periods.'**
  String get historyEmpty;

  /// No description provided for @topSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Most frequent symptoms'**
  String get topSymptoms;

  /// No description provided for @last90Days.
  ///
  /// In en, this message translates to:
  /// **'Last 90 days'**
  String get last90Days;

  /// No description provided for @noSymptomsLogged.
  ///
  /// In en, this message translates to:
  /// **'No symptoms logged yet.'**
  String get noSymptomsLogged;

  /// No description provided for @moodSummary.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get moodSummary;

  /// No description provided for @noMoodLogged.
  ///
  /// In en, this message translates to:
  /// **'No mood logged yet.'**
  String get noMoodLogged;

  /// No description provided for @medicalDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Predictions are estimates based on what you log. They are not medical advice and should not be used as contraception.'**
  String get medicalDisclaimer;

  /// No description provided for @yourBody.
  ///
  /// In en, this message translates to:
  /// **'Your body'**
  String get yourBody;

  /// No description provided for @tipsForYou.
  ///
  /// In en, this message translates to:
  /// **'Tips for this phase'**
  String get tipsForYou;

  /// No description provided for @todayTracking.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayTracking;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @glassesOfGoal.
  ///
  /// In en, this message translates to:
  /// **'{count} of {goal} glasses'**
  String glassesOfGoal(int count, int goal);

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @weightHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 58.5'**
  String get weightHint;

  /// No description provided for @kg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get kg;

  /// No description provided for @bodyTemperature.
  ///
  /// In en, this message translates to:
  /// **'Body temperature'**
  String get bodyTemperature;

  /// No description provided for @temperatureHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 36.6'**
  String get temperatureHint;

  /// No description provided for @tapToAdd.
  ///
  /// In en, this message translates to:
  /// **'Tap to add'**
  String get tapToAdd;

  /// No description provided for @averageSleep7.
  ///
  /// In en, this message translates to:
  /// **'Average sleep (7 days)'**
  String get averageSleep7;

  /// No description provided for @pregnancyChanceToday.
  ///
  /// In en, this message translates to:
  /// **'Chance of pregnancy today'**
  String get pregnancyChanceToday;

  /// No description provided for @chanceLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get chanceLow;

  /// No description provided for @chanceMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get chanceMedium;

  /// No description provided for @chanceHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get chanceHigh;

  /// No description provided for @aboutMenstrual.
  ///
  /// In en, this message translates to:
  /// **'Your period marks the start of a new cycle. The lining of the uterus is shed, and it is normal to feel lower on energy for a few days.'**
  String get aboutMenstrual;

  /// No description provided for @aboutFollicular.
  ///
  /// In en, this message translates to:
  /// **'After your period, estrogen rises and your body prepares to release an egg. Most people feel more energetic and focused in this phase.'**
  String get aboutFollicular;

  /// No description provided for @aboutOvulation.
  ///
  /// In en, this message translates to:
  /// **'An egg is released around now. This is the most fertile part of your cycle.'**
  String get aboutOvulation;

  /// No description provided for @aboutLuteal.
  ///
  /// In en, this message translates to:
  /// **'After ovulation, progesterone rises. In the days before your period you may notice PMS symptoms such as bloating, tender breasts or mood changes.'**
  String get aboutLuteal;

  /// No description provided for @aboutNoData.
  ///
  /// In en, this message translates to:
  /// **'Log your period to see which phase of your cycle you are in and get tips that fit it.'**
  String get aboutNoData;

  /// No description provided for @tipMenstrual1.
  ///
  /// In en, this message translates to:
  /// **'Rest when you need to. Gentle movement such as walking or stretching can ease cramps.'**
  String get tipMenstrual1;

  /// No description provided for @tipMenstrual2.
  ///
  /// In en, this message translates to:
  /// **'A warm compress on your lower belly may help with pain.'**
  String get tipMenstrual2;

  /// No description provided for @tipMenstrual3.
  ///
  /// In en, this message translates to:
  /// **'Iron-rich foods like lentils, spinach and red meat, plus enough water, help you recover.'**
  String get tipMenstrual3;

  /// No description provided for @tipFollicular1.
  ///
  /// In en, this message translates to:
  /// **'Energy usually rises in this phase, so it is a good time for more intense exercise.'**
  String get tipFollicular1;

  /// No description provided for @tipFollicular2.
  ///
  /// In en, this message translates to:
  /// **'A good time to start new plans or tasks that need focus.'**
  String get tipFollicular2;

  /// No description provided for @tipFollicular3.
  ///
  /// In en, this message translates to:
  /// **'Keep your meals balanced with protein and fresh vegetables.'**
  String get tipFollicular3;

  /// No description provided for @tipOvulation1.
  ///
  /// In en, this message translates to:
  /// **'This is the most fertile time of your cycle.'**
  String get tipOvulation1;

  /// No description provided for @tipOvulation2.
  ///
  /// In en, this message translates to:
  /// **'Mild one-sided lower belly pain or clearer discharge is usually normal around ovulation.'**
  String get tipOvulation2;

  /// No description provided for @tipOvulation3.
  ///
  /// In en, this message translates to:
  /// **'Energy and mood are often at their best, so enjoy being active.'**
  String get tipOvulation3;

  /// No description provided for @tipLuteal1.
  ///
  /// In en, this message translates to:
  /// **'PMS symptoms such as bloating or mood changes may show up. Go easy on yourself.'**
  String get tipLuteal1;

  /// No description provided for @tipLuteal2.
  ///
  /// In en, this message translates to:
  /// **'Cutting back on salt, caffeine and sugar can ease bloating and irritability.'**
  String get tipLuteal2;

  /// No description provided for @tipLuteal3.
  ///
  /// In en, this message translates to:
  /// **'Prioritise sleep and lighter exercise such as yoga or walking.'**
  String get tipLuteal3;

  /// No description provided for @tipGeneral1.
  ///
  /// In en, this message translates to:
  /// **'Log your period regularly. Predictions get more accurate after a few cycles.'**
  String get tipGeneral1;

  /// No description provided for @tipGeneral2.
  ///
  /// In en, this message translates to:
  /// **'Drink enough water and keep a steady sleep schedule.'**
  String get tipGeneral2;

  /// No description provided for @tipGeneral3.
  ///
  /// In en, this message translates to:
  /// **'See a doctor if your cycles are often shorter than 21 or longer than 35 days, or if the pain is severe.'**
  String get tipGeneral3;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get yourName;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'What should we call you?'**
  String get nameHint;

  /// No description provided for @noName.
  ///
  /// In en, this message translates to:
  /// **'Dear friend'**
  String get noName;

  /// No description provided for @trackingSince.
  ///
  /// In en, this message translates to:
  /// **'Tracking since {date}'**
  String trackingSince(String date);

  /// No description provided for @daysLogged.
  ///
  /// In en, this message translates to:
  /// **'Days logged'**
  String get daysLogged;

  /// No description provided for @periodsLogged.
  ///
  /// In en, this message translates to:
  /// **'Periods logged'**
  String get periodsLogged;

  /// No description provided for @cycleSettings.
  ///
  /// In en, this message translates to:
  /// **'Cycle settings'**
  String get cycleSettings;

  /// No description provided for @cycleSettingsHint.
  ///
  /// In en, this message translates to:
  /// **'Used for predictions until you have logged a few cycles.'**
  String get cycleSettingsHint;

  /// No description provided for @cycleLength.
  ///
  /// In en, this message translates to:
  /// **'Cycle length'**
  String get cycleLength;

  /// No description provided for @cycleLengthHint.
  ///
  /// In en, this message translates to:
  /// **'From the first day of one period to the first day of the next. Usually 21 to 35 days.'**
  String get cycleLengthHint;

  /// No description provided for @periodLength.
  ///
  /// In en, this message translates to:
  /// **'Period length'**
  String get periodLength;

  /// No description provided for @periodLengthHint.
  ///
  /// In en, this message translates to:
  /// **'How many days your bleeding usually lasts. Usually 3 to 7 days.'**
  String get periodLengthHint;

  /// No description provided for @lutealLength.
  ///
  /// In en, this message translates to:
  /// **'Luteal phase length'**
  String get lutealLength;

  /// No description provided for @lutealLengthHint.
  ///
  /// In en, this message translates to:
  /// **'Days between ovulation and your next period. Leave it at 14 unless you know yours.'**
  String get lutealLengthHint;

  /// No description provided for @privacyNote.
  ///
  /// In en, this message translates to:
  /// **'Everything stays on this device. Little Moon works fully offline and never sends your data anywhere.'**
  String get privacyNote;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @calendarType.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendarType;

  /// No description provided for @calendarJalali.
  ///
  /// In en, this message translates to:
  /// **'Solar Hijri (Shamsi)'**
  String get calendarJalali;

  /// No description provided for @calendarGregorian.
  ///
  /// In en, this message translates to:
  /// **'Gregorian'**
  String get calendarGregorian;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeMoon.
  ///
  /// In en, this message translates to:
  /// **'Moon'**
  String get themeMoon;

  /// No description provided for @themeSakura.
  ///
  /// In en, this message translates to:
  /// **'Sakura'**
  String get themeSakura;

  /// No description provided for @themeLavender.
  ///
  /// In en, this message translates to:
  /// **'Lavender'**
  String get themeLavender;

  /// No description provided for @themeOcean.
  ///
  /// In en, this message translates to:
  /// **'Ocean'**
  String get themeOcean;

  /// No description provided for @themeMint.
  ///
  /// In en, this message translates to:
  /// **'Mint'**
  String get themeMint;

  /// No description provided for @themeSunset.
  ///
  /// In en, this message translates to:
  /// **'Sunset'**
  String get themeSunset;

  /// No description provided for @themeMidnight.
  ///
  /// In en, this message translates to:
  /// **'Midnight'**
  String get themeMidnight;

  /// No description provided for @themeNightRose.
  ///
  /// In en, this message translates to:
  /// **'Night rose'**
  String get themeNightRose;

  /// No description provided for @dataAndBackup.
  ///
  /// In en, this message translates to:
  /// **'Data and backup'**
  String get dataAndBackup;

  /// No description provided for @backupHint.
  ///
  /// In en, this message translates to:
  /// **'Your backup is plain text that you can keep anywhere you like.'**
  String get backupHint;

  /// No description provided for @copyBackup.
  ///
  /// In en, this message translates to:
  /// **'Copy backup to clipboard'**
  String get copyBackup;

  /// No description provided for @backupCopied.
  ///
  /// In en, this message translates to:
  /// **'Backup copied. Paste it somewhere safe.'**
  String get backupCopied;

  /// No description provided for @restoreBackup.
  ///
  /// In en, this message translates to:
  /// **'Restore from backup'**
  String get restoreBackup;

  /// No description provided for @restoreHint.
  ///
  /// In en, this message translates to:
  /// **'Paste your backup text here'**
  String get restoreHint;

  /// No description provided for @restoreInvalid.
  ///
  /// In en, this message translates to:
  /// **'This is not a valid Little Moon backup.'**
  String get restoreInvalid;

  /// No description provided for @restoreConfirm.
  ///
  /// In en, this message translates to:
  /// **'This replaces everything currently in the app with the backup. Continue?'**
  String get restoreConfirm;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// No description provided for @restoreDone.
  ///
  /// In en, this message translates to:
  /// **'Backup restored.'**
  String get restoreDone;

  /// No description provided for @deleteAllData.
  ///
  /// In en, this message translates to:
  /// **'Delete all data'**
  String get deleteAllData;

  /// No description provided for @deleteAllConfirm.
  ///
  /// In en, this message translates to:
  /// **'All your logs, profile and settings will be permanently deleted. This cannot be undone.'**
  String get deleteAllConfirm;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Little Moon helps you track your period and know what is coming next. A few quick questions to get started.'**
  String get onboardingWelcomeBody;

  /// No description provided for @onboardingHello.
  ///
  /// In en, this message translates to:
  /// **'Hello!'**
  String get onboardingHello;

  /// No description provided for @onboardingWelcomeLine.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Little Moon'**
  String get onboardingWelcomeLine;

  /// No description provided for @onboardingTagline.
  ///
  /// In en, this message translates to:
  /// **'Your everyday companion for managing your cycle and feeling better'**
  String get onboardingTagline;

  /// No description provided for @lastPeriodQuestion.
  ///
  /// In en, this message translates to:
  /// **'When did your last period start?'**
  String get lastPeriodQuestion;

  /// No description provided for @lastPeriodHint.
  ///
  /// In en, this message translates to:
  /// **'Pick the first day of bleeding. You can change it later.'**
  String get lastPeriodHint;

  /// No description provided for @dontRemember.
  ///
  /// In en, this message translates to:
  /// **'I do not remember'**
  String get dontRemember;

  /// No description provided for @periodLengthQuestion.
  ///
  /// In en, this message translates to:
  /// **'How long does your period usually last?'**
  String get periodLengthQuestion;

  /// No description provided for @cycleLengthQuestion.
  ///
  /// In en, this message translates to:
  /// **'How long is your cycle usually?'**
  String get cycleLengthQuestion;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted;

  /// No description provided for @insightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Cycle insights'**
  String get insightsTitle;

  /// No description provided for @dedication.
  ///
  /// In en, this message translates to:
  /// **'Dedicated to my little moon'**
  String get dedication;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @chooseAvatar.
  ///
  /// In en, this message translates to:
  /// **'Choose your avatar'**
  String get chooseAvatar;

  /// No description provided for @aboutDeveloper.
  ///
  /// In en, this message translates to:
  /// **'About Little Moon'**
  String get aboutDeveloper;

  /// No description provided for @aboutAppBody.
  ///
  /// In en, this message translates to:
  /// **'Little Moon is a private, free and offline platform for girls and women to track their periods. It predicts your monthly cycle from the information you log yourself and shows it to you. All your data is stored only on your own phone.'**
  String get aboutAppBody;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String appVersion(String version);

  /// No description provided for @developer.
  ///
  /// In en, this message translates to:
  /// **'Made by'**
  String get developer;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @telegram.
  ///
  /// In en, this message translates to:
  /// **'Telegram'**
  String get telegram;

  /// No description provided for @instagram.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get instagram;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @madeWithLove.
  ///
  /// In en, this message translates to:
  /// **'Made by ALION'**
  String get madeWithLove;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Little Moon'**
  String get appTitle;

  /// No description provided for @dateRange.
  ///
  /// In en, this message translates to:
  /// **'{start} – {end}'**
  String dateRange(String start, String end);

  /// No description provided for @privacySection.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacySection;

  /// No description provided for @appLock.
  ///
  /// In en, this message translates to:
  /// **'App lock'**
  String get appLock;

  /// No description provided for @appLockHint.
  ///
  /// In en, this message translates to:
  /// **'Protect the app with a PIN or your fingerprint.'**
  String get appLockHint;

  /// No description provided for @appLockOn.
  ///
  /// In en, this message translates to:
  /// **'App lock is on.'**
  String get appLockOn;

  /// No description provided for @useBiometric.
  ///
  /// In en, this message translates to:
  /// **'Unlock with fingerprint'**
  String get useBiometric;

  /// No description provided for @changePin.
  ///
  /// In en, this message translates to:
  /// **'Change PIN'**
  String get changePin;

  /// No description provided for @pinChanged.
  ///
  /// In en, this message translates to:
  /// **'PIN changed.'**
  String get pinChanged;

  /// No description provided for @enterPin.
  ///
  /// In en, this message translates to:
  /// **'Enter your PIN'**
  String get enterPin;

  /// No description provided for @newPin.
  ///
  /// In en, this message translates to:
  /// **'Choose a 4-digit PIN'**
  String get newPin;

  /// No description provided for @confirmPin.
  ///
  /// In en, this message translates to:
  /// **'Enter the PIN again'**
  String get confirmPin;

  /// No description provided for @pinMismatch.
  ///
  /// In en, this message translates to:
  /// **'The PINs didn\'t match. Try again.'**
  String get pinMismatch;

  /// No description provided for @wrongPin.
  ///
  /// In en, this message translates to:
  /// **'Wrong PIN'**
  String get wrongPin;

  /// No description provided for @tooManyAttempts.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Wait {seconds} seconds.'**
  String tooManyAttempts(int seconds);

  /// No description provided for @unlockReason.
  ///
  /// In en, this message translates to:
  /// **'Unlock Little Moon'**
  String get unlockReason;

  /// No description provided for @forgotPin.
  ///
  /// In en, this message translates to:
  /// **'I forgot my PIN'**
  String get forgotPin;

  /// No description provided for @forgotPinBody.
  ///
  /// In en, this message translates to:
  /// **'The PIN can\'t be recovered because no data ever leaves your phone. You can erase all data and start over; if you saved a backup, you can restore it afterwards.'**
  String get forgotPinBody;

  /// No description provided for @resetApp.
  ///
  /// In en, this message translates to:
  /// **'Erase and start over'**
  String get resetApp;

  /// No description provided for @discreetNotifications.
  ///
  /// In en, this message translates to:
  /// **'Discreet notifications'**
  String get discreetNotifications;

  /// No description provided for @discreetNotificationsHint.
  ///
  /// In en, this message translates to:
  /// **'Reminders and the widget use neutral text that says nothing about your cycle, and are hidden on the lock screen.'**
  String get discreetNotificationsHint;

  /// No description provided for @discreetTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get discreetTitle;

  /// No description provided for @discreetCycleBody.
  ///
  /// In en, this message translates to:
  /// **'You have a new reminder.'**
  String get discreetCycleBody;

  /// No description provided for @discreetLogBody.
  ///
  /// In en, this message translates to:
  /// **'Your note for today is waiting.'**
  String get discreetLogBody;

  /// No description provided for @discreetPillBody.
  ///
  /// In en, this message translates to:
  /// **'It\'s time for your daily reminder.'**
  String get discreetPillBody;

  /// No description provided for @pillReminder.
  ///
  /// In en, this message translates to:
  /// **'Pill reminder'**
  String get pillReminder;

  /// No description provided for @pillReminderTime.
  ///
  /// In en, this message translates to:
  /// **'Pill reminder time'**
  String get pillReminderTime;

  /// No description provided for @reminderPill.
  ///
  /// In en, this message translates to:
  /// **'Time to take your pill.'**
  String get reminderPill;

  /// No description provided for @widgetTitle.
  ///
  /// In en, this message translates to:
  /// **'Home screen widget'**
  String get widgetTitle;

  /// No description provided for @widgetHint.
  ///
  /// In en, this message translates to:
  /// **'Long-press an empty spot on your home screen, tap Widgets and add Little Moon. With discreet notifications on, the widget only shows the day number.'**
  String get widgetHint;

  /// No description provided for @doctorReport.
  ///
  /// In en, this message translates to:
  /// **'Report for your doctor'**
  String get doctorReport;

  /// No description provided for @doctorReportHint.
  ///
  /// In en, this message translates to:
  /// **'A PDF summary of your cycles, symptoms and mood, made right on this phone.'**
  String get doctorReportHint;

  /// No description provided for @reportTitle.
  ///
  /// In en, this message translates to:
  /// **'Menstrual cycle report'**
  String get reportTitle;

  /// No description provided for @reportGenerated.
  ///
  /// In en, this message translates to:
  /// **'Prepared on {date}'**
  String reportGenerated(String date);

  /// No description provided for @reportWindow.
  ///
  /// In en, this message translates to:
  /// **'Symptom statistics cover the last {days} days ({logged} days logged)'**
  String reportWindow(int days, int logged);

  /// No description provided for @reportSummary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get reportSummary;

  /// No description provided for @reportCycleRange.
  ///
  /// In en, this message translates to:
  /// **'Shortest and longest cycle'**
  String get reportCycleRange;

  /// No description provided for @reportMinMax.
  ///
  /// In en, this message translates to:
  /// **'{min} to {max} days'**
  String reportMinMax(int min, int max);

  /// No description provided for @reportLastPeriod.
  ///
  /// In en, this message translates to:
  /// **'Last period started'**
  String get reportLastPeriod;

  /// No description provided for @reportStart.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get reportStart;

  /// No description provided for @reportInProgress.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get reportInProgress;

  /// No description provided for @reportUnitsNote.
  ///
  /// In en, this message translates to:
  /// **'All values are in days. * means a period was probably not logged in this cycle, so it is left out of the averages.'**
  String get reportUnitsNote;

  /// No description provided for @reportTimes.
  ///
  /// In en, this message translates to:
  /// **'{count} times'**
  String reportTimes(int count);

  /// No description provided for @reportPainDays.
  ///
  /// In en, this message translates to:
  /// **'Days with moderate or severe pain'**
  String get reportPainDays;

  /// No description provided for @reportFooter.
  ///
  /// In en, this message translates to:
  /// **'Made with Little Moon, based on data logged by the user'**
  String get reportFooter;

  /// No description provided for @reportFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t create the report. Please try again.'**
  String get reportFailed;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @quickLog.
  ///
  /// In en, this message translates to:
  /// **'Quick log'**
  String get quickLog;

  /// No description provided for @quickLogHint.
  ///
  /// In en, this message translates to:
  /// **'Saved with one tap'**
  String get quickLogHint;

  /// No description provided for @detailedLog.
  ///
  /// In en, this message translates to:
  /// **'Detailed log'**
  String get detailedLog;

  /// No description provided for @saveBackupFile.
  ///
  /// In en, this message translates to:
  /// **'Save backup to a file'**
  String get saveBackupFile;

  /// No description provided for @restoreBackupFile.
  ///
  /// In en, this message translates to:
  /// **'Restore from a backup file'**
  String get restoreBackupFile;

  /// No description provided for @backupFileSaved.
  ///
  /// In en, this message translates to:
  /// **'Backup file saved.'**
  String get backupFileSaved;

  /// No description provided for @backupFileFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save the file, so the backup text was copied to the clipboard.'**
  String get backupFileFailed;

  /// No description provided for @reminderLate.
  ///
  /// In en, this message translates to:
  /// **'Your period is {days} days late. If it has started, log it to keep predictions accurate.'**
  String reminderLate(int days);

  /// No description provided for @lateReminderSetting.
  ///
  /// In en, this message translates to:
  /// **'Late period'**
  String get lateReminderSetting;

  /// No description provided for @autoNightTheme.
  ///
  /// In en, this message translates to:
  /// **'Automatic night theme'**
  String get autoNightTheme;

  /// No description provided for @autoNightThemeHint.
  ///
  /// In en, this message translates to:
  /// **'Uses a night theme when your phone is in dark mode.'**
  String get autoNightThemeHint;

  /// No description provided for @patternsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your patterns'**
  String get patternsTitle;

  /// No description provided for @patternsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Things that repeat across your cycles'**
  String get patternsSubtitle;

  /// No description provided for @patternsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No repeating patterns yet. The more cycles you log symptoms and mood for, the more patterns will show up here.'**
  String get patternsEmpty;

  /// No description provided for @patternsNote.
  ///
  /// In en, this message translates to:
  /// **'Worked out on this phone from your own logs only. Not a medical diagnosis.'**
  String get patternsNote;

  /// No description provided for @patternPain.
  ///
  /// In en, this message translates to:
  /// **'Moderate or severe pain'**
  String get patternPain;

  /// No description provided for @patternDayBefore.
  ///
  /// In en, this message translates to:
  /// **'Usually the day before your period'**
  String get patternDayBefore;

  /// No description provided for @patternDaysBefore.
  ///
  /// In en, this message translates to:
  /// **'Usually about {days} days before your period'**
  String patternDaysBefore(int days);

  /// No description provided for @patternDuring.
  ///
  /// In en, this message translates to:
  /// **'Usually on day {day} of your period'**
  String patternDuring(int day);

  /// No description provided for @patternSeen.
  ///
  /// In en, this message translates to:
  /// **'in {cycles} cycles'**
  String patternSeen(int cycles);

  /// No description provided for @charts.
  ///
  /// In en, this message translates to:
  /// **'Charts'**
  String get charts;

  /// No description provided for @chartsHint.
  ///
  /// In en, this message translates to:
  /// **'Tap or drag across a chart to see each day\'s value.'**
  String get chartsHint;

  /// No description provided for @chartNotEnoughData.
  ///
  /// In en, this message translates to:
  /// **'This chart needs at least two entries.'**
  String get chartNotEnoughData;

  /// No description provided for @chartCycleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Last 12 cycles; the dashed line is the average'**
  String get chartCycleSubtitle;

  /// No description provided for @chartLastDays.
  ///
  /// In en, this message translates to:
  /// **'Last {days} days'**
  String chartLastDays(int days);

  /// No description provided for @chartSleepSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Hours of sleep over the last {days} days'**
  String chartSleepSubtitle(int days);

  /// No description provided for @aboutTagline.
  ///
  /// In en, this message translates to:
  /// **'Your gentle cycle companion'**
  String get aboutTagline;

  /// No description provided for @aboutMeta.
  ///
  /// In en, this message translates to:
  /// **'Free & open source · Fully offline'**
  String get aboutMeta;

  /// No description provided for @rateOnMyket.
  ///
  /// In en, this message translates to:
  /// **'Rate on Myket'**
  String get rateOnMyket;

  /// No description provided for @rateOnBazaar.
  ///
  /// In en, this message translates to:
  /// **'Rate on Bazaar'**
  String get rateOnBazaar;

  /// No description provided for @developerRole.
  ///
  /// In en, this message translates to:
  /// **'Maker of this app'**
  String get developerRole;

  /// No description provided for @contactCall.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get contactCall;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance & language'**
  String get settingsAppearance;

  /// No description provided for @remindersOnCount.
  ///
  /// In en, this message translates to:
  /// **'{count} reminders on'**
  String remindersOnCount(int count);

  /// No description provided for @appLockStatusOn.
  ///
  /// In en, this message translates to:
  /// **'App lock on'**
  String get appLockStatusOn;

  /// No description provided for @appLockStatusOff.
  ///
  /// In en, this message translates to:
  /// **'App lock off'**
  String get appLockStatusOff;

  /// No description provided for @settingsDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Backup, restore and delete data'**
  String get settingsDataSubtitle;

  /// No description provided for @cycleRemindersGroup.
  ///
  /// In en, this message translates to:
  /// **'Cycle'**
  String get cycleRemindersGroup;

  /// No description provided for @dailyRemindersGroup.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get dailyRemindersGroup;

  /// No description provided for @notificationsCaption.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsCaption;

  /// No description provided for @backupFileCaption.
  ///
  /// In en, this message translates to:
  /// **'Backup file'**
  String get backupFileCaption;

  /// No description provided for @backupTextCaption.
  ///
  /// In en, this message translates to:
  /// **'Transfer as text'**
  String get backupTextCaption;

  /// No description provided for @dataLocalNote.
  ///
  /// In en, this message translates to:
  /// **'All your data and files are only available on your device and are never sent to any server.'**
  String get dataLocalNote;

  /// No description provided for @widgetDayLabel.
  ///
  /// In en, this message translates to:
  /// **'cycle day'**
  String get widgetDayLabel;

  /// No description provided for @widgetSizeWide.
  ///
  /// In en, this message translates to:
  /// **'Slim · 5×1'**
  String get widgetSizeWide;

  /// No description provided for @widgetSizeSquare.
  ///
  /// In en, this message translates to:
  /// **'Small · 2×2'**
  String get widgetSizeSquare;

  /// No description provided for @widgetSizeMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium · 3×2'**
  String get widgetSizeMedium;

  /// No description provided for @addWidget.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addWidget;

  /// No description provided for @widgetPinFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t add the widget. Add it from your home screen\'s widgets.'**
  String get widgetPinFailed;

  /// No description provided for @careMenstrual.
  ///
  /// In en, this message translates to:
  /// **'Rest a little; your body is doing big work 🌙|A warm herbal tea can help today ☕|Be extra gentle with yourself today 💗|Drink enough water and sleep a bit more 💧|A warm compress can ease cramps 🌸'**
  String get careMenstrual;

  /// No description provided for @careFollicular.
  ///
  /// In en, this message translates to:
  /// **'Your energy is coming back; time for fresh starts ✨|A great day to move and exercise 🏃‍♀️|Write your ideas down; your mind is sharp 📝|Like the moon, you grow fuller every day 🌒'**
  String get careFollicular;

  /// No description provided for @careOvulation.
  ///
  /// In en, this message translates to:
  /// **'You\'re shining brighter than ever today ✨|Celebrate your confidence 💫|A lovely time to see your friends 🌸|Your energy is at its peak; enjoy it ☀️'**
  String get careOvulation;

  /// No description provided for @careLuteal.
  ///
  /// In en, this message translates to:
  /// **'Feeling a bit low is completely normal 🌙|Go easy on salt and caffeine; your body will thank you 🍵|A gentle walk can lift your mood 🍃|Enough sleep is the best gift to yourself 😴'**
  String get careLuteal;

  /// No description provided for @careDiscreet.
  ///
  /// In en, this message translates to:
  /// **'Be kind to yourself today 💗|Have a glass of water 💧|Take a deep breath 🍃|You are wonderful ✨'**
  String get careDiscreet;

  /// No description provided for @widgetChooseHint.
  ///
  /// In en, this message translates to:
  /// **'Pick one and add it to your home screen.'**
  String get widgetChooseHint;

  /// No description provided for @addWidgetToHome.
  ///
  /// In en, this message translates to:
  /// **'Add the {name} widget'**
  String addWidgetToHome(String name);

  /// No description provided for @widgetPinNotShown.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t see the add-widget window?'**
  String get widgetPinNotShown;

  /// No description provided for @widgetHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get widgetHelp;

  /// No description provided for @widgetHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Widget not added?'**
  String get widgetHelpTitle;

  /// No description provided for @widgetHelpBody.
  ///
  /// In en, this message translates to:
  /// **'Some phones, such as Xiaomi and Poco, only add widgets after you allow it:\n\n1. Long-press the Little Moon icon and tap App info.\n2. Open Other permissions.\n3. Set Home screen shortcuts to Allow.\n4. Come back and tap the add button again.\n\nAlternatively, long-press an empty spot on your home screen, tap Widgets and find Little Moon.'**
  String get widgetHelpBody;

  /// No description provided for @widgetSizeLarge.
  ///
  /// In en, this message translates to:
  /// **'Large · 5×4'**
  String get widgetSizeLarge;

  /// 150 general self-care sentences separated by |. Shown on the home screen widgets, one per day.
  ///
  /// In en, this message translates to:
  /// **'Every day is a new chance to be kinder to yourself.|Listen to your body; it speaks to you every day.|You don\'t have to be strong every day; being honest with yourself is enough.|Rest is part of your growth journey, too.|You are worthy in every phase of your cycle.|Treat yourself today the way you would treat your best friend.|You don\'t have to figure everything out today.|Your body deserves care, not criticism.|Give yourself permission to slow down.|You don\'t have to shine every day; your presence is enough.|One deep breath, one peaceful moment, one fresh start.|Your feelings aren\'t your enemy; listen to them with kindness.|You are more than what you accomplish today.|Every small step you take for yourself matters.|Work with your body instead of fighting it.|You don\'t have to be the perfect version of yourself today.|You are allowed to feel hopeful and tired at the same time.|Every cycle is a chance to understand yourself a little better.|Self-kindness is a powerful habit.|Be proud of your progress, even when it\'s slow.|If you need rest today, listen to yourself.|A calm, nourishing meal is also an act of self-love.|Drink some water and give yourself a few moments.|A little gentle stretching can be an invitation to relax.|Enough sleep is a gift you give your future self.|You don\'t need a big reason to give yourself a moment of calm.|A warm shower can be a moment just for you.|If your body moves more slowly today, be gentle with it.|Setting boundaries is a form of self-care, too.|Give yourself permission to ask for help.|Do one small thing today that brings you peace.|Your body has real needs; honor them.|Self-care doesn\'t have to be complicated or expensive.|Ask yourself today: What do I really need?|A few screen-free minutes are a gift to your mind.|Make a promise to judge yourself a little less today.|When you\'re tired, you don\'t need to justify resting.|Focus on being real rather than perfect.|You deserve love and respect today, too.|Appreciate your body for all it does for you.|You don\'t have to change every feeling immediately.|Leave a little space for yourself today.|You can be strong and still need support.|Your body isn\'t a project to fix; it\'s a companion to cherish.|You don\'t have to fight your body to deserve love.|Every month is a new chance to understand yourself, not judge yourself.|Your body doesn\'t have to look like anyone else\'s.|Your worth isn\'t measured by numbers on a calendar or scale.|Get curious about your body instead of blaming it.|Every day doesn\'t have to look like yesterday.|Your body deserves your patience.|Changes in your energy are part of being human; meet yourself where you are.|You don\'t have to maximize every single day.|You are allowed to adapt your plans to your needs.|Trust yourself; you know your own experience best.|Every feeling you have deserves attention.|You don\'t have to apologize for needing rest.|Your body isn\'t the enemy of your plans; it has information for you.|Self-awareness begins with noticing the little things.|Follow your own path instead of comparing yourself.|You don\'t have to feel the same every day.|Your body deserves respect, even on hard days.|Speak to yourself more gently; your inner words matter.|You don\'t need to have all the answers today.|Give yourself time to grow, change, and begin again.|You deserve the peace you create for others.|Sometimes the best thing to do is less.|Each time you listen to a need, you grow closer to yourself.|Your body works with you; show it gratitude.|You don\'t have to minimize your pain or tiredness.|Self-care means taking your own needs seriously.|You can begin again, even with one small step.|Taking a break doesn\'t mean you\'ve failed.|Let your body have its own rhythm.|Your peace is part of your success, too.|A healthy boundary can protect your energy today.|You don\'t have to be available to everyone all the time.|A quiet moment can be self-care, too.|Support yourself today instead of pushing yourself harder.|You can be proud of yourself even if no one notices.|A day doesn\'t have to be productive to be valuable.|Instead of punishing yourself, ask what might help you.|Your body deserves the attention you give your tasks.|Instead of asking why you\'re not your usual self, ask what you need now.|One hard day is not your whole story.|Give yourself room to feel without judgment.|You don\'t have to prove your struggle to deserve support.|Remind yourself: having needs is part of being human.|Moving more slowly is still moving forward.|You can be committed to your goals and still prioritize rest.|Thank your body for being with you through every day.|You don\'t have to act on every feeling; sometimes noticing it is enough.|Listening to yourself helps you make more mindful choices.|Offer yourself support instead of blame.|You can reset your day; you don\'t have to stick rigidly to the plan.|Every cycle has its own story; observe it with curiosity.|Track your changes to better understand your own patterns.|Your cycle doesn\'t have to be like anyone else\'s.|The better you know yourself, the more fitting your care can be.|Your body isn\'t a one-size-fits-all calendar; learn your own patterns.|If your cycle pattern changes, notice it with curiosity rather than blame.|Cycle tracking is for understanding yourself, not limiting yourself.|Your body may have different needs throughout the month.|Observing without judgment is the beginning of better care.|Pay attention to your body\'s signals rather than relying on certainty.|Every month is a chance to learn something new about yourself.|Remember that everyone\'s cycle experience can be different.|Note your body\'s signals; understanding them can bring peace of mind.|Your cycle is part of your experience, not your entire identity.|Every day is a chance to begin again.|Everything doesn\'t have to be perfect for you to have a good day.|You are stronger than your hardest days make you feel.|Trust your path, even when the next step isn\'t clear.|Every time you keep going, you learn something about yourself.|Be proud of yourself for how far you\'ve come.|You don\'t have to move at anyone else\'s pace.|Hope can be quiet and gentle, too.|Remind yourself that small beginnings matter, too.|You can change your plan and still stay true to your goal.|Every day is a new chance to choose kindness.|You deserve the same support you give to others.|When the path gets hard, be on your own team.|Not every change has to happen all at once.|Small steps can help you build a kinder life for yourself.|Every day doesn\'t need a grand beginning; sometimes one breath is enough.|Give yourself time to find hope again today.|You can be learning and progressing at the same time.|Focus on the next step instead of rushing.|You don\'t have to prove anything to be worthy.|Sometimes progress means realizing what no longer works for you.|Allow yourself to redefine what success means to you.|Every mindful step brings you closer to yourself.|Today, accompany yourself instead of competing with yesterday\'s you.|You can pause, breathe, and choose again.|You can be kind to yourself even on uncertain days.|Begin today with one kind intention for yourself.|You deserve a peaceful and kind relationship with yourself.|Each time you respect yourself, your boundaries become clearer.|You can make time for yourself without guilt.|Remind yourself: I\'m learning, not falling behind.|Today, you can make one small choice in favor of your peace.|You don\'t have to control everything to feel safe.|Every day is a chance to practice patience with yourself.|Remember that your needs matter.|You can be kind and still stand firm.|Today, you may need more support rather than more effort.|Every day is a chance to choose yourself without dismissing others.|You deserve care that stays with you on hard days, too.|Get to know your body with curiosity, not fear.|If you have a concerning symptom or severe pain, seeking professional help is an act of care.'**
  String get careGeneral;

  /// The general self-care sentences that never mention the cycle, for discreet mode. Separated by |.
  ///
  /// In en, this message translates to:
  /// **'Every day is a new chance to be kinder to yourself.|Listen to your body; it speaks to you every day.|You don\'t have to be strong every day; being honest with yourself is enough.|Rest is part of your growth journey, too.|Treat yourself today the way you would treat your best friend.|You don\'t have to figure everything out today.|Your body deserves care, not criticism.|Give yourself permission to slow down.|You don\'t have to shine every day; your presence is enough.|One deep breath, one peaceful moment, one fresh start.|Your feelings aren\'t your enemy; listen to them with kindness.|You are more than what you accomplish today.|Every small step you take for yourself matters.|Work with your body instead of fighting it.|You don\'t have to be the perfect version of yourself today.|You are allowed to feel hopeful and tired at the same time.|Be proud of your progress, even when it\'s slow.|If you need rest today, listen to yourself.|A calm, nourishing meal is also an act of self-love.|Drink some water and give yourself a few moments.|A little gentle stretching can be an invitation to relax.|Enough sleep is a gift you give your future self.|You don\'t need a big reason to give yourself a moment of calm.|A warm shower can be a moment just for you.|If your body moves more slowly today, be gentle with it.|Setting boundaries is a form of self-care, too.|Give yourself permission to ask for help.|Do one small thing today that brings you peace.|Your body has real needs; honor them.|Self-care doesn\'t have to be complicated or expensive.|Ask yourself today: What do I really need?|A few screen-free minutes are a gift to your mind.|Make a promise to judge yourself a little less today.|When you\'re tired, you don\'t need to justify resting.|Focus on being real rather than perfect.|You deserve love and respect today, too.|Appreciate your body for all it does for you.|You don\'t have to change every feeling immediately.|Leave a little space for yourself today.|You can be strong and still need support.|You don\'t have to fight your body to deserve love.|Every month is a new chance to understand yourself, not judge yourself.|Your body doesn\'t have to look like anyone else\'s.|Your worth isn\'t measured by numbers on a calendar or scale.|Get curious about your body instead of blaming it.|Every day doesn\'t have to look like yesterday.|Your body deserves your patience.|Changes in your energy are part of being human; meet yourself where you are.|You don\'t have to maximize every single day.|You are allowed to adapt your plans to your needs.|Trust yourself; you know your own experience best.|Every feeling you have deserves attention.|You don\'t have to apologize for needing rest.|Your body isn\'t the enemy of your plans; it has information for you.|Self-awareness begins with noticing the little things.|Follow your own path instead of comparing yourself.|You don\'t have to feel the same every day.|Your body deserves respect, even on hard days.|Speak to yourself more gently; your inner words matter.|You don\'t need to have all the answers today.|Give yourself time to grow, change, and begin again.|You deserve the peace you create for others.|Sometimes the best thing to do is less.|Each time you listen to a need, you grow closer to yourself.|Your body works with you; show it gratitude.|You don\'t have to minimize your pain or tiredness.|Self-care means taking your own needs seriously.|You can begin again, even with one small step.|Taking a break doesn\'t mean you\'ve failed.|Let your body have its own rhythm.|Your peace is part of your success, too.|A healthy boundary can protect your energy today.|You don\'t have to be available to everyone all the time.|A quiet moment can be self-care, too.|Support yourself today instead of pushing yourself harder.|You can be proud of yourself even if no one notices.|A day doesn\'t have to be productive to be valuable.|Instead of punishing yourself, ask what might help you.|Your body deserves the attention you give your tasks.|One hard day is not your whole story.|Give yourself room to feel without judgment.|You don\'t have to prove your struggle to deserve support.|Remind yourself: having needs is part of being human.|Moving more slowly is still moving forward.|You can be committed to your goals and still prioritize rest.|Thank your body for being with you through every day.|You don\'t have to act on every feeling; sometimes noticing it is enough.|Listening to yourself helps you make more mindful choices.|Offer yourself support instead of blame.|You can reset your day; you don\'t have to stick rigidly to the plan.|Track your changes to better understand your own patterns.|The better you know yourself, the more fitting your care can be.|Your body isn\'t a one-size-fits-all calendar; learn your own patterns.|Your body may have different needs throughout the month.|Observing without judgment is the beginning of better care.|Pay attention to your body\'s signals rather than relying on certainty.|Every month is a chance to learn something new about yourself.|Note your body\'s signals; understanding them can bring peace of mind.|Every day is a chance to begin again.|Everything doesn\'t have to be perfect for you to have a good day.|You are stronger than your hardest days make you feel.|Trust your path, even when the next step isn\'t clear.|Every time you keep going, you learn something about yourself.|Be proud of yourself for how far you\'ve come.|You don\'t have to move at anyone else\'s pace.|Hope can be quiet and gentle, too.|Remind yourself that small beginnings matter, too.|You can change your plan and still stay true to your goal.|Every day is a new chance to choose kindness.|You deserve the same support you give to others.|When the path gets hard, be on your own team.|Not every change has to happen all at once.|Small steps can help you build a kinder life for yourself.|Every day doesn\'t need a grand beginning; sometimes one breath is enough.|Give yourself time to find hope again today.|You can be learning and progressing at the same time.|Focus on the next step instead of rushing.|You don\'t have to prove anything to be worthy.|Sometimes progress means realizing what no longer works for you.|Allow yourself to redefine what success means to you.|Every mindful step brings you closer to yourself.|Today, accompany yourself instead of competing with yesterday\'s you.|You can pause, breathe, and choose again.|You can be kind to yourself even on uncertain days.|Begin today with one kind intention for yourself.|You deserve a peaceful and kind relationship with yourself.|Each time you respect yourself, your boundaries become clearer.|You can make time for yourself without guilt.|Remind yourself: I\'m learning, not falling behind.|Today, you can make one small choice in favor of your peace.|You don\'t have to control everything to feel safe.|Every day is a chance to practice patience with yourself.|Remember that your needs matter.|You can be kind and still stand firm.|Today, you may need more support rather than more effort.|Every day is a chance to choose yourself without dismissing others.|You deserve care that stays with you on hard days, too.|Get to know your body with curiosity, not fear.|If you have a concerning symptom or severe pain, seeking professional help is an act of care.'**
  String get careGeneralDiscreet;

  /// No description provided for @cycleLateWithinRangeNote.
  ///
  /// In en, this message translates to:
  /// **'Your period is a little late, but that is still within the normal variation of your cycles.'**
  String get cycleLateWithinRangeNote;

  /// No description provided for @cycleLateMildNote.
  ///
  /// In en, this message translates to:
  /// **'Your period is later than your usual range. Stress, travel, illness or poor sleep can shift a cycle. If it keeps being late, consider a pregnancy test or talking to a doctor.'**
  String get cycleLateMildNote;

  /// No description provided for @cycleShortNote.
  ///
  /// In en, this message translates to:
  /// **'Your cycles are usually shorter than 21 days. If this is new for you, it is worth mentioning to a doctor.'**
  String get cycleShortNote;

  /// No description provided for @cycleLongNote.
  ///
  /// In en, this message translates to:
  /// **'Your cycles are usually longer than 35 days. If this is new for you, it is worth mentioning to a doctor.'**
  String get cycleLongNote;

  /// No description provided for @cycleMissedLogNote.
  ///
  /// In en, this message translates to:
  /// **'One of your cycles looks unusually long, so you may have missed logging a period. Adding it will make predictions more accurate.'**
  String get cycleMissedLogNote;

  /// No description provided for @predictionConfidenceLow.
  ///
  /// In en, this message translates to:
  /// **'Prediction confidence: low. Log a few more cycles to improve it.'**
  String get predictionConfidenceLow;

  /// No description provided for @predictionConfidenceMedium.
  ///
  /// In en, this message translates to:
  /// **'Prediction confidence: medium.'**
  String get predictionConfidenceMedium;

  /// No description provided for @predictionConfidenceHigh.
  ///
  /// In en, this message translates to:
  /// **'Prediction confidence: high. Your recent cycles are very consistent.'**
  String get predictionConfidenceHigh;

  /// No description provided for @reminderPatternSoon.
  ///
  /// In en, this message translates to:
  /// **'Heads-up: around this time in your cycle you often notice: {what}. Be kind to yourself.'**
  String reminderPatternSoon(String what);

  /// No description provided for @hapticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Haptic feedback'**
  String get hapticsTitle;

  /// No description provided for @hapticsHint.
  ///
  /// In en, this message translates to:
  /// **'Gentle vibrations when you tap, save or log something'**
  String get hapticsHint;

  /// No description provided for @dailyTipsTitle.
  ///
  /// In en, this message translates to:
  /// **'Tips for today'**
  String get dailyTipsTitle;

  /// No description provided for @tipCategoryNutrition.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get tipCategoryNutrition;

  /// No description provided for @tipCategoryMovement.
  ///
  /// In en, this message translates to:
  /// **'Movement'**
  String get tipCategoryMovement;

  /// No description provided for @tipCategoryRest.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get tipCategoryRest;

  /// No description provided for @tipsTapHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a tip to see another one.'**
  String get tipsTapHint;

  /// No description provided for @tipNutritionMenstrual.
  ///
  /// In en, this message translates to:
  /// **'Iron-rich foods like lentils, spinach or beans can help replace what you lose 🥬|Warm soups and herbal teas can feel soothing today 🍵|Keep a water bottle close; staying hydrated can ease bloating 💧'**
  String get tipNutritionMenstrual;

  /// No description provided for @tipMovementMenstrual.
  ///
  /// In en, this message translates to:
  /// **'Gentle stretching or a slow walk is plenty today 🚶‍♀️|Light yoga can ease tension in your back and hips 🧘‍♀️|Listen to your body: it is okay to skip an intense workout 💗'**
  String get tipMovementMenstrual;

  /// No description provided for @tipRestMenstrual.
  ///
  /// In en, this message translates to:
  /// **'Try an earlier bedtime tonight; your body is working hard 😴|A warm compress on your lower belly can be comforting 🌸|Give yourself permission to slow down today 🌙'**
  String get tipRestMenstrual;

  /// No description provided for @tipNutritionFollicular.
  ///
  /// In en, this message translates to:
  /// **'Fresh vegetables, fruit and whole grains suit your rising energy 🥗|Add some protein to your meals to feel full and steady 🍳|Try a new healthy recipe; you may have energy to cook 🍲'**
  String get tipNutritionFollicular;

  /// No description provided for @tipMovementFollicular.
  ///
  /// In en, this message translates to:
  /// **'Your energy is climbing: a good time for cardio or strength training 🏃‍♀️|Try something new, like a class, a hike or a dance 💃|Warm up well, then you can gradually push a little harder 💪'**
  String get tipMovementFollicular;

  /// No description provided for @tipRestFollicular.
  ///
  /// In en, this message translates to:
  /// **'Keep a steady sleep schedule to hold on to your energy ⏰|A short walk outside in daylight can lift your mood ☀️|Plan your week now while your mind feels sharp 📝'**
  String get tipRestFollicular;

  /// No description provided for @tipNutritionOvulation.
  ///
  /// In en, this message translates to:
  /// **'Colorful fruits and vegetables are a lovely way to eat today 🍓|Drink plenty of water; you might feel warmer than usual 💧|Fiber-rich foods like oats and beans keep digestion comfortable 🥣'**
  String get tipNutritionOvulation;

  /// No description provided for @tipMovementOvulation.
  ///
  /// In en, this message translates to:
  /// **'Energy is often at its peak: enjoy a workout you love ⚡|A good day for group activities or a fun outdoor walk 🌿|Warm up and stretch well to protect your joints 🧘‍♀️'**
  String get tipMovementOvulation;

  /// No description provided for @tipRestOvulation.
  ///
  /// In en, this message translates to:
  /// **'Plan time with people you enjoy; you may feel more social 💬|Even on high-energy days, wind down before bed 🌙|Take a few quiet minutes to recharge between activities 🍃'**
  String get tipRestOvulation;

  /// No description provided for @tipNutritionLuteal.
  ///
  /// In en, this message translates to:
  /// **'Complex carbs like oats and sweet potato can steady your mood 🍠|Go easy on salt and caffeine if you feel bloated or tense 🍵|Nuts, seeds and a little dark chocolate can be a satisfying snack 🍫'**
  String get tipNutritionLuteal;

  /// No description provided for @tipMovementLuteal.
  ///
  /// In en, this message translates to:
  /// **'A gentle walk, yoga or swimming can lift your mood 🏊‍♀️|Lower the intensity if you feel tired; moving gently still counts 🍃|Stretching before bed can ease tension 🧘‍♀️'**
  String get tipMovementLuteal;

  /// No description provided for @tipRestLuteal.
  ///
  /// In en, this message translates to:
  /// **'Early nights help; your body may need more sleep now 😴|Be kind to yourself if your mood dips; it is common before a period 💗|Try a few slow breaths or a warm shower to unwind 🛁'**
  String get tipRestLuteal;

  /// No description provided for @unusualCycle.
  ///
  /// In en, this message translates to:
  /// **'Unusual cycle'**
  String get unusualCycle;

  /// No description provided for @unusualCycleHint.
  ///
  /// In en, this message translates to:
  /// **'If illness, travel, stress or medication threw this cycle off, mark it so it\'s left out of your averages and predictions.'**
  String get unusualCycleHint;

  /// No description provided for @unusualCycleUndoHint.
  ///
  /// In en, this message translates to:
  /// **'This cycle is marked unusual and isn\'t used for predictions. Switch it back to normal?'**
  String get unusualCycleUndoHint;

  /// No description provided for @markUnusual.
  ///
  /// In en, this message translates to:
  /// **'Mark'**
  String get markUnusual;

  /// No description provided for @unmarkUnusual.
  ///
  /// In en, this message translates to:
  /// **'Unmark'**
  String get unmarkUnusual;

  /// No description provided for @historyTapHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a cycle to mark it as unusual.'**
  String get historyTapHint;

  /// No description provided for @unusualCyclesCount.
  ///
  /// In en, this message translates to:
  /// **'Unusual cycles'**
  String get unusualCyclesCount;

  /// No description provided for @bbtLearningTitle.
  ///
  /// In en, this message translates to:
  /// **'Learning from basal temperature'**
  String get bbtLearningTitle;

  /// No description provided for @lutealPersonal.
  ///
  /// In en, this message translates to:
  /// **'Personal luteal phase'**
  String get lutealPersonal;

  /// No description provided for @lutealDefault.
  ///
  /// In en, this message translates to:
  /// **'Luteal phase (default)'**
  String get lutealDefault;

  /// No description provided for @lutealLearnedHint.
  ///
  /// In en, this message translates to:
  /// **'Learned from cycles where ovulation was confirmed by temperature.'**
  String get lutealLearnedHint;

  /// No description provided for @lutealNeedMore.
  ///
  /// In en, this message translates to:
  /// **'Log your temperature each morning before getting up for a few cycles and the app will learn your own luteal phase.'**
  String get lutealNeedMore;

  /// No description provided for @bbtThisCycle.
  ///
  /// In en, this message translates to:
  /// **'Ovulation by temperature'**
  String get bbtThisCycle;

  /// No description provided for @bbtNoShift.
  ///
  /// In en, this message translates to:
  /// **'No temperature shift yet'**
  String get bbtNoShift;

  /// No description provided for @bbtRefinedNote.
  ///
  /// In en, this message translates to:
  /// **'Next period prediction refined by temperature'**
  String get bbtRefinedNote;

  /// No description provided for @bbtTip.
  ///
  /// In en, this message translates to:
  /// **'To confirm ovulation, log your temperature every morning before getting out of bed.'**
  String get bbtTip;

  /// No description provided for @logHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'How are you today?'**
  String get logHeroTitle;

  /// No description provided for @logHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Take a few minutes for yourself'**
  String get logHeroSubtitle;

  /// No description provided for @logSectionGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get logSectionGeneral;

  /// No description provided for @logSectionPhysical.
  ///
  /// In en, this message translates to:
  /// **'Body'**
  String get logSectionPhysical;

  /// No description provided for @logSectionNote.
  ///
  /// In en, this message translates to:
  /// **'Daily note'**
  String get logSectionNote;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'es', 'fa', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fa':
      return AppLocalizationsFa();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
