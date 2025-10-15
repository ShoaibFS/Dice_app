import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dicelab/features/history/dice_history.dart';

final Random _random = Random();

class DiceRoller extends ConsumerStatefulWidget {
  const DiceRoller({super.key});

  @override
  ConsumerState<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends ConsumerState<DiceRoller> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _spin;
  int _currentDiceRoll = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _spin = CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _rollDice() {
    _controller.forward(from: 0);
    setState(() {
      _currentDiceRoll = _random.nextInt(6) + 1;
    });
    ref.read(diceHistoryProvider.notifier).addRoll(_currentDiceRoll);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RotationTransition(
          turns: _spin,
          child: Image.asset('assets/images/dice-$_currentDiceRoll.png', width: 200),
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: _rollDice,
          icon: const Icon(Icons.casino),
          label: const Text('Roll Dice'),
        ),
      ],
    );
  }
}