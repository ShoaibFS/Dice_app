import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/models/dice_roll.dart';
import '../../shared/models/dice_statistics.dart';

/// Service for managing local storage
class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();
  
  SharedPreferences? _prefs;
  
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  // Theme
  Future<bool> saveThemeMode(bool isDark) async {
    return await _prefs?.setBool('theme_mode', isDark) ?? false;
  }
  
  bool? getThemeMode() {
    return _prefs?.getBool('theme_mode');
  }
  
  // Sound Settings
  Future<bool> saveSoundEnabled(bool enabled) async {
    return await _prefs?.setBool('sound_enabled', enabled) ?? false;
  }
  
  bool getSoundEnabled() {
    return _prefs?.getBool('sound_enabled') ?? true;
  }
  
  // Vibration Settings
  Future<bool> saveVibrationEnabled(bool enabled) async {
    return await _prefs?.setBool('vibration_enabled', enabled) ?? false;
  }
  
  bool getVibrationEnabled() {
    return _prefs?.getBool('vibration_enabled') ?? true;
  }
  
  // Dice History
  Future<bool> saveRollHistory(List<MultiDiceRoll> history) async {
    final jsonList = history.map((roll) => roll.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    return await _prefs?.setString('roll_history', jsonString) ?? false;
  }
  
  List<MultiDiceRoll> getRollHistory() {
    final jsonString = _prefs?.getString('roll_history');
    if (jsonString == null) return [];
    
    try {
      final jsonList = jsonDecode(jsonString) as List;
      return jsonList
          .map((json) => MultiDiceRoll.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }
  
  // Statistics
  Future<bool> saveStatistics(DiceStatistics stats) async {
    final jsonString = jsonEncode(stats.toJson());
    return await _prefs?.setString('statistics', jsonString) ?? false;
  }
  
  DiceStatistics getStatistics() {
    final jsonString = _prefs?.getString('statistics');
    if (jsonString == null) return const DiceStatistics();
    
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return DiceStatistics.fromJson(json);
    } catch (e) {
      return const DiceStatistics();
    }
  }
  
  // Dice Count Preference
  Future<bool> saveDiceCount(int count) async {
    return await _prefs?.setInt('dice_count', count) ?? false;
  }
  
  int getDiceCount() {
    return _prefs?.getInt('dice_count') ?? 1;
  }
  
  // Clear all data
  Future<bool> clearAll() async {
    return await _prefs?.clear() ?? false;
  }
}
