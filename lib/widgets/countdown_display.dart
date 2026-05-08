import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app_theme.dart';
import '../models/event.dart';
import '../providers/locale_provider.dart';
// Colors adapt to event type via AppTheme.colorsFor()

class CountdownDisplay extends ConsumerWidget {
  const CountdownDisplay({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = ref.watch(l10nProvider);
    final days = event.daysRemaining;
    final colors = AppTheme.colorsFor(event.type);

    if (days < 0) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text('🎉', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 8),
              Text(
                l.arrived(event.name),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: colors.dark,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                l.daysAgo(-days),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    if (days == 0) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text('🎊', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 8),
              Text(
                l.todayIsTheDay,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final (value, unit) = switch (event.displayUnit) {
      DisplayUnit.days => ('${event.daysRemaining}', l.dayUnit(event.daysRemaining)),
      DisplayUnit.weeks => ('${event.weeksRemaining}', l.weekUnit(event.weeksRemaining)),
      DisplayUnit.months => ('${event.monthsRemaining}', l.monthUnit(event.monthsRemaining)),
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 32),
        child: Column(
          children: [
            Text(
              l.daysRemaining,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
            Text(
              unit,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: colors.dark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
