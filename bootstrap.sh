#!/usr/bin/env sh
set -eu
flutter create --platforms=android,ios,web,windows .
flutter pub get
flutter gen-l10n
echo "Project generated. Run: flutter test; flutter run"
