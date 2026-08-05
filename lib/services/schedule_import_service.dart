import 'dart:convert';

import 'package:uuid/uuid.dart';

import '../domain/models/app_data.dart';
import '../domain/models/meeting_schedule.dart';

enum ImportErrorCode {
  invalidJson,
  invalidRoot,
  missingSchedules,
  invalidSchedule,
  invalidTitle,
  invalidTime,
  invalidDays,
  invalidMode,
  invalidReminder,
  emptyFile,
}

class ScheduleImportException implements Exception {
  const ScheduleImportException(this.code);

  final ImportErrorCode code;
}

class ScheduleImportService {
  const ScheduleImportService();

  List<MeetingSchedule> parse(String source) {
    if (source.trim().isEmpty) {
      throw const ScheduleImportException(
        ImportErrorCode.emptyFile,
      );
    }

    final dynamic decoded;

    try {
      decoded = jsonDecode(source);
    } on FormatException {
      throw const ScheduleImportException(
        ImportErrorCode.invalidJson,
      );
    }

    if (decoded is! Map) {
      throw const ScheduleImportException(
        ImportErrorCode.invalidRoot,
      );
    }

    final map = Map<String, dynamic>.from(decoded);

    if (!map.containsKey('schedules')) {
      throw const ScheduleImportException(
        ImportErrorCode.missingSchedules,
      );
    }

    if (map['schedules'] is! List) {
      throw const ScheduleImportException(
        ImportErrorCode.invalidSchedule,
      );
    }

    try {
      final schedules = AppData.fromJson(map).schedules;
      const uuid = Uuid();

      return schedules
          .map(
            (schedule) => schedule.id.trim().isEmpty
                ? schedule.copyWith(id: uuid.v4())
                : schedule,
          )
          .toList(growable: false);
    } on ScheduleImportException {
      rethrow;
    } on FormatException catch (error) {
      final code = _errorCodeFromMessage(error.message);

      throw ScheduleImportException(
        code ?? ImportErrorCode.invalidSchedule,
      );
    } on TypeError {
      throw const ScheduleImportException(
        ImportErrorCode.invalidSchedule,
      );
    } on Object {
      throw const ScheduleImportException(
        ImportErrorCode.invalidSchedule,
      );
    }
  }

  ImportErrorCode? _errorCodeFromMessage(String message) {
    for (final code in ImportErrorCode.values) {
      if (code.name == message) {
        return code;
      }
    }

    return null;
  }
}
