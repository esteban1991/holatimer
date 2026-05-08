import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../app_theme.dart';
import '../data/events_repository.dart';
import '../data/pregnancy_data.dart';
import '../models/event.dart';
import '../providers/locale_provider.dart';
import '../widgets/countdown_display.dart';
import '../widgets/pregnancy_animation.dart';
import '../widgets/week_info_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = ref.watch(l10nProvider);
    final eventsAsync = ref.watch(eventsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HolaTimer 🌸', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () => context.push('/events'),
            tooltip: l.allEvents,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
            tooltip: l.settings,
          ),
        ],
      ),
      body: eventsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (events) {
          if (events.isEmpty) return _EmptyState(l: l);
          return _HomeContent(event: events.first);
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

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.l});
  final dynamic l;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🌸', style: TextStyle(fontSize: 72)),
          const SizedBox(height: 16),
          Text(
            l.createFirstEvent,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppTheme.pinkDark,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            l.createFirstEventSub,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    final isPregnancy = event.type == EventType.pregnancy;
    int? currentWeek;
    WeekInfo? weekInfo;

    if (isPregnancy) {
      currentWeek = getCurrentPregnancyWeek(event.targetDate);
      weekInfo = getWeekInfo(currentWeek);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          Text(
            event.name,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppTheme.pinkDark,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          if (isPregnancy && weekInfo != null) ...[
            PregnancyAnimation(weekInfo: weekInfo, week: currentWeek!),
            const SizedBox(height: 24),
          ] else ...[
            _GenericAnimation(event: event),
            const SizedBox(height: 24),
          ],
          CountdownDisplay(event: event),
          const SizedBox(height: 20),
          if (isPregnancy && weekInfo != null) WeekInfoCard(weekInfo: weekInfo, week: currentWeek!),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _GenericAnimation extends StatelessWidget {
  const _GenericAnimation({required this.event});
  final Event event;

  String get _emoji => switch (event.type) {
    EventType.birthday => '🎂',
    EventType.anniversary => '💑',
    EventType.travel => '✈️',
    _ => '⭐',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: AppTheme.pink.withValues(alpha: 0.3), blurRadius: 20, spreadRadius: 5),
        ],
      ),
      child: Center(child: Text(_emoji, style: const TextStyle(fontSize: 72))),
    );
  }
}
