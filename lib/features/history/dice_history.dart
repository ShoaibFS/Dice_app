import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dicelab/core/providers.dart';

@immutable
class DiceRoll {
  const DiceRoll({required this.value, required this.timestamp});

  final int value;
  final DateTime timestamp;

  Map<String, dynamic> toJson() => {
        'value': value,
        'timestamp': timestamp.toIso8601String(),
      };

  factory DiceRoll.fromJson(Map<String, dynamic> json) {
    return DiceRoll(
      value: json['value'] as int,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}

class DiceHistoryController extends StateNotifier<List<DiceRoll>> {
  DiceHistoryController(this.ref) : super(const []);

  final Ref ref;
  static const String _prefsKey = 'diceHistoryV1';

  Future<void> load() async {
    final SharedPreferences prefs = await ref.read(sharedPrefsProvider.future);
    final String? serialized = prefs.getString(_prefsKey);
    if (serialized == null) {
      state = const [];
      return;
    }
    try {
      final List<dynamic> list = jsonDecode(serialized) as List<dynamic>;
      state = list
          .map((e) => DiceRoll.fromJson(e as Map<String, dynamic>))
          .toList(growable: false);
    } catch (_) {
      state = const [];
    }
  }

  Future<void> _persist() async {
    final SharedPreferences prefs = await ref.read(sharedPrefsProvider.future);
    final String serialized = jsonEncode(state.map((e) => e.toJson()).toList());
    await prefs.setString(_prefsKey, serialized);
  }

  Future<void> addRoll(int value) async {
    final DiceRoll roll = DiceRoll(value: value, timestamp: DateTime.now());
    state = [roll, ...state].take(100).toList(growable: false);
    await _persist();
  }

  Future<void> clear() async {
    state = const [];
    await _persist();
  }
}

final diceHistoryProvider =
    StateNotifierProvider<DiceHistoryController, List<DiceRoll>>((ref) {
  final controller = DiceHistoryController(ref);
  controller.load();
  return controller;
});
