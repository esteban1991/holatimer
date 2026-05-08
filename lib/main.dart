import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app_theme.dart';
import 'l10n/app_l10n.dart';
import 'providers/locale_provider.dart';
import 'providers/onboarding_provider.dart';
import 'router.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';
import 'services/notification_service.dart';
import 'services/widget_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  for (final lang in AppLanguage.values) {
    await initializeDateFormatting(lang.locale, null);
  }
  await NotificationService.instance.init();
  await WidgetService.update();
  runApp(const ProviderScope(child: HolaTimerApp()));
}

class HolaTimerApp extends ConsumerWidget {
  const HolaTimerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(languageProvider);

    return MaterialApp.router(
      title: 'HolaTimer',
      theme: AppTheme.theme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      locale: Locale(lang.locale),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLanguage.values.map((l) => Locale(l.locale)).toList(),
    );
  }
}

class AppGate extends ConsumerWidget {
  const AppGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboarded = ref.watch(onboardingProvider);
    return switch (onboarded) {
      null => const Scaffold(body: Center(child: CircularProgressIndicator())),
      false => const OnboardingScreen(),
      _ => const HomeScreen(),
    };
  }
}
