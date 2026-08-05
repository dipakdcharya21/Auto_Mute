import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as timezone_data;
import 'package:timezone/timezone.dart' as timezone;

import '../domain/models/meeting_schedule.dart';
import '../domain/services/schedule_engine.dart';

enum NotificationEvent {
  reminder,
  start,
  end,
}

class NotificationPlan {
  const NotificationPlan({
    required this.id,
    required this.when,
    required this.title,
    required this.body,
    required this.event,
  });

  final int id;
  final DateTime when;
  final String title;
  final String body;
  final NotificationEvent event;
}

class NotificationScheduler {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  final ScheduleEngine _engine = const ScheduleEngine();

  bool _initialized = false;

  bool get isSupported => !kIsWeb;

  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    timezone_data.initializeTimeZones();

    if (kIsWeb) {
      _initialized = false;
      return;
    }

    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      ),
      iOS: DarwinInitializationSettings(),
      macOS: DarwinInitializationSettings(),
      windows: WindowsInitializationSettings(
        appName: 'ICT107 Auto Silent',
        appUserModelId: 'ICT107.AutoSilent.App',
        guid: '6d9ab8b7-7ad3-4d13-b493-2d6cb3efe913',
      ),
    );

    _initialized = await _plugin.initialize(
          settings: initializationSettings,
        ) ??
        false;
  }

  List<NotificationPlan> buildPlans(
    List<MeetingSchedule> schedules,
    DateTime now, {
    String languageCode = 'en',
  }) {
    final plans = <NotificationPlan>[];
    var notificationId = 1000;

    final enabledSchedules =
        schedules.where((schedule) => schedule.enabled).toList();

    for (final schedule in enabledSchedules) {
      final upcomingStarts = _engine.upcomingStarts(schedule, now);

      for (final startTime in upcomingStarts) {
        if (schedule.reminderMinutes > 0) {
          final reminderTime = startTime.subtract(
            Duration(minutes: schedule.reminderMinutes),
          );

          if (reminderTime.isAfter(now)) {
            plans.add(
              NotificationPlan(
                id: notificationId++,
                when: reminderTime,
                title: schedule.title,
                body: _notificationMessage(
                  event: NotificationEvent.reminder,
                  languageCode: languageCode,
                  minutes: schedule.reminderMinutes,
                ),
                event: NotificationEvent.reminder,
              ),
            );
          }
        }

        if (startTime.isAfter(now)) {
          plans.add(
            NotificationPlan(
              id: notificationId++,
              when: startTime,
              title: schedule.title,
              body: _notificationMessage(
                event: NotificationEvent.start,
                languageCode: languageCode,
              ),
              event: NotificationEvent.start,
            ),
          );
        }
      }

      final upcomingEnds = _engine.upcomingEnds(schedule, now);

      for (final endTime in upcomingEnds) {
        if (!endTime.isAfter(now)) continue;

        plans.add(
          NotificationPlan(
            id: notificationId++,
            when: endTime,
            title: schedule.title,
            body: _notificationMessage(
              event: NotificationEvent.end,
              languageCode: languageCode,
            ),
            event: NotificationEvent.end,
          ),
        );
      }
    }

    plans.sort(
      (first, second) => first.when.compareTo(second.when),
    );

    return plans;
  }

  String _notificationMessage({
    required NotificationEvent event,
    required String languageCode,
    int minutes = 0,
  }) {
    switch (languageCode) {
      case 'ne':
        switch (event) {
          case NotificationEvent.reminder:
            return 'बैठक $minutes मिनेटमा सुरु हुँदैछ।';
          case NotificationEvent.start:
            return 'बैठक सुरु भएको छ। निर्धारित फोन मोड सक्रिय गरिएको छ।';
          case NotificationEvent.end:
            return 'बैठक समाप्त भएको छ। सामान्य फोन मोड पुनः लागू गरिएको छ।';
        }

      case 'hi':
        switch (event) {
          case NotificationEvent.reminder:
            return 'मीटिंग $minutes मिनट में शुरू होगी।';
          case NotificationEvent.start:
            return 'मीटिंग शुरू हो गई है। निर्धारित फ़ोन मोड सक्रिय कर दिया गया है।';
          case NotificationEvent.end:
            return 'मीटिंग समाप्त हो गई है। सामान्य फ़ोन मोड बहाल कर दिया गया है।';
        }

      default:
        switch (event) {
          case NotificationEvent.reminder:
            return 'Meeting starts in $minutes minutes.';
          case NotificationEvent.start:
            return 'Meeting started. The scheduled phone mode is now active.';
          case NotificationEvent.end:
            return 'Meeting ended. Normal phone mode has been restored.';
        }
    }
  }

  Future<bool> requestPermission() async {
    if (kIsWeb || !_initialized) {
      return false;
    }

    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    final iosPlugin = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();

    final macOSPlugin = _plugin.resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>();

    final androidPermission =
        await androidPlugin?.requestNotificationsPermission();

    final iosPermission = await iosPlugin?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );

    final macOSPermission = await macOSPlugin?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );

    return androidPermission ?? iosPermission ?? macOSPermission ?? true;
  }

  Future<void> reschedule(
    List<MeetingSchedule> schedules,
    DateTime now, {
    String languageCode = 'en',
  }) async {
    if (kIsWeb || !_initialized) {
      return;
    }

    await _plugin.cancelAll();

    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'meeting_events',
        'Meeting events',
        channelDescription:
            'Meeting reminders, meeting start alerts and meeting end alerts',
        importance: Importance.high,
        priority: Priority.high,
        enableVibration: true,
        playSound: true,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
      macOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
      windows: WindowsNotificationDetails(),
    );

    final plans = buildPlans(
      schedules,
      now,
      languageCode: languageCode,
    );

    for (final plan in plans.take(60)) {
      final scheduledTime = timezone.TZDateTime.from(
        plan.when,
        timezone.local,
      );

      if (!scheduledTime.isAfter(timezone.TZDateTime.now(timezone.local))) {
        continue;
      }

      await _plugin.zonedSchedule(
        id: plan.id,
        title: plan.title,
        body: plan.body,
        scheduledDate: scheduledTime,
        notificationDetails: notificationDetails,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        payload: plan.event.name,
      );
    }
  }

  Future<void> cancelAll() async {
    if (kIsWeb || !_initialized) {
      return;
    }

    await _plugin.cancelAll();
  }

  Future<void> showTestNotification({
    String languageCode = 'en',
  }) async {
    if (kIsWeb || !_initialized) {
      return;
    }

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'meeting_events',
        'Meeting events',
        channelDescription:
            'Meeting reminders, meeting start alerts and meeting end alerts',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
      macOS: DarwinNotificationDetails(),
      windows: WindowsNotificationDetails(),
    );

    await _plugin.show(
      id: 999,
      title: 'ICT107 Auto Silent',
      body: _notificationMessage(
        event: NotificationEvent.reminder,
        languageCode: languageCode,
        minutes: 10,
      ),
      notificationDetails: details,
    );
  }
}
