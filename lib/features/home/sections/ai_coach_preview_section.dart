import 'package:flutter/material.dart';

import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/widgets/animated_tap.dart';

class AiCoachPreviewSection extends StatelessWidget {
  const AiCoachPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedTap(
      onTap: () {
        Navigator.pushNamed(context, '/ai-coach');
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFFEAF3),
              Color(0xFFEDE7FF),
            ],
          ),
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: AppShadows.soft,
        ),
        child: const Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.auto_awesome,
                color: Color(0xFFE91E63),
                size: 32,
              ),
            ),
            SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dawrati AI Coach",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Ask your cycle assistant for daily guidance.",
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}