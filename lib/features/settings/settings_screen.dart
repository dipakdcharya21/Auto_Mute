import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_controller.dart';
import '../../l10n/app_localizations.dart';
import '../shared/responsive_page.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final controller = context.watch<AppController>();
    final androidModeSupported =
        controller.platformModeService.isSystemModeSupported;

    return ResponsivePage(
      title: l.settings,
      child: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          _SettingsSection(
            title: l.appearance,
            icon: Icons.palette_outlined,
            child: SegmentedButton<ThemeMode>(
              segments: [
                ButtonSegment(
                  value: ThemeMode.system,
                  icon: const Icon(Icons.brightness_auto_rounded),
                  label: const Text('System'),
                ),
                ButtonSegment(
                  value: ThemeMode.light,
                  icon: const Icon(Icons.light_mode_rounded),
                  label: const Text('Light'),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  icon: const Icon(Icons.dark_mode_rounded),
                  label: const Text('Dark'),
                ),
              ],
              selected: {controller.themeMode},
              onSelectionChanged: controller.isBusy
                  ? null
                  : (value) {
                      controller.setThemeMode(value.first);
                    },
            ),
          ),
          const SizedBox(height: 16),
          _SettingsSection(
            title: l.language,
            icon: Icons.translate_rounded,
            child: SegmentedButton<String>(
              segments: [
                ButtonSegment(
                  value: 'en',
                  icon: const Icon(Icons.language_rounded),
                  label: Text(l.english),
                ),
                ButtonSegment(
                  value: 'ne',
                  icon: const Icon(Icons.translate_rounded),
                  label: Text(l.nepali),
                ),
                ButtonSegment(
                  value: 'hi',
                  icon: const Icon(Icons.translate_rounded),
                  label: Text(l.hindi),
                ),
              ],
              selected: {controller.locale.languageCode},
              onSelectionChanged: controller.isBusy
                  ? null
                  : (value) {
                      controller.setLocale(Locale(value.first));
                    },
            ),
          ),
          const SizedBox(height: 16),
          _SettingsSection(
            title: l.permissions,
            icon: Icons.admin_panel_settings_outlined,
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: const Icon(
                    Icons.notifications_active_outlined,
                  ),
                  title: Text(l.notifications),
                  subtitle: Text(l.notificationDescription),
                  value: controller.notificationsEnabled,
                  onChanged: controller.isBusy
                      ? null
                      : (value) {
                          _changeNotifications(
                            context,
                            value,
                          );
                        },
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.do_not_disturb_on_outlined,
                  ),
                  title: Text(l.dndAccess),
                  subtitle: Text(
                    androidModeSupported
                        ? l.dndExplanation
                        : l.platformLimitation,
                  ),
                  trailing: androidModeSupported
                      ? FilledButton.tonalIcon(
                          onPressed: controller.isBusy
                              ? null
                              : () {
                                  _requestDnd(context);
                                },
                          icon: const Icon(Icons.settings_outlined),
                          label: Text(l.openSettings),
                        )
                      : const Icon(Icons.info_outline_rounded),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _SettingsSection(
            title: l.account,
            icon: Icons.person_outline_rounded,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 24,
                child: Text(
                  _initials(controller.displayName),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              title: Text(controller.displayName),
              subtitle: controller.accountEmail.isEmpty
                  ? null
                  : Text(controller.accountEmail),
              trailing: OutlinedButton.icon(
                onPressed: controller.isBusy
                    ? null
                    : () {
                        _signOut(context);
                      },
                icon: const Icon(Icons.logout_rounded),
                label: Text(l.signOut),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _SettingsSection(
            title: l.privacyTitle,
            icon: Icons.shield_outlined,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.lock_outline_rounded),
              title: Text(l.offlineOnly),
              subtitle: Text(l.privacyDescription),
            ),
          ),
        ],
      ),
    );
  }

  static String _initials(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();

    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }

    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  Future<void> _signOut(BuildContext context) async {
    final l = AppLocalizations.of(context);

    final confirmed = await showDialog<bool>(
          context: context,
          builder: (dialogContext) {
            return AlertDialog(
              title: Text(l.signOut),
              content: Text(l.signOutConfirmation),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext, false);
                  },
                  child: Text(l.cancel),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.pop(dialogContext, true);
                  },
                  child: Text(l.signOut),
                ),
              ],
            );
          },
        ) ??
        false;

    if (confirmed && context.mounted) {
      await context.read<AppController>().signOut();
    }
  }

  Future<void> _changeNotifications(
    BuildContext context,
    bool enabled,
  ) async {
    final l = AppLocalizations.of(context);

    if (enabled) {
      final accepted = await _explainPermission(
        context,
        l.notificationPermissionExplanation,
      );

      if (!accepted || !context.mounted) {
        return;
      }
    }

    final success =
        await context.read<AppController>().setNotifications(enabled);

    if (!success && enabled && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l.permissionDenied),
        ),
      );
    }
  }

  Future<void> _requestDnd(BuildContext context) async {
    final l = AppLocalizations.of(context);

    final accepted = await _explainPermission(
      context,
      l.dndPermissionExplanation,
    );

    if (accepted && context.mounted) {
      await context
          .read<AppController>()
          .platformModeService
          .openPolicySettings();
    }
  }

  Future<bool> _explainPermission(
    BuildContext context,
    String explanation,
  ) async {
    final l = AppLocalizations.of(context);

    return await showDialog<bool>(
          context: context,
          builder: (dialogContext) {
            return AlertDialog(
              title: Text(l.permissionTitle),
              content: Text(explanation),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext, false);
                  },
                  child: Text(l.cancel),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.pop(dialogContext, true);
                  },
                  child: Text(l.continueLabel),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 4,
            bottom: 8,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: scheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ],
    );
  }
}
