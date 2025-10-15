import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dicelab/features/history/dice_history.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(diceHistoryProvider);
    if (history.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('No rolls yet. Tap Roll to get started!'),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: history.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final roll = history[index];
        return ListTile(
          leading: const Icon(Icons.casino),
          title: Text('Rolled ${roll.value}')
              ,
          subtitle: Text(roll.timestamp.toLocal().toString()),
        );
      },
    );
  }
}
