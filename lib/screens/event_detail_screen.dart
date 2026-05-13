import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../app_theme.dart';
import '../data/events_repository.dart';
import '../data/pregnancy_data.dart';
import '../l10n/app_l10n.dart';
import '../models/event.dart';
import '../providers/locale_provider.dart';
import '../services/moon_phase_service.dart';
import '../widgets/countdown_display.dart';
import '../widgets/zodiac_card.dart';
import '../widgets/photo_gallery.dart';
import '../widgets/pregnancy_animation.dart';
import '../widgets/week_info_card.dart';

final _eventDetailProvider = FutureProvider.family<Event?, int>((ref, id) async {
  final repo = ref.watch(eventsRepositoryProvider);
  return repo.getById(id);
});

class EventDetailScreen extends ConsumerWidget {
  const EventDetailScreen({super.key, required this.eventId});
  final int eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = ref.watch(l10nProvider);
    final eventAsync = ref.watch(_eventDetailProvider(eventId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l.detail),
        actions: [
          eventAsync.whenData((event) => event == null
            ? const SizedBox.shrink()
            : IconButton(
                icon: const Icon(Icons.share),
                onPressed: () => _showShareSheet(context, ref, event),
              )).value ?? const SizedBox.shrink(),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await context.push('/events/$eventId/edit');
              ref.invalidate(_eventDetailProvider(eventId));
            },
          ),
        ],
      ),
      body: eventAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (event) {
          if (event == null) return Center(child: Text(l.eventNotFound));
          return _DetailContent(event: event);
        },
      ),
    );
  }

  void _showShareSheet(BuildContext context, WidgetRef ref, Event event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _ShareSheet(event: event),
    );
  }
}

class _DetailContent extends ConsumerWidget {
  const _DetailContent({required this.event});
  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = ref.watch(l10nProvider);
    final colors = AppTheme.colorsFor(event.type);
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
          if (event.daysRemaining < 0 &&
              (event.type == EventType.pregnancy ||
               event.type == EventType.birthday ||
               event.type == EventType.anniversary))
            _ArrivalActions(event: event),
          if (event.daysRemaining < 0 &&
              (event.type == EventType.pregnancy ||
               event.type == EventType.birthday ||
               event.type == EventType.anniversary))
            const SizedBox(height: 16),
          Text(
            event.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: colors.dark,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '${l.dateLabel}: ${DateFormat(l.dateFormat, l.locale).format(event.targetDate)}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          if (isPregnancy && weekInfo != null) ...[
            PregnancyAnimation(weekInfo: weekInfo, week: currentWeek!),
            const SizedBox(height: 24),
          ],
          CountdownDisplay(event: event),
          const SizedBox(height: 20),
          if (isPregnancy && weekInfo != null)
            WeekInfoCard(weekInfo: weekInfo, week: currentWeek!),
          const SizedBox(height: 20),
          _MoonPhaseCard(event: event),
          const SizedBox(height: 20),
          if (event.type == EventType.pregnancy || event.type == EventType.birthday) ...[
            ZodiacCard(
              date: event.targetDate,
              title: event.type == EventType.pregnancy ? l.zodiacTitle : l.zodiacTitleBirthday,
              showChinese: event.type == EventType.pregnancy,
            ),
            const SizedBox(height: 20),
          ],
          if (event.id != null) PhotoGallery(eventId: event.id!),
        ],
      ),
    );
  }
}

// ─── Share sheet ──────────────────────────────────────────────────────────────

class _ShareSheet extends ConsumerStatefulWidget {
  const _ShareSheet({required this.event});
  final Event event;

  @override
  ConsumerState<_ShareSheet> createState() => _ShareSheetState();
}

class _ShareSheetState extends ConsumerState<_ShareSheet> {
  final _cardKey = GlobalKey();
  bool _sharing = false;

