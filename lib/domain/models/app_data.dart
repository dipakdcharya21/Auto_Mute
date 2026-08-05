import 'meeting_schedule.dart';

class AppData {
  const AppData({required this.schedules});
  final List<MeetingSchedule> schedules;

  factory AppData.fromJson(Map<String, dynamic> json) {
    final raw = json['schedules'];
    if (raw is! List) throw const FormatException('missingSchedules');
    return AppData(
      schedules: raw.map((item) {
        if (item is! Map) throw const FormatException('invalidSchedule');
        return MeetingSchedule.fromJson(Map<String, dynamic>.from(item));
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'version': 1,
        'schedules': schedules.map((schedule) => schedule.toJson()).toList(),
      };
}
