import '../models/meeting_schedule.dart';

class ScheduleEngine {
  const ScheduleEngine();

  MeetingSchedule? activeSchedule(
      DateTime now, List<MeetingSchedule> schedules) {
    final enabled = schedules.where((schedule) => schedule.enabled).toList();
    for (final schedule in enabled) {
      if (_isActive(schedule, now)) return schedule;
    }
    return null;
  }

  bool _isActive(MeetingSchedule schedule, DateTime now) {
    final minute = now.hour * 60 + now.minute;
    if (!schedule.crossesMidnight) {
      return schedule.weekdays.contains(now.weekday) &&
          minute >= schedule.startMinutes &&
          minute < schedule.endMinutes;
    }

    if (schedule.weekdays.contains(now.weekday) &&
        minute >= schedule.startMinutes) {
      return true;
    }
    final previousDay =
        now.weekday == DateTime.monday ? DateTime.sunday : now.weekday - 1;
    return schedule.weekdays.contains(previousDay) &&
        minute < schedule.endMinutes;
  }

  DateTime? nextStart(DateTime from, List<MeetingSchedule> schedules) {
    DateTime? closest;
    for (final schedule in schedules.where((schedule) => schedule.enabled)) {
      for (final start in upcomingStarts(schedule, from, days: 14)) {
        if (closest == null || start.isBefore(closest)) closest = start;
      }
    }
    return closest;
  }

  List<DateTime> upcomingEnds(MeetingSchedule schedule, DateTime from,
      {int days = 56}) {
    final ends = <DateTime>[];
    final base = DateTime(from.year, from.month, from.day);
    for (var offset = 0; offset <= days; offset++) {
      final startDay = base.add(Duration(days: offset));
      if (!schedule.weekdays.contains(startDay.weekday)) continue;
      final start = startDay.add(Duration(minutes: schedule.startMinutes));
      final endDay = schedule.crossesMidnight
          ? startDay.add(const Duration(days: 1))
          : startDay;
      final end = endDay.add(Duration(minutes: schedule.endMinutes));
      if (end.isAfter(from) && start.isBefore(end)) ends.add(end);
    }
    return ends;
  }

  List<DateTime> upcomingStarts(MeetingSchedule schedule, DateTime from,
      {int days = 56}) {
    final starts = <DateTime>[];
    final base = DateTime(from.year, from.month, from.day);
    for (var offset = 0; offset <= days; offset++) {
      final day = base.add(Duration(days: offset));
      if (!schedule.weekdays.contains(day.weekday)) continue;
      final start = day.add(Duration(minutes: schedule.startMinutes));
      if (start.isAfter(from)) starts.add(start);
    }
    return starts;
  }
}
