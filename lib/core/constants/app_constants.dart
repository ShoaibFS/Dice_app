/// Application-wide constants
class AppConstants {
  // App Info
  static const String appName = 'Pro Dice Roller';
  static const String appVersion = '2.0.0';
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);
  static const Duration diceRollDuration = Duration(milliseconds: 800);
  
  // Dice Configuration
  static const int minDiceValue = 1;
  static const int maxDiceValue = 6;
  static const int defaultDiceCount = 1;
  static const int maxDiceCount = 6;
  
  // Storage Keys
  static const String themeKey = 'theme_mode';
  static const String soundEnabledKey = 'sound_enabled';
  static const String vibrationEnabledKey = 'vibration_enabled';
  static const String rollHistoryKey = 'roll_history';
  static const String statisticsKey = 'statistics';
  
  // UI Constants
  static const double borderRadius = 16.0;
  static const double cardElevation = 4.0;
  static const double maxAppWidth = 600.0;
}
