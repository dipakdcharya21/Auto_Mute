enum MeetingMode { silent, vibration }

class MeetingSchedule {
  const MeetingSchedule({
    required this.id,
    required this.title,
    required this.startMinutes,
    required this.endMinutes,
    required this.weekdays,
    required this.mode,
    required this.enabled,
    required this.reminderMinutes,
  });

  final String id;
  final String title;
  final int startMinutes;
  final int endMinutes;
  final List<int> weekdays;
  final MeetingMode mode;
  final bool enabled;
  final int reminderMinutes;

  bool get crossesMidnight => endMinutes < startMinutes;

  factory MeetingSchedule.fromJson(Map<String, dynamic> json) {
    final title = json['title'];
    final start = json['startMinutes'];
    final end = json['endMinutes'];
    final rawDays = json['weekdays'];
    final rawMode = json['mode'];
    final reminder = json['reminderMinutes'] ?? 10;

    if (title is! String || title.trim().isEmpty) {
      throw const FormatException('invalidTitle');
    }
    if (start is! int ||
        end is! int ||
        start < 0 ||
        start > 1439 ||
        end < 0 ||
        end > 1439 ||
        start == end) {
      throw const FormatException('invalidTime');
    }
    if (rawDays is! List || rawDays.isEmpty) {
      throw const FormatException('invalidDays');
    }
    final days = <int>{};
    for (final value in rawDays) {
      if (value is! int || value < 1 || value > 7) {
        throw const FormatException('invalidDays');
      }
      days.add(value);
    }
    final mode = switch (rawMode) {
      'silent' => MeetingMode.silent,
      'vibration' => MeetingMode.vibration,
      _ => throw const FormatException('invalidMode'),
    };
    if (reminder is! int || reminder < 0 || reminder > 120) {
      throw const FormatException('invalidReminder');
    }

    return MeetingSchedule(
      id: json['id'] is String ? json['id'] as String : '',
      title: title.trim(),
      startMinutes: start,
      endMinutes: end,
      weekdays: (days.toList()..sort()),
      mode: mode,
      enabled: json['enabled'] is bool ? json['enabled'] as bool : true,
      reminderMinutes: reminder,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'startMinutes': startMinutes,
        'endMinutes': endMinutes,
        'weekdays': weekdays,
        'mode': mode.name,
        'enabled': enabled,
        'reminderMinutes': reminderMinutes,
      };

  MeetingSchedule copyWith({
    String? id,
    String? title,
    int? startMinutes,
    int? endMinutes,
    List<int>? weekdays,
    MeetingMode? mode,
    bool? enabled,
    int? reminderMinutes,
  }) {
    return MeetingSchedule(
      id: id ?? this.id,
      title: title ?? this.title,
      startMinutes: startMinutes ?? this.startMinutes,
      endMinutes: endMinutes ?? this.endMinutes,
      weekdays: weekdays ?? this.weekdays,
      mode: mode ?? this.mode,
      enabled: enabled ?? this.enabled,
      reminderMinutes: reminderMinutes ?? this.reminderMinutes,
    );
  }
}
