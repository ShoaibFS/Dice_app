import 'package:vibration/vibration.dart';

/// Manages haptic feedback for the application
class HapticManager {
  static final HapticManager _instance = HapticManager._internal();
  factory HapticManager() => _instance;
  HapticManager._internal();
  
  bool _isEnabled = true;
  
  bool get isEnabled => _isEnabled;
  
  set isEnabled(bool value) {
    _isEnabled = value;
  }
  
  /// Light haptic feedback
  Future<void> light() async {
    if (!_isEnabled) return;
    
    try {
      final hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator == true) {
        await Vibration.vibrate(duration: 10);
      }
    } catch (e) {
      // Silently fail on platforms that don't support vibration
    }
  }
  
  /// Medium haptic feedback
  Future<void> medium() async {
    if (!_isEnabled) return;
    
    try {
      final hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator == true) {
        await Vibration.vibrate(duration: 20);
      }
    } catch (e) {
      // Silently fail
    }
  }
  
  /// Heavy haptic feedback
  Future<void> heavy() async {
    if (!_isEnabled) return;
    
    try {
      final hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator == true) {
        await Vibration.vibrate(duration: 50);
      }
    } catch (e) {
      // Silently fail
    }
  }
  
  /// Success pattern
  Future<void> success() async {
    if (!_isEnabled) return;
    
    try {
      final hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator == true) {
        await Vibration.vibrate(
          pattern: [0, 10, 50, 10],
          intensities: [0, 128, 0, 255],
        );
      }
    } catch (e) {
      // Silently fail
    }
  }
}
