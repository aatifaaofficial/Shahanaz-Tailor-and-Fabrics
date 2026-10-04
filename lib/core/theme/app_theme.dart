import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color blush = Color(0xFFF9DDE1);
  static const Color softPink = Color(0xFFF7E4EA);
  static const Color rose = Color(0xFFE8B7C6);
  static const Color plum = Color(0xFF8C5A68);
  static const Color charcoal = Color(0xFF2B2B2B);
  static const Color cream = Color(0xFFFEF9F8);
  static const Color gold = Color(0xFFD9B36C);
  static const Color success = Color(0xFF1FB07A);
  static const Color error = Color(0xFFCE5A5A);

  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: plum,
        brightness: Brightness.light,
        primary: plum,
        secondary: rose,
        surface: cream,
      ),
      scaffoldBackgroundColor: cream,
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE9D9DF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE9D9DF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: plum, width: 1.5),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: blush,
        labelTextStyle: WidgetStateProperty.all(
          GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
    );

    return base.copyWith(
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }

  static ThemeData get darkTheme => lightTheme.copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1B1B1D),
        colorScheme: ColorScheme.fromSeed(
          seedColor: plum,
          brightness: Brightness.dark,
          primary: blush,
          secondary: rose,
          surface: const Color(0xFF271D20),
        ),
      );
}
