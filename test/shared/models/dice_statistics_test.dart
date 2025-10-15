import 'package:flutter_test/flutter_test.dart';
import 'package:first_app/shared/models/dice_statistics.dart';

void main() {
  group('DiceStatistics Tests', () {
    test('Average calculation works correctly', () {
      final stats = const DiceStatistics(
        totalRolls: 6,
        valueFrequency: {
          1: 1,
          2: 1,
          3: 1,
          4: 1,
          5: 1,
          6: 1,
        },
      );
      
      expect(stats.averageValue, 3.5);
    });
    
    test('Average is 0 when no rolls', () {
      const stats = DiceStatistics();
      
      expect(stats.averageValue, 0.0);
    });
    
    test('Most frequent value is calculated correctly', () {
      final stats = const DiceStatistics(
        totalRolls: 10,
        valueFrequency: {
          1: 1,
          2: 2,
          3: 5, // Most frequent
          4: 1,
          5: 1,
        },
      );
      
      expect(stats.getMostFrequentValue(), 3);
    });
    
    test('Least frequent value is calculated correctly', () {
      final stats = const DiceStatistics(
        totalRolls: 10,
        valueFrequency: {
          1: 1, // Least frequent (tied)
          2: 2,
          3: 5,
          4: 1, // Least frequent (tied)
          5: 1, // Least frequent (tied)
        },
      );
      
      final leastFrequent = stats.getLeastFrequentValue();
      expect([1, 4, 5].contains(leastFrequent), true);
    });
    
    test('Frequency percentage is calculated correctly', () {
      final stats = const DiceStatistics(
        totalRolls: 100,
        valueFrequency: {
          1: 10,
          2: 20,
          3: 30,
          4: 20,
          5: 10,
          6: 10,
        },
      );
      
      expect(stats.getFrequencyPercentage(1), 10.0);
      expect(stats.getFrequencyPercentage(2), 20.0);
      expect(stats.getFrequencyPercentage(3), 30.0);
    });
    
    test('JSON serialization works correctly', () {
      final now = DateTime.now();
      final stats = DiceStatistics(
        totalRolls: 10,
        valueFrequency: const {1: 2, 2: 3, 3: 5},
        maxValue: 6,
        minValue: 1,
        lastRollTime: now,
      );
      
      final json = stats.toJson();
      final restored = DiceStatistics.fromJson(json);
      
      expect(restored.totalRolls, stats.totalRolls);
      expect(restored.valueFrequency, stats.valueFrequency);
      expect(restored.maxValue, stats.maxValue);
      expect(restored.minValue, stats.minValue);
      expect(restored.lastRollTime?.toIso8601String(), 
             now.toIso8601String());
    });
    
    test('copyWith works correctly', () {
      const original = DiceStatistics(
        totalRolls: 10,
        valueFrequency: {1: 5},
      );
      
      final updated = original.copyWith(totalRolls: 20);
      
      expect(updated.totalRolls, 20);
      expect(updated.valueFrequency, original.valueFrequency);
    });
  });
}
