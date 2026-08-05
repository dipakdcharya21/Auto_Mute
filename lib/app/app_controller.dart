import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../data/repositories/app_repository.dart';
import '../domain/models/app_data.dart';
import '../domain/models/meeting_schedule.dart';
import '../domain/services/schedule_engine.dart';
import '../services/auth_service.dart';
import '../services/localization_engine.dart';
import '../services/notification_scheduler.dart';
import '../services/platform_mode_service.dart';
import '../services/settings_manager.dart';

class AppController extends ChangeNotifier {
  AppController({
    required this.repository,
    required this.settingsManager,
    required this.notificationScheduler,
    required this.platformModeService,
    required this.localizationEngine,
    required this.authService,
  });

  final AppRepository repository;
  final SettingsManager settingsManager;
  final NotificationScheduler notificationScheduler;
  final PlatformModeService platformModeService;
  final LocalizationEngine localizationEngine;
  final AuthService authService;

  final ScheduleEngine _engine = const ScheduleEngine();

  List<MeetingSchedule> _schedules = [];
  MeetingSchedule? _activeSchedule;
  Timer? _clock;
  bool _isBusy = false;
  Object? _startupError;
  bool _isSignedIn = false;

  List<MeetingSchedule> get schedules => List.unmodifiable(_schedules);

  MeetingSchedule? get activeSchedule => _activeSchedule;

  Locale get locale {
    return localizationEngine.normalize(settingsManager.locale);
  }

  ThemeMode get themeMode => settingsManager.themeMode;

  bool get notificationsEnabled {
    return settingsManager.notificationsEnabled;
  }

  bool get isBusy => _isBusy;

  Object? get startupError => _startupError;

  bool get isSignedIn => _isSignedIn;

  bool get hasLocalAccount => authService.hasAccount;

  String get displayName => authService.displayName;

  String get accountEmail => authService.email;

  DateTime? get nextMeetingStart {
    return _engine.nextStart(
      DateTime.now(),
      _schedules,
    );
  }

  Future<void> initialize() async {
    _isSignedIn = authService.isSignedIn;

    try {
      _schedules = (await repository.load()).schedules;
      await _syncExternalServices();
      await refreshActiveMode();
    } catch (error) {
      _startupError = error;
      _schedules = [];
    }

    _clock = Timer.periodic(
      const Duration(seconds: 20),
      (_) => refreshActiveMode(),
    );
  }

  Future<bool> createAccount({
    required String fullName,
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    final success = await authService.createAccount(
      fullName: fullName,
      email: email,
      password: password,
      rememberMe: rememberMe,
    );

    if (success) {
      _isSignedIn = true;
      notifyListeners();
    }

    return success;
  }

  Future<bool> signIn({
    required String email,
    required String password,
    bool rememberMe = true,
  }) async {
    final success = await authService.signIn(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );

    if (success) {
      _isSignedIn = true;
      notifyListeners();
    }

    return success;
  }

  Future<void> signOut() async {
    await authService.signOut();
    _isSignedIn = false;
    notifyListeners();
  }

  Future<void> deleteAccount() async {
    await authService.deleteAccount();
    _isSignedIn = false;
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    final normalizedLocale = localizationEngine.normalize(locale);

    await settingsManager.setLocale(normalizedLocale);

    if (notificationsEnabled) {
      await notificationScheduler.reschedule(
        _schedules,
        DateTime.now(),
        languageCode: normalizedLocale.languageCode,
      );
    }

    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await settingsManager.setThemeMode(mode);
    notifyListeners();
  }

  Future<bool> setNotifications(bool enabled) async {
    if (enabled) {
      final allowed = await notificationScheduler.requestPermission();

      if (!allowed) {
        return false;
      }
    }

    await settingsManager.setNotificationsEnabled(enabled);

    if (enabled) {
      await notificationScheduler.reschedule(
        _schedules,
        DateTime.now(),
        languageCode: locale.languageCode,
      );
    } else {
      await notificationScheduler.cancelAll();
    }

    notifyListeners();
    return true;
  }

  Future<void> saveSchedule(MeetingSchedule schedule) async {
    final normalized = schedule.id.isEmpty
        ? schedule.copyWith(id: const Uuid().v4())
        : schedule;

    final index = _schedules.indexWhere(
      (item) => item.id == normalized.id,
    );

    if (index == -1) {
      _schedules = [
        ..._schedules,
        normalized,
      ];
    } else {
      final updatedSchedules = [..._schedules];
      updatedSchedules[index] = normalized;
      _schedules = updatedSchedules;
    }

    await _persist();
  }

  Future<void> toggleSchedule(
    MeetingSchedule schedule,
    bool enabled,
  ) {
    return saveSchedule(
      schedule.copyWith(enabled: enabled),
    );
  }

  Future<void> deleteSchedule(String id) async {
    _schedules = _schedules.where((schedule) => schedule.id != id).toList();

    await _persist();
  }

  Future<void> replaceSchedules(
    List<MeetingSchedule> schedules,
  ) async {
    _schedules = List.of(schedules);
    await _persist();
  }

  Future<void> retryLoad() async {
    _setBusy(true);
    _startupError = null;

    try {
      _schedules = (await repository.load()).schedules;
      await _syncExternalServices();
      await refreshActiveMode();
    } catch (error) {
      _startupError = error;
    } finally {
      _setBusy(false);
    }
  }

  Future<void> refreshActiveMode() async {
    final nextSchedule = _engine.activeSchedule(
      DateTime.now(),
      _schedules,
    );

    final unchanged = nextSchedule?.id == _activeSchedule?.id &&
        nextSchedule?.mode == _activeSchedule?.mode;

    if (unchanged) {
      return;
    }

    _activeSchedule = nextSchedule;

    await platformModeService.apply(
      nextSchedule?.mode,
    );

    notifyListeners();
  }

  Future<void> _persist() async {
    _setBusy(true);

    try {
      await repository.save(
        AppData(schedules: _schedules),
      );

      await _syncExternalServices();
      await refreshActiveMode();
    } finally {
      _setBusy(false);
    }
  }

  Future<void> _syncExternalServices() async {
    await platformModeService.syncSchedules(
      _schedules,
    );

    if (notificationsEnabled) {
      await notificationScheduler.reschedule(
        _schedules,
        DateTime.now(),
        languageCode: locale.languageCode,
      );
    }
  }

  void _setBusy(bool value) {
    if (_isBusy == value) {
      return;
    }

    _isBusy = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _clock?.cancel();
    super.dispose();
  }
}
