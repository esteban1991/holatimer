import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_theme.dart';
import '../providers/locale_provider.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = ref.watch(l10nProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFE91E8C), Color(0xFFAD1457)],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const Text('⏳', style: TextStyle(fontSize: 56)),
                    const SizedBox(height: 8),
                    const Text(
                      'HolaTimer',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${l.version} 1.0.0',
                      style: const TextStyle(fontSize: 13, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StoryCard(locale: l.locale),
                  const SizedBox(height: 20),
                  _InfoCard(
                    icon: Icons.favorite,
                    color: AppTheme.pink,
                    text: l.madeWithLove,
                  ),
                  const SizedBox(height: 12),
                  _InfoCard(
                    icon: Icons.block,
                    color: Colors.green[700]!,
                    text: l.noAds,
                  ),
                  const SizedBox(height: 12),
                  _LinkedInCard(),
                  const SizedBox(height: 32),
                  Center(
                    child: Text(
                      '#HolaTimer',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppTheme.pink,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkedInCard extends StatelessWidget {
  static final _uri = Uri.parse('https://www.linkedin.com/in/esteban-peralta-nunez/');

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => launchUrl(_uri, mode: LaunchMode.externalApplication),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF0A66C2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Center(
                  child: Text(
                    'in',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Esteban Peralta Núñez',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'linkedin.com/in/esteban-peralta-nunez',
                      style: TextStyle(fontSize: 12, color: Color(0xFF0A66C2)),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.open_in_new, size: 18, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({required this.locale});
  final String locale;

  String get _story => switch (locale) {
    'en' =>
      'HolaTimer was born from love.\n\n'
      'My girlfriend was pregnant and looking for a countdown app — '
      'but everything was full of ads. Tap here, tap there, '
      'ads everywhere. I wanted something clean, beautiful, '
      'and that actually works.\n\n'
      'So I built it for her, and decided to share it with the world '
      'so others can live these moments too.',
    'ja' =>
      'HolaTimerは愛から生まれました。\n\n'
      '彼女が妊娠し、カウントダウンアプリを探していましたが、'
      'どれも広告だらけ。シンプルで美しく、本当に役立つものを作りたかった。\n\n'
      'だから彼女のために作り、同じ喜びを感じるすべての人と分かち合うことにしました。',
    'it' =>
      'HolaTimer è nato dall\'amore.\n\n'
      'La mia ragazza era incinta e cercava un\'app di conto alla rovescia '
      '— ma tutto era pieno di pubblicità. Volevo qualcosa di pulito, '
      'bello e che funzionasse davvero.\n\n'
      'Così l\'ho costruita per lei e ho deciso di condividerla con il mondo.',
    'fr' =>
      'HolaTimer est né de l\'amour.\n\n'
      'Ma copine était enceinte et cherchait une app de compte à rebours '
      '— mais tout était plein de publicités. Je voulais quelque chose '
      'de propre, beau et qui fonctionne vraiment.\n\n'
      'Alors je l\'ai construite pour elle, et j\'ai décidé de la partager avec le monde.',
    'de' =>
      'HolaTimer entstand aus Liebe.\n\n'
      'Meine Freundin war schwanger und suchte eine Countdown-App '
      '— aber alles war voller Werbung. Ich wollte etwas Sauberes, '
      'Schönes und das wirklich funktioniert.\n\n'
      'Also baute ich es für sie und entschied, es mit der Welt zu teilen.',
    _ =>
      'HolaTimer nació del amor.\n\n'
      'Mi novia estaba embarazada y buscaba una app de cuenta regresiva '
      '— pero todas tenían demasiados anuncios. Quería algo limpio, '
      'bonito y que de verdad sirviera.\n\n'
      'Así que la construí para ella, y decidí compartirla con el mundo '
      'para que otros puedan vivirlo también.',
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          _story,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.7),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.icon, required this.color, required this.text});
  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
