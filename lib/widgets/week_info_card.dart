import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app_theme.dart';
import '../data/pregnancy_data.dart';
import '../providers/locale_provider.dart';

class WeekInfoCard extends ConsumerWidget {
  const WeekInfoCard({super.key, required this.weekInfo, required this.week});
  final WeekInfo weekInfo;
  final int week;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = ref.watch(l10nProvider);

    // Japanese week label: 第X週
    final weekStr = l.locale == 'ja' ? '${l.weekLabel}$week週' : '${l.weekLabel} $week';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.child_care, color: AppTheme.pink),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '$weekStr — ${weekInfo.fruitFor(l.locale)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.pinkDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            _Row(icon: '📏', label: l.sizeLabel, value: weekInfo.size),
            const SizedBox(height: 8),
            _Row(icon: '⚖️', label: l.weightLabel, value: weekInfo.weight),
            const SizedBox(height: 12),
            Text(
              weekInfo.developmentFor(l.locale),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.icon, required this.label, required this.value});
  final String icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
        Text(value),
      ],
    );
  }
}
