package com.example.ict107_auto_silent

import android.app.AlarmManager
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.media.AudioManager
import android.os.Build
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONArray
import org.json.JSONObject
import java.util.Calendar

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL_NAME,
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "hasPolicyAccess" -> result.success(policyManager().isNotificationPolicyAccessGranted)
                "openPolicySettings" -> {
                    startActivity(Intent(Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS))
                    result.success(null)
                }
                "setMode" -> {
                    applyMode(this, call.argument<String>("mode") ?: "normal")
                    result.success(null)
                }
                "syncSchedules" -> {
                    @Suppress("UNCHECKED_CAST")
                    val schedules = call.argument<List<Map<String, Any?>>>("schedules") ?: emptyList()
                    NativeScheduleManager.saveAndSchedule(this, schedules)
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun policyManager() =
        getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

    companion object {
        private const val CHANNEL_NAME = "ict107.auto_silent/mode"

        fun applyMode(context: Context, mode: String) {
            val audioManager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
            val notificationManager =
                context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            try {
                when (mode) {
                    "silent" -> {
                        if (notificationManager.isNotificationPolicyAccessGranted) {
                            notificationManager.setInterruptionFilter(
                                NotificationManager.INTERRUPTION_FILTER_NONE,
                            )
                        }
                        audioManager.ringerMode = AudioManager.RINGER_MODE_SILENT
                    }
                    "vibration" -> {
                        if (notificationManager.isNotificationPolicyAccessGranted) {
                            notificationManager.setInterruptionFilter(
                                NotificationManager.INTERRUPTION_FILTER_PRIORITY,
                            )
                        }
                        audioManager.ringerMode = AudioManager.RINGER_MODE_VIBRATE
                    }
                    else -> {
                        if (notificationManager.isNotificationPolicyAccessGranted) {
                            notificationManager.setInterruptionFilter(
                                NotificationManager.INTERRUPTION_FILTER_ALL,
                            )
                        }
                        audioManager.ringerMode = AudioManager.RINGER_MODE_NORMAL
                    }
                }
            } catch (_: SecurityException) {
                // The Flutter UI explains and requests access before opening settings.
            }
        }
    }
}

object NativeScheduleManager {
    private const val PREFS = "ict107_native_schedules"
    private const val JSON_KEY = "schedules"
    private const val FIRST_REQUEST_CODE = 20000
    private const val LAST_REQUEST_CODE = 20400

    fun saveAndSchedule(context: Context, schedules: List<Map<String, Any?>>) {
        val array = JSONArray()
        schedules.forEach { item -> array.put(JSONObject(item)) }
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
            .edit()
            .putString(JSON_KEY, array.toString())
            .apply()
        scheduleNextBoundaries(context)
        applyCurrentMode(context)
    }

    fun scheduleNextBoundaries(context: Context) {
        val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        cancelOwnedAlarms(context, alarmManager)
        val schedules = load(context)
        val now = System.currentTimeMillis()
        var requestCode = FIRST_REQUEST_CODE

        schedules.forEach { schedule ->
            if (!schedule.optBoolean("enabled", true)) return@forEach
            val weekdays = schedule.optJSONArray("weekdays") ?: return@forEach
            val startMinutes = schedule.optInt("startMinutes", -1)
            val endMinutes = schedule.optInt("endMinutes", -1)
            if (startMinutes !in 0..1439 || endMinutes !in 0..1439) return@forEach

            for (offset in 0..8) {
                val day = Calendar.getInstance().apply {
                    add(Calendar.DAY_OF_YEAR, offset)
                    set(Calendar.SECOND, 0)
                    set(Calendar.MILLISECOND, 0)
                }
                val weekday = toDartWeekday(day.get(Calendar.DAY_OF_WEEK))
                if (!contains(weekdays, weekday)) continue

                val start = (day.clone() as Calendar).apply {
                    set(Calendar.HOUR_OF_DAY, startMinutes / 60)
                    set(Calendar.MINUTE, startMinutes % 60)
                }
                val end = (day.clone() as Calendar).apply {
                    set(Calendar.HOUR_OF_DAY, endMinutes / 60)
                    set(Calendar.MINUTE, endMinutes % 60)
                    if (endMinutes < startMinutes) add(Calendar.DAY_OF_YEAR, 1)
                }
                if (start.timeInMillis > now && requestCode <= LAST_REQUEST_CODE) {
                    scheduleAlarm(context, alarmManager, requestCode++, start.timeInMillis)
                }
                if (end.timeInMillis > now && requestCode <= LAST_REQUEST_CODE) {
                    scheduleAlarm(context, alarmManager, requestCode++, end.timeInMillis)
                }
            }
        }
    }

