import 'package:flutter/material.dart';

import 'premium_badge.dart';

class PremiumHeader extends StatelessWidget {
  const PremiumHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PremiumBadge(),
        const SizedBox(height: 20),
        const Text(
          "Unlock Dawrati Premium",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          "AI insights, unlimited history,\nadvanced predictions and much more.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}