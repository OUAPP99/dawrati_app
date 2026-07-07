import 'package:flutter/material.dart';

class DayScoreCard extends StatelessWidget {
  final double score;

  const DayScoreCard({
    super.key,
    required this.score,
  });

  Color get color {
    if (score >= 8) return Colors.green;
    if (score >= 6) return Colors.orange;
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Today's Wellness",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 20),

          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: score / 10,
                  strokeWidth: 10,
                  color: color,
                  backgroundColor: Colors.grey.shade200,
                ),
              ),

              Text(
                "${score.toStringAsFixed(1)}/10",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}