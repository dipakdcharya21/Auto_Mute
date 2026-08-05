Replace these files:
- lib/services/auth_service.dart
- lib/app/app_controller.dart
- lib/features/auth/login_screen.dart

Add to pubspec.yaml under dependencies:
  crypto: ^3.0.7

Run:
flutter clean
flutter pub get
flutter gen-l10n
dart format lib
flutter analyze
flutter run -d chrome
