import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_controller.dart';
import '../../domain/models/meeting_schedule.dart';
import '../../l10n/app_localizations.dart';
import '../../services/schedule_import_service.dart';
import '../shared/responsive_page.dart';
import 'schedule_editor_screen.dart';

enum _ScheduleFilter {
  all,
  enabled,
  disabled,
  silent,
  vibration,
}

class SchedulesScreen extends StatefulWidget {
  const SchedulesScreen({super.key});

  @override
  State<SchedulesScreen> createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends State<SchedulesScreen> {
  final TextEditingController _searchController = TextEditingController();

  _ScheduleFilter _selectedFilter = _ScheduleFilter.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final controller = context.watch<AppController>();

    final schedules = _filteredSchedules(
      controller.schedules,
    );

    final enabledCount =
        controller.schedules.where((schedule) => schedule.enabled).length;

    final disabledCount = controller.schedules.length - enabledCount;

    return ResponsivePage(
      title: l.schedules,
      actions: [
        IconButton(
          tooltip: l.importJson,
          onPressed: controller.isBusy
              ? null
              : () {
                  _import(context);
                },
          icon: const Icon(Icons.file_upload_outlined),
        ),
      ],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.isBusy
            ? null
            : () {
                _openEditor(context);
              },
        icon: const Icon(Icons.add_rounded),
        label: Text(l.addSchedule),
      ),
      child: controller.schedules.isEmpty
          ? _EmptyState(
              onAdd: () {
                _openEditor(context);
              },
              onImport: () {
                _import(context);
              },
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ScheduleSummary(
                  total: controller.schedules.length,
                  enabled: enabledCount,
                  disabled: disabledCount,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    labelText: l.search,
                    hintText: l.search,
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: _searchController.text.isEmpty
                        ? null
                        : IconButton(
                            tooltip: l.clearData,
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                            },
                            icon: const Icon(Icons.close_rounded),
                          ),
                  ),
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 14),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterChip(
                        label: l.allDays,
                        icon: Icons.view_list_rounded,
                        selected: _selectedFilter == _ScheduleFilter.all,
                        onSelected: () {
                          _selectFilter(_ScheduleFilter.all);
                        },
                      ),
                      _FilterChip(
                        label: l.active,
                        icon: Icons.check_circle_outline_rounded,
                        selected: _selectedFilter == _ScheduleFilter.enabled,
                        onSelected: () {
                          _selectFilter(_ScheduleFilter.enabled);
                        },
                      ),
                      _FilterChip(
                        label: l.inactive,
                        icon: Icons.pause_circle_outline_rounded,
                        selected: _selectedFilter == _ScheduleFilter.disabled,
                        onSelected: () {
                          _selectFilter(_ScheduleFilter.disabled);
                        },
                      ),
                      _FilterChip(
                        label: l.silent,
                        icon: Icons.volume_off_rounded,
                        selected: _selectedFilter == _ScheduleFilter.silent,
                        onSelected: () {
                          _selectFilter(_ScheduleFilter.silent);
                        },
                      ),
                      _FilterChip(
                        label: l.vibration,
                        icon: Icons.vibration_rounded,
                        selected: _selectedFilter == _ScheduleFilter.vibration,
                        onSelected: () {
                          _selectFilter(_ScheduleFilter.vibration);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: schedules.isEmpty
                      ? _NoSearchResults(
                          onClear: () {
                            _searchController.clear();
                            setState(() {
                              _selectedFilter = _ScheduleFilter.all;
                            });
                          },
                        )
                      : LayoutBuilder(
                          builder: (context, constraints) {
                            final columns = constraints.maxWidth >= 1050
                                ? 3
                                : constraints.maxWidth >= 680
                                    ? 2
                                    : 1;

                            if (columns == 1) {
                              return ListView.separated(
                                padding: const EdgeInsets.only(
                                  bottom: 92,
                                ),
                                itemCount: schedules.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  final schedule = schedules[index];

                                  return _ScheduleCard(
                                    schedule: schedule,
                                    onToggle: (value) {
                                      controller.toggleSchedule(
                                        schedule,
                                        value,
                                      );
                                    },
                                    onEdit: () {
                                      _openEditor(context, schedule);
                                    },
                                    onDelete: () {
                                      _confirmDelete(
                                        context,
                                        schedule,
                                      );
                                    },
                                  );
                                },
                              );
                            }

                            return GridView.builder(
                              padding: const EdgeInsets.only(
                                bottom: 92,
                              ),
                              itemCount: schedules.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: columns,
                                crossAxisSpacing: 14,
                                mainAxisSpacing: 14,
                                mainAxisExtent: 225,
                              ),
                              itemBuilder: (context, index) {
                                final schedule = schedules[index];

                                return _ScheduleCard(
                                  schedule: schedule,
                                  onToggle: (value) {
                                    controller.toggleSchedule(
                                      schedule,
                                      value,
                                    );
                                  },
                                  onEdit: () {
                                    _openEditor(context, schedule);
                                  },
                                  onDelete: () {
                                    _confirmDelete(
                                      context,
                                      schedule,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }

  void _selectFilter(_ScheduleFilter filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  List<MeetingSchedule> _filteredSchedules(
    List<MeetingSchedule> schedules,
  ) {
    final search = _searchController.text.trim().toLowerCase();

    final filtered = schedules.where((schedule) {
      final matchesSearch =
          search.isEmpty || schedule.title.toLowerCase().contains(search);

      if (!matchesSearch) {
        return false;
      }

      return switch (_selectedFilter) {
        _ScheduleFilter.all => true,
        _ScheduleFilter.enabled => schedule.enabled,
        _ScheduleFilter.disabled => !schedule.enabled,
        _ScheduleFilter.silent => schedule.mode == MeetingMode.silent,
        _ScheduleFilter.vibration => schedule.mode == MeetingMode.vibration,
      };
    }).toList();

    filtered.sort((first, second) {
      final enabledComparison = second.enabled == first.enabled
          ? 0
          : second.enabled
              ? 1
              : -1;

      if (enabledComparison != 0) {
        return enabledComparison;
      }

      return first.startMinutes.compareTo(
        second.startMinutes,
      );
    });

    return filtered;
  }

  Future<void> _openEditor(
    BuildContext context, [
    MeetingSchedule? schedule,
  ]) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) {
          return ScheduleEditorScreen(
            existing: schedule,
          );
        },
      ),
    );
  }

  Future<void> _import(BuildContext context) async {
    final l = AppLocalizations.of(context);

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['json'],
        withData: true,
        allowMultiple: false,
      );

      if (result == null || !context.mounted) {
        return;
      }

      final bytes = result.files.single.bytes;

      if (bytes == null) {
        throw const ScheduleImportException(
          ImportErrorCode.emptyFile,
        );
      }

      final schedules = const ScheduleImportService().parse(
        utf8.decode(bytes),
      );

      await context.read<AppController>().replaceSchedules(schedules);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l.importSuccess(schedules.length),
            ),
          ),
        );
      }
    } on ScheduleImportException catch (error) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _localizedImportError(l, error.code),
          ),
        ),
      );
    } on Object {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l.importInvalidJson),
        ),
      );
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    MeetingSchedule schedule,
  ) async {
    final l = AppLocalizations.of(context);

    final confirmed = await showDialog<bool>(
          context: context,
          builder: (dialogContext) {
            return AlertDialog(
              title: Text(l.deleteScheduleTitle),
              content: Text(
                l.deleteScheduleMessage(schedule.title),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext, false);
                  },
                  child: Text(l.cancel),
                ),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(dialogContext, true);
                  },
                  icon: const Icon(Icons.delete_outline_rounded),
                  label: Text(l.delete),
                ),
              ],
            );
          },
        ) ??
        false;

    if (confirmed && context.mounted) {
      await context.read<AppController>().deleteSchedule(schedule.id);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l.scheduleDeleted),
          ),
        );
      }
    }
  }

  String _localizedImportError(
    AppLocalizations l,
    ImportErrorCode code,
  ) {
    return switch (code) {
      ImportErrorCode.invalidJson => l.importInvalidJson,
      ImportErrorCode.invalidRoot => l.importInvalidRoot,
      ImportErrorCode.missingSchedules => l.importMissingSchedules,
      ImportErrorCode.invalidSchedule => l.importInvalidSchedule,
      ImportErrorCode.invalidTitle => l.importInvalidTitle,
      ImportErrorCode.invalidTime => l.importInvalidTime,
      ImportErrorCode.invalidDays => l.importInvalidDays,
      ImportErrorCode.invalidMode => l.importInvalidMode,
      ImportErrorCode.invalidReminder => l.importInvalidReminder,
      ImportErrorCode.emptyFile => l.importEmptyFile,
    };
  }
}

