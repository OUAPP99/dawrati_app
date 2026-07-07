import 'package:flutter/material.dart';

import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';

class TodaysJourneySection extends StatelessWidget {
  const TodaysJourneySection({super.key});

  Widget tile(IconData icon, String title) {
    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: const Color(0xFFFFE8F1),
            child: Icon(
              icon,
              color: const Color(0xFFE91E63),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Journey",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 26),

          Row(
            children: [
              tile(Icons.mood, "Mood"),
              tile(Icons.water_drop, "Water"),
              tile(Icons.nightlight_round, "Sleep"),
              tile(Icons.directions_walk, "Activity"),
            ],
          ),

          const SizedBox(height: 28),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Continue"),
            ),
          ),
        ],
      ),
    );
  }
}