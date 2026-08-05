import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager {
  static const _localeKey = 'locale_code';
  static const _notificationsKey = 'notifications_enabled';
  static const _themeModeKey = 'theme_mode';

  late final SharedPreferences _preferences;

  Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Locale get locale {
    return Locale(_preferences.getString(_localeKey) ?? 'en');
  }

  bool get notificationsEnabled {
    return _preferences.getBool(_notificationsKey) ?? false;
  }

  ThemeMode get themeMode {
    final value = _preferences.getString(_themeModeKey) ?? 'system';

    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setLocale(Locale locale) {
    return _preferences.setString(
      _localeKey,
      locale.languageCode,
    );
  }

  Future<void> setNotificationsEnabled(bool enabled) {
    return _preferences.setBool(
      _notificationsKey,
      enabled,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) {
    return _preferences.setString(
      _themeModeKey,
      mode.name,
    );
  }
}
