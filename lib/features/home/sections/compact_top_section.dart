import 'package:flutter/material.dart';

import '../../../core/widgets/premium_card.dart';

class CompactTopSection extends StatelessWidget {
  final int score;
  final int cycleDay;
  final String phase;

  const CompactTopSection({
    super.key,
    required this.score,
    required this.cycleDay,
    required this.phase,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PremiumCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const Icon(
                  Icons.favorite,
                  color: Colors.pink,
                  size: 30,
                ),
                const SizedBox(height: 8),
                Text(
                  "$score",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Health Score",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: PremiumCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const Icon(
                  Icons.spa,
                  color: Colors.purple,
                  size: 30,
                ),
                const SizedBox(height: 8),
                Text(
                  "Day $cycleDay",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  phase,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}