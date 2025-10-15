import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/dice_statistics.dart';
import '../../dice_roller/providers/dice_provider.dart';

/// Statistics provider that automatically updates based on history
final statisticsProvider = Provider<DiceStatistics>((ref) {
  final history = ref.watch(historyProvider);
  
  if (history.isEmpty) {
    return const DiceStatistics();
  }
  
  int totalRolls = 0;
  final Map<int, int> valueFrequency = {};
  int maxValue = 0;
  int minValue = 6;
  
  for (final roll in history) {
    for (final value in roll.values) {
      totalRolls++;
      valueFrequency[value] = (valueFrequency[value] ?? 0) + 1;
      if (value > maxValue) maxValue = value;
      if (value < minValue) minValue = value;
    }
  }
  
  return DiceStatistics(
    totalRolls: totalRolls,
    valueFrequency: valueFrequency,
    maxValue: maxValue,
    minValue: minValue == 6 && totalRolls == 0 ? 0 : minValue,
    lastRollTime: history.isNotEmpty ? history.first.timestamp : null,
  );
});
