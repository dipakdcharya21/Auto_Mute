import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../features/auth/login_screen.dart';
import '../features/shell/home_shell.dart';
import 'app_controller.dart';
import 'app_theme.dart';

class AutoSilentApp extends StatelessWidget {
  const AutoSilentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppController>(
      builder: (context, controller, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: controller.locale,
          onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
          home: controller.isSignedIn ? const HomeShell() : const LoginScreen(),
        );
      },
    );
  }
}
