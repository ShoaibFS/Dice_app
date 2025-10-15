import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dicelab/core/providers.dart';
import 'package:dicelab/core/router.dart';

class DiceLabApp extends ConsumerWidget {
  const DiceLabApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    final baseTextTheme = GoogleFonts.poppinsTextTheme();
    final lightScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF6C63FF),
      brightness: Brightness.light,
    );
    final darkScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF6C63FF),
      brightness: Brightness.dark,
    );

    final lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: lightScheme,
      textTheme: baseTextTheme,
      appBarTheme: const AppBarTheme(centerTitle: true),
    );
    final darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: darkScheme,
      textTheme: baseTextTheme,
      appBarTheme: const AppBarTheme(centerTitle: true),
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'DiceLab',
      themeMode: themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: router,
    );
  }
}
