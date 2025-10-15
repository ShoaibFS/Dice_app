import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Animated gradient background
class GradientBackground extends StatelessWidget {
  final Widget child;
  final bool isDark;
  
  const GradientBackground({
    super.key,
    required this.child,
    this.isDark = false,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppTheme.getGradient(isDark),
        ),
      ),
      child: child,
    );
  }
}
