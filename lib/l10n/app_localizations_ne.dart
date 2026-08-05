// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Nepali (`ne`).
class AppLocalizationsNe extends AppLocalizations {
  AppLocalizationsNe([String locale = 'ne']) : super(locale);

  @override
  String get appTitle => 'ICT107 अटो साइलेन्ट';

  @override
  String get dashboard => 'गृहपृष्ठ';

  @override
  String get schedules => 'तालिकाहरू';

  @override
  String get worldClock => 'विश्व घडी';

  @override
  String get settings => 'सेटिङहरू';

  @override
  String get normalMode => 'सामान्य मोड';

  @override
  String get silentMode => 'साइलेन्ट मोड';

  @override
  String get vibrationMode => 'भाइब्रेशन मोड';

  @override
  String get noActiveMeeting => 'अहिले कुनै बैठक सक्रिय छैन';

  @override
  String get privacyTitle => 'गोपनीयता';

  @override
  String get privacyDescription =>
      'कुनै एनालिटिक्स, ट्र्याकिङ, क्लाउड भण्डारण वा नेटवर्क अनुरोध छैन। तपाईंको डाटा यही उपकरणमा रहन्छ।';

  @override
  String scheduleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count तालिकाहरू',
      one: '१ तालिका',
      zero: 'कुनै तालिका छैन',
    );
    return '$_temp0';
  }

  @override
  String get offlineOnly => 'स्थानीय रूपमा JSON मा सुरक्षित';

  @override
  String get importJson => 'JSON आयात गर्नुहोस्';

  @override
  String importSuccess(int count) {
    return '$count तालिकाहरू आयात गरियो';
  }

  @override
  String get noSchedules =>
      'आफ्नो पहिलो बैठक तालिका बनाउनुहोस् वा JSON फाइल आयात गर्नुहोस्।';

  @override
  String get noSchedulesTitle => 'अहिलेसम्म कुनै तालिका छैन';

  @override
  String get addSchedule => 'तालिका थप्नुहोस्';

  @override
  String get editSchedule => 'तालिका सम्पादन गर्नुहोस्';

  @override
  String get title => 'तालिकाको शीर्षक';

  @override
  String get requiredField => 'यो विवरण आवश्यक छ।';

  @override
  String get startTime => 'सुरु समय';

  @override
  String get endTime => 'समाप्ति समय';

  @override
  String get time => 'समय';

  @override
  String get days => 'दोहोरिने दिनहरू';

  @override
  String get mode => 'फोन मोड';

  @override
  String get reminder => 'सम्झाउने सूचना';

  @override
  String minutesBefore(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes मिनेटअघि',
      one: '१ मिनेटअघि',
      zero: 'सम्झाउने सूचना छैन',
    );
    return '$_temp0';
  }

  @override
  String get enabled => 'तालिका सक्रिय';

  @override
  String get enabledDescription =>
      'छानिएको समय आएपछि एपले यो तालिका स्वतः लागू गर्नेछ।';

  @override
  String get save => 'तालिका सुरक्षित गर्नुहोस्';

  @override
  String get language => 'भाषा';

  @override
  String get english => 'अङ्ग्रेजी';

  @override
  String get nepali => 'नेपाली';

  @override
  String get hindi => 'हिन्दी';

  @override
  String get chinese => 'चिनियाँ';

  @override
  String get spanish => 'स्पेनी';

  @override
  String get french => 'फ्रेन्च';

  @override
  String get notifications => 'बैठक सम्झाउने सूचनाहरू';

  @override
  String get notificationDescription =>
      'हरेक बैठकअघि स्थानीय सूचना प्राप्त गर्नुहोस्।';

  @override
  String get dndAccess => 'डु नट डिस्टर्ब पहुँच';

  @override
  String get dndExplanation =>
      'साइलेन्ट वा भाइब्रेशन मोड स्वतः परिवर्तन गर्न एन्ड्रोइडलाई यो अनुमति आवश्यक हुन्छ।';

  @override
  String get openSettings => 'सेटिङ खोल्नुहोस्';

  @override
  String get permissionTitle => 'अनुमति आवश्यक';

  @override
  String get notificationPermissionExplanation =>
      'सूचनाहरू स्थानीय सम्झाउने उद्देश्यका लागि मात्र प्रयोग हुन्छन्। कुनै डाटा उपकरणबाहिर जाँदैन।';

  @override
  String get dndPermissionExplanation =>
      'फोन मोड स्वतः परिवर्तन गर्नुअघि एन्ड्रोइडलाई डु नट डिस्टर्ब अनुमति आवश्यक हुन्छ।';

  @override
  String get cancel => 'रद्द गर्नुहोस्';

  @override
  String get continueLabel => 'जारी राख्नुहोस्';

  @override
  String get sydney => 'सिड्नी';

  @override
  String get london => 'लन्डन';

  @override
  String get newYork => 'न्युयोर्क';

  @override
  String get tokyo => 'टोकियो';

  @override
  String get kathmandu => 'काठमाडौं';

  @override
  String cityName(String key) {
    String _temp0 = intl.Intl.selectLogic(
      key,
      {
        'sydney': 'सिड्नी',
        'london': 'लन्डन',
        'newYork': 'न्युयोर्क',
        'tokyo': 'टोकियो',
        'kathmandu': 'काठमाडौं',
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
        'tue': 'मङ्गल',
        'wed': 'बुध',
        'thu': 'बिही',
        'fri': 'शुक्र',
        'sat': 'शनि',
        'sun': 'आइत',
        'other': '?',
      },
    );
    return '$_temp0';
  }

  @override
  String get manageSchedules => 'तालिकाहरू व्यवस्थापन गर्नुहोस्';

  @override
  String get fiveCities => 'पाँच सहरको प्रत्यक्ष समय';

  @override
  String get permissionsAndLanguage => 'अनुमति र भाषा';

  @override
  String get nextMeeting => 'अर्को बैठक';

  @override
  String get options => 'विकल्पहरू';

  @override
  String get selectOneDay => 'कम्तीमा एउटा दिन छान्नुहोस्।';

  @override
  String get delete => 'मेटाउनुहोस्';

  @override
  String get deleteScheduleTitle => 'तालिका मेटाउने?';

  @override
  String deleteScheduleMessage(String title) {
    return '“$title” मेटाउने? यो कार्य फिर्ता गर्न सकिँदैन।';
  }

  @override
  String get permissions => 'अनुमतिहरू';

  @override
  String get platformLimitation =>
      'फोन मोड स्वतः परिवर्तन गर्ने सुविधा एन्ड्रोइडमा मात्र उपलब्ध छ। तालिका र सम्झाउने सूचना सबै प्लेटफर्ममा काम गर्छन्।';

  @override
  String get permissionDenied => 'अनुमति प्रदान गरिएन।';

  @override
  String get loadError => 'स्थानीय तालिकाहरू लोड गर्न सकिएन।';

  @override
  String get retry => 'फेरि प्रयास गर्नुहोस्';

  @override
  String get importInvalidJson => 'छानिएको फाइल मान्य JSON होइन।';

  @override
  String get importInvalidRoot => 'JSON को मूल संरचना वस्तु हुनुपर्छ।';

  @override
  String get importMissingSchedules => 'JSON मा schedules एरे हुनुपर्छ।';

  @override
  String get importInvalidSchedule => 'एक वा बढी तालिका अमान्य छन्।';

  @override
  String get importInvalidTitle => 'हरेक तालिकामा शीर्षक हुनुपर्छ।';

  @override
  String get importInvalidTime => 'सुरु र अन्त्य समय मान्य हुनुपर्छ।';

  @override
  String get importInvalidDays => 'हप्ताका दिन सोमबारदेखि आइतबारसम्म हुनुपर्छ।';

  @override
  String get importInvalidMode => 'मोड साइलेन्ट वा भाइब्रेशन हुनुपर्छ।';

  @override
  String get importInvalidReminder =>
      'सम्झाउने समय ० देखि १२० मिनेटसम्म हुनुपर्छ।';

  @override
  String get importEmptyFile => 'छानिएको फाइल खाली छ।';

  @override
  String get signIn => 'लगइन';

  @override
  String get signInSubtitle => 'जारी राख्न आफ्नो विवरण प्रयोग गर्नुहोस्।';

  @override
  String get email => 'इमेल';

  @override
  String get password => 'पासवर्ड';

  @override
  String get emailRequired => 'कृपया आफ्नो इमेल ठेगाना प्रविष्ट गर्नुहोस्।';

  @override
  String get emailInvalid => 'मान्य इमेल ठेगाना प्रविष्ट गर्नुहोस्।';

  @override
  String get passwordRequired => 'कृपया पासवर्ड प्रविष्ट गर्नुहोस्।';

  @override
  String get passwordTooShort => 'पासवर्ड कम्तीमा ४ अक्षरको हुनुपर्छ।';

  @override
  String get showPassword => 'पासवर्ड देखाउनुहोस्';

  @override
  String get hidePassword => 'पासवर्ड लुकाउनुहोस्';

  @override
  String get signingIn => 'लगइन हुँदै...';

  @override
  String get invalidCredentials => 'गलत इमेल वा पासवर्ड।';

  @override
  String get demoCredentials =>
      'डेमो लगइन: student@ict107.edu • पासवर्ड: ict107';

  @override
  String get loginWelcome =>
      'तपाईंका विश्वविद्यालयका बैठकहरूका लागि फोनलाई स्वचालित रूपमा साइलेन्ट वा भाइब्रेशन मोडमा व्यवस्थापन गर्नुहोस्।';

  @override
  String get loginFeatureSchedules =>
      'साप्ताहिक बैठक तालिका सिर्जना र व्यवस्थापन गर्नुहोस्';

  @override
  String get loginFeatureClock =>
      'विश्वका प्रमुख सहरहरूको प्रत्यक्ष समय हेर्नुहोस्';

  @override
  String get loginFeaturePrivacy => 'सबै डाटा यसै उपकरणमा सुरक्षित रहन्छ';

  @override
  String get account => 'खाता';

  @override
  String get signOut => 'लगआउट';

  @override
  String get signOutConfirmation =>
      'यस उपकरणबाट लगआउट गर्ने? तपाईंका तालिकाहरू स्थानीय रूपमा सुरक्षित रहनेछन्।';

  @override
  String get appearance => 'रूप';

  @override
  String get systemTheme => 'सिस्टम';

  @override
  String get lightTheme => 'उज्यालो';

  @override
  String get darkTheme => 'अँध्यारो';

  @override
  String get lightMode => 'उज्यालो मोड';

  @override
  String get darkMode => 'गाढा मोड';

  @override
  String get systemMode => 'प्रणाली अनुसार';

  @override
  String get themeDescription => 'यस उपकरणमा एपको देखावट छान्नुहोस्।';

  @override
  String get profile => 'प्रोफाइल';

  @override
  String get welcomeBack => 'फेरि स्वागत छ';

  @override
  String get goodMorning => 'शुभ प्रभात';

  @override
  String get goodAfternoon => 'शुभ दिउँसो';

  @override
  String get goodEvening => 'शुभ साँझ';

  @override
  String get currentStatus => 'हालको अवस्था';

  @override
  String get todaysMeetings => 'आजका बैठकहरू';

  @override
  String get quickActions => 'द्रुत कार्यहरू';

  @override
  String get viewAll => 'सबै हेर्नुहोस्';

  @override
  String get meetingStarted => 'बैठक सुरु भयो';

  @override
  String get meetingEnded => 'बैठक समाप्त भयो';

  @override
  String get startsIn => 'सुरु हुन बाँकी';

  @override
  String get noUpcomingMeetings => 'आगामी बैठक छैन';

  @override
  String get createMeeting => 'बैठक सिर्जना गर्नुहोस्';

  @override
  String get uploadJson => 'JSON अपलोड गर्नुहोस्';

  @override
  String get chooseFile => 'फाइल छान्नुहोस्';

  @override
  String get uploadSuccessful => 'अपलोड सफल भयो';

  @override
  String get uploadFailed => 'अपलोड असफल भयो';

  @override
  String get exportJson => 'JSON निर्यात गर्नुहोस्';

  @override
  String get clearData => 'सबै डाटा हटाउनुहोस्';

  @override
  String get clearDataTitle => 'सबै स्थानीय डाटा हटाउने?';

  @override
  String get clearDataMessage =>
      'यसले यस उपकरणमा सुरक्षित सबै तालिका र सेटिङहरू स्थायी रूपमा हटाउनेछ।';

  @override
  String get confirm => 'पुष्टि गर्नुहोस्';

  @override
  String get yes => 'हो';

  @override
  String get no => 'होइन';

  @override
  String get about => 'हाम्रो बारेमा';

  @override
  String get aboutDescription =>
      'ICT107 Auto Silent एउटा अफलाइन विश्वविद्यालय परियोजना हो जसले बैठक तालिका, सम्झाउने सूचना, विश्व घडी र फोन मोड व्यवस्थापन गर्न मद्दत गर्छ।';

  @override
  String get search => 'खोज्नुहोस्';

  @override
  String get filterByDay => 'दिन अनुसार फिल्टर';

  @override
  String get calendarView => 'क्यालेन्डर दृश्य';

  @override
  String get listView => 'सूची दृश्य';

  @override
  String get allDays => 'सबै दिन';

  @override
  String get monday => 'सोमबार';

  @override
  String get tuesday => 'मंगलबार';

  @override
  String get wednesday => 'बुधबार';

  @override
  String get thursday => 'बिहीबार';

  @override
  String get friday => 'शुक्रबार';

  @override
  String get saturday => 'शनिबार';

  @override
  String get sunday => 'आइतबार';

  @override
  String get normal => 'सामान्य';

  @override
  String get silent => 'साइलेन्ट';

  @override
  String get vibration => 'भाइब्रेशन';

  @override
  String get active => 'सक्रिय';

  @override
  String get inactive => 'निष्क्रिय';

  @override
  String get loading => 'लोड हुँदै...';

  @override
  String get error => 'त्रुटि';

  @override
  String get success => 'सफल';

  @override
  String get close => 'बन्द गर्नुहोस्';

  @override
  String get edit => 'सम्पादन';

  @override
  String get back => 'फिर्ता';

  @override
  String get refresh => 'रिफ्रेस';

  @override
  String get homeTooltip => 'गृहपृष्ठ खोल्नुहोस्';

  @override
  String get schedulesTooltip => 'तालिकाहरू खोल्नुहोस्';

  @override
  String get worldClockTooltip => 'विश्व घडी खोल्नुहोस्';

  @override
  String get settingsTooltip => 'सेटिङहरू खोल्नुहोस्';

  @override
  String get languageTooltip => 'भाषा परिवर्तन गर्नुहोस्';

  @override
  String get notificationTooltip => 'सूचना सेटिङहरू';

  @override
  String get menuTooltip => 'मेनु खोल्नुहोस्';

  @override
  String get passwordVisibilityTooltip => 'पासवर्ड देखाउनुहोस् वा लुकाउनुहोस्';

  @override
  String get scheduleSaved => 'तालिका सफलतापूर्वक सुरक्षित गरियो।';

  @override
  String get scheduleDeleted => 'तालिका सफलतापूर्वक मेटियो।';

  @override
  String get settingsSaved => 'सेटिङहरू सफलतापूर्वक सुरक्षित गरियो।';

  @override
  String get dataCleared => 'स्थानीय डाटा सफलतापूर्वक हटाइयो।';

  @override
  String get unsupportedFeature => 'यो सुविधा यस प्लेटफर्ममा उपलब्ध छैन।';

  @override
  String get androidModeSupport =>
      'अनुमति प्राप्त भएपछि एन्ड्रोइडमा फोनको साउन्ड मोड स्वचालित रूपमा परिवर्तन गर्न सकिन्छ।';

  @override
  String get otherPlatformModeSupport =>
      'यस प्लेटफर्ममा एपले बैठक मोड देखाउँछ र सम्झाउने सूचना पठाउँछ, तर फोनको साउन्ड मोड परिवर्तन गर्न सक्दैन।';

  @override
  String get selectLanguage => 'भाषा छान्नुहोस्';

  @override
  String get selectMode => 'फोन मोड छान्नुहोस्';

  @override
  String get selectDays => 'बैठक हुने दिनहरू छान्नुहोस्';

  @override
  String get invalidSchedule =>
      'कृपया तालिकाको जानकारी जाँचेर पुनः प्रयास गर्नुहोस्।';

  @override
  String get startBeforeEnd => 'सुरु र अन्त्य समय एउटै हुन सक्दैन।';

  @override
  String get noFileSelected => 'कुनै फाइल छानिएको छैन।';

  @override
  String get localStorage => 'स्थानीय भण्डारण';

  @override
  String get localStorageDescription =>
      'तालिका र सेटिङहरू यस उपकरणमा मात्र सुरक्षित हुन्छन्।';

  @override
  String get version => 'संस्करण';

  @override
  String get logoutSuccess => 'तपाईं साइन आउट हुनुभएको छ।';
}
