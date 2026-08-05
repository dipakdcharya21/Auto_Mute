import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'app/app_controller.dart';
import 'data/repositories/app_repository.dart';
import 'data/sources/local_json_data_source.dart';
import 'services/auth_service.dart';
import 'services/localization_engine.dart';
import 'services/notification_scheduler.dart';
import 'services/platform_mode_service.dart';
import 'services/settings_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final settingsManager = SettingsManager();
    final notificationScheduler = NotificationScheduler();
    final authService = AuthService();

    await settingsManager.initialize();
    await notificationScheduler.initialize();
    await authService.initialize();

    final controller = AppController(
      repository: AppRepository(
        LocalJsonDataSource(),
      ),
      settingsManager: settingsManager,
      notificationScheduler: notificationScheduler,
      platformModeService: PlatformModeService(),
      localizationEngine: const LocalizationEngine(),
      authService: authService,
    );

    await controller.initialize();

    runApp(
      ChangeNotifierProvider<AppController>.value(
        value: controller,
        child: const AutoSilentApp(),
      ),
    );
  } catch (error, stackTrace) {
    debugPrint('Application startup failed: $error');
    debugPrintStack(stackTrace: stackTrace);

    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'The application could not start.\n\n$error',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
