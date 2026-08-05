# Setup and run

## 1. Requirements

Install Flutter stable and confirm the environment:

```bash
flutter doctor
```

## 2. Generate missing platform runner files

The archive keeps the important custom Android files. From the project root run:

### Windows PowerShell

```powershell
.\bootstrap.ps1
```

### macOS/Linux

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

The script runs `flutter create`, `flutter pub get`, and `flutter gen-l10n`.

## 3. Verify before running

```bash
flutter analyze
flutter test
```

## 4. Run

```bash
flutter run
```

Or choose a target:

```bash
flutter run -d chrome
flutter run -d windows
flutter devices
flutter run -d <device-id>
```

## Android permissions

The manifest already declares notification, audio-setting, Do Not Disturb policy, and reboot permissions. In the app, open **Settings → Do Not Disturb access**, read the explanation, continue to Android settings, and enable access for Auto Silent.

Android 13 and later also show the notification permission prompt when meeting reminders are enabled.

## iOS setup

After platform generation, run `pod install` when required by Xcode. Notification permission is requested only after the user enables reminders. iOS does not permit third-party apps to change the physical silent switch or system ringer mode.

## Windows and Web

These targets support the responsive interface, schedules, storage, localization, and world clocks. Windows notification support depends on normal Windows notification configuration. Browsers do not permit this project to change system ringer mode.

## JSON import example

```json
{
  "schedules": [
    {
      "id": "lecture-1",
      "title": "ICT107 Lecture",
      "startMinutes": 540,
      "endMinutes": 600,
      "weekdays": [1, 3],
      "mode": "silent",
      "enabled": true,
      "reminderMinutes": 10
    }
  ]
}
```

Weekdays use Monday `1` through Sunday `7`. Time values are minutes after midnight.