  @override
  Widget build(BuildContext context) {
    final l = ref.watch(l10nProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          RepaintBoundary(
            key: _cardKey,
            child: _ShareCard(event: widget.event, l: l),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _sharing ? null : () => _share(l),
            icon: _sharing
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Icon(Icons.share),
            label: Text(l.shareCaption.contains('#')
                ? 'Share  #HolaTimer'
                : 'Share'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: AppTheme.colorsFor(widget.event.type).primary,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _share(AppL10n l) async {
    setState(() => _sharing = true);
    try {
      final boundary = _cardKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;
      final bytes = byteData.buffer.asUint8List();
      final dir = await getTemporaryDirectory();
      final path = '${dir.path}/holatimer_share.png';
      await File(path).writeAsBytes(bytes);
      await Share.shareXFiles([XFile(path)], text: l.shareCaption);
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }
}

// ─── Arrival actions card ────────────────────────────────────────────────────

class _ArrivalActions extends ConsumerWidget {
  const _ArrivalActions({required this.event});
  final Event event;

  DateTime _nextOccurrence() {
    final now = DateTime.now();
    var next = DateTime(now.year, event.targetDate.month, event.targetDate.day);
    while (!next.isAfter(now)) {
      next = DateTime(next.year + 1, next.month, next.day);
    }
    return next;
  }

  Future<void> _renew(BuildContext context, WidgetRef ref) async {
    final repo = ref.read(eventsRepositoryProvider);
    final next = _nextOccurrence();
    await repo.update(event.copyWith(targetDate: next));
    ref.invalidate(eventsProvider);
    ref.invalidate(_eventDetailProvider(event.id!));
  }

  Future<void> _createBirthday(BuildContext context, WidgetRef ref, AppL10n l) async {
    final next = _nextOccurrence();
    final repo = ref.read(eventsRepositoryProvider);
    final birthday = Event(
      name: event.name,
      targetDate: next,
      type: EventType.birthday,
      displayUnit: DisplayUnit.days,
      createdAt: DateTime.now(),
      notificationTime: event.notificationTime,
    );
    await repo.create(birthday);
    ref.invalidate(eventsProvider);
    if (context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = ref.watch(l10nProvider);
    final colors = AppTheme.colorsFor(event.type);
    final next = _nextOccurrence();
    final isPregnancy = event.type == EventType.pregnancy;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary.withValues(alpha: 0.12), colors.light.withValues(alpha: 0.08)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(isPregnancy ? '🎉' : '✅', style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isPregnancy ? l.arrived(event.name) : l.arrived(event.name),
                  style: TextStyle(fontWeight: FontWeight.bold, color: colors.dark, fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (isPregnancy) ...[
            _ActionButton(
              label: l.updateBirthDate,
              icon: Icons.edit_calendar,
              colors: colors,
              onTap: () => context.push('/events/${event.id}/edit'),
            ),
            const SizedBox(height: 8),
            _ActionButton(
              label: l.createBirthdayEvent,
              icon: Icons.cake,
              colors: colors,
              onTap: () => _createBirthday(context, ref, l),
            ),
          ] else ...[
            _ActionButton(
              label: l.renewForYear(next.year),
              icon: Icons.refresh,
              colors: colors,
              onTap: () => _renew(context, ref),
            ),
          ],
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.label, required this.icon, required this.colors, required this.onTap});
  final String label;
  final IconData icon;
  final dynamic colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.dark,
          side: BorderSide(color: colors.primary.withValues(alpha: 0.5)),
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }
}

// ─── Moon phase card ─────────────────────────────────────────────────────────

class _MoonPhaseCard extends ConsumerWidget {
  const _MoonPhaseCard({required this.event});
  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = ref.watch(l10nProvider);
    final todayPhase = MoonPhaseService.getPhase(DateTime.now());
    final isPregnancy = event.type == EventType.pregnancy;
    final birthPhase = isPregnancy ? MoonPhaseService.getPhase(event.targetDate) : null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MoonRow(label: l.moonToday, phase: todayPhase, locale: l.locale),
            if (birthPhase != null) ...[
              const Divider(height: 24),
              _MoonRow(label: l.moonBirth, phase: birthPhase, locale: l.locale),
            ],
          ],
        ),
      ),
    );
  }
}

class _MoonRow extends StatelessWidget {
  const _MoonRow({required this.label, required this.phase, required this.locale});
  final String label;
  final MoonPhase phase;
  final String locale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(phase.emoji, style: const TextStyle(fontSize: 40)),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
            Text(
              phase.nameFor(locale),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Share card ───────────────────────────────────────────────────────────────

class _ShareCard extends StatelessWidget {
  const _ShareCard({required this.event, required this.l});
  final Event event;
  final AppL10n l;

  String get _emoji => switch (event.type) {
    EventType.pregnancy => '🤰',
    EventType.birthday => '🎂',
    EventType.anniversary => '💑',
    EventType.travel => '✈️',
    EventType.custom => '⭐',
  };

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colorsFor(event.type);
    final days = event.daysRemaining;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors.primary, colors.dark],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_emoji, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 8),
          Text(
            event.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            '$days',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 72,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),
          Text(
            l.dayUnit(days),
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 14),
          const Text(
            '⏳ HolaTimer  •  #HolaTimer',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
