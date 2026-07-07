import 'package:flutter/material.dart';

import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/widgets/animated_tap.dart';

class RecommendationSection extends StatelessWidget {
  const RecommendationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recommended for you",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),

        const SizedBox(height: 20),

        _card(
          Colors.pink.shade50,
          Icons.auto_awesome,
          "Dawrati AI",
          "Your energy may decrease over the next 2 days. Prioritize sleep and hydration.",
        ),

        const SizedBox(height: 18),

        _card(
          Colors.orange.shade50,
          Icons.restaurant,
          "Nutrition",
          "Foods rich in iron can help support your body during this phase.",
        ),

        const SizedBox(height: 18),

        _card(
          Colors.blue.shade50,
          Icons.nightlight_round,
          "Sleep",
          "Going to bed 30 minutes earlier may improve your recovery.",
        ),
      ],
    );
  }

  Widget _card(
    Color color,
    IconData icon,
    String title,
    String text,
  ) {
    return AnimatedTap(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: AppShadows.soft,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.white,
              child: Icon(icon),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    text,
                    style: const TextStyle(
                      height: 1.4,
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
}