import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_controller.dart';
import '../../domain/models/meeting_schedule.dart';
import '../../l10n/app_localizations.dart';

class ScheduleEditorScreen extends StatefulWidget {
  const ScheduleEditorScreen({this.existing, super.key});
  final MeetingSchedule? existing;

  @override
  State<ScheduleEditorScreen> createState() => _ScheduleEditorScreenState();
}

class _ScheduleEditorScreenState extends State<ScheduleEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late TimeOfDay _start;
  late TimeOfDay _end;
  late Set<int> _days;
  late MeetingMode _mode;
  late int _reminder;
  late bool _enabled;

  @override
  void initState() {
    super.initState();
    final schedule = widget.existing;
    _titleController = TextEditingController(text: schedule?.title ?? '');
    _start = _toTime(schedule?.startMinutes ?? 540);
    _end = _toTime(schedule?.endMinutes ?? 600);
    _days = {
      ...?schedule?.weekdays,
      if (schedule == null) ...[1, 2, 3, 4, 5]
    };
    _mode = schedule?.mode ?? MeetingMode.silent;
    _reminder = schedule?.reminderMinutes ?? 10;
    _enabled = schedule?.enabled ?? true;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final busy = context.watch<AppController>().isBusy;
    return Scaffold(
      appBar: AppBar(
          title:
              Text(widget.existing == null ? l.addSchedule : l.editSchedule)),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _titleController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        labelText: l.title,
                        prefixIcon: const Icon(Icons.title_rounded)),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? l.requiredField
                        : null,
                  ),
                  const SizedBox(height: 16),
                  _SectionTitle(l.time),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.schedule_rounded),
                          title: Text(l.startTime),
                          trailing: Text(_start.format(context),
                              style: Theme.of(context).textTheme.titleMedium),
                          onTap: () => _pickTime(isStart: true),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.schedule_outlined),
                          title: Text(l.endTime),
                          trailing: Text(_end.format(context),
                              style: Theme.of(context).textTheme.titleMedium),
                          onTap: () => _pickTime(isStart: false),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _SectionTitle(l.days),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(7, (index) {
                      final day = index + 1;
                      return FilterChip(
                        label: Text(
                          l.weekdayShort(
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
                        ),
                        selected: _days.contains(day),
                        onSelected: (selected) => setState(() =>
                            selected ? _days.add(day) : _days.remove(day)),
                      );
                    }),
                  ),
                  if (_days.isEmpty) ...[
                    const SizedBox(height: 8),
                    Text(l.selectOneDay,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error)),
                  ],
                  const SizedBox(height: 20),
                  _SectionTitle(l.options),
                  DropdownButtonFormField<MeetingMode>(
                    initialValue: _mode,
                    decoration: InputDecoration(
                        labelText: l.mode,
                        prefixIcon:
                            const Icon(Icons.notifications_off_outlined)),
                    items: [
                      DropdownMenuItem(
                          value: MeetingMode.silent, child: Text(l.silentMode)),
                      DropdownMenuItem(
                          value: MeetingMode.vibration,
                          child: Text(l.vibrationMode)),
                    ],
                    onChanged: (value) =>
                        setState(() => _mode = value ?? _mode),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    initialValue: _reminder,
                    decoration: InputDecoration(
                        labelText: l.reminder,
                        prefixIcon: const Icon(Icons.alarm_rounded)),
                    items: [0, 5, 10, 15, 30, 60]
                        .map((minutes) => DropdownMenuItem(
                            value: minutes,
                            child: Text(l.minutesBefore(minutes))))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _reminder = value ?? _reminder),
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l.enabled),
                    subtitle: Text(l.enabledDescription),
                    value: _enabled,
                    onChanged: (value) => setState(() => _enabled = value),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: busy ? null : _save,
                    icon: busy
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.save_rounded),
                    label: Text(l.save),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickTime({required bool isStart}) async {
    final selected = await showTimePicker(
        context: context, initialTime: isStart ? _start : _end);
    if (selected == null) return;
    setState(() => isStart ? _start = selected : _end = selected);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate() || _days.isEmpty) {
      setState(() {});
      return;
    }
    final schedule = MeetingSchedule(
      id: widget.existing?.id ?? '',
      title: _titleController.text.trim(),
      startMinutes: _start.hour * 60 + _start.minute,
      endMinutes: _end.hour * 60 + _end.minute,
      weekdays: _days.toList()..sort(),
      mode: _mode,
      enabled: _enabled,
      reminderMinutes: _reminder,
    );
    await context.read<AppController>().saveSchedule(schedule);
    if (mounted) Navigator.pop(context);
  }

  static TimeOfDay _toTime(int minutes) =>
      TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600)),
      );
}
