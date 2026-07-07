import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cycle/cycle_provider.dart';
import '../log/provider/daily_log_provider.dart';

class AiCoachScreen extends StatelessWidget {
  const AiCoachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cycle = context.watch<CycleProvider>();
    final log = context.watch<DailyLogProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 120),
          children: [
            const Text(
              "Dawrati AI",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 22),

            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFEAF3),
                    Color(0xFFEDE7FF),
                  ],
                ),
                borderRadius: BorderRadius.circular(34),
              ),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.auto_awesome,
                      size: 40,
                      color: Color(0xFFE91E63),
                    ),
                  ),
                  SizedBox(height: 18),
                  Text(
                    "Your Personal AI Coach",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Daily guidance based on your cycle and your health logs.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            _adviceCard(
              "Current phase",
              "${cycle.phase} • Day ${cycle.cycleDay}",
              Icons.favorite,
            ),

            _adviceCard(
              "Today's mood",
              log.mood,
              Icons.mood,
            ),

            _adviceCard(
              "Hydration",
              "${log.water.toStringAsFixed(1)} L today",
              Icons.water_drop,
            ),

            _adviceCard(
              "Sleep",
              "${log.sleep.toStringAsFixed(1)} hours",
              Icons.bedtime,
            ),

            const SizedBox(height: 26),

            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        color: Color(0xFFE91E63),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Today's AI Insight",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    _generateInsight(cycle.phase, log.water, log.sleep),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "AI Chat will be available in the next version.",
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.chat_bubble_outline),
                label: const Text(
                  "Start AI Conversation",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _adviceCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFFFEAF3),
            child: Icon(
              icon,
              color: const Color(0xFFE91E63),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _generateInsight(
    String phase,
    double water,
    double sleep,
  ) {
    if (phase == "Ovulation") {
      return "You are likely in your most energetic phase. Stay hydrated and enjoy physical activity if you feel comfortable.";
    }

    if (phase == "Menstruation") {
      return "Your body may need more rest today. Prioritize sleep, hydration and iron-rich foods.";
    }

    if (water < 1.5) {
      return "Your hydration is lower than recommended. Drinking more water may help reduce fatigue.";
    }

    if (sleep < 7) {
      return "You slept less than recommended. A consistent bedtime may improve your energy tomorrow.";
    }

    return "Your recent health data looks balanced. Keep tracking daily to receive more personalized insights.";
  }
}