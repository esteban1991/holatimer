import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app_theme.dart';
import '../data/pregnancy_data.dart';
import '../providers/locale_provider.dart';

class PregnancyAnimation extends ConsumerStatefulWidget {
  const PregnancyAnimation({super.key, required this.weekInfo, required this.week});

  final WeekInfo weekInfo;
  final int week;

  @override
  ConsumerState<PregnancyAnimation> createState() => _PregnancyAnimationState();
}

class _PregnancyAnimationState extends ConsumerState<PregnancyAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _scaleAnim = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(PregnancyAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.week != widget.week) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get _fruitSize {
    // Scale fruit from 60 (week 4) to 150 (week 40)
    final week = widget.week.clamp(4, 40);
    return 60 + ((week - 4) / 36) * 90;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnim,
          child: ScaleTransition(
            scale: _scaleAnim,
            child: child,
          ),
        );
      },
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [AppTheme.pinkLight, AppTheme.pinkLighter],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.pink.withValues(alpha: 0.35),
              blurRadius: 24,
              spreadRadius: 4,
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
              '${ref.watch(l10nProvider).weekLabel} ${widget.week}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppTheme.pinkDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
