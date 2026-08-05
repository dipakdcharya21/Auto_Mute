import 'dart:ui';

class LocalizationEngine {
  const LocalizationEngine();
  static const supportedLanguageCodes = {'en', 'ne', 'hi'};

  Locale normalize(Locale locale) {
    return supportedLanguageCodes.contains(locale.languageCode)
        ? Locale(locale.languageCode)
        : const Locale('en');
  }
}
