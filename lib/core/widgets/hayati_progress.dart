import 'package:flutter/material.dart';

class HayatiProgress extends StatelessWidget {
  final double value;

  const HayatiProgress({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: LinearProgressIndicator(
          value: value,
          minHeight: 8,
          color: Colors.pink,
          backgroundColor: Colors.pink.shade100,
        ),
      ),
    );
  }
}