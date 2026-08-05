import 'package:flutter_test/flutter_test.dart';
import 'package:ict107_auto_silent/domain/models/meeting_schedule.dart';
import 'package:ict107_auto_silent/domain/services/schedule_engine.dart';

void main() {
  const engine = ScheduleEngine();
  const overnight = MeetingSchedule(
    id: '1',
    title: 'Night meeting',
    startMinutes: 23 * 60,
    endMinutes: 60,
    weekdays: [1],
    mode: MeetingMode.silent,
    enabled: true,
    reminderMinutes: 10,
  );

  test('overnight schedule remains active on following morning', () {
    expect(
      engine.activeSchedule(DateTime(2026, 8, 4, 0, 30), [overnight]),
      overnight,
    );
  });

  test('overnight schedule is inactive after its end', () {
    expect(
      engine.activeSchedule(DateTime(2026, 8, 4, 1, 30), [overnight]),
      isNull,
    );
  });
}
