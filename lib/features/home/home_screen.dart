import 'package:flutter/material.dart';
import 'package:dicelab/gradient_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: GradientContainer([
        Color(0xFF2A2A72),
        Color(0xFF009FFD),
      ]),
    );
  }
}
