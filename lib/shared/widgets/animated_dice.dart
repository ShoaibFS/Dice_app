import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Animated dice widget with 3D-like appearance
class AnimatedDice extends StatelessWidget {
  final int value;
  final bool isRolling;
  final double size;
  
  const AnimatedDice({
    super.key,
    required this.value,
    this.isRolling = false,
    this.size = 120,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: size,
      height: size,
      child: isRolling
          ? _buildRollingDice(theme)
          : _buildStaticDice(theme),
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .shimmer(
          duration: 2000.ms,
          color: isRolling ? theme.colorScheme.primary.withOpacity(0.3) : Colors.transparent,
        );
  }
  
  Widget _buildStaticDice(ThemeData theme) {
    return Hero(
      tag: 'dice_$value',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.secondary,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: _buildDiceDots(theme),
      ),
    )
        .animate()
        .scale(
          duration: 400.ms,
          curve: Curves.elasticOut,
        )
        .fadeIn(duration: 200.ms);
  }
  
  Widget _buildRollingDice(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.colorScheme.surface,
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 2,
        ),
      ),
      child: _buildDiceDots(theme),
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .rotate(
          duration: 200.ms,
          curve: Curves.easeInOut,
        );
  }
  
  Widget _buildDiceDots(ThemeData theme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dotSize = constraints.maxWidth * 0.15;
        final padding = constraints.maxWidth * 0.15;
        
        return Padding(
          padding: EdgeInsets.all(padding),
          child: _getDicePattern(
            value,
            dotSize,
            theme.brightness == Brightness.dark ? Colors.white : Colors.white,
          ),
        );
      },
    );
  }
  
  Widget _getDicePattern(int value, double dotSize, Color dotColor) {
    switch (value) {
      case 1:
        return Center(
          child: _dot(dotSize, dotColor),
        );
      case 2:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: _dot(dotSize, dotColor),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: _dot(dotSize, dotColor),
            ),
          ],
        );
      case 3:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: _dot(dotSize, dotColor),
            ),
            Center(
              child: _dot(dotSize, dotColor),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: _dot(dotSize, dotColor),
            ),
          ],
        );
      case 4:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dot(dotSize, dotColor),
                _dot(dotSize, dotColor),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dot(dotSize, dotColor),
                _dot(dotSize, dotColor),
              ],
            ),
          ],
        );
      case 5:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dot(dotSize, dotColor),
                _dot(dotSize, dotColor),
              ],
            ),
            Center(
              child: _dot(dotSize, dotColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dot(dotSize, dotColor),
                _dot(dotSize, dotColor),
              ],
            ),
          ],
        );
      case 6:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dot(dotSize, dotColor),
                _dot(dotSize, dotColor),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dot(dotSize, dotColor),
                _dot(dotSize, dotColor),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dot(dotSize, dotColor),
                _dot(dotSize, dotColor),
              ],
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
  
  Widget _dot(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
