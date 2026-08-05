$ErrorActionPreference = "Stop"
flutter create --platforms=android,ios,web,windows .
flutter pub get
flutter gen-l10n
Write-Host "Project generated. Run: flutter test; flutter run"
