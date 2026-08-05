// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'ICT107 ऑटो साइलेंट';

  @override
  String get dashboard => 'होम';

  @override
  String get schedules => 'शेड्यूल';

  @override
  String get worldClock => 'विश्व घड़ी';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get normalMode => 'सामान्य मोड';

  @override
  String get silentMode => 'साइलेंट मोड';

  @override
  String get vibrationMode => 'वाइब्रेशन मोड';

  @override
  String get noActiveMeeting => 'अभी कोई मीटिंग सक्रिय नहीं है';

  @override
  String get privacyTitle => 'गोपनीयता';

  @override
  String get privacyDescription =>
      'कोई एनालिटिक्स, ट्रैकिंग, क्लाउड स्टोरेज या नेटवर्क अनुरोध नहीं है। आपका डेटा इसी डिवाइस पर रहता है।';

  @override
  String scheduleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count शेड्यूल',
      one: '1 शेड्यूल',
      zero: 'कोई शेड्यूल नहीं',
    );
    return '$_temp0';
  }

  @override
  String get offlineOnly => 'स्थानीय रूप से JSON में संग्रहीत';

  @override
  String get importJson => 'JSON आयात करें';

  @override
  String importSuccess(int count) {
    return '$count शेड्यूल आयात किए गए';
  }

  @override
  String get noSchedules =>
      'अपना पहला मीटिंग शेड्यूल बनाएँ या JSON फ़ाइल आयात करें।';

  @override
  String get noSchedulesTitle => 'अभी कोई शेड्यूल नहीं';

  @override
  String get addSchedule => 'शेड्यूल जोड़ें';

  @override
  String get editSchedule => 'शेड्यूल संपादित करें';

  @override
  String get title => 'शेड्यूल शीर्षक';

  @override
  String get requiredField => 'यह फ़ील्ड आवश्यक है';

  @override
  String get startTime => 'प्रारंभ समय';

  @override
  String get endTime => 'समाप्ति समय';

  @override
  String get time => 'समय';

  @override
  String get days => 'इन दिनों दोहराएँ';

  @override
  String get mode => 'फ़ोन मोड';

  @override
  String get reminder => 'रिमाइंडर';

  @override
  String minutesBefore(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes मिनट पहले',
      one: '1 मिनट पहले',
      zero: 'कोई रिमाइंडर नहीं',
    );
    return '$_temp0';
  }

  @override
  String get enabled => 'शेड्यूल सक्रिय';

  @override
  String get enabledDescription => 'समय आने पर ऐप यह शेड्यूल लागू करेगा।';

  @override
  String get save => 'शेड्यूल सहेजें';

  @override
  String get language => 'भाषा';

  @override
  String get english => 'अंग्रेज़ी';

  @override
  String get nepali => 'नेपाली';

  @override
  String get hindi => 'हिन्दी';

  @override
  String get chinese => 'चीनी';

  @override
  String get spanish => 'स्पेनिश';

  @override
  String get french => 'फ़्रेंच';

  @override
  String get notifications => 'मीटिंग रिमाइंडर';

  @override
  String get notificationDescription =>
      'मीटिंग शुरू होने से पहले स्थानीय सूचना दिखाएँ।';

  @override
  String get dndAccess => 'डू नॉट डिस्टर्ब एक्सेस';

  @override
  String get dndExplanation =>
      'साइलेंट या वाइब्रेशन मोड स्वतः बदलने के लिए Android को यह अनुमति चाहिए।';

  @override
  String get openSettings => 'सेटिंग्स खोलें';

  @override
  String get permissionTitle => 'अनुमति आवश्यक';

  @override
  String get notificationPermissionExplanation =>
      'सूचना अनुमति केवल स्थानीय मीटिंग रिमाइंडर के लिए उपयोग होती है। कोई जानकारी डिवाइस से बाहर नहीं जाती।';

  @override
  String get dndPermissionExplanation =>
      'फ़ोन मोड बदलने से पहले Android को विशेष डू नॉट डिस्टर्ब अनुमति चाहिए।';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get continueLabel => 'जारी रखें';

  @override
  String get sydney => 'सिडनी';

  @override
  String get london => 'लंदन';

  @override
  String get newYork => 'न्यूयॉर्क';

  @override
  String get tokyo => 'टोक्यो';

  @override
  String get kathmandu => 'काठमांडू';

  @override
  String cityName(String key) {
    String _temp0 = intl.Intl.selectLogic(
      key,
      {
        'sydney': 'सिडनी',
        'london': 'लंदन',
        'newYork': 'न्यूयॉर्क',
        'tokyo': 'टोक्यो',
        'kathmandu': 'काठमांडू',
        'other': 'अज्ञात',
      },
    );
    return '$_temp0';
  }

  @override
  String weekdayShort(String day) {
    String _temp0 = intl.Intl.selectLogic(
      day,
      {
        'mon': 'सोम',
        'tue': 'मंगल',
        'wed': 'बुध',
        'thu': 'गुरु',
        'fri': 'शुक्र',
        'sat': 'शनि',
        'sun': 'रवि',
        'other': '?',
      },
    );
    return '$_temp0';
  }

  @override
  String get manageSchedules => 'शेड्यूल प्रबंधित करें';

  @override
  String get fiveCities => 'पाँच शहरों का लाइव समय';

  @override
  String get permissionsAndLanguage => 'अनुमतियाँ और भाषा';

  @override
  String get nextMeeting => 'अगली मीटिंग';

  @override
  String get options => 'विकल्प';

  @override
  String get selectOneDay => 'कम से कम एक दिन चुनें।';

  @override
  String get delete => 'हटाएँ';

  @override
  String get deleteScheduleTitle => 'शेड्यूल हटाएँ?';

  @override
  String deleteScheduleMessage(String title) {
    return '“$title” हटाएँ? इसे वापस नहीं किया जा सकता।';
  }

  @override
  String get permissions => 'अनुमतियाँ';

  @override
  String get platformLimitation =>
      'फ़ोन मोड स्वतः बदलना केवल Android पर उपलब्ध है। शेड्यूल और रिमाइंडर इस प्लेटफ़ॉर्म पर भी काम करते हैं।';

  @override
  String get permissionDenied => 'अनुमति नहीं दी गई।';

  @override
  String get loadError => 'स्थानीय शेड्यूल फ़ाइल लोड नहीं हुई।';

  @override
  String get retry => 'फिर प्रयास करें';

  @override
  String get importInvalidJson => 'चुनी गई फ़ाइल मान्य JSON नहीं है।';

  @override
  String get importInvalidRoot => 'JSON का मूल भाग एक ऑब्जेक्ट होना चाहिए।';

  @override
  String get importMissingSchedules => 'JSON में “schedules” सूची होनी चाहिए।';

  @override
  String get importInvalidSchedule => 'एक या अधिक शेड्यूल की संरचना अमान्य है।';

  @override
  String get importInvalidTitle => 'हर शेड्यूल में शीर्षक होना चाहिए।';

  @override
  String get importInvalidTime =>
      'प्रारंभ और समाप्ति समय अलग और 0 से 1439 के बीच होना चाहिए।';

  @override
  String get importInvalidDays => 'हर शेड्यूल में 1 से 7 तक के दिन होने चाहिए।';

  @override
  String get importInvalidMode => 'मोड “silent” या “vibration” होना चाहिए।';

  @override
  String get importInvalidReminder =>
      'रिमाइंडर 0 से 120 मिनट के बीच होना चाहिए।';

  @override
  String get importEmptyFile => 'चुनी गई फ़ाइल खाली है।';

  @override
  String get signIn => 'साइन इन';

  @override
  String get signInSubtitle =>
      'जारी रखने के लिए स्थानीय ICT107 डेमो खाते का उपयोग करें।';

  @override
  String get email => 'ईमेल';

  @override
  String get password => 'पासवर्ड';

  @override
  String get emailRequired => 'अपना ईमेल पता दर्ज करें।';

  @override
  String get emailInvalid => 'मान्य ईमेल पता दर्ज करें।';

  @override
  String get passwordRequired => 'अपना पासवर्ड दर्ज करें।';

  @override
  String get passwordTooShort => 'पासवर्ड कम से कम 4 अक्षरों का होना चाहिए।';

  @override
  String get showPassword => 'पासवर्ड दिखाएँ';

  @override
  String get hidePassword => 'पासवर्ड छुपाएँ';

  @override
  String get signingIn => 'साइन इन हो रहा है…';

  @override
  String get invalidCredentials => 'गलत ईमेल या पासवर्ड।';

  @override
  String get demoCredentials =>
      'डेमो लॉगिन: student@ict107.edu • पासवर्ड: ict107';

  @override
  String get loginWelcome =>
      'विश्वविद्यालय की मीटिंग के दौरान फ़ोन को साइलेंट या वाइब्रेशन मोड में प्रबंधित करें।';

  @override
  String get loginFeatureSchedules =>
      'साप्ताहिक मीटिंग शेड्यूल बनाएँ और प्रबंधित करें';

  @override
  String get loginFeatureClock => 'दुनिया के पाँच शहरों का लाइव समय देखें';

  @override
  String get loginFeaturePrivacy => 'सारा ऐप डेटा इसी डिवाइस पर रहता है';

  @override
  String get account => 'खाता';

  @override
  String get signOut => 'साइन आउट';

  @override
  String get signOutConfirmation =>
      'इस डिवाइस से साइन आउट करें? शेड्यूल स्थानीय रूप से सुरक्षित रहेंगे।';

  @override
  String get appearance => 'रूप';

  @override
  String get systemTheme => 'System';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get lightMode => 'लाइट मोड';

  @override
  String get darkMode => 'डार्क मोड';

  @override
  String get systemMode => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get themeDescription => 'इस डिवाइस पर ऐप का रूप चुनें।';

  @override
  String get profile => 'प्रोफ़ाइल';

  @override
  String get welcomeBack => 'वापसी पर स्वागत है';

  @override
  String get goodMorning => 'सुप्रभात';

  @override
  String get goodAfternoon => 'शुभ दोपहर';

  @override
  String get goodEvening => 'शुभ संध्या';

  @override
  String get currentStatus => 'वर्तमान स्थिति';

  @override
  String get todaysMeetings => 'आज की मीटिंग्स';

  @override
  String get quickActions => 'त्वरित कार्य';

  @override
  String get viewAll => 'सभी देखें';

  @override
  String get meetingStarted => 'मीटिंग शुरू हुई';

  @override
  String get meetingEnded => 'मीटिंग समाप्त हुई';

  @override
  String get startsIn => 'शुरू होने में';

  @override
  String get noUpcomingMeetings => 'कोई आगामी मीटिंग नहीं';

  @override
  String get createMeeting => 'मीटिंग बनाएँ';

  @override
  String get uploadJson => 'JSON अपलोड करें';

  @override
  String get chooseFile => 'फ़ाइल चुनें';

  @override
  String get uploadSuccessful => 'अपलोड सफल';

  @override
  String get uploadFailed => 'अपलोड विफल';

  @override
  String get exportJson => 'JSON निर्यात करें';

  @override
  String get clearData => 'डेटा साफ़ करें';

  @override
  String get clearDataTitle => 'सारा स्थानीय डेटा साफ़ करें?';

  @override
  String get clearDataMessage =>
      'यह सभी सहेजे गए शेड्यूल और सेटिंग्स स्थायी रूप से हटाएगा।';

  @override
  String get confirm => 'पुष्टि करें';

  @override
  String get yes => 'हाँ';

  @override
  String get no => 'नहीं';

  @override
  String get about => 'परिचय';

  @override
  String get aboutDescription =>
      ' Auto Silent मीटिंग शेड्यूल, रिमाइंडर, विश्व घड़ी और समर्थित फ़ोन मोड प्रबंधित करने वाला ऑफ़लाइन विश्वविद्यालय प्रोजेक्ट है।';

  @override
  String get search => 'खोजें';

  @override
  String get filterByDay => 'दिन के अनुसार फ़िल्टर';

  @override
  String get calendarView => 'कैलेंडर दृश्य';

  @override
  String get listView => 'सूची दृश्य';

  @override
  String get allDays => 'सभी दिन';

  @override
  String get monday => 'सोमवार';

  @override
  String get tuesday => 'मंगलवार';

  @override
  String get wednesday => 'बुधवार';

  @override
  String get thursday => 'गुरुवार';

  @override
  String get friday => 'शुक्रवार';

  @override
  String get saturday => 'शनिवार';

  @override
  String get sunday => 'रविवार';

  @override
  String get normal => 'सामान्य';

  @override
  String get silent => 'साइलेंट';

  @override
  String get vibration => 'वाइब्रेशन';

  @override
  String get active => 'सक्रिय';

  @override
  String get inactive => 'निष्क्रिय';

  @override
  String get loading => 'लोड हो रहा है…';

  @override
  String get error => 'त्रुटि';

  @override
  String get success => 'सफल';

  @override
  String get close => 'बंद करें';

  @override
  String get edit => 'संपादित करें';

  @override
  String get back => 'वापस';

  @override
  String get refresh => 'रीफ़्रेश';

  @override
  String get homeTooltip => 'होम खोलें';

  @override
  String get schedulesTooltip => 'शेड्यूल खोलें';

  @override
  String get worldClockTooltip => 'विश्व घड़ी खोलें';

  @override
  String get settingsTooltip => 'सेटिंग्स खोलें';

  @override
  String get languageTooltip => 'भाषा बदलें';

  @override
  String get notificationTooltip => 'सूचना सेटिंग्स';

  @override
  String get menuTooltip => 'मेनू खोलें';

  @override
  String get passwordVisibilityTooltip => 'पासवर्ड दिखाएँ या छुपाएँ';

  @override
  String get scheduleSaved => 'शेड्यूल सफलतापूर्वक सहेजा गया।';

  @override
  String get scheduleDeleted => 'शेड्यूल सफलतापूर्वक हटाया गया।';

  @override
  String get settingsSaved => 'सेटिंग्स सफलतापूर्वक सहेजी गईं।';

  @override
  String get dataCleared => 'स्थानीय डेटा साफ़ किया गया।';

  @override
  String get unsupportedFeature =>
      'यह सुविधा इस प्लेटफ़ॉर्म पर उपलब्ध नहीं है।';

  @override
  String get androidModeSupport =>
      'अनुमति के बाद Android डिवाइस का साउंड मोड स्वतः बदल सकता है।';

  @override
  String get otherPlatformModeSupport =>
      'इस प्लेटफ़ॉर्म पर ऐप सक्रिय मीटिंग मोड दिखाता है और रिमाइंडर भेजता है, लेकिन सिस्टम साउंड मोड नहीं बदल सकता।';

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get selectMode => 'फ़ोन मोड चुनें';

  @override
  String get selectDays => 'मीटिंग के दिन चुनें';

  @override
  String get invalidSchedule => 'शेड्यूल की जानकारी जाँचें और फिर प्रयास करें।';

  @override
  String get startBeforeEnd => 'प्रारंभ और समाप्ति समय समान नहीं हो सकते।';

  @override
  String get noFileSelected => 'कोई फ़ाइल नहीं चुनी गई।';

  @override
  String get localStorage => 'स्थानीय संग्रहण';

  @override
  String get localStorageDescription =>
      'शेड्यूल और सेटिंग्स इसी डिवाइस पर स्थानीय रूप से सहेजी जाती हैं।';

  @override
  String get version => 'संस्करण';

  @override
  String get logoutSuccess => 'आप साइन आउट हो गए हैं।';
}