    fun applyCurrentMode(context: Context) {
        val now = Calendar.getInstance()
        val minute = now.get(Calendar.HOUR_OF_DAY) * 60 + now.get(Calendar.MINUTE)
        val today = toDartWeekday(now.get(Calendar.DAY_OF_WEEK))
        val yesterday = if (today == 1) 7 else today - 1
        var selectedMode = "normal"

        load(context).forEach { schedule ->
            if (!schedule.optBoolean("enabled", true)) return@forEach
            val weekdays = schedule.optJSONArray("weekdays") ?: return@forEach
            val start = schedule.optInt("startMinutes", -1)
            val end = schedule.optInt("endMinutes", -1)
            val active = if (end > start) {
                contains(weekdays, today) && minute >= start && minute < end
            } else {
                (contains(weekdays, today) && minute >= start) ||
                    (contains(weekdays, yesterday) && minute < end)
            }
            if (active) {
                val mode = schedule.optString("mode", "silent")
                // Silent takes precedence when overlapping schedules disagree.
                if (mode == "silent") selectedMode = "silent"
                else if (selectedMode == "normal") selectedMode = "vibration"
            }
        }
        MainActivity.applyMode(context, selectedMode)
    }

    private fun load(context: Context): List<JSONObject> {
        val text = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
            .getString(JSON_KEY, "[]") ?: "[]"
        return try {
            val array = JSONArray(text)
            List(array.length()) { index -> array.getJSONObject(index) }
        } catch (_: Exception) {
            emptyList()
        }
    }

    private fun scheduleAlarm(
        context: Context,
        manager: AlarmManager,
        requestCode: Int,
        triggerAtMillis: Long,
    ) {
        val intent = Intent(context, ModeAlarmReceiver::class.java)
        val pendingIntent = PendingIntent.getBroadcast(
            context,
            requestCode,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            manager.setAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, triggerAtMillis, pendingIntent)
        } else {
            manager.set(AlarmManager.RTC_WAKEUP, triggerAtMillis, pendingIntent)
        }
    }

    private fun cancelOwnedAlarms(context: Context, manager: AlarmManager) {
        for (code in FIRST_REQUEST_CODE..LAST_REQUEST_CODE) {
            val pendingIntent = PendingIntent.getBroadcast(
                context,
                code,
                Intent(context, ModeAlarmReceiver::class.java),
                PendingIntent.FLAG_NO_CREATE or PendingIntent.FLAG_IMMUTABLE,
            )
            if (pendingIntent != null) {
                manager.cancel(pendingIntent)
                pendingIntent.cancel()
            }
        }
    }

    private fun contains(array: JSONArray, value: Int): Boolean {
        for (index in 0 until array.length()) {
            if (array.optInt(index) == value) return true
        }
        return false
    }

    private fun toDartWeekday(androidWeekday: Int): Int =
        if (androidWeekday == Calendar.SUNDAY) 7 else androidWeekday - 1
}

class ModeAlarmReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        NativeScheduleManager.applyCurrentMode(context)
        NativeScheduleManager.scheduleNextBoundaries(context)
    }
}

class ScheduleBootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == Intent.ACTION_BOOT_COMPLETED ||
            intent.action == Intent.ACTION_MY_PACKAGE_REPLACED
        ) {
            NativeScheduleManager.applyCurrentMode(context)
            NativeScheduleManager.scheduleNextBoundaries(context)
        }
    }
}
