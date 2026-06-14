import 'dart:ui';
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

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final PageController _pageCtrl;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageCtrl = PageController();
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = ref.watch(l10nProvider);
    final eventsAsync = ref.watch(eventsProvider);

    return eventsAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (allEvents) {
        final events = allEvents.where((e) => e.daysRemaining >= 0).toList();
        final currentType = events.isEmpty ? EventType.pregnancy : events[_currentPage.clamp(0, events.length - 1)].type;
        final gradientColors = AppTheme.gradientFor(currentType);

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: _GlassAppBar(l: l),
          body: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
            ),
            child: events.isEmpty
                ? _EmptyState(l: l)
                : Stack(
                    children: [
                      // Soft blob decoration
                      Positioned(
                        top: -60,
                        right: -60,
                        child: _GlowBlob(color: AppTheme.colorsFor(currentType).primary),
                      ),
                      Positioned(
                        bottom: 100,
                        left: -80,
                        child: _GlowBlob(
                          color: AppTheme.colorsFor(currentType).light,
                          size: 220,
                        ),
                      ),
                      // Page content
                      PageView.builder(
                        controller: _pageCtrl,
                        physics: events.length > 1
                            ? const BouncingScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        itemCount: events.length,
                        onPageChanged: (i) => setState(() => _currentPage = i),
                        itemBuilder: (_, i) => GestureDetector(
                          onTap: () => context.push('/events/${events[i].id}'),
                          child: _HomeContent(event: events[i]),
                        ),
                      ),
                      // Dots indicator
                      if (events.length > 1)
                        Positioned(
                          bottom: MediaQuery.of(context).padding.bottom + 82,
                          left: 0,
                          right: 0,
                          child: _DotsIndicator(
                            count: events.length,
                            current: _currentPage,
                            events: events,
                          ),
                        ),
                    ],
                  ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => context.push('/events/new'),
            icon: const Icon(Icons.add_rounded),
            label: Text(l.newEvent),
            elevation: 4,
          ),
        );
      },
    );
  }
}

// ─── Glass AppBar ─────────────────────────────────────────────────────────────

class _GlassAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const _GlassAppBar({required this.l});
  final dynamic l;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: AppBar(
          backgroundColor: Colors.white.withValues(alpha: 0.55),
          title: const Text('HolaTimer 🌸'),
          actions: [
            IconButton(
              icon: const Icon(Icons.dashboard_rounded),
              onPressed: () => context.push('/events'),
              tooltip: l.allEvents,
            ),
            IconButton(
              icon: const Icon(Icons.tune_rounded),
              onPressed: () => context.push('/settings'),
              tooltip: l.settings,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Empty State ──────────────────────────────────────────────────────────────

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              l.createFirstEventSub,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Home Content ─────────────────────────────────────────────────────────────

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

    final colors = AppTheme.colorsFor(event.type);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            // Event name chip
            GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: colors.light.withValues(alpha: 0.8), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.1),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        event.name,
                        style: TextStyle(
                          color: colors.dark,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          letterSpacing: -0.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.chevron_right_rounded, color: colors.primary, size: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Animation
            if (isPregnancy && weekInfo != null) ...[
              PregnancyAnimation(weekInfo: weekInfo, week: currentWeek!),
              const SizedBox(height: 28),
            ] else ...[
              _GenericAnimation(event: event),
              const SizedBox(height: 28),
            ],

            // Countdown
            _GlassCard(
              child: CountdownDisplay(event: event),
            ),
            const SizedBox(height: 16),

            // Week info card
            if (isPregnancy && weekInfo != null)
              WeekInfoCard(weekInfo: weekInfo, week: currentWeek!),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

// ─── Glass Card ───────────────────────────────────────────────────────────────

class _GlassCard extends StatelessWidget {
  const _GlassCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.8),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 16,
                spreadRadius: 0,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

// ─── Glow Blob Decoration ─────────────────────────────────────────────────────

class _GlowBlob extends StatelessWidget {
  const _GlowBlob({required this.color, this.size = 280});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.18),
      ),
    );
  }
}

// ─── Dots Indicator ───────────────────────────────────────────────────────────

class _DotsIndicator extends StatelessWidget {
  const _DotsIndicator({
    required this.count,
    required this.current,
    required this.events,
  });
  final int count;
  final int current;
  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == current;
        final color = AppTheme.colorsFor(events[i].type).primary;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 22 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? color : color.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

// ─── Generic Animation ────────────────────────────────────────────────────────

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
    final colors = AppTheme.colorsFor(event.type);
    return Container(
      width: 170,
      height: 170,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(-0.3, -0.4),
          colors: [colors.light, colors.lighter],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.3),
            blurRadius: 28,
            spreadRadius: 4,
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.9),
            blurRadius: 10,
            spreadRadius: -6,
            offset: const Offset(-5, -5),
          ),
        ],
      ),
      child: Center(child: Text(_emoji, style: const TextStyle(fontSize: 72))),
    );
  }
}
