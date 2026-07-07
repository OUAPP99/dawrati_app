import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HayatiAiCard extends StatelessWidget {
  final String title;
  final String text;

  const HayatiAiCard({
    super.key,
    this.title = "AI Insight",
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.primaryLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.auto_awesome, color: AppColors.primary, size: 30),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(text, style: const TextStyle(fontSize: 15, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}