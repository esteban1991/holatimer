import 'dart:io';
import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/database.dart';
import '../l10n/app_l10n.dart';

class WidgetService {
  static Future<void> update() async {
    if (!Platform.isAndroid) return;

    final events = await AppDatabase.instance.getEvents();
    final upcoming = events.where((e) => e.daysRemaining >= 0).toList()
      ..sort((a, b) => a.daysRemaining.compareTo(b.daysRemaining));

    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('language') ?? 'es';
    final lang = AppLanguage.values.firstWhere(
      (l) => l.name == code,
      orElse: () => AppLanguage.es,
    );
    final l = AppL10n.of(lang);

    if (upcoming.isEmpty) {
      await HomeWidget.saveWidgetData('widget_name', 'HolaTimer');
      await HomeWidget.saveWidgetData('widget_count', '—');
      await HomeWidget.saveWidgetData('widget_unit', '');
    } else {
      final event = upcoming.first;
      await HomeWidget.saveWidgetData('widget_name', event.name);
      await HomeWidget.saveWidgetData('widget_count', '${event.daysRemaining}');
      await HomeWidget.saveWidgetData('widget_unit', l.dayUnit(event.daysRemaining));
    }

    await HomeWidget.updateWidget(androidName: 'HolaTimerWidget');
  }
}
