import 'package:go_router/go_router.dart';
import 'main.dart';
import 'screens/about_screen.dart';
import 'screens/events_screen.dart';
import 'screens/event_form_screen.dart';
import 'screens/event_detail_screen.dart';
import 'screens/settings_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (ctx, state) => const AppGate()),
    GoRoute(path: '/events', builder: (ctx, state) => const EventsScreen()),
    GoRoute(path: '/events/new', builder: (ctx, state) => const EventFormScreen()),
    GoRoute(
      path: '/events/:id/edit',
      builder: (ctx, state) => EventFormScreen(eventId: int.parse(state.pathParameters['id']!)),
    ),
    GoRoute(
      path: '/events/:id',
      builder: (ctx, state) => EventDetailScreen(eventId: int.parse(state.pathParameters['id']!)),
    ),
    GoRoute(path: '/settings', builder: (ctx, state) => const SettingsScreen()),
    GoRoute(path: '/about', builder: (ctx, state) => const AboutScreen()),
  ],
);
