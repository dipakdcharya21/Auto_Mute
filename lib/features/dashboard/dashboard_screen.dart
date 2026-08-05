import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../app/app_controller.dart';
import '../../domain/models/meeting_schedule.dart';
import '../../l10n/app_localizations.dart';
import '../schedules/schedules_screen.dart';
import '../settings/settings_screen.dart';
import '../world_clock/world_clock_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required this.controller,
    required this.active,
  });

  final AppController controller;
  final bool active;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Timer? _clockTimer;
  DateTime _now = DateTime.now();

  AppController get controller => widget.controller;

  @override
  void initState() {
    super.initState();

    _clockTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!mounted) {
          return;
        }

        setState(() {
          _now = DateTime.now();
        });
      },
    );
  }

  @override
  void dispose() {
    _clockTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final activeSchedule = controller.activeSchedule;
    final nextMeetingStart = controller.nextMeetingStart;

    final enabledSchedules =
        controller.schedules.where((schedule) => schedule.enabled).length;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth >= 900 ? 32.0 : 18.0;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1200,
                ),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    20,
                    horizontalPadding,
                    32,
                  ),
                  children: [
                    _DashboardHeader(
                      title: l.dashboard,
                      date: DateFormat.yMMMMEEEEd(
                        l.localeName,
                      ).format(_now),
                      time: DateFormat.jm(
                        l.localeName,
                      ).format(_now),
                    ),
                    const SizedBox(height: 18),
                    _StatusCard(
                      activeSchedule: activeSchedule,
                      fallbackActive: widget.active,
                    ),
                    const SizedBox(height: 18),
                    if (nextMeetingStart != null)
                      _NextMeetingCard(
                        title: l.nextMeeting,
                        meetingTime: DateFormat.yMMMd(
                          l.localeName,
                        ).add_jm().format(nextMeetingStart),
                        countdown: _countdownText(
                          nextMeetingStart,
                        ),
                      )
                    else
                      _NoUpcomingMeetingCard(
                        title: l.nextMeeting,
                        message: l.noUpcomingMeetings,
                      ),
                    const SizedBox(height: 22),
                    Text(
                      l.quickActions,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    LayoutBuilder(
                      builder: (context, actionConstraints) {
                        final columns = actionConstraints.maxWidth >= 800
                            ? 3
                            : actionConstraints.maxWidth >= 520
                                ? 2
                                : 1;

                        return GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: columns,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: columns == 1 ? 3.4 : 2.2,
                          children: [
                            _QuickActionCard(
                              icon: Icons.calendar_month_rounded,
                              title: l.schedules,
                              subtitle: l.manageSchedules,
                              color: scheme.primary,
                              onTap: () {
                                _openPage(
                                  context,
                                  const SchedulesScreen(),
                                );
                              },
                            ),
                            _QuickActionCard(
                              icon: Icons.public_rounded,
                              title: l.worldClock,
                              subtitle: l.fiveCities,
                              color: scheme.tertiary,
                              onTap: () {
                                _openPage(
                                  context,
                                  const WorldClockScreen(),
                                );
                              },
                            ),
                            _QuickActionCard(
                              icon: Icons.settings_rounded,
                              title: l.settings,
                              subtitle: l.permissionsAndLanguage,
                              color: scheme.secondary,
                              onTap: () {
                                _openPage(
                                  context,
                                  const SettingsScreen(),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 22),
                    Text(
                      l.currentStatus,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    LayoutBuilder(
                      builder: (context, cardConstraints) {
                        final columns = cardConstraints.maxWidth >= 900
                            ? 4
                            : cardConstraints.maxWidth >= 560
                                ? 2
                                : 1;

                        final cards = [
                          _StatisticCard(
                            icon: Icons.calendar_month_rounded,
                            title: l.schedules,
                            value: controller.schedules.length.toString(),
                            subtitle: l.scheduleCount(
                              controller.schedules.length,
                            ),
                            iconColor: scheme.primary,
                            onTap: () {
                              _openPage(
                                context,
                                const SchedulesScreen(),
                              );
                            },
                          ),
                          _StatisticCard(
                            icon: Icons.check_circle_outline_rounded,
                            title: l.active,
                            value: enabledSchedules.toString(),
                            subtitle: l.enabled,
                            iconColor: scheme.tertiary,
                            onTap: () {
                              _openPage(
                                context,
                                const SchedulesScreen(),
                              );
                            },
                          ),
                          _StatisticCard(
                            icon: Icons.notifications_active_outlined,
                            title: l.notifications,
                            value: controller.notificationsEnabled
                                ? l.active
                                : l.inactive,
                            subtitle: l.notificationDescription,
                            iconColor: controller.notificationsEnabled
                                ? scheme.primary
                                : scheme.outline,
                            onTap: () {
                              _openPage(
                                context,
                                const SettingsScreen(),
                              );
                            },
                          ),
                          _StatisticCard(
                            icon: Icons.language_rounded,
                            title: l.language,
                            value: _languageName(
                              l,
                              controller.locale.languageCode,
                            ),
                            subtitle:
                                controller.locale.languageCode.toUpperCase(),
                            iconColor: scheme.secondary,
                            onTap: () {
                              _openPage(
                                context,
                                const SettingsScreen(),
                              );
                            },
                          ),
                        ];

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cards.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: columns,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            mainAxisExtent: 155,
                          ),
                          itemBuilder: (context, index) {
                            return cards[index];
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 18),
                    _PrivacyCard(
                      title: l.privacyTitle,
                      description: l.privacyDescription,
                      storageLabel: l.offlineOnly,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _openPage(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => page,
      ),
    );
  }

  String _countdownText(DateTime target) {
    final difference = target.difference(_now);

    if (difference.isNegative) {
      return '';
    }

    final days = difference.inDays;
    final hours = difference.inHours.remainder(24);
    final minutes = difference.inMinutes.remainder(60);

    if (days > 0) {
      return '${days}d ${hours}h ${minutes}m';
    }

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }

    if (minutes > 0) {
      return '${minutes}m';
    }

    return '< 1m';
  }

  String _languageName(
    AppLocalizations l,
    String languageCode,
  ) {
    switch (languageCode) {
      case 'ne':
        return l.nepali;
      case 'hi':
        return l.hindi;
      default:
        return l.english;
    }
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({
    required this.title,
    required this.date,
    required this.time,
  });

  final String title;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.primary,
            scheme.tertiary,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.20),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 520;

          final titleSection = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                date,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.88),
                ),
              ),
            ],
          );

          final clock = Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.24),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.access_time_rounded,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  time,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          );

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleSection,
                const SizedBox(height: 18),
                clock,
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: titleSection),
              const SizedBox(width: 20),
              clock,
            ],
          );
        },
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_ios_rounded, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.activeSchedule,
    required this.fallbackActive,
  });

  final MeetingSchedule? activeSchedule;
  final bool fallbackActive;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final isActive = activeSchedule != null || fallbackActive;
    final mode = activeSchedule?.mode;

    final IconData icon;

    if (mode == MeetingMode.silent) {
      icon = Icons.volume_off_rounded;
    } else if (mode == MeetingMode.vibration) {
      icon = Icons.vibration_rounded;
    } else {
      icon =
          isActive ? Icons.notifications_off_rounded : Icons.volume_up_rounded;
    }

    final statusTitle =
        activeSchedule?.title ?? (isActive ? l.active : l.noActiveMeeting);

    final statusSubtitle = mode == MeetingMode.silent
        ? l.silentMode
        : mode == MeetingMode.vibration
            ? l.vibrationMode
            : l.normalMode;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isActive
                    ? scheme.primaryContainer
                    : scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(19),
              ),
              child: Icon(
                icon,
                size: 31,
                color: isActive
                    ? scheme.onPrimaryContainer
                    : scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.currentStatus,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    statusTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(statusSubtitle),
                ],
              ),
            ),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? Colors.green : scheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextMeetingCard extends StatelessWidget {
  const _NextMeetingCard({
    required this.title,
    required this.meetingTime,
    required this.countdown,
  });

  final String title;
  final String meetingTime;
  final String countdown;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              scheme.secondaryContainer,
              scheme.tertiaryContainer,
            ],
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: scheme.surface.withValues(alpha: 0.80),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                Icons.upcoming_rounded,
                color: scheme.primary,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(meetingTime),
                ],
              ),
            ),
            if (countdown.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: scheme.surface.withValues(alpha: 0.80),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  countdown,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NoUpcomingMeetingCard extends StatelessWidget {
  const _NoUpcomingMeetingCard({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                Icons.event_available_rounded,
                color: scheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(message),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatisticCard extends StatelessWidget {
  const _StatisticCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              const Spacer(),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: scheme.onSurfaceVariant,
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrivacyCard extends StatelessWidget {
  const _PrivacyCard({
    required this.title,
    required this.description,
    required this.storageLabel,
  });

  final String title;
  final String description;
  final String storageLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.shield_outlined,
                color: scheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(description),
                  const SizedBox(height: 8),
                  Text(
                    storageLabel,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: scheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
