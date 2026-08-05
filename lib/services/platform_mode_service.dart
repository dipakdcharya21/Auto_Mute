import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../domain/models/meeting_schedule.dart';

class PlatformModeService {
  static const _channel = MethodChannel('ict107.auto_silent/mode');

  bool get isSystemModeSupported =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  Future<bool> hasPolicyAccess() async {
    if (!isSystemModeSupported) return false;
    try {
      return await _channel.invokeMethod<bool>('hasPolicyAccess') ?? false;
    } on PlatformException {
      return false;
    }
  }

  Future<void> openPolicySettings() async {
    if (!isSystemModeSupported) return;
    await _channel.invokeMethod<void>('openPolicySettings');
  }

  Future<void> syncSchedules(List<MeetingSchedule> schedules) async {
    if (!isSystemModeSupported) return;
    await _channel.invokeMethod<void>('syncSchedules', {
      'schedules': schedules.map((schedule) => schedule.toJson()).toList(),
    });
  }

  Future<void> apply(MeetingMode? mode) async {
    if (!isSystemModeSupported) return;
    await _channel
        .invokeMethod<void>('setMode', {'mode': mode?.name ?? 'normal'});
  }
}
