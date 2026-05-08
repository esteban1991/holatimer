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
import '../models/event.dart';
import '../l10n/app_l10n.dart';
import '../providers/locale_provider.dart';
import '../widgets/countdown_display.dart';
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
            onPressed: () => context.push('/events/$eventId/edit'),
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