class _ScheduleSummary extends StatelessWidget {
  const _ScheduleSummary({
    required this.total,
    required this.enabled,
    required this.disabled,
  });

  final int total;
  final int enabled;
  final int disabled;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 560;

        final cards = [
          _SummaryItem(
            icon: Icons.calendar_month_rounded,
            label: l.schedules,
            value: total.toString(),
            color: scheme.primary,
          ),
          _SummaryItem(
            icon: Icons.check_circle_outline_rounded,
            label: l.active,
            value: enabled.toString(),
            color: scheme.tertiary,
          ),
          _SummaryItem(
            icon: Icons.pause_circle_outline_rounded,
            label: l.inactive,
            value: disabled.toString(),
            color: scheme.error,
          ),
        ];

        if (compact) {
          return Column(
            children: [
              for (var index = 0; index < cards.length; index++) ...[
                cards[index],
                if (index != cards.length - 1) const SizedBox(height: 10),
              ],
            ],
          );
        }

        return Row(
          children: [
            for (var index = 0; index < cards.length; index++) ...[
              Expanded(child: cards[index]),
              if (index != cards.length - 1) const SizedBox(width: 12),
            ],
          ],
        );
      },
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: color,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: selected,
        onSelected: (_) {
          onSelected();
        },
        avatar: Icon(
          icon,
          size: 18,
        ),
        label: Text(label),
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({
    required this.schedule,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  final MeetingSchedule schedule;
  final ValueChanged<bool> onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final isSilent = schedule.mode == MeetingMode.silent;

    final modeText = isSilent ? l.silentMode : l.vibrationMode;

    final dayText = schedule.weekdays
        .map(
          (day) => l.weekdayShort(
            switch (day) {
              1 => 'mon',
              2 => 'tue',
              3 => 'wed',
              4 => 'thu',
              5 => 'fri',
              6 => 'sat',
              7 => 'sun',
              _ => 'mon',
            },
          ),
        )
        .join(', ');

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onEdit,
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      isSilent
                          ? Icons.volume_off_rounded
                          : Icons.vibration_rounded,
                      color: scheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          schedule.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          modeText,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: scheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: schedule.enabled,
                    onChanged: onToggle,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              _ScheduleDetail(
                icon: Icons.access_time_rounded,
                text:
                    '${_time(schedule.startMinutes)} – ${_time(schedule.endMinutes)}',
              ),
              const SizedBox(height: 8),
              _ScheduleDetail(
                icon: Icons.calendar_today_outlined,
                text: dayText,
              ),
              const SizedBox(height: 12),
              const Divider(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      schedule.enabled ? l.active : l.inactive,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: schedule.enabled
                            ? Colors.green
                            : scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: l.edit,
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  IconButton(
                    tooltip: l.delete,
                    onPressed: onDelete,
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: scheme.error,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _time(int minutes) {
    final hour = minutes ~/ 60;
    final minute = minutes % 60;

    return '${hour.toString().padLeft(2, '0')}:'
        '${minute.toString().padLeft(2, '0')}';
  }
}

class _ScheduleDetail extends StatelessWidget {
  const _ScheduleDetail({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: scheme.onSurfaceVariant,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _NoSearchResults extends StatelessWidget {
  const _NoSearchResults({
    required this.onClear,
  });

  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 68,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              l.noSchedulesTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              l.noSchedules,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: onClear,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(l.refresh),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.onAdd,
    required this.onImport,
  });

  final VoidCallback onAdd;
  final VoidCallback onImport;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 104,
                height: 104,
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.event_busy_rounded,
                  size: 54,
                  color: scheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                l.noSchedulesTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                l.noSchedules,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add_rounded),
                label: Text(l.addSchedule),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: onImport,
                icon: const Icon(Icons.upload_file_rounded),
                label: Text(l.importJson),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
