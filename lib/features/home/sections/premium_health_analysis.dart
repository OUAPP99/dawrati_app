import 'package:flutter/material.dart';

import '../../../core/premium/premium_gate.dart';
import '../../../core/widgets/premium_card.dart';

class PremiumHealthAnalysis extends StatelessWidget {
  const PremiumHealthAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return PremiumGate(
      title: "Health Analysis",
      description:
          "Unlock AI health analysis, score evolution and personalized recommendations.",
      child: PremiumCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Health Analysis",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _row(
              Icons.water_drop,
              Colors.blue,
              "Hydration",
              "+18 points",
            ),

            _row(
              Icons.bedtime,
              Colors.indigo,
              "Sleep",
              "+22 points",
            ),

            _row(
              Icons.mood,
              Colors.orange,
              "Mood",
              "+20 points",
            ),

            _row(
              Icons.favorite,
              Colors.pink,
              "Cycle",
              "+5 points",
            ),

            const Divider(height: 34),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    color: Colors.pink,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Your health score has improved compared to last week. Continue staying hydrated and maintaining your sleep routine.",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(
    IconData icon,
    Color color,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withValues(alpha: .12),
            child: Icon(
              icon,
              color: color,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}