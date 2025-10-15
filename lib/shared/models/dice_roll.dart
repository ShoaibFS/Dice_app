import 'package:equatable/equatable.dart';

/// Represents a single dice roll result
class DiceRoll extends Equatable {
  final int value;
  final DateTime timestamp;
  final String id;
  
  const DiceRoll({
    required this.value,
    required this.timestamp,
    required this.id,
  });
  
  @override
  List<Object?> get props => [value, timestamp, id];
  
  Map<String, dynamic> toJson() => {
    'value': value,
    'timestamp': timestamp.toIso8601String(),
    'id': id,
  };
  
  factory DiceRoll.fromJson(Map<String, dynamic> json) => DiceRoll(
    value: json['value'] as int,
    timestamp: DateTime.parse(json['timestamp'] as String),
    id: json['id'] as String,
  );
}

/// Represents a multi-dice roll session
class MultiDiceRoll extends Equatable {
  final List<int> values;
  final DateTime timestamp;
  final String id;
  
  const MultiDiceRoll({
    required this.values,
    required this.timestamp,
    required this.id,
  });
  
  int get total => values.fold(0, (sum, value) => sum + value);
  
  int get diceCount => values.length;
  
  @override
  List<Object?> get props => [values, timestamp, id];
  
  Map<String, dynamic> toJson() => {
    'values': values,
    'timestamp': timestamp.toIso8601String(),
    'id': id,
  };
  
  factory MultiDiceRoll.fromJson(Map<String, dynamic> json) => MultiDiceRoll(
    values: (json['values'] as List).cast<int>(),
    timestamp: DateTime.parse(json['timestamp'] as String),
    id: json['id'] as String,
  );
}
