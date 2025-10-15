import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/animated_dice.dart';
import '../../../shared/widgets/gradient_background.dart';
import '../../../core/constants/app_constants.dart';
import '../providers/dice_provider.dart';
import '../../settings/providers/settings_provider.dart';

class DiceRollerScreen extends ConsumerWidget {
  const DiceRollerScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diceState = ref.watch(diceProvider);
    final settings = ref.watch(settingsProvider);
    final isDark = settings.themeMode == ThemeMode.dark;
    
    return GradientBackground(
      isDark: isDark,
      child: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context, ref),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDiceGrid(diceState),
                      const SizedBox(height: 40),
                      _buildTotalDisplay(context, diceState),
                      const SizedBox(height: 40),
                      _buildRollButton(context, ref, diceState),
                      const SizedBox(height: 20),
                      _buildDiceCountSelector(context, ref, diceState),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAppBar(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppConstants.appName,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildDiceGrid(DiceState diceState) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: List.generate(
        diceState.diceCount,
        (index) => AnimatedDice(
          value: diceState.currentValues[index],
          isRolling: diceState.isRolling,
          size: diceState.diceCount > 3 ? 100 : 120,
        ),
      ),
    );
  }
  
  Widget _buildTotalDisplay(BuildContext context, DiceState diceState) {
    if (diceState.diceCount == 1) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
      ),
      child: Column(
        children: [
          Text(
            'Total',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${diceState.total}',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRollButton(BuildContext context, WidgetRef ref, DiceState diceState) {
    return ElevatedButton(
      onPressed: diceState.isRolling
          ? null
          : () => ref.read(diceProvider.notifier).rollDice(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 8,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            diceState.isRolling ? Icons.autorenew : Icons.casino,
            size: 28,
          ),
          const SizedBox(width: 12),
          Text(
            diceState.isRolling ? 'Rolling...' : 'Roll Dice',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDiceCountSelector(BuildContext context, WidgetRef ref, DiceState diceState) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'Number of Dice',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              AppConstants.maxDiceCount,
              (index) {
                final count = index + 1;
                final isSelected = count == diceState.diceCount;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text('$count'),
                    selected: isSelected,
                    onSelected: diceState.isRolling
                        ? null
                        : (_) => ref.read(diceProvider.notifier).setDiceCount(count),
                    selectedColor: Colors.white,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
