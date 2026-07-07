import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../log/provider/daily_log_provider.dart';
import 'phase_ai_message.dart';

class AiInsightCard extends StatelessWidget {
  final String phase;

  const AiInsightCard({
    super.key,
    required this.phase,
  });

  @override
  Widget build(BuildContext context) {
    final log = context.watch<DailyLogProvider>();

    String message = PhaseAiMessage.getMessage(phase);

    if (log.sleep < 6) {
      message =
          "You slept only ${log.sleep.toStringAsFixed(1)} hours. Try to rest more tonight to support hormonal balance.";
    } else if (log.water >= 2.5) {
      message =
          "Great job! You reached your hydration goal today. This can help your energy and comfort.";
    } else if (log.mood.contains("Sad") || log.mood.contains("Stressed")) {
      message =
          "Your mood seems lower today. Try a calm routine, hydration and light movement.";
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEAF2),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0xFFFFC1D6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.auto_awesome, color: Color(0xFFE91E63), size: 30),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Dawrati AI",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}