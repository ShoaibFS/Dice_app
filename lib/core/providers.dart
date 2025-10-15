import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// SharedPreferences instance provider
final sharedPrefsProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

// Theme Mode controller with persistence
class ThemeModeController extends StateNotifier<ThemeMode> {
  ThemeModeController(this.ref) : super(ThemeMode.system);

  final Ref ref;
  static const _prefsKey = 'themeMode';

  Future<void> load() async {
    final prefs = await ref.read(sharedPrefsProvider.future);
    final value = prefs.getString(_prefsKey);
    switch (value) {
      case 'light':
        state = ThemeMode.light;
        break;
      case 'dark':
        state = ThemeMode.dark;
        break;
      default:
        state = ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = await ref.read(sharedPrefsProvider.future);
    await prefs.setString(_prefsKey, switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    });
  }

  Future<void> toggleDarkMode(bool enabled) async {
    await setThemeMode(enabled ? ThemeMode.dark : ThemeMode.light);
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeController, ThemeMode>((ref) {
  final controller = ThemeModeController(ref);
  // Fire and forget load; state updates when complete
  controller.load();
  return controller;
});
