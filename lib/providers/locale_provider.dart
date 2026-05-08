import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_l10n.dart';

final languageProvider =
    StateNotifierProvider<LanguageNotifier, AppLanguage>((ref) => LanguageNotifier());

final l10nProvider = Provider<AppL10n>((ref) => AppL10n.of(ref.watch(languageProvider)));

class LanguageNotifier extends StateNotifier<AppLanguage> {
  LanguageNotifier() : super(AppLanguage.es) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('language');
    if (saved != null) {
      state = AppLanguage.values.firstWhere((l) => l.name == saved, orElse: () => AppLanguage.es);
    } else {
      final deviceLang = PlatformDispatcher.instance.locale.languageCode;
      state = AppLanguage.values.firstWhere(
        (l) => l.name == deviceLang,
        orElse: () => AppLanguage.es,
      );
    }
  }

  Future<void> setLanguage(AppLanguage lang) async {
    state = lang;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', lang.name);
  }
}
