// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Auto Silent';

  @override
  String get dashboard => 'Home';

  @override
  String get schedules => 'Schedules';

  @override
  String get worldClock => 'World Clock';

  @override
  String get settings => 'Settings';

  @override
  String get normalMode => 'Normal Mode';

  @override
  String get silentMode => 'Silent Mode';

  @override
  String get vibrationMode => 'Vibration Mode';

  @override
  String get noActiveMeeting => 'No meeting is active right now';

  @override
  String get privacyTitle => 'Privacy';

  @override
  String get privacyDescription =>
      'No analytics, tracking, cloud storage or network requests. Your data stays only on this device.';

  @override
  String scheduleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count schedules',
      one: '1 schedule',
      zero: 'No schedules',
    );
    return '$_temp0';
  }

  @override
  String get offlineOnly => 'Stored locally as JSON';

  @override
  String get importJson => 'Import JSON';

  @override
  String importSuccess(int count) {
    return 'Imported $count schedules';
  }

  @override
  String get noSchedules =>
      'Create your first meeting schedule or import a JSON file.';

  @override
  String get noSchedulesTitle => 'No schedules yet';

  @override
  String get addSchedule => 'Add Schedule';

  @override
  String get editSchedule => 'Edit Schedule';

  @override
  String get title => 'Schedule Title';

  @override
  String get requiredField => 'This field is required.';

  @override
  String get startTime => 'Start Time';

  @override
  String get endTime => 'End Time';

  @override
  String get time => 'Time';

  @override
  String get days => 'Repeat On';

  @override
  String get mode => 'Phone Mode';

  @override
  String get reminder => 'Reminder';

  @override
  String minutesBefore(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes minutes before',
      one: '1 minute before',
      zero: 'No reminder',
    );
    return '$_temp0';
  }

  @override
  String get enabled => 'Schedule Enabled';

  @override
  String get enabledDescription =>
      'The app will automatically apply this schedule when the selected time arrives.';

  @override
  String get save => 'Save Schedule';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get nepali => 'Nepali';

  @override
  String get hindi => 'Hindi';

  @override
  String get chinese => 'Chinese';

  @override
  String get spanish => 'Spanish';

  @override
  String get french => 'French';

  @override
  String get notifications => 'Meeting Reminders';

  @override
  String get notificationDescription =>
      'Receive a local notification before each meeting.';

  @override
  String get dndAccess => 'Do Not Disturb Access';

  @override
  String get dndExplanation =>
      'Android requires this permission to change Silent or Vibration mode automatically.';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get permissionTitle => 'Permission Required';

  @override
  String get notificationPermissionExplanation =>
      'Notifications are used only for local reminders. No data leaves your device.';

  @override
  String get dndPermissionExplanation =>
      'Android requires Do Not Disturb permission before the app can automatically change phone mode.';

  @override
  String get cancel => 'Cancel';

  @override
  String get continueLabel => 'Continue';

  @override
  String get sydney => 'Sydney';

  @override
  String get london => 'London';

  @override
  String get newYork => 'New York';

  @override
  String get tokyo => 'Tokyo';

  @override
  String get kathmandu => 'Kathmandu';

  @override
  String cityName(String key) {
    String _temp0 = intl.Intl.selectLogic(
      key,
      {
        'sydney': 'Sydney',
        'london': 'London',
        'newYork': 'New York',
        'tokyo': 'Tokyo',
        'kathmandu': 'Kathmandu',
        'other': 'Unknown',
      },
    );
    return '$_temp0';
  }

  @override
  String weekdayShort(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        'mon': 'Mon',
        'tue': 'Tue',
        'wed': 'Wed',
        'thu': 'Thu',
        'fri': 'Fri',
        'sat': 'Sat',
        'sun': 'Sun',
        'other': '?',
      },
    );
    return '$_temp0';
  }

  @override
  String get manageSchedules => 'Manage Schedules';

  @override
  String get fiveCities => 'Live Time';

  @override
  String get permissionsAndLanguage => 'Permissions and Language';

  @override
  String get nextMeeting => 'Next Meeting';

  @override
  String get options => 'Options';

  @override
  String get selectOneDay => 'Select at least one day.';

  @override
  String get delete => 'Delete';

  @override
  String get deleteScheduleTitle => 'Delete Schedule?';

  @override
  String deleteScheduleMessage(String title) {
    return 'Delete \"$title\"? This action cannot be undone.';
  }

  @override
  String get permissions => 'Permissions';

  @override
  String get platformLimitation =>
      'Automatic phone mode changes are available only on Android. Schedules and reminders continue to work on every platform.';

  @override
  String get permissionDenied => 'Permission was not granted.';

  @override
  String get loadError => 'Unable to load local schedules.';

  @override
  String get retry => 'Retry';

  @override
  String get importInvalidJson => 'The selected file is not valid JSON.';

  @override
  String get importInvalidRoot => 'The JSON root must be an object.';

  @override
  String get importMissingSchedules =>
      'The JSON must contain a schedules array.';

  @override
  String get importInvalidSchedule => 'One or more schedules are invalid.';

  @override
  String get importInvalidTitle => 'Every schedule must have a title.';

  @override
  String get importInvalidTime => 'Start and end times must be valid.';

  @override
  String get importInvalidDays => 'Weekdays must be between Monday and Sunday.';

  @override
  String get importInvalidMode => 'Mode must be Silent or Vibration.';

  @override
  String get importInvalidReminder =>
      'Reminder must be between 0 and 120 minutes.';

  @override
  String get importEmptyFile => 'The selected file is empty.';

  @override
  String get signIn => 'Sign In';

  @override
  String get signInSubtitle => 'Use your details to continue.';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get emailRequired => 'Enter your email address.';

  @override
  String get emailInvalid => 'Enter a valid email address.';

  @override
  String get passwordRequired => 'Enter your password.';

  @override
  String get passwordTooShort => 'Password must contain at least 4 characters.';

  @override
  String get showPassword => 'Show Password';

  @override
  String get hidePassword => 'Hide Password';

  @override
  String get signingIn => 'Signing In…';

  @override
  String get invalidCredentials => 'Incorrect email or password.';

  @override
  String get demoCredentials =>
      'Demo login: student@ict107.edu • Password: ict107';

  @override
  String get loginWelcome =>
      'Automatically manage silent or vibration mode around your university meetings.';

  @override
  String get loginFeatureSchedules =>
      'Create and manage weekly meeting schedules';

  @override
  String get loginFeatureClock => 'View live time';

  @override
  String get loginFeaturePrivacy =>
      'All application data remains on this device';

  @override
  String get account => 'Account';

  @override
  String get signOut => 'Sign Out';

  @override
  String get signOutConfirmation =>
      'Sign out of this device? Your schedules will remain stored locally.';

  @override
  String get appearance => 'Appearance';

  @override
  String get systemTheme => 'System';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get systemMode => 'System Default';

  @override
  String get themeDescription =>
      'Choose how the application looks on this device.';

  @override
  String get profile => 'Profile';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get goodMorning => 'Good Morning';

  @override
  String get goodAfternoon => 'Good Afternoon';

  @override
  String get goodEvening => 'Good Evening';

  @override
  String get currentStatus => 'Current Status';

  @override
  String get todaysMeetings => 'Today\'s Meetings';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get viewAll => 'View All';

  @override
  String get meetingStarted => 'Meeting Started';

  @override
  String get meetingEnded => 'Meeting Ended';

  @override
  String get startsIn => 'Starts In';

  @override
  String get noUpcomingMeetings => 'No upcoming meetings';

  @override
  String get createMeeting => 'Create Meeting';

  @override
  String get uploadJson => 'Upload JSON';

  @override
  String get chooseFile => 'Choose File';

  @override
  String get uploadSuccessful => 'Upload successful';

  @override
  String get uploadFailed => 'Upload failed';

  @override
  String get exportJson => 'Export JSON';

  @override
  String get clearData => 'Clear Data';

  @override
  String get clearDataTitle => 'Clear all local data?';

  @override
  String get clearDataMessage =>
      'This will permanently remove all saved schedules and settings from this device.';

  @override
  String get confirm => 'Confirm';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get about => 'About';

  @override
  String get aboutDescription =>
      'Auto Silent is an offline university project for managing meeting schedules, reminders, world clocks and supported phone modes.';

  @override
  String get search => 'Search';

  @override
  String get filterByDay => 'Filter by day';

  @override
  String get calendarView => 'Calendar View';

  @override
  String get listView => 'List View';

  @override
  String get allDays => 'All Days';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get normal => 'Normal';

  @override
  String get silent => 'Silent';

  @override
  String get vibration => 'Vibration';

  @override
  String get active => 'Active';

  @override
  String get inactive => 'Inactive';

  @override
  String get loading => 'Loading…';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get close => 'Close';

  @override
  String get edit => 'Edit';

  @override
  String get back => 'Back';

  @override
  String get refresh => 'Refresh';

  @override
  String get homeTooltip => 'Open home';

  @override
  String get schedulesTooltip => 'Open schedules';

  @override
  String get worldClockTooltip => 'Open world clock';

  @override
  String get settingsTooltip => 'Open settings';

  @override
  String get languageTooltip => 'Change language';

  @override
  String get notificationTooltip => 'Notification settings';

  @override
  String get menuTooltip => 'Open menu';

  @override
  String get passwordVisibilityTooltip => 'Show or hide password';

  @override
  String get scheduleSaved => 'Schedule saved successfully.';

  @override
  String get scheduleDeleted => 'Schedule deleted successfully.';

  @override
  String get settingsSaved => 'Settings saved successfully.';

  @override
  String get dataCleared => 'Local data cleared successfully.';

  @override
  String get unsupportedFeature =>
      'This feature is not supported on this platform.';

  @override
  String get androidModeSupport =>
      'Android can automatically change the device sound mode after permission is granted.';

  @override
  String get otherPlatformModeSupport =>
      'On this platform, the app displays the active meeting mode and sends supported reminders but cannot change the global device sound mode.';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get selectMode => 'Select Phone Mode';

  @override
  String get selectDays => 'Select Meeting Days';

  @override
  String get invalidSchedule =>
      'Please check the schedule information and try again.';

  @override
  String get startBeforeEnd => 'Start and end times cannot be the same.';

  @override
  String get noFileSelected => 'No file was selected.';

  @override
  String get localStorage => 'Local Storage';

  @override
  String get localStorageDescription =>
      'Schedules and settings are saved locally on this device.';

  @override
  String get version => 'Version';

  @override
  String get logoutSuccess => 'You have been signed out.';
}
