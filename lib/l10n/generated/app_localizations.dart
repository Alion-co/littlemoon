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
  /// **'This app is dedicated to my little moon'**
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
  /// **'About the developer'**
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
