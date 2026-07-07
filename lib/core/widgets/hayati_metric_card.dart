import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HayatiMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final double progress;

  const HayatiMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 30),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            color: AppColors.primary,
            backgroundColor: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(20),
          ),
        ],
      ),
    );
  }
}