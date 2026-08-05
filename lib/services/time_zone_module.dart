import 'package:timezone/data/latest.dart' as timezone_data;
import 'package:timezone/timezone.dart' as timezone;

class CityClock {
  const CityClock({required this.translationKey, required this.zone});
  final String translationKey;
  final String zone;
}

class TimeZoneModule {
  TimeZoneModule() {
    timezone_data.initializeTimeZones();
  }

  static const cities = [
    CityClock(translationKey: 'sydney', zone: 'Australia/Sydney'),
    CityClock(translationKey: 'london', zone: 'Europe/London'),
    CityClock(translationKey: 'newYork', zone: 'America/New_York'),
    CityClock(translationKey: 'tokyo', zone: 'Asia/Tokyo'),
    CityClock(translationKey: 'kathmandu', zone: 'Asia/Kathmandu'),
  ];

  DateTime timeFor(String zone, DateTime instant) {
    return timezone.TZDateTime.from(
        instant.toUtc(), timezone.getLocation(zone));
  }
}
