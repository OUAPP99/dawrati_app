import 'package:flutter/material.dart';

class AIInsightCard extends StatelessWidget {
  final String insight;

  const AIInsightCard({
    super.key,
    required this.insight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFEAF3),
            Color(0xFFFFF7FA),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.auto_awesome,
              color: Color(0xFFE91E63),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Dawrati AI",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  insight,
                  style: const TextStyle(height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}