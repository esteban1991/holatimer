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
    scaffoldBackgroundColor: _pinkLighter,
    appBarTheme: const AppBarTheme(
      backgroundColor: _pink,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _pink,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _pink,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _pink, width: 2),
      ),
    ),
  );

  static const Color pink = _pink;
  static const Color pinkLight = _pinkLight;
  static const Color pinkLighter = _pinkLighter;
  static const Color pinkDark = _pinkDark;

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
