import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_app/features/dice_roller/providers/dice_provider.dart';
import 'package:first_app/shared/models/dice_roll.dart';

void main() {
  group('DiceProvider Tests', () {
    late ProviderContainer container;
    
    setUp(() {
      container = ProviderContainer();
    });
    
    tearDown(() {
      container.dispose();
    });
    
    test('Initial state has one die with value 1', () {
      final state = container.read(diceProvider);
      
      expect(state.diceCount, 1);
      expect(state.currentValues.length, 1);
      expect(state.isRolling, false);
    });
    
    test('Rolling dice updates values', () async {
      final notifier = container.read(diceProvider.notifier);
      
      await notifier.rollDice();
      
      final state = container.read(diceProvider);
      expect(state.currentValues.length, 1);
      expect(state.currentValues.first, greaterThanOrEqualTo(1));
      expect(state.currentValues.first, lessThanOrEqualTo(6));
      expect(state.isRolling, false);
    });
    
    test('Setting dice count updates state', () async {
      final notifier = container.read(diceProvider.notifier);
      
      await notifier.setDiceCount(3);
      
      final state = container.read(diceProvider);
      expect(state.diceCount, 3);
      expect(state.currentValues.length, 3);
    });
    
    test('Cannot set dice count below 1', () async {
      final notifier = container.read(diceProvider.notifier);
      
      await notifier.setDiceCount(0);
      
      final state = container.read(diceProvider);
      expect(state.diceCount, 1); // Should remain unchanged
    });
    
    test('Cannot set dice count above 6', () async {
      final notifier = container.read(diceProvider.notifier);
      
      await notifier.setDiceCount(10);
      
      final state = container.read(diceProvider);
      expect(state.diceCount, 1); // Should remain unchanged
    });
    
    test('Total calculation is correct', () {
      final state = const DiceState(
        currentValues: [1, 2, 3, 4, 5, 6],
        diceCount: 6,
      );
      
      expect(state.total, 21);
    });
  });
  
  group('MultiDiceRoll Model Tests', () {
    test('Total calculation works correctly', () {
      final roll = MultiDiceRoll(
        values: [1, 2, 3],
        timestamp: DateTime.now(),
        id: 'test-id',
      );
      
      expect(roll.total, 6);
      expect(roll.diceCount, 3);
    });
    
    test('JSON serialization works', () {
      final now = DateTime.now();
      final roll = MultiDiceRoll(
        values: [1, 2, 3],
        timestamp: now,
        id: 'test-id',
      );
      
      final json = roll.toJson();
      final restored = MultiDiceRoll.fromJson(json);
      
      expect(restored.values, roll.values);
      expect(restored.id, roll.id);
      expect(restored.timestamp.toIso8601String(), 
             now.toIso8601String());
    });
  });
}
