import 'package:flutter/material.dart';
import 'models/event.dart';

class EventTypeColors {
  const EventTypeColors({
    required this.primary,
    required this.dark,
    required this.light,
    required this.lighter,
  });
  final Color primary;
  final Color dark;
  final Color light;
  final Color lighter;
}

class AppTheme {
  static const _pink = Color(0xFFE91E8C);
  static const _pinkLight = Color(0xFFF8BBD9);
  static const _pinkLighter = Color(0xFFFCE4EC);
  static const _pinkDark = Color(0xFFC2185B);

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _pink,
      primary: _pink,
      secondary: _pinkDark,
      surfaceContainerHighest: _pinkLighter,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: const Color(0xFFFFF0F5),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: _pinkDark,
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        color: _pinkDark,
        fontSize: 20,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.3,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white.withValues(alpha: 0.85),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: _pinkLight.withValues(alpha: 0.5), width: 1.2),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _pink,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: StadiumBorder(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _pink,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: _pinkLight.withValues(alpha: 0.6)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: _pinkLight.withValues(alpha: 0.6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _pink, width: 2),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: _pinkLight.withValues(alpha: 0.5),
      thickness: 1,
    ),
  );

  static const Color pink = _pink;
  static const Color pinkLight = _pinkLight;
  static const Color pinkLighter = _pinkLighter;
  static const Color pinkDark = _pinkDark;

  // Gradient backgrounds per event type
  static List<Color> gradientFor(EventType type) => switch (type) {
    EventType.pregnancy => [const Color(0xFFFFF0F5), const Color(0xFFFCE4EC), const Color(0xFFF8BBD9)],
    EventType.birthday => [const Color(0xFFFFF8E1), const Color(0xFFFFF3E0), const Color(0xFFFFE0B2)],
    EventType.anniversary => [const Color(0xFFFFF0F0), const Color(0xFFFFEBEE), const Color(0xFFFFCDD2)],
    EventType.travel => [const Color(0xFFE8F4FD), const Color(0xFFE1F5FE), const Color(0xFFB3E5FC)],
    EventType.custom => [const Color(0xFFF5F0FF), const Color(0xFFF3E5F5), const Color(0xFFE1BEE7)],
  };

  static EventTypeColors colorsFor(EventType type) => switch (type) {
    EventType.pregnancy => const EventTypeColors(
      primary: Color(0xFFE91E8C),
      dark: Color(0xFFC2185B),
      light: Color(0xFFF8BBD9),
      lighter: Color(0xFFFCE4EC),
    ),
    EventType.birthday => const EventTypeColors(
      primary: Color(0xFFFF8F00),
      dark: Color(0xFFE65100),
      light: Color(0xFFFFCC80),
      lighter: Color(0xFFFFF3E0),
    ),
    EventType.anniversary => const EventTypeColors(
      primary: Color(0xFFD32F2F),
      dark: Color(0xFFB71C1C),
      light: Color(0xFFEF9A9A),
      lighter: Color(0xFFFFEBEE),
    ),
    EventType.travel => const EventTypeColors(
      primary: Color(0xFF0288D1),
      dark: Color(0xFF01579B),
      light: Color(0xFF81D4FA),
      lighter: Color(0xFFE1F5FE),
    ),
    EventType.custom => const EventTypeColors(
      primary: Color(0xFF7B1FA2),
      dark: Color(0xFF4A148C),
      light: Color(0xFFCE93D8),
      lighter: Color(0xFFF3E5F5),
    ),
  };
}
