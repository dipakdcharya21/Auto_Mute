import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ne.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('en'),
    Locale('hi'),
    Locale('ne')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Auto Silent'**
  String get appTitle;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get dashboard;

  /// No description provided for @schedules.
  ///
  /// In en, this message translates to:
  /// **'Schedules'**
  String get schedules;

  /// No description provided for @worldClock.
  ///
  /// In en, this message translates to:
  /// **'World Clock'**
  String get worldClock;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @normalMode.
  ///
  /// In en, this message translates to:
  /// **'Normal Mode'**
  String get normalMode;

  /// No description provided for @silentMode.
  ///
  /// In en, this message translates to:
  /// **'Silent Mode'**
  String get silentMode;

  /// No description provided for @vibrationMode.
  ///
  /// In en, this message translates to:
  /// **'Vibration Mode'**
  String get vibrationMode;

  /// No description provided for @noActiveMeeting.
  ///
  /// In en, this message translates to:
  /// **'No meeting is active right now'**
  String get noActiveMeeting;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacyTitle;

  /// No description provided for @privacyDescription.
  ///
  /// In en, this message translates to:
  /// **'No analytics, tracking, cloud storage or network requests. Your data stays only on this device.'**
  String get privacyDescription;

  /// No description provided for @scheduleCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No schedules} =1{1 schedule} other{{count} schedules}}'**
  String scheduleCount(int count);

  /// No description provided for @offlineOnly.
  ///
  /// In en, this message translates to:
  /// **'Stored locally as JSON'**
  String get offlineOnly;

  /// No description provided for @importJson.
  ///
  /// In en, this message translates to:
  /// **'Import JSON'**
  String get importJson;

  /// No description provided for @importSuccess.
  ///
  /// In en, this message translates to:
  /// **'Imported {count} schedules'**
  String importSuccess(int count);

  /// No description provided for @noSchedules.
  ///
  /// In en, this message translates to:
  /// **'Create your first meeting schedule or import a JSON file.'**
  String get noSchedules;

  /// No description provided for @noSchedulesTitle.
  ///
  /// In en, this message translates to:
  /// **'No schedules yet'**
  String get noSchedulesTitle;

  /// No description provided for @addSchedule.
  ///
  /// In en, this message translates to:
  /// **'Add Schedule'**
  String get addSchedule;

  /// No description provided for @editSchedule.
  ///
  /// In en, this message translates to:
  /// **'Edit Schedule'**
  String get editSchedule;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Schedule Title'**
  String get title;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get requiredField;

  /// No description provided for @startTime.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTime;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Repeat On'**
  String get days;

  /// No description provided for @mode.
  ///
  /// In en, this message translates to:
  /// **'Phone Mode'**
  String get mode;

  /// No description provided for @reminder.
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get reminder;

  /// No description provided for @minutesBefore.
  ///
  /// In en, this message translates to:
  /// **'{minutes, plural, =0{No reminder} =1{1 minute before} other{{minutes} minutes before}}'**
  String minutesBefore(int minutes);

  /// No description provided for @enabled.
  ///
  /// In en, this message translates to:
  /// **'Schedule Enabled'**
  String get enabled;

  /// No description provided for @enabledDescription.
  ///
  /// In en, this message translates to:
  /// **'The app will automatically apply this schedule when the selected time arrives.'**
  String get enabledDescription;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save Schedule'**
  String get save;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @nepali.
  ///
  /// In en, this message translates to:
  /// **'Nepali'**
  String get nepali;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get hindi;

  /// No description provided for @chinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get chinese;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Meeting Reminders'**
  String get notifications;

  /// No description provided for @notificationDescription.
  ///
  /// In en, this message translates to:
  /// **'Receive a local notification before each meeting.'**
  String get notificationDescription;

  /// No description provided for @dndAccess.
  ///
  /// In en, this message translates to:
  /// **'Do Not Disturb Access'**
  String get dndAccess;

  /// No description provided for @dndExplanation.
  ///
  /// In en, this message translates to:
  /// **'Android requires this permission to change Silent or Vibration mode automatically.'**
  String get dndExplanation;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @permissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Permission Required'**
  String get permissionTitle;

  /// No description provided for @notificationPermissionExplanation.
  ///
  /// In en, this message translates to:
  /// **'Notifications are used only for local reminders. No data leaves your device.'**
  String get notificationPermissionExplanation;

  /// No description provided for @dndPermissionExplanation.
  ///
  /// In en, this message translates to:
  /// **'Android requires Do Not Disturb permission before the app can automatically change phone mode.'**
  String get dndPermissionExplanation;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @sydney.
  ///
  /// In en, this message translates to:
  /// **'Sydney'**
  String get sydney;

  /// No description provided for @london.
  ///
  /// In en, this message translates to:
  /// **'London'**
  String get london;

  /// No description provided for @newYork.
  ///
  /// In en, this message translates to:
  /// **'New York'**
  String get newYork;

  /// No description provided for @tokyo.
  ///
  /// In en, this message translates to:
  /// **'Tokyo'**
  String get tokyo;

  /// No description provided for @kathmandu.
  ///
  /// In en, this message translates to:
  /// **'Kathmandu'**
  String get kathmandu;

  /// No description provided for @cityName.
  ///
  /// In en, this message translates to:
  /// **'{key, select, sydney{Sydney} london{London} newYork{New York} tokyo{Tokyo} kathmandu{Kathmandu} other{Unknown}}'**
  String cityName(String key);

  /// No description provided for @weekdayShort.
  ///
  /// In en, this message translates to:
  /// **'{day, select, mon{Mon} tue{Tue} wed{Wed} thu{Thu} fri{Fri} sat{Sat} sun{Sun} other{?}}'**
  String weekdayShort(String day);

  /// No description provided for @manageSchedules.
  ///
  /// In en, this message translates to:
  /// **'Manage Schedules'**
  String get manageSchedules;

  /// No description provided for @fiveCities.
  ///
  /// In en, this message translates to:
  /// **'Live Time'**
  String get fiveCities;

  /// No description provided for @permissionsAndLanguage.
  ///
  /// In en, this message translates to:
  /// **'Permissions and Language'**
  String get permissionsAndLanguage;

  /// No description provided for @nextMeeting.
  ///
  /// In en, this message translates to:
  /// **'Next Meeting'**
  String get nextMeeting;

  /// No description provided for @options.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get options;

  /// No description provided for @selectOneDay.
  ///
  /// In en, this message translates to:
  /// **'Select at least one day.'**
  String get selectOneDay;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteScheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Schedule?'**
  String get deleteScheduleTitle;

  /// No description provided for @deleteScheduleMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{title}\"? This action cannot be undone.'**
  String deleteScheduleMessage(String title);

  /// No description provided for @permissions.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get permissions;

  /// No description provided for @platformLimitation.
  ///
  /// In en, this message translates to:
  /// **'Automatic phone mode changes are available only on Android. Schedules and reminders continue to work on every platform.'**
  String get platformLimitation;

  /// No description provided for @permissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission was not granted.'**
  String get permissionDenied;

  /// No description provided for @loadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load local schedules.'**
  String get loadError;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @importInvalidJson.
  ///
  /// In en, this message translates to:
  /// **'The selected file is not valid JSON.'**
  String get importInvalidJson;

  /// No description provided for @importInvalidRoot.
  ///
  /// In en, this message translates to:
  /// **'The JSON root must be an object.'**
  String get importInvalidRoot;

  /// No description provided for @importMissingSchedules.
  ///
  /// In en, this message translates to:
  /// **'The JSON must contain a schedules array.'**
  String get importMissingSchedules;

  /// No description provided for @importInvalidSchedule.
  ///
  /// In en, this message translates to:
  /// **'One or more schedules are invalid.'**
  String get importInvalidSchedule;

  /// No description provided for @importInvalidTitle.
  ///
  /// In en, this message translates to:
  /// **'Every schedule must have a title.'**
  String get importInvalidTitle;

  /// No description provided for @importInvalidTime.
  ///
  /// In en, this message translates to:
  /// **'Start and end times must be valid.'**
  String get importInvalidTime;

  /// No description provided for @importInvalidDays.
  ///
  /// In en, this message translates to:
  /// **'Weekdays must be between Monday and Sunday.'**
  String get importInvalidDays;

  /// No description provided for @importInvalidMode.
  ///
  /// In en, this message translates to:
  /// **'Mode must be Silent or Vibration.'**
  String get importInvalidMode;

  /// No description provided for @importInvalidReminder.
  ///
  /// In en, this message translates to:
  /// **'Reminder must be between 0 and 120 minutes.'**
  String get importInvalidReminder;

  /// No description provided for @importEmptyFile.
  ///
  /// In en, this message translates to:
  /// **'The selected file is empty.'**
  String get importEmptyFile;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use your details to continue.'**
  String get signInSubtitle;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address.'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your password.'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 4 characters.'**
  String get passwordTooShort;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show Password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide Password'**
  String get hidePassword;

  /// No description provided for @signingIn.
  ///
  /// In en, this message translates to:
  /// **'Signing In…'**
  String get signingIn;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password.'**
  String get invalidCredentials;

  /// No description provided for @demoCredentials.
  ///
  /// In en, this message translates to:
  /// **'Demo login: student@ict107.edu • Password: ict107'**
  String get demoCredentials;

  /// No description provided for @loginWelcome.
  ///
  /// In en, this message translates to:
  /// **'Automatically manage silent or vibration mode around your university meetings.'**
  String get loginWelcome;

  /// No description provided for @loginFeatureSchedules.
  ///
  /// In en, this message translates to:
  /// **'Create and manage weekly meeting schedules'**
  String get loginFeatureSchedules;

  /// No description provided for @loginFeatureClock.
  ///
  /// In en, this message translates to:
  /// **'View live time'**
  String get loginFeatureClock;

  /// No description provided for @loginFeaturePrivacy.
  ///
  /// In en, this message translates to:
  /// **'All application data remains on this device'**
  String get loginFeaturePrivacy;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @signOutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Sign out of this device? Your schedules will remain stored locally.'**
  String get signOutConfirmation;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @systemTheme.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemTheme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkTheme;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @systemMode.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemMode;

  /// No description provided for @themeDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose how the application looks on this device.'**
  String get themeDescription;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get goodEvening;

  /// No description provided for @currentStatus.
  ///
  /// In en, this message translates to:
  /// **'Current Status'**
  String get currentStatus;

  /// No description provided for @todaysMeetings.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Meetings'**
  String get todaysMeetings;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @meetingStarted.
  ///
  /// In en, this message translates to:
  /// **'Meeting Started'**
  String get meetingStarted;

  /// No description provided for @meetingEnded.
  ///
  /// In en, this message translates to:
  /// **'Meeting Ended'**
  String get meetingEnded;

  /// No description provided for @startsIn.
  ///
  /// In en, this message translates to:
  /// **'Starts In'**
  String get startsIn;

  /// No description provided for @noUpcomingMeetings.
  ///
  /// In en, this message translates to:
  /// **'No upcoming meetings'**
  String get noUpcomingMeetings;

  /// No description provided for @createMeeting.
  ///
  /// In en, this message translates to:
  /// **'Create Meeting'**
  String get createMeeting;

  /// No description provided for @uploadJson.
  ///
  /// In en, this message translates to:
  /// **'Upload JSON'**
  String get uploadJson;

  /// No description provided for @chooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose File'**
  String get chooseFile;

  /// No description provided for @uploadSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Upload successful'**
  String get uploadSuccessful;

  /// No description provided for @uploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Upload failed'**
  String get uploadFailed;

  /// No description provided for @exportJson.
  ///
  /// In en, this message translates to:
  /// **'Export JSON'**
  String get exportJson;

  /// No description provided for @clearData.
  ///
  /// In en, this message translates to:
  /// **'Clear Data'**
  String get clearData;

  /// No description provided for @clearDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear all local data?'**
  String get clearDataTitle;

  /// No description provided for @clearDataMessage.
  ///
  /// In en, this message translates to:
  /// **'This will permanently remove all saved schedules and settings from this device.'**
  String get clearDataMessage;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'ICT107 Auto Silent is an offline university project for managing meeting schedules, reminders, world clocks and supported phone modes.'**
  String get aboutDescription;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @filterByDay.
  ///
  /// In en, this message translates to:
  /// **'Filter by day'**
  String get filterByDay;

  /// No description provided for @calendarView.
  ///
  /// In en, this message translates to:
  /// **'Calendar View'**
  String get calendarView;

  /// No description provided for @listView.
  ///
  /// In en, this message translates to:
  /// **'List View'**
  String get listView;

  /// No description provided for @allDays.
  ///
  /// In en, this message translates to:
  /// **'All Days'**
  String get allDays;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// No description provided for @silent.
  ///
  /// In en, this message translates to:
  /// **'Silent'**
  String get silent;

  /// No description provided for @vibration.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get vibration;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @homeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open home'**
  String get homeTooltip;

  /// No description provided for @schedulesTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open schedules'**
  String get schedulesTooltip;

  /// No description provided for @worldClockTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open world clock'**
  String get worldClockTooltip;

  /// No description provided for @settingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get settingsTooltip;

  /// No description provided for @languageTooltip.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get languageTooltip;

  /// No description provided for @notificationTooltip.
  ///
  /// In en, this message translates to:
  /// **'Notification settings'**
  String get notificationTooltip;

  /// No description provided for @menuTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open menu'**
  String get menuTooltip;

  /// No description provided for @passwordVisibilityTooltip.
  ///
  /// In en, this message translates to:
  /// **'Show or hide password'**
  String get passwordVisibilityTooltip;

  /// No description provided for @scheduleSaved.
  ///
  /// In en, this message translates to:
  /// **'Schedule saved successfully.'**
  String get scheduleSaved;

  /// No description provided for @scheduleDeleted.
  ///
  /// In en, this message translates to:
  /// **'Schedule deleted successfully.'**
  String get scheduleDeleted;

  /// No description provided for @settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved successfully.'**
  String get settingsSaved;

  /// No description provided for @dataCleared.
  ///
  /// In en, this message translates to:
  /// **'Local data cleared successfully.'**
  String get dataCleared;

  /// No description provided for @unsupportedFeature.
  ///
  /// In en, this message translates to:
  /// **'This feature is not supported on this platform.'**
  String get unsupportedFeature;

  /// No description provided for @androidModeSupport.
  ///
  /// In en, this message translates to:
  /// **'Android can automatically change the device sound mode after permission is granted.'**
  String get androidModeSupport;

  /// No description provided for @otherPlatformModeSupport.
  ///
  /// In en, this message translates to:
  /// **'On this platform, the app displays the active meeting mode and sends supported reminders but cannot change the global device sound mode.'**
  String get otherPlatformModeSupport;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @selectMode.
  ///
  /// In en, this message translates to:
  /// **'Select Phone Mode'**
  String get selectMode;

  /// No description provided for @selectDays.
  ///
  /// In en, this message translates to:
  /// **'Select Meeting Days'**
  String get selectDays;

  /// No description provided for @invalidSchedule.
  ///
  /// In en, this message translates to:
  /// **'Please check the schedule information and try again.'**
  String get invalidSchedule;

  /// No description provided for @startBeforeEnd.
  ///
  /// In en, this message translates to:
  /// **'Start and end times cannot be the same.'**
  String get startBeforeEnd;

  /// No description provided for @noFileSelected.
  ///
  /// In en, this message translates to:
  /// **'No file was selected.'**
  String get noFileSelected;

  /// No description provided for @localStorage.
  ///
  /// In en, this message translates to:
  /// **'Local Storage'**
  String get localStorage;

  /// No description provided for @localStorageDescription.
  ///
  /// In en, this message translates to:
  /// **'Schedules and settings are saved locally on this device.'**
  String get localStorageDescription;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @logoutSuccess.
  ///
  /// In en, this message translates to:
  /// **'You have been signed out.'**
  String get logoutSuccess;
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
      <String>['en', 'hi', 'ne'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'ne':
      return AppLocalizationsNe();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
