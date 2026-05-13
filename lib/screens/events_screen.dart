import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../app_theme.dart';
import '../data/events_repository.dart';
import '../l10n/app_l10n.dart';
import '../models/event.dart';
import '../providers/locale_provider.dart';

class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = ref.watch(l10nProvider);
    final eventsAsync = ref.watch(eventsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l.myEvents)),
      body: eventsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (events) {
          if (events.isEmpty) {
            return Center(child: Text(l.noEventsYet, textAlign: TextAlign.center));
          }
          final upcoming = events.where((e) => e.daysRemaining >= 0).toList();
          // Most recently passed first (least negative daysRemaining = closest to today)
          final past = events.where((e) => e.daysRemaining < 0).toList().reversed.toList();
          return ListView(
            padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 80),
            children: [
              if (upcoming.isNotEmpty) ...[
                if (past.isNotEmpty) _SectionHeader(l.upcomingEvents),
                ...upcoming.map((e) => _EventTile(event: e, ref: ref, l: l)),
              ],
              if (past.isNotEmpty) ...[
                _SectionHeader(l.pastEvents),
                ...past.map((e) => _EventTile(event: e, ref: ref, l: l, isPast: true)),
              ],
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/events/new'),
        icon: const Icon(Icons.add),
        label: Text(l.newEvent),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 6),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Colors.grey[500],
          letterSpacing: 1.2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  const _EventTile({required this.event, required this.ref, required this.l, this.isPast = false});
  final Event event;
  final WidgetRef ref;
  final AppL10n l;
  final bool isPast;

  String get _typeEmoji => switch (event.type) {
    EventType.pregnancy => '🤰',
    EventType.birthday => '🎂',
    EventType.anniversary => '💑',
    EventType.travel => '✈️',
    EventType.custom => '⭐',
  };

  @override
  Widget build(BuildContext context) {
    final days = event.daysRemaining;
    final dateStr = DateFormat(l.dateFormat, l.locale).format(event.targetDate);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Text(_typeEmoji, style: const TextStyle(fontSize: 32)),
        title: Text(event.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(dateStr),
        trailing: isPast
          ? Icon(Icons.check_circle_outline, color: Colors.grey[400])
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${days.abs()}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.colorsFor(event.type).primary,
                  ),
                ),
                Text(
                  l.dayUnit(days.abs()),
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
              ],
            ),
        onTap: () => context.push('/events/${event.id}'),
        onLongPress: () => _showOptions(context),
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text(l.edit),
              onTap: () {
                Navigator.pop(context);
                context.push('/events/${event.id}/edit');
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: Text(l.delete, style: const TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.pop(context);
                final repo = ref.read(eventsRepositoryProvider);
                await repo.delete(event.id!);
                ref.invalidate(eventsProvider);
              },
            ),
          ],
        ),
      ),
    );
  }
}
