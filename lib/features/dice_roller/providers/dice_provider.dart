import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../shared/models/dice_roll.dart';
import '../../../core/utils/storage_service.dart';
import '../../../core/utils/sound_manager.dart';
import '../../../core/utils/haptic_manager.dart';
import '../../../core/constants/app_constants.dart';

/// Dice rolling state
class DiceState {
  final List<int> currentValues;
  final bool isRolling;
  final int diceCount;
  
  const DiceState({
    this.currentValues = const [1],
    this.isRolling = false,
    this.diceCount = 1,
  });
  
  int get total => currentValues.fold(0, (sum, value) => sum + value);
  
  DiceState copyWith({
    List<int>? currentValues,
    bool? isRolling,
    int? diceCount,
  }) {
    return DiceState(
      currentValues: currentValues ?? this.currentValues,
      isRolling: isRolling ?? this.isRolling,
      diceCount: diceCount ?? this.diceCount,
    );
  }
}

/// Dice provider
class DiceNotifier extends StateNotifier<DiceState> {
  final Random _random = Random();
  final StorageService _storage;
  final SoundManager _soundManager;
  final HapticManager _hapticManager;
  final Ref _ref;
  
  DiceNotifier(this._storage, this._soundManager, this._hapticManager, this._ref)
      : super(const DiceState()) {
    _loadDiceCount();
  }
  
  void _loadDiceCount() {
    final count = _storage.getDiceCount();
    state = DiceState(
      currentValues: List.generate(count, (_) => 1),
      diceCount: count,
    );
  }
  
  Future<void> rollDice() async {
    if (state.isRolling) return;
    
    state = state.copyWith(isRolling: true);
    
    // Play sound and haptic feedback
    await Future.wait([
      _soundManager.playDiceRoll(),
      _hapticManager.medium(),
    ]);
    
    // Simulate rolling animation with multiple updates
    for (int i = 0; i < 5; i++) {
      final tempValues = List.generate(
        state.diceCount,
        (_) => _random.nextInt(AppConstants.maxDiceValue) + AppConstants.minDiceValue,
      );
      state = state.copyWith(currentValues: tempValues);
      await Future.delayed(const Duration(milliseconds: 100));
    }
    
    // Final roll values
    final finalValues = List.generate(
      state.diceCount,
      (_) => _random.nextInt(AppConstants.maxDiceValue) + AppConstants.minDiceValue,
    );
    
    state = state.copyWith(
      currentValues: finalValues,
      isRolling: false,
    );
    
    // Add to history
    _addToHistory(finalValues);
    
    // Success haptic
    await _hapticManager.light();
  }
  
  void _addToHistory(List<int> values) {
    final roll = MultiDiceRoll(
      values: values,
      timestamp: DateTime.now(),
      id: const Uuid().v4(),
    );
    
    // Update history through the history provider
    _ref.read(historyProvider.notifier).addRoll(roll);
  }
  
  Future<void> setDiceCount(int count) async {
    if (count < 1 || count > AppConstants.maxDiceCount) return;
    
    state = state.copyWith(
      diceCount: count,
      currentValues: List.generate(count, (index) {
        if (index < state.currentValues.length) {
          return state.currentValues[index];
        }
        return 1;
      }),
    );
    
    await _storage.saveDiceCount(count);
  }
}

final diceProvider = StateNotifierProvider<DiceNotifier, DiceState>((ref) {
  return DiceNotifier(
    StorageService(),
    SoundManager(),
    HapticManager(),
    ref,
  );
});

// History provider
class HistoryNotifier extends StateNotifier<List<MultiDiceRoll>> {
  final StorageService _storage;
  
  HistoryNotifier(this._storage) : super([]) {
    _loadHistory();
  }
  
  void _loadHistory() {
    state = _storage.getRollHistory();
  }
  
  void addRoll(MultiDiceRoll roll) {
    state = [roll, ...state];
    if (state.length > 100) {
      state = state.sublist(0, 100);
    }
    _storage.saveRollHistory(state);
  }
  
  void clearHistory() {
    state = [];
    _storage.saveRollHistory([]);
  }
}

final historyProvider = StateNotifierProvider<HistoryNotifier, List<MultiDiceRoll>>(
  (ref) => HistoryNotifier(StorageService()),
);
