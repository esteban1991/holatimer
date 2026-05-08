import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../app_theme.dart';
import '../l10n/app_l10n.dart';
import '../providers/locale_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = ref.watch(l10nProvider);
    final currentLang = ref.watch(languageProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l.settings)),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 32),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.language, color: AppTheme.pink),
                      const SizedBox(width: 8),
                      Text(
                        l.language,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.pinkDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...AppLanguage.values.map((lang) => _LangTile(
                        lang: lang,
                        selected: currentLang == lang,
                        onTap: () => ref.read(languageProvider.notifier).setLanguage(lang),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.favorite, color: AppTheme.pink),
              title: Text(l.about),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/about'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.notifications_active, color: AppTheme.pink),
                      const SizedBox(width: 8),
                      Text(
                        l.notifSound,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.pinkDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _soundInfoText(l),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SoundRow(emoji: '🤰', label: l.typePregnancy, sound: '👶 ${_babySound(l)}'),
                  _SoundRow(emoji: '💑', label: l.typeAnniversary, sound: '🔔 ${_bellsSound(l)}'),
                  _SoundRow(emoji: '🎂', label: l.typeBirthday, sound: '🎵 ${_defaultSound(l)}'),
                  _SoundRow(emoji: '✈️', label: l.typeTravel, sound: '🎵 ${_defaultSound(l)}'),
                  _SoundRow(emoji: '⭐', label: l.typeCustom, sound: '🎵 ${_defaultSound(l)}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _soundInfoText(AppL10n l) {
    return switch (l.locale) {
      'en' => 'Each event type plays a different notification sound. Customize them in Android Settings → Apps → HolaTimer → Notifications.',
      'ja' => 'イベントの種類ごとに通知音が異なります。Android設定 → アプリ → HolaTimer → 通知でカスタマイズできます。',
      'it' => 'Ogni tipo di evento ha un suono diverso. Personalizza in Impostazioni Android → App → HolaTimer → Notifiche.',
      'fr' => 'Chaque type d\'événement a un son différent. Personnalisez dans Paramètres Android → Applications → HolaTimer → Notifications.',
      'de' => 'Jeder Ereignistyp hat einen anderen Ton. Anpassen unter Android-Einstellungen → Apps → HolaTimer → Benachrichtigungen.',
      _ => 'Cada tipo de evento tiene su propio sonido de notificación. Personalízalos en Ajustes Android → Apps → HolaTimer → Notificaciones.',
    };
  }

  String _babySound(AppL10n l) => switch (l.locale) {
    'en' => 'Baby sound',
    'ja' => '赤ちゃんの声',
    'it' => 'Suono bebè',
    'fr' => 'Son bébé',
    'de' => 'Babygeräusch',
    _ => 'Sonido de bebé',
  };

  String _bellsSound(AppL10n l) => switch (l.locale) {
    'en' => 'Wedding bells',
    'ja' => 'ウェディングベル',
    'it' => 'Campane nuziali',
    'fr' => 'Cloches de mariage',
    'de' => 'Hochzeitsglocken',
    _ => 'Campanas de boda',
  };

  String _defaultSound(AppL10n l) => switch (l.locale) {
    'en' => 'Default',
    'ja' => 'デフォルト',
    'it' => 'Predefinito',
    'fr' => 'Par défaut',
    'de' => 'Standard',
    _ => 'Por defecto',
  };
}

class _LangTile extends StatelessWidget {
  const _LangTile({required this.lang, required this.selected, required this.onTap});
  final AppLanguage lang;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(lang.flag, style: const TextStyle(fontSize: 28)),
      title: Text(lang.label, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: selected
          ? const Icon(Icons.check_circle, color: AppTheme.pink)
          : const Icon(Icons.circle_outlined, color: Colors.grey),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: selected ? AppTheme.pinkLighter : null,
    );
  }
}

class _SoundRow extends StatelessWidget {
  const _SoundRow({required this.emoji, required this.label, required this.sound});
  final String emoji;
  final String label;
  final String sound;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          Expanded(child: Text(label.replaceAll(RegExp(r'^[^\s]+ '), ''))),
          Text(sound, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        ],
      ),
    );
  }
}
