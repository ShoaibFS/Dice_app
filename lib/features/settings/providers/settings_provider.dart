import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/storage_service.dart';
import '../../../core/utils/sound_manager.dart';
import '../../../core/utils/haptic_manager.dart';

/// Settings state
class SettingsState {
  final ThemeMode themeMode;
  final bool soundEnabled;
  final bool vibrationEnabled;
  
  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.soundEnabled = true,
    this.vibrationEnabled = true,
  });
  
  SettingsState copyWith({
    ThemeMode? themeMode,
    bool? soundEnabled,
    bool? vibrationEnabled,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
    );
  }
}

/// Settings provider
class SettingsNotifier extends StateNotifier<SettingsState> {
  final StorageService _storage;
  final SoundManager _soundManager;
  final HapticManager _hapticManager;
  
  SettingsNotifier(this._storage, this._soundManager, this._hapticManager)
      : super(const SettingsState()) {
    _loadSettings();
  }
  
  Future<void> _loadSettings() async {
    final isDark = _storage.getThemeMode();
    final soundEnabled = _storage.getSoundEnabled();
    final vibrationEnabled = _storage.getVibrationEnabled();
    
    state = SettingsState(
      themeMode: isDark == null
          ? ThemeMode.system
          : (isDark ? ThemeMode.dark : ThemeMode.light),
      soundEnabled: soundEnabled,
      vibrationEnabled: vibrationEnabled,
    );
    
    _soundManager.isEnabled = soundEnabled;
    _hapticManager.isEnabled = vibrationEnabled;
  }
  
  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    if (mode != ThemeMode.system) {
      await _storage.saveThemeMode(mode == ThemeMode.dark);
    }
  }
  
  Future<void> toggleTheme() async {
    final newMode = state.themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    await setThemeMode(newMode);
  }
  
  Future<void> setSoundEnabled(bool enabled) async {
    state = state.copyWith(soundEnabled: enabled);
    _soundManager.isEnabled = enabled;
    await _storage.saveSoundEnabled(enabled);
  }
  
  Future<void> setVibrationEnabled(bool enabled) async {
    state = state.copyWith(vibrationEnabled: enabled);
    _hapticManager.isEnabled = enabled;
    await _storage.saveVibrationEnabled(enabled);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) => SettingsNotifier(
    StorageService(),
    SoundManager(),
    HapticManager(),
  ),
);
