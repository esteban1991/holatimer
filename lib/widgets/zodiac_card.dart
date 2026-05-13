import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/locale_provider.dart';
import '../services/zodiac_service.dart';

class ZodiacCard extends ConsumerWidget {
  const ZodiacCard({
    super.key,
    required this.date,
    required this.title,
    this.showChinese = true,
  });
  final DateTime date;
  final String title;
  final bool showChinese;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = ref.watch(l10nProvider);
    final western = ZodiacService.getWesternZodiac(date);
    final chinese = ZodiacService.getChineseZodiac(date);
    final element = ZodiacService.chineseElementFor(date, l.locale);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.grey[600],
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 16),
            if (showChinese)
              Row(
                children: [
                  Expanded(
                    child: _ZodiacBadge(
                      emoji: western.emoji,
                      glyph: western.glyph,
                      name: western.nameFor(l.locale),
                      subtitle: l.westernZodiac,
                      description: western.descriptionFor(l.locale),
                      gradientColors: const [Color(0xFF7C4DFF), Color(0xFF448AFF)],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ZodiacBadge(
                      emoji: chinese.emoji,
                      glyph: element,
                      name: chinese.nameFor(l.locale),
                      subtitle: l.chineseZodiac,
                      description: chinese.descriptionFor(l.locale),
                      gradientColors: const [Color(0xFFE91E8C), Color(0xFFFF6F00)],
                    ),
                  ),
                ],
              )
            else
              _ZodiacBadge(
                emoji: western.emoji,
                glyph: western.glyph,
                name: western.nameFor(l.locale),
                subtitle: l.westernZodiac,
                description: western.descriptionFor(l.locale),
                gradientColors: const [Color(0xFF7C4DFF), Color(0xFF448AFF)],
              ),
          ],
        ),
      ),
    );
  }
}

class _ZodiacBadge extends StatefulWidget {
  const _ZodiacBadge({
    required this.emoji,
    required this.glyph,
    required this.name,
    required this.subtitle,
    required this.description,
    required this.gradientColors,
  });

  final String emoji;
  final String glyph;
  final String name;
  final String subtitle;
  final String description;
  final List<Color> gradientColors;

  @override
  State<_ZodiacBadge> createState() => _ZodiacBadgeState();
}

class _ZodiacBadgeState extends State<_ZodiacBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 0.93, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _showSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => _ZodiacSheet(
        emoji: widget.emoji,
        glyph: widget.glyph,
        name: widget.name,
        subtitle: widget.subtitle,
        description: widget.description,
        gradientColors: widget.gradientColors,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSheet(context),
      child: _buildBadge(),
    );
  }

  Widget _buildBadge() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.gradientColors[0].withValues(alpha: 0.12),
            widget.gradientColors[1].withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: widget.gradientColors[0].withValues(alpha: 0.25),
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      child: Column(
        children: [
          ScaleTransition(
            scale: _scale,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.gradientColors,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.gradientColors[0].withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Center(
                child: Text(widget.emoji, style: const TextStyle(fontSize: 42)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            widget.glyph,
            style: TextStyle(
              fontSize: 13,
              color: widget.gradientColors[0],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.subtitle,
            style: TextStyle(fontSize: 11, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─── Bottom sheet ─────────────────────────────────────────────────────────────

class _ZodiacSheet extends StatelessWidget {
  const _ZodiacSheet({
    required this.emoji,
    required this.glyph,
    required this.name,
    required this.subtitle,
    required this.description,
    required this.gradientColors,
  });

  final String emoji;
  final String glyph;
  final String name;
  final String subtitle;
  final String description;
  final List<Color> gradientColors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 20, 24, MediaQuery.of(context).padding.bottom + 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40, height: 4,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
              boxShadow: [
                BoxShadow(
                  color: gradientColors[0].withValues(alpha: 0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 52)),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '$glyph  ·  $subtitle',
            style: TextStyle(
              fontSize: 13,
              color: gradientColors[0],
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  gradientColors[0].withValues(alpha: 0.08),
                  gradientColors[1].withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: gradientColors[0].withValues(alpha: 0.2),
              ),
            ),
            child: Text(
              description,
              style: const TextStyle(fontSize: 15, height: 1.6),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
