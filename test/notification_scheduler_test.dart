import 'package:flutter_test/flutter_test.dart';
import 'package:ict107_auto_silent/domain/models/meeting_schedule.dart';
import 'package:ict107_auto_silent/services/notification_scheduler.dart';

void main() {
  test('buildPlans creates reminder, start, and end notifications', () {
    final scheduler = NotificationScheduler();
    const schedule = MeetingSchedule(
      id: '1',
      title: 'Tutorial',
      startMinutes: 10 * 60,
      endMinutes: 11 * 60,
      weekdays: [1],
      mode: MeetingMode.vibration,
      enabled: true,
      reminderMinutes: 10,
    );

    final plans = scheduler.buildPlans([schedule], DateTime(2026, 8, 3, 8));
    final mondayPlans = plans.where((plan) => plan.when.day == 3).toList();

    expect(mondayPlans.map((plan) => plan.event), containsAll([
      NotificationEvent.reminder,
      NotificationEvent.start,
      NotificationEvent.end,
    ]));
    expect(mondayPlans.first.when, DateTime(2026, 8, 3, 9, 50));
  });
}
