import 'package:flutter_test/flutter_test.dart';
import 'package:ict107_auto_silent/services/schedule_import_service.dart';

void main() {
  const service = ScheduleImportService();

  test('parses a valid schedule upload', () {
    final schedules = service.parse('''
      {"schedules":[{
        "id":"",
        "title":"Lecture",
        "startMinutes":540,
        "endMinutes":600,
        "weekdays":[1,3,5],
        "mode":"silent",
        "enabled":true,
        "reminderMinutes":10
      }]}
    ''');

    expect(schedules, hasLength(1));
    expect(schedules.single.title, 'Lecture');
    expect(schedules.single.id, isNotEmpty);
  });

  test('returns a stable error code for malformed JSON', () {
    expect(
      () => service.parse('{bad json'),
      throwsA(
        isA<ScheduleImportException>().having(
          (error) => error.code,
          'code',
          ImportErrorCode.invalidJson,
        ),
      ),
    );
  });
}
