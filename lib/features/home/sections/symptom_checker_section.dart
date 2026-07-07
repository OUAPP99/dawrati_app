import 'package:flutter/material.dart';

import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';

class SymptomCheckerSection extends StatelessWidget {
  const SymptomCheckerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(
                child: Text("Symptom Checker", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
              ),
              Text("See all", style: TextStyle(fontSize: 17, color: Colors.grey, fontWeight: FontWeight.w700)),
              SizedBox(width: 4),
              Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 22),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: Image.asset(
              "assets/images/articles/symptoms.png",
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 22),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 30),
              SizedBox(width: 14),
              Expanded(
                child: Text(
                  "Track unusual symptoms and learn when they may need attention.",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, height: 1.25),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Dawrati can help you understand patterns in your cycle, mood, sleep and symptoms.",
            style: TextStyle(fontSize: 17, color: Colors.grey.shade700, height: 1.35),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF6E6),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Column(
              children: [
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: Color(0xFFFFE4EC),
                      child: Icon(Icons.health_and_safety, color: Color(0xFFE91E63)),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Text("Quick self-check", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                    ),
                    Icon(Icons.timer_outlined, color: Colors.grey),
                    SizedBox(width: 4),
                    Text("5 min", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Check my symptoms", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Note: Dawrati is not a diagnosis tool.",
            style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
          ),
        ],
      ),
    );
  }
}