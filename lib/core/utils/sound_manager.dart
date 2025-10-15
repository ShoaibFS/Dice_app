import 'package:audioplayers/audioplayers.dart';

/// Manages sound effects for the application
class SoundManager {
  static final SoundManager _instance = SoundManager._internal();
  factory SoundManager() => _instance;
  SoundManager._internal();
  
  final AudioPlayer _player = AudioPlayer();
  bool _isEnabled = true;
  
  bool get isEnabled => _isEnabled;
  
  set isEnabled(bool value) {
    _isEnabled = value;
  }
  
  /// Play dice roll sound effect
  Future<void> playDiceRoll() async {
    if (!_isEnabled) return;
    
    try {
      // For now, we'll use a simple beep sound
      // In a real app, you'd add actual dice rolling sound files
      await _player.play(AssetSource('sounds/dice_roll.mp3'));
    } catch (e) {
      // Silently fail if sound file doesn't exist
      // In production, you'd want to log this
    }
  }
  
  /// Play success sound
  Future<void> playSuccess() async {
    if (!_isEnabled) return;
    
    try {
      await _player.play(AssetSource('sounds/success.mp3'));
    } catch (e) {
      // Silently fail
    }
  }
  
  /// Dispose resources
  void dispose() {
    _player.dispose();
  }
}
