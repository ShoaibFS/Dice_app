import 'package:equatable/equatable.dart';

/// Statistics for dice rolls
class DiceStatistics extends Equatable {
  final int totalRolls;
  final Map<int, int> valueFrequency;
  final int maxValue;
  final int minValue;
  final DateTime? lastRollTime;
  
  const DiceStatistics({
    this.totalRolls = 0,
    this.valueFrequency = const {},
    this.maxValue = 0,
    this.minValue = 0,
    this.lastRollTime,
  });
  
  double get averageValue {
    if (totalRolls == 0) return 0.0;
    int sum = 0;
    valueFrequency.forEach((value, frequency) {
      sum += value * frequency;
    });
    return sum / totalRolls;
  }
  
  int getMostFrequentValue() {
    if (valueFrequency.isEmpty) return 0;
    return valueFrequency.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }
  
  int getLeastFrequentValue() {
    if (valueFrequency.isEmpty) return 0;
    final nonZeroEntries = valueFrequency.entries
        .where((e) => e.value > 0)
        .toList();
    if (nonZeroEntries.isEmpty) return 0;
    return nonZeroEntries
        .reduce((a, b) => a.value < b.value ? a : b)
        .key;
  }
  
  double getFrequencyPercentage(int value) {
    if (totalRolls == 0) return 0.0;
    return (valueFrequency[value] ?? 0) / totalRolls * 100;
  }
  
  DiceStatistics copyWith({
    int? totalRolls,
    Map<int, int>? valueFrequency,
    int? maxValue,
    int? minValue,
    DateTime? lastRollTime,
  }) {
    return DiceStatistics(
      totalRolls: totalRolls ?? this.totalRolls,
      valueFrequency: valueFrequency ?? this.valueFrequency,
      maxValue: maxValue ?? this.maxValue,
      minValue: minValue ?? this.minValue,
      lastRollTime: lastRollTime ?? this.lastRollTime,
    );
  }
  
  @override
  List<Object?> get props => [
    totalRolls,
    valueFrequency,
    maxValue,
    minValue,
    lastRollTime,
  ];
  
  Map<String, dynamic> toJson() => {
    'totalRolls': totalRolls,
    'valueFrequency': valueFrequency,
    'maxValue': maxValue,
    'minValue': minValue,
    'lastRollTime': lastRollTime?.toIso8601String(),
  };
  
  factory DiceStatistics.fromJson(Map<String, dynamic> json) => DiceStatistics(
    totalRolls: json['totalRolls'] as int,
    valueFrequency: (json['valueFrequency'] as Map<String, dynamic>)
        .map((key, value) => MapEntry(int.parse(key), value as int)),
    maxValue: json['maxValue'] as int,
    minValue: json['minValue'] as int,
    lastRollTime: json['lastRollTime'] != null
        ? DateTime.parse(json['lastRollTime'] as String)
        : null,
  );
}
