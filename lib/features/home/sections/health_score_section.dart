import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/animated_score.dart';
import '../../../core/widgets/premium_card.dart';
import '../../cycle/cycle_provider.dart';
import '../../log/provider/daily_log_provider.dart';

class HealthScoreSection extends StatelessWidget {
  const HealthScoreSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cycle = context.watch<CycleProvider>();
    final log = context.watch<DailyLogProvider>();

    int score = 50;

    // Hydration (25 pts)
    score += ((log.water / 2.5) * 25).clamp(0, 25).toInt();

    // Sleep (25 pts)
    score += ((log.sleep / 8.0) * 25).clamp(0, 25).toInt();

    // Mood (20 pts)
    if (log.mood.contains("Happy")) {
      score += 20;
    } else if (log.mood.contains("Neutral")) {
      score += 12;
    } else {
      score += 5;
    }

    // Cycle bonus
    if (cycle.phase == "Ovulation") {
      score += 5;
    }

    if (score > 100) score = 100;

    String status;

    if (score >= 90) {
      status = "Excellent";
    } else if (score >= 75) {
      status = "Very Good";
    } else if (score >= 60) {
      status = "Good";
    } else {
      status = "Needs Attention";
    }

    return PremiumCard(
      child: Column(
        children: [
          const Text(
            "Health Score",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 22),

          AnimatedScore(score: score),

          const SizedBox(height: 18),

          Text(
            status,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade600,
            ),
          ),
        ],
      ),
    );
  }
}