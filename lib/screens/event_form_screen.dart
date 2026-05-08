import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../app_theme.dart';
import '../data/events_repository.dart';
import '../models/event.dart';
import '../providers/locale_provider.dart';
import '../services/notification_service.dart';

class EventFormScreen extends ConsumerStatefulWidget {
  const EventFormScreen({super.key, this.eventId});
  final int? eventId;

  @override
  ConsumerState<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends ConsumerState<EventFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();

  EventType _type = EventType.pregnancy;
  DisplayUnit _unit = DisplayUnit.days;
  DateTime _targetDate = DateTime.now().add(const Duration(days: 90));
  TimeOfDay? _notifTime;
  bool _loading = false;
  Event? _existing;

  @override
  void initState() {
    super.initState();
    if (widget.eventId != null) _loadEvent();
  }

  Future<void> _loadEvent() async {
    setState(() => _loading = true);
    final repo = ref.read(eventsRepositoryProvider);
    final event = await repo.getById(widget.eventId!);
    if (event != null && mounted) {
      setState(() {
        _existing = event;
        _nameCtrl.text = event.name;
        _type = event.type;
        _unit = event.displayUnit;
        _targetDate = event.targetDate;
        if (event.notificationTime != null) {
          final parts = event.notificationTime!.split(':');
          _notifTime = TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
        }
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _targetDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: AppTheme.pink),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _targetDate = picked);
  }

  Future<void> _pickNotifTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _notifTime ?? const TimeOfDay(hour: 9, minute: 0),
    );
    if (picked != null) setState(() => _notifTime = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final notifStr = _notifTime != null
        ? '${_notifTime!.hour.toString().padLeft(2, '0')}:${_notifTime!.minute.toString().padLeft(2, '0')}'
        : null;

    final repo = ref.read(eventsRepositoryProvider);

    if (_existing != null) {
      final updated = _existing!.copyWith(
        name: _nameCtrl.text.trim(),
        targetDate: _targetDate,
        type: _type,
        displayUnit: _unit,
        notificationTime: notifStr,
      );
      await repo.update(updated);
      if (notifStr != null) await NotificationService.instance.scheduleEventNotification(updated);
    } else {
      final event = Event(
        name: _nameCtrl.text.trim(),
        targetDate: _targetDate,
        type: _type,
        displayUnit: _unit,
        createdAt: DateTime.now(),
        notificationTime: notifStr,
      );
      final id = await repo.create(event);
      if (notifStr != null) {
        await NotificationService.instance.scheduleEventNotification(event.copyWith(id: id));
      }
    }

    ref.invalidate(eventsProvider);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = ref.watch(l10nProvider);
    final isEdit = widget.eventId != null;

    final typeLabels = {
      EventType.pregnancy: l.typePregnancy,
      EventType.birthday: l.typeBirthday,
      EventType.anniversary: l.typeAnniversary,
      EventType.travel: l.typeTravel,
      EventType.custom: l.typeCustom,
    };

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? l.editEvent : l.newEvent)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  TextFormField(
                    controller: _nameCtrl,
                    decoration: InputDecoration(
                      labelText: l.eventName,
                      prefixIcon: const Icon(Icons.event),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    validator: (v) => v == null || v.trim().isEmpty ? l.enterName : null,
                  ),
                  const SizedBox(height: 20),
                  Text(l.eventType, style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: EventType.values.map((t) {
                      return ChoiceChip(
                        label: Text(typeLabels[t]!),
                        selected: _type == t,
                        selectedColor: AppTheme.pinkLight,
                        onSelected: (_) {
                          setState(() {
                            _type = t;
                            if (t == EventType.pregnancy) _unit = DisplayUnit.weeks;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Text(l.displayIn, style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 8),
                  SegmentedButton<DisplayUnit>(
                    segments: [
                      ButtonSegment(value: DisplayUnit.days, label: Text(l.unitDays)),
                      ButtonSegment(value: DisplayUnit.weeks, label: Text(l.unitWeeks)),
                      ButtonSegment(value: DisplayUnit.months, label: Text(l.unitMonths)),
                    ],
                    selected: {_unit},
                    onSelectionChanged: (s) => setState(() => _unit = s.first),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith((states) =>
                          states.contains(WidgetState.selected) ? AppTheme.pinkLight : null),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.calendar_today, color: AppTheme.pink),
                    title: Text(l.targetDate),
                    subtitle: Text(DateFormat(l.dateFormat, l.locale).format(_targetDate)),
                    onTap: _pickDate,
                    trailing: const Icon(Icons.chevron_right),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.black12),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.notifications, color: AppTheme.pink),
                    title: Text(l.dailyNotif),
                    subtitle: Text(_notifTime != null
                        ? '${l.atTime} ${_notifTime!.format(context)}'
                        : l.noNotification),
                    onTap: _pickNotifTime,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_notifTime != null)
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => setState(() => _notifTime = null),
                          ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.black12),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                    child: Text(
                      isEdit ? l.saveChanges : l.createEvent,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
