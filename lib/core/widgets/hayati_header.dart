import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HayatiHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const HayatiHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.favorite_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.primaryLight,
          child: Icon(icon, color: AppColors.primaryDark),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: AppColors.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }
}