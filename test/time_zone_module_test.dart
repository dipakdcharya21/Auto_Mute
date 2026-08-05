import 'package:flutter_test/flutter_test.dart';
import 'package:ict107_auto_silent/services/time_zone_module.dart';

void main() {
  final module = TimeZoneModule();
  final instant = DateTime.utc(2026, 1, 15, 12);

  test('contains exactly five configured cities', () {
    expect(TimeZoneModule.cities, hasLength(5));
  });

  test('Kathmandu uses its 5 hour 45 minute offset', () {
    final time = module.timeFor('Asia/Kathmandu', instant);
    expect(time.hour, 17);
    expect(time.minute, 45);
  });

  test('Sydney observes daylight saving in January', () {
    final time = module.timeFor('Australia/Sydney', instant);
    expect(time.hour, 23);
  });
}
