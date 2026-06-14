import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app_theme.dart';
import '../data/pregnancy_data.dart';
import '../providers/locale_provider.dart';
import 'baby_detail_sheet.dart';

class PregnancyAnimation extends ConsumerStatefulWidget {
  const PregnancyAnimation({super.key, required this.weekInfo, required this.week});

  final WeekInfo weekInfo;
  final int week;

  @override
  ConsumerState<PregnancyAnimation> createState() => _PregnancyAnimationState();
}

class _PregnancyAnimationState extends ConsumerState<PregnancyAnimation>
    with TickerProviderStateMixin {
  late AnimationController _enterCtrl;
  late AnimationController _pulseCtrl;
  late AnimationController _tapCtrl;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;
  late Animation<double> _pulseAnim;
  late Animation<double> _tapAnim;

  @override
  void initState() {
    super.initState();
    _enterCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200))
      ..repeat(reverse: true);
    _tapCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));

    _scaleAnim = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _enterCtrl, curve: Curves.elasticOut),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _enterCtrl, curve: Curves.easeIn),
    );
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
    _tapAnim = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _tapCtrl, curve: Curves.easeInOut),
    );

    _enterCtrl.forward();
  }

  @override
  void didUpdateWidget(PregnancyAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.week != widget.week) {
      _enterCtrl.reset();
      _enterCtrl.forward();
    }
  }

  @override
  void dispose() {
    _enterCtrl.dispose();
    _pulseCtrl.dispose();
    _tapCtrl.dispose();
    super.dispose();
  }

  void _onTap() async {
    await _tapCtrl.forward();
    await _tapCtrl.reverse();
    if (!mounted) return;
    showBabyDetailSheet(context, widget.weekInfo, widget.week);
  }

  double get _fruitSize {
    final week = widget.week.clamp(4, 40);
    return 60 + ((week - 4) / 36) * 90;
  }

  @override
  Widget build(BuildContext context) {
    final l = ref.watch(l10nProvider);

    return AnimatedBuilder(
      animation: Listenable.merge([_enterCtrl, _pulseCtrl, _tapCtrl]),
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnim,
          child: ScaleTransition(
            scale: _scaleAnim,
            child: Transform.scale(
              scale: _pulseAnim.value * _tapAnim.value,
              child: child,
            ),
          ),
        );
      },
      child: GestureDetector(
        onTap: _onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer glow ring
            Container(
              width: 196,
              height: 196,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.pink.withValues(alpha: 0.08),
              ),
            ),
            // Main circle
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-0.3, -0.4),
                  colors: [
                    AppTheme.pinkLight,
                    AppTheme.pinkLighter,
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.pink.withValues(alpha: 0.35),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.weekInfo.fruitEmoji,
                    style: TextStyle(fontSize: _fruitSize),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${l.weekLabel} ${widget.week}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.pinkDark,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
            // Tap hint — small icon at bottom of circle
            Positioned(
              bottom: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: AppTheme.pinkDark.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.touch_app_rounded, size: 11, color: AppTheme.pinkDark.withValues(alpha: 0.6)),
                    const SizedBox(width: 3),
                    Text(
                      l.tapToSeeBaby,
                      style: TextStyle(
                        fontSize: 10,
                        color: AppTheme.pinkDark.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
